---
title: Applications & Automation Changes (1.13 → 2.0)
description: Search Indexing app config removals, RDF Index app defaults, Data Insights module config, MCP tool contract changes and CSV background jobs in OpenMetadata 2.0.
---

# Applications & Automation

**Four installed applications have their stored configuration rewritten by the 2.0.0 migration.
If you manage app configuration as code, read this before you replay it.**

---

## Search Indexing app configuration fields removed { #search-indexing-app-configuration-fields-removed }

:material-close-octagon:{ .om-breaking } **Breaking** · Affects: scripted reindex triggers, IaC

```diff title="entity/applications/configuration/internal/searchIndexingAppConfig.json"
- "recreateIndex": {
-   "description": "This schema publisher run modes.",
-   "type": "boolean",
-   "default": true
- },
- "useDistributedIndexing": {
-   "title": "Use Distributed Indexing",
-   "description": "Enable distributed indexing to scale reindexing across multiple servers…",
-   "type": "boolean",
-   "default": true
- },
```

In 2.0 **reindex always recreates the index** and distributed indexing is always used. The
`searchIndexLanguage` field's description is also corrected from *"Recreate Indexes with updated
Language"* to *"Search index mapping language."*

Supporting infrastructure added in the migration:

| Table | Purpose |
|-------|---------|
| `search_index_job` | Distributed reindex job tracking (status, staged index mapping, per-phase counts, registration deadline, registered server count) |
| `search_index_retry_queue` | Retry queue for failed search-index writes, with `claimToken` leasing |

!!! danger "A POST carrying `recreateIndex` will be rejected"
    Any automation that triggers a reindex with `{"recreateIndex": false}` — for example an
    "incremental reindex" job — must drop the field. There is no incremental mode in 2.0.

New diagnostics ship alongside: reindex-drift and index-health checks in `/v1/system/validate`, plus
a cluster-fitness diagnostic (REST endpoint + ops CLI).

---

## RDF Index app defaults changed { #rdf-index-app-defaults-changed }

:material-alert:{ .om-behavioral } **Behavioural — the migration overwrites your settings**

The 2.0.0 migration rewrites `RdfIndexApp` on `installed_apps` and `apps_marketplace`:

| Setting | Before | After |
|---------|--------|-------|
| `appSchedule.cronExpression` | daily | **`0 0 * * 6`** (weekly, Saturday) |
| `appConfiguration.recreateIndex` | incremental | **`true`** (full rebuild every run) |
| `appConfiguration.entities` | operator's subset | **`["all"]`** |

The reasoning, from the migration itself: incremental RDF indexing produced unbounded triple growth
because relationship-removal paths were not fully reconciled. With a per-run `CLEAR ALL` the dataset
always converges to the relational state; a weekly cadence keeps per-run cost from saturating Fuseki.

The `entities` reset is a **safety measure** — with `recreateIndex: true` issuing `CLEAR ALL` before
indexing, a narrowed entity subset would wipe triples for entity types still present in the database.

!!! warning "Re-narrow after upgrading if you need partial RDF indexing"
    Your `entities` subset is not preserved. Reapply it after the migration completes, understanding
    that the following run will still `CLEAR ALL` first.

### RDF configuration defaults

| Field | 1.13 | 2.0 |
|-------|------|-----|
| `bulkEntityBatchSize` | `50` | `100` |
| `bulkRelationshipSourceBatchSize` | `25` | `100` |
| `inferenceEnabled` | **`true`** | **`false`** |
| `bulkLineageEdgeBatchSize` | — | `50` (new) |
| `remoteEndpoint` env | `RDF_ENDPOINT` | `RDF_ENDPOINT` with `RDF_REMOTE_ENDPOINT` fallback |

!!! warning "RDF inference is now off"
    SPARQL queries relying on inferred triples return fewer results. Set `RDF_INFERENCE_ENABLED=true`
    to restore 1.13 behaviour.

---

## Data Insights app: `dataQuality` module removed

