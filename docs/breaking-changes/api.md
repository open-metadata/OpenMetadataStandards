---
title: API & Schema Contract Changes (1.13 → 2.0)
description: Removed REST endpoints, changed request/response shapes, tightened validation and enum changes in OpenMetadata 2.0.
---

# API & Schema Contracts

**REST surface and JSON Schema changes that affect any programmatic client.**

Across the 1.13 → 2.0 jump the REST surface gains **208 endpoints** and loses **10**. The JSON Schema
spec gains **86 files**, modifies **107**, and removes **3**.

---

## Removed endpoints

### Suggestions API removed { #suggestions-api-removed }

:material-close-octagon:{ .om-breaking } **Breaking** · Affects: API clients, SDKs, automation bots

`SuggestionsResource` is deleted. The entire `/v1/suggestions` namespace is gone:

| Removed in 2.0 |
|---|
| `GET /v1/suggestions` |
| `POST /v1/suggestions` |
| `GET /v1/suggestions/{id}` |
| `PUT /v1/suggestions/{id}` |
| `PUT /v1/suggestions/{id}/accept` |
| `PUT /v1/suggestions/{id}/reject` |
| `PUT /v1/suggestions/accept-all` |
| `PUT /v1/suggestions/reject-all` |
| `DELETE /v1/suggestions/{suggestionId}` |
| `DELETE /v1/suggestions/{entityType}/name/{entityFQN}` |

Suggestions are now **Tasks**. See [Collaboration → Suggestions](collaboration.md#suggestions-api-removed)
for the full mapping.

!!! success "Action"
    Replace suggestion calls with `/v1/tasks` filtered by `type=Suggestion` (`category=MetadataUpdate`).
    Accept/reject become `POST /v1/tasks/{id}/resolve` and `PUT /v1/tasks/{id}/suggestion/apply`.
    Existing suggestions are migrated into `task_entity` by the 2.0.0 migration.

---

## Changed request contracts

### `search_after` is now a repeated query parameter { #search_after-is-now-a-repeated-query-parameter }

:material-close-octagon:{ .om-breaking } **Breaking** · Affects: anyone paginating `/v1/search/query`

```diff title="SearchResource.search()"
- @QueryParam("search_after") String  searchAfter    // 1.13: single comma-joined value
+ @QueryParam("search_after") List<String> searchAfter // 2.0: repeated once per sort value
```

Each sort value is now carried as its own parameter so values containing a comma (for example a
glossary term FQN) are safe.

=== "1.13"

    ```http
    GET /api/v1/search/query?q=*&index=table&search_after=1712345678000,abc-123
    ```

=== "2.0"

    ```http
    GET /api/v1/search/query?q=*&index=table&search_after=1712345678000&search_after=abc-123
    ```

!!! success "Action"
    Split the cursor on the client and emit one `search_after` parameter per sort value.

---

### `deleted` query parameter on `/v1/search/query` deprecated

:material-clock-alert:{ .om-deprecated } **Deprecated** · Affects: search clients

`@QueryParam("deleted")` on the search endpoint is annotated `@Deprecated(forRemoval = true)` in 2.0.
Express deleted-entity filtering through `query_filter` instead.

---

### `testCaseStatus` accepts multiple values

:material-plus-circle:{ .om-additive } **Additive, with stricter validation** · Affects: data quality clients

`GET /v1/dataQuality/testCases` now binds `testCaseStatus` as a `List<String>`, so multiple statuses
can be requested at once:

```http
GET /api/v1/dataQuality/testCases?testCaseStatus=Failed&testCaseStatus=Aborted
```

Values are validated against the `TestCaseStatus` enum and an unknown value now returns a
`400 Bad Request` naming the allowed values. A single-value call is unchanged.

---

## Changed response contracts

### `ingestionPipeline.pipelineStatuses` is an array

:material-close-octagon:{ .om-breaking } — see [Ingestion → pipelineStatuses](ingestion-and-connectors.md#pipelinestatuses-is-now-an-array).

### Ingestion log stream emits structured events

:material-close-octagon:{ .om-breaking } — see [Ingestion → log stream](ingestion-and-connectors.md#log-stream-sse-payload-changed).

### `testCase` inlines `incidentStatus`

:material-plus-circle:{ .om-additive } — see [Data Quality → incidentStatus](data-quality.md#incidentstatus-is-inlined-on-testcase).

---

## Validation changes

### Entity name validation tightened { #entity-name-validation-tightened }

:material-close-octagon:{ .om-breaking } · Affects: every write path, ingestion connectors, CSV import

`type/basic.json` tightens two patterns:

```diff title="openmetadata-spec/.../type/basic.json"
  "entityName": {
-   "pattern": "^((?!::).)*$"
+   "pattern": "^((?!::)[^>\"\\x00-\\x1f])*$"
  },
  "testCaseEntityName": {
-   "pattern": "^((?!::).)*$"
+   "pattern": "^((?!::)[^>\"\\x00-\\x1f])*$"
  }
```

In addition to the existing `::` restriction, names may no longer contain:

- `>` (greater-than)
- `"` (double quote)
- any ASCII control character (`\x00`–`\x1f`)

The same restriction is applied to table column names, search-index field names, generic schema
field names, and pipeline task names. Pipeline task names also gain `minLength: 1`, so an empty task
name that previously validated is rejected in 2.0.

!!! warning "Existing data"
    Entities already stored with these characters are not rewritten by the migration, but the next
    `PUT`/`PATCH` that revalidates the name will fail. Audit source systems whose object names can
    contain quotes or angle brackets before upgrading.

!!! success "Action"
    Add a sanitisation step in custom connectors and CSV pipelines, or rename the affected assets.

### Auto-classification validation bounds

:material-close-octagon:{ .om-breaking } **Breaking for previously out-of-range configs** ·
Affects: database and storage auto-classification pipelines

The auto-classification schemas now require `sampleDataCount >= 1` and constrain `confidence` to
the inclusive range `0`–`100`. Existing YAML with zero samples, a negative confidence, or a
confidence above 100 no longer validates.

!!! success "Action"
    Validate external pipeline YAML before upgrade and clamp confidence values to `0`–`100`.

---

## Enum changes

### Removed enum values

:material-close-octagon:{ .om-breaking }

| Schema | Enum | Removed values |
|--------|------|----------------|
| `entity/applications/app.json` | `agentType` | `CollateAI`, `CollateAITierAgent`, `CollateAIQualityAgent` |

Only `Metadata` remains. The corresponding app-config schemas were deleted:

- `entity/applications/configuration/external/collateAIQualityAgentAppConfig.json`
- `entity/applications/configuration/external/collateAITierAgentAppConfig.json`
- `entity/applications/configuration/private/internal/collateAITierAgentAppPrivateConfig.json`

### Added enum values

:material-plus-circle:{ .om-additive } — additive, but note that clients doing exhaustive
`switch`/`match` on these enums need new branches.

| Schema | Enum | Added values |
|--------|------|--------------|
| `entity/policies/accessControl/resourceDescriptor.json` | `operation` | `CreateTask`, `EditTask`, `ResolveTask`, `CloseTask`, `ReassignTask` |
| `type/changeEventType.json` | — | `taskCreated`, `taskUpdated`, `entityLineageAdded`, `entityLineageDeleted`, `entityLineageUpdated` |
| `type/entityRelationship.json` | `relationshipType` | `assignedTo` |
| `type/workflowTriggerFields.json` | — | `entityStatus` |
| `settings/settings.json` | `settingType` | `appConfiguration` |
| `governance/workflows/elements/nodeSubType.json` | — | `policyAgentTask`, `createAndRunAIAutomationTask` |
| `jobs/backgroundJob.json` | `jobType` | `CSV_IMPORT`, `CSV_EXPORT`, `AUDIT_EXPORT` |
| `jobs/backgroundJob.json` | `status` | `CANCELLED` |
| `entity/services/ingestionPipelines/ingestionPipeline.json` | `pipelineType` | `policyAgent` |
| `entity/data/table.json` | `tableType` | `SemanticView` |
| `entity/data/metric.json` | `metricType` | `SIMPLE`, `CUMULATIVE`, `DERIVED`, `CONVERSION` |
| `entity/data/dashboardDataModel.json` | `dataModelType` | `OmniDataModel` |
| `entity/services/databaseService.json` | `databaseServiceType` | `SapBw4Hana` |
| `entity/services/dashboardService.json` | `dashboardServiceType` | `Omni` |
| `entity/services/pipelineService.json` | `pipelineServiceType` | `Prefect`, `SapBw4HanaPipeline` |

---

## Default value changes

:material-alert:{ .om-behavioral } **Behavioural** · Affects: deployments that never set these explicitly

| Schema | Field | 1.13 | 2.0 |
|--------|-------|------|-----|
| `api/configuration/rdfConfiguration.json` | `bulkEntityBatchSize` | `50` | `100` |
| `api/configuration/rdfConfiguration.json` | `bulkRelationshipSourceBatchSize` | `25` | `100` |
| `api/configuration/rdfConfiguration.json` | `inferenceEnabled` | `true` | **`false`** |
| `configuration/workflowSettings.json` | `executorConfiguration.asyncJobAcquisitionInterval` | `10000` ms | `1000` ms |

The 2.0.0 post-data migration also lowers `timerJobAcquisitionInterval` to `5000` ms and the
`WorkflowEventConsumer` poll interval from 10 s to 1 s, so governance workflows fire near-real-time
instead of up to 10 s after the triggering change.

!!! warning "RDF inference is off by default in 2.0"
    If you relied on inferred triples in SPARQL queries, set `RDF_INFERENCE_ENABLED=true` explicitly.

### Connector filter-pattern defaults

:material-alert:{ .om-behavioral } · Affects: new **and** existing ingestion runs

Three connectors now ship non-empty default exclude patterns:

| Connector | Field | New default excludes |
|-----------|-------|----------------------|
| Redshift | `tableFilterPattern` | `^(?:.*\.)?mv_tbl__.*__\d+$` |
| Kafka | `topicFilterPattern` | `^__.*`, `^_schemas$`, `^_confluent.*` |
| Redpanda | `topicFilterPattern` | `^__.*`, `^_schemas$`, `^_confluent.*` |

!!! success "Action"
    If you deliberately ingest Redshift materialised-view backing tables or Kafka internal topics,
    override the filter pattern explicitly — the default now excludes them.

---

## `$ref` relocations

:material-alert:{ .om-behavioral } · Affects: code generated from the spec, JSON-Schema validators

Chart `function` and `kpiDetails` definitions moved out of `dataInsightCustomChart.json` into a new
`dataInsight/custom/chartFunctions.json`:

```diff
- "$ref": "dataInsightCustomChart.json#/definitions/function"
+ "$ref": "chartFunctions.json#/definitions/function"

- "$ref": "dataInsightCustomChart.json#/definitions/kpiDetails"
+ "$ref": "chartFunctions.json#/definitions/kpiDetails"
```

Affected files: `formulaHolder.json`, `lineChart.json`, `summaryCard.json`,
`dataInsightCustomChartResultList.json`.

Similarly, `entity/data/table.json` extracts the inline `cardinalityDistribution` object into a
named `#/definitions/cardinalityDistribution`. The wire shape is unchanged; only the pointer moved.

!!! success "Action"
    Regenerate any client models built from the JSON Schema. If you resolve `$ref` pointers by hand,
    update the paths.

---

## Notable new endpoint groups

:material-plus-circle:{ .om-additive } — these do not break anything, but they replace patterns you
may currently implement client-side.

| Namespace | Purpose | Replaces |
|-----------|---------|----------|
| `/v1/tasks/**` | First-class Task entity (22 endpoints) | `/v1/feed/tasks/*`, `/v1/suggestions/*` |
| `/v1/announcements/**` | Standalone Announcement entity | `/v1/feed?type=Announcement` |
| `/v1/activity/**` | Ephemeral activity stream | System-generated `/v1/feed` threads |
| `/v1/csvAsyncJobs/**` | CSV import/export job status + result download | WebSocket-only job tracking |
| `/v1/csv/documentation/{entityType}` | Machine-readable CSV column docs | Hard-coded column lists |
| `/v1/services/overview` | One call for per-type + per-connector service counts | N per-service `GET` calls |
| `/v1/lineage/hydrate` | Batch-hydrate up to 200 lineage nodes | N per-node entity `GET` calls |
| `/v1/{entityType}/deleteStale` | Connector-driven stale-entity cleanup | Manual delete loops |
| `/v1/search/export/async` | Queue a CSV export as a background job | Synchronous `/v1/search/export` |
| `/v1/columns/name/{fqn}` | Fetch a single column by FQN | Fetching the whole table |
| `/v1/personas/{id}/context`, `/v1/personas/me/context` | Persona-scoped AI context | — |
| `/v1/contextCenter/**`, `/v1/attachments/**` | Knowledge/Context Center + file assets | — |
| `/v1/aiGovernance/**`, `/v1/aiGovernanceFrameworks/**`, `/v1/aiFrameworkControls/**`, `/v1/auditReports/**` | AI Governance Studio | — |

`deleteStale` is available on 18 entity types: `tables`, `databases`, `databaseSchemas`,
`storedProcedures`, `dashboards`, `charts`, `dashboard/datamodels`, `pipelines`, `topics`,
`mlmodels`, `searchIndexes`, `containers`, `apiCollections`, `apiEndpoints`, `drives/directories`,
`drives/files`, `drives/spreadsheets`, `drives/worksheets`.

---

## Deprecations to plan for

| Item | Status in 2.0 | Replacement |
|------|---------------|-------------|
| `GET /v1/search/query?deleted=` | `@Deprecated(forRemoval = true)` | `query_filter` |
| `authenticationConfiguration.oidcConfiguration.sessionExpiry` | Deprecated fallback | `authenticationConfiguration.sessionExpiry` |
| `EntityResource.patchInternal(uriInfo, ctx, id, patch)` (Java) | `@Deprecated` | overload taking `ChangeSource` |