:material-close-octagon:{ .om-breaking } — see
[Data Quality → Data Insights no longer computes data quality](data-quality.md#data-insights-no-longer-computes-data-quality).

Because `moduleConfiguration` is `additionalProperties: false`, a stored config containing
`dataQuality` prevents `DataInsightsApplication` from deserialising at startup. The migration strips
it from `installed_apps`, `apps_marketplace` and every `app.version.*` row in `entity_extension`.

---

## MCP application configuration removed

:material-close-octagon:{ .om-breaking } · Affects: MCP deployments

```sql
UPDATE installed_apps
SET json = JSON_SET(JSON_REMOVE(json, '$.appConfiguration'), '$.allowConfiguration', false)
WHERE name = 'McpApplication';
```

MCP configuration lives **solely** in the `mcpConfiguration` setting. The app-level copy — which no
code read — is dropped and the now-empty configure step is hidden in the UI.

!!! success "Action"
    Configure MCP through **Settings → MCP**, not through the application's config. The UI tab is
    wired to the settings the MCP server actually uses.

---

## Runtime-only fields stripped from stored application data

:material-alert:{ .om-behavioral } **Security-relevant** · Affects: anyone reading app JSON

```sql
UPDATE installed_apps
SET json = JSON_REMOVE(json, '$.openMetadataServerConnection', '$.privateConfiguration')
WHERE …;
-- and the same for entity_extension rows with extension LIKE 'app.version.%'
```

`openMetadataServerConnection` and `privateConfiguration` were being persisted into application rows
and version history. They are runtime-only and are removed. Separately, 2.0 stops exposing the app
bot JWT and `privateConfiguration` secrets in API responses.

!!! success "Action"
    If your tooling read the app bot token out of `/v1/apps/...`, obtain it through the bot API
    instead.

---

## Application config union changed

:material-alert:{ .om-behavioral } · Affects: generated models and strict validators

`applicationConfig.json`'s `appConfig` `oneOf` list drops the three Collate AI agent configs and
gains a permissive terminal branch:

```json
[
  { "$ref": "external/collateAIAppConfig.json" },
  { "$ref": "external/automatorAppConfig.json" },
  { "$ref": "../../../configuration/slackAppConfiguration.json" },
  { "$ref": "internal/dataInsightsAppConfig.json" },
  { "$ref": "internal/dataInsightsReportAppConfig.json" },
  { "$ref": "internal/searchIndexingAppConfig.json" },
  { "$ref": "internal/cacheWarmupAppConfig.json" },
  { "$ref": "internal/dataRetentionConfiguration.json" },
  { "$ref": "internal/autoPilotAppConfig.json" },
  { "type": "object", "additionalProperties": true }
]
```

The branch **indexes shift** — generated unions that key on `oneOf` position (some code generators do)
must be regenerated, not hand-patched.

---

## New tenant-wide app configuration setting

:material-plus-circle:{ .om-additive }

`settings/settings.json` gains `settingType: "appConfiguration"`, backed by
`api/configuration/appConfiguration.json`:

```json
{ "defaultAppMode": "ai | classic | null" }
```

> Seeded from yaml/env on first boot; DB-backed and admin-mutable at runtime afterwards
> (yaml is ignored once a DB row exists).

Precedence: **user preference → persona app mode → tenant `defaultAppMode`**. See
[UI & Customization → App Mode](ui-and-customization.md#app-mode).

---

## MCP tool contracts

:material-alert:{ .om-behavioral } **Behavioural for MCP clients that parse responses**

No tools are removed. **7 tools are added** and **15 change**.

### New tools

`create_context_memory`, `find_context`, `get_asset_context`, `get_company_context`,
`get_knowledge_content`, `get_persona_context`, `search_company_context` — all Context Center / AI
context tools.

### Changed tools

`create_classification`, `create_data_product`, `create_domain`, `create_glossary`,
`create_glossary_term`, `create_lineage`, `create_metric`, `create_tag`, `create_test_case`,
`get_entity_lineage`, `get_test_definitions`, `patch_entity`, `root_cause_analysis`,
`search_metadata`, `semantic_search`.

### Contract changes that will break clients

| Change | Detail |
|--------|--------|
| **`queryFilter` no longer honours `size` / `aggs`** | A `size` or `aggs` key inside `search_metadata`'s `queryFilter` is **ignored**. Read `totalFound` from the response for counts, or set `includeAggregations=true` for facets. Count queries written as `{"size": 0, "aggs": {...}}` silently return a normal result page in 2.0. |
| **Opaque `nextCursor` pagination** | Read tools return `nextCursor` for stable cursor paging. Existing `from` / `size` offset parameters remain supported and take effect when no cursor is supplied. |
| **`structuredContent` + `isError`** | Tools emit `structuredContent`, and soft errors are flagged via `isError` rather than being returned as prose. |
| **Response size budget** | A global size budget trims wide payloads. Read tools stay under the cap **by paging items, not by truncating content** — so a response can now be a partial page where 1.13 returned a truncated blob. |
| **`queries` is not a retrievable field** | `search_metadata`'s `fields` no longer resolves `queries`. Search `entityType='query'` instead. |
| **`get_entity_details` paginates columns** | Wide entities return paged columns; the payload is trimmed. `extension` (custom properties) is now surfaced. |
| **`get_entity_lineage` returns full SQL** | Transformation SQL is no longer truncated; size is controlled by returning fewer edges. |
| **`create_*` tools return a compact entity** | `create_metric`, `create_test_case` and the glossary create tools return a compact representation instead of the full entity. |
| **`root_cause_analysis` payload slimmed** | Fits LLM context limits. |
| **`fullyQualifiedName` term queries must be lowercased** | The field is indexed with a lowercase normalizer. `{"terms": {"fullyQualifiedName": ["DailyActiveUsers"]}}` silently matches nothing; use `["dailyactiveusers"]`. |

### Other MCP changes

- Tools are annotated with `title` / `readOnly` / `destructive` / `openWorld` hints;
  `create_lineage` is marked destructive.
- `get_entity_details` is authorized against the **resolved** entity.
- Create tools can set custom properties, and create-overwrites are re-authorized.
- SAML SSO is supported in the MCP OAuth flow; public clients are no longer issued a client secret;
  OAuth `state` is echoed without double-encoding; `id_token` in a URL fragment no longer 400s.
- Content negotiation: `application/json` is preferred when the client accepts both, and SSE is
  emitted when the client negotiates `text/event-stream`.
- Tool-call usage is tracked (`mcpToolCallUsage` entity, `/v1/mcp/usage`).
- A `server.json` is published for the MCP Registry.

!!! success "Action"
    Re-run your MCP client against 2.0 before rolling out. Anything that counted results with a
    `size: 0` aggregation query must change. Existing offset pagination remains compatible, while
    cursor pagination is preferred when concurrent writes could otherwise skip results.

---

## CSV import/export becomes a tracked background job

:material-alert:{ .om-behavioral } · Affects: CSV automation and the UI

`background_jobs` gains `progress`, `total`, `result`, `error`, `message`, `cancelRequested` and
`completedAt`; a new `background_job_logs` table stores per-job log lines. `jobType` gains
`CSV_IMPORT`, `CSV_EXPORT` and `AUDIT_EXPORT`; `status` gains `CANCELLED`.

New API:

| Endpoint | Purpose |
|----------|---------|
| `GET /v1/csvAsyncJobs` | List the caller's jobs |
| `GET /v1/csvAsyncJobs/{jobId}` | Job status |
| `GET /v1/csvAsyncJobs/{jobId}/result` | Download the produced CSV (`text/csv`) |
| `PUT /v1/csvAsyncJobs/{jobId}/cancel` | Request cancellation |
| `GET /v1/csv/documentation/{entityType}` | Machine-readable CSV column documentation |
| `GET /v1/audit/logs/export/{jobId}` | Audit log export result |

In 1.13 async CSV progress was delivered **only** over WebSocket — a client without a live socket had
no way to observe the job. 2.0 makes jobs pollable and downloadable, and the UI surfaces them in a
**Background jobs** tray.

Async entity **restore** is also available: `PUT /v1/{entityType}/restore?async=true` returns `202`
with a job id and notifies over the `RESTORE_ENTITY_CHANNEL` WebSocket channel.

Entity metrics gain full CSV support: `GET /v1/metrics/name/{name}/export`, `/exportAsync`,
`PUT /v1/metrics/name/{name}/import`, `/importAsync`, `GET /v1/metrics/documentation/csv`.

---

## Concurrency limits for background fan-out

:material-plus-circle:{ .om-additive } · New `openmetadata.yaml` block

```yaml
asyncOperations:
  maxConcurrentDbTasks: ${ASYNC_MAX_CONCURRENT_DB_TASKS:-25}
  maxConcurrentRdfWrites: ${ASYNC_MAX_CONCURRENT_RDF_WRITES:-8}
  dataInsightsMaxConcurrentDbTasks: ${DATA_INSIGHTS_MAX_CONCURRENT_DB_TASKS:-16}
```

Prevents background fan-out from exhausting the request connection pool. Tune down if you see
connection-pool starvation during reindex or Data Insights runs.

---

## Search & vector infrastructure

:material-plus-circle:{ .om-additive }

| Change | Detail |
|--------|--------|
| Native Elasticsearch vector search | In addition to OpenSearch |
| Google Gemini embedding provider | New provider option |
| Denormalised chunk docs | Versioned rollout for multi-chunk hybrid ranking |
| Staged, generation-based recreate | For the vector chunk index |
| `GET /v1/search/vector/fingerprint` | Inspect vector index fingerprint |
| `knnNumCandidatesMultiplier` | `num_candidates = max(k * multiplier, 100)`, default `2` |
| NLQ `filterExtractor` block | Cache size/TTL and prompt sample limits for NLQ filter extraction |
| `testSuite` / `testCase` vectorised | Hybrid search over data quality entities |

---

## Cache

:material-plus-circle:{ .om-additive }

New admin endpoints: `GET /v1/system/cache/keys`, `POST /v1/system/cache/invalidate`,
`POST /v1/system/cache/invalidate/entity`.

The `cache` block documentation changes from *"Default: Disabled (uses NoopCacheProvider)"* to
*"Default: none (no external dependency). Set `CACHE_PROVIDER=redis` to enable the Redis L2 cache;
it falls back to `NoopCacheProvider` if Redis is unreachable at startup."* The default is unchanged.
