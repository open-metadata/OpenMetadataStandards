---
title: Ingestion & Connector Changes (1.13 → 2.0)
description: pipelineStatuses shape change, Databricks Pipeline auth, Great Expectations 1.x, log-stream SSE contract, hierarchical progress tracking and new connectors in OpenMetadata 2.0.
---

# Ingestion & Connectors

**Four hard breaks here: the `pipelineStatuses` shape, the Databricks Pipeline connection, the
log-stream SSE payload, and the progress payload. Plus a Great Expectations major-version jump.**

---

## `pipelineStatuses` is now an array { #pipelinestatuses-is-now-an-array }

:material-close-octagon:{ .om-breaking } **Breaking** · Affects: every client reading ingestion
pipelines, dashboards, health checks, SDK users

```diff title="entity/services/ingestionPipelines/ingestionPipeline.json"
  "pipelineStatuses": {
-   "description": "Last of executions and status for the Pipeline.",
-   "$ref": "#/definitions/pipelineStatus"
+   "description": "List of the most recent executions and status for the Pipeline.",
+   "type": "array",
+   "items": { "$ref": "#/definitions/pipelineStatus" }
  }
```

The list endpoint now returns the **last five** statuses per pipeline (which also removes an N+1
query), instead of a single most-recent status object.

=== "1.13 response"

    ```json
    { "name": "my_pipeline", "pipelineStatuses": { "runId": "…", "pipelineState": "success" } }
    ```

=== "2.0 response"

    ```json
    { "name": "my_pipeline",
      "pipelineStatuses": [ { "runId": "…", "pipelineState": "success" },
                            { "runId": "…", "pipelineState": "failed" } ] }
    ```

!!! danger "Deserialisation will fail, not degrade"
    Strongly-typed clients (Java/Python SDK models, generated TypeScript types) will throw on the
    type change. Loosely-typed scripts reading `pipelineStatuses.pipelineState` will silently get
    `undefined`/`None`.

The 2.0.0 migration also strips any stale single-object `pipelineStatuses` value that a `GET → PUT`
round-trip may have persisted into stored entity JSON, so it cannot break deserialisation
server-side:

```sql
UPDATE ingestion_pipeline_entity
SET json = JSON_REMOVE(json, '$.pipelineStatuses')
WHERE JSON_CONTAINS_PATH(json, 'one', '$.pipelineStatuses');
```

!!! success "Action"
    Read `pipelineStatuses[0]` for the latest run. Regenerate SDK models.

---

## Databricks Pipeline connection requires `authType` { #databricks-pipeline-connection-requires-authtype }

:material-close-octagon:{ .om-breaking } **Breaking** · Affects: Databricks Pipeline services created
via API/IaC

```diff title="entity/services/connections/pipeline/databricksPipelineConnection.json"
- "required": ["hostPort", "token"]
+ "required": ["hostPort", "authType"]
```

The top-level `token` property is removed and moves under `authType`:

=== "1.13"

    ```json
    { "hostPort": "…", "token": "dapi…" }
    ```

=== "2.0"

    ```json
    { "hostPort": "…", "authType": { "token": "dapi…" } }
    ```

The 2.0.0 migration rewrites existing services in place:

```sql
UPDATE pipeline_service_entity
SET json = JSON_INSERT(JSON_REMOVE(json, '$.connection.config.token'),
                       '$.connection.config.authType',
                       JSON_OBJECT('token', JSON_EXTRACT(json, '$.connection.config.token')))
WHERE serviceType = 'DatabricksPipeline'
  AND JSON_EXTRACT(json, '$.connection.config.token') IS NOT NULL
  AND NOT JSON_CONTAINS_PATH(json, 'one', '$.connection.config.authType');
```

!!! success "Action"
    Existing services are migrated automatically. Update Terraform / Ansible / scripted service
    creation, and any ingestion YAML that sets `token` at the top level.

---

## Log stream SSE payload changed { #log-stream-sse-payload-changed }

:material-close-octagon:{ .om-breaking } **Breaking** — flagged `BREAKING CHANGE:` in the commit trailer

```
GET /v1/services/ingestionPipelines/logs/{fqn}/stream/{runId}
```

emits **one JSON `LogStreamEvent` per frame** instead of one raw log line.

```json title="entity/services/ingestionPipelines/logStreamEvent.json"
{
  "eventType": "logs | complete | error",
  "runId": "scheduled__2026-08-01T00:00:00+00:00",
  "logs": "…appended log content…",
  "after": "opaque-cursor",
  "replay": false,
  "endReason": "runFinished | idleTimeout | maxDuration | maxBytes"
}
```

- `after` is an opaque resume cursor — pass it back as the `after` query parameter to resume without
  re-reading delivered content.
- `endReason` is set **only** on a `complete` event. A stream that ends without one was cut short —
  reconnect from the last cursor.
- `replay: true` marks chunks replayed from the server buffer because the stream was already running
  when this client connected.
- The path now accepts an **id or FQN**, and `runId` is a free-form `String`, so Airflow's
  `scheduled__<ts>` run ids no longer 404 before reaching a backend.

!!! success "Action"
    Clients parsing `data:` as log text must parse it as JSON and read `event.logs`.

---

## Ingestion progress payload changed

:material-close-octagon:{ .om-breaking } **Breaking** · Affects: consumers of
`GET /v1/services/ingestionPipelines/progress/{fqn}/stream/{runId}`

`progressUpdate.progress` changes from a flat per-entity-type map to a **hierarchical tree**:

=== "1.13"

    > Progress by entity type (e.g., Database, DatabaseSchema, Table). Keys are entity types, values
    > contain `total`, `processed`, and `estimatedRemainingSeconds`.

=== "2.0 — `progressNode`"

    ```json
    {
      "label": "",                 // display name; empty for the run root
      "entityType": "Database",    // type of children this node counts
      "processed": 3,
      "expected": 12,              // null when the producer was iterated lazily
      "active": true,
      "overflow": 0,               // active children beyond the per-parent display cap
      "children": [ /* active or relevant child nodes only */ ]
    }
    ```

    A node counts its **direct children** — root counts databases, a database counts schemas, a
    schema counts tables.

### New service-level progress stream

:material-plus-circle:{ .om-additive }

```
GET /v1/services/ingestionPipelines/progress/service/{serviceType}/{serviceFqn}/stream
```

with a `serviceProgressEvent` payload, so the Services page can show live progress across all agents
for a service.

### Hierarchical progress tracking and SSE { #hierarchical-progress-tracking-and-sse }

Connectors now **declare** progress totals, the runner counts, and the registry reports. Coverage
added in 2.0:

- Database connectors generally, plus Databricks and Unity Catalog explicitly
- Airflow REST and dbt Cloud pipeline totals
- Looker and Tableau via MANUAL progress mode
- Profiler and auto-classification workflows
- Total assets, run-start emit, and agent-on-discovery events

Third-party logs, warnings and uncaught exceptions are captured in the streamable logger.

---

## Dependency changes

### Great Expectations 1.3+ required

:material-close-octagon:{ .om-breaking } **Breaking** · Affects: the `great-expectations` plugin

```diff title="ingestion/setup.py"
- "great-expectations": "great-expectations~=0.18.0",
- "great-expectations-1xx": "great-expectations~=1.0",
+ "great-expectations": "great-expectations~=1.3",
```

The separate `great-expectations-1xx` extra is **removed**. 1.3 is the floor because GX only gained
the validation-action registry there — on 1.0–1.2 `Checkpoint.actions` is a closed union that rejects
the OpenMetadata action outright.

!!! success "Action"
    Migrate GX checkpoints from 0.18 to 1.3+ syntax before upgrading, and replace
    `pip install "openmetadata-ingestion[great-expectations-1xx]"` with
    `pip install "openmetadata-ingestion[great-expectations]"`.

### Ingestion images require Python 3.12

:material-close-octagon:{ .om-breaking } **Breaking** · Affects: custom ingestion and Airflow images

The 2.0 ingestion image uses `python:3.12-slim-trixie`, and the bundled Airflow image uses
`apache/airflow:3.3.0-python3.12`. Custom images and binary wheels built only for CPython 3.10 must
be rebuilt for Python 3.12. This image change first shipped in 1.13.4, so no additional action is
needed when upgrading from that patch release.

!!! success "Action"
    Rebuild custom images on Python 3.12, remove or replace `cp310`-only wheels, and use the
    Python-3.12 Airflow base image. External Airflow deployments remain supported; only Airflow as
    OpenMetadata's internal orchestrator is scheduled for deprecation in 2.1.

### Other dependency floors raised

:material-alert:{ .om-behavioral } · Affects: pinned/air-gapped installs

| Package | 1.13 | 2.0 | Why |
|---------|------|-----|-----|
| `requests` | `>=2.23` | `>=2.32.4` | security |
| `sqlalchemy_exasol` | `>=6,<7` | `>=7.1.1,<8` | Exasol connector |
| `sqlalchemy-pytds` | `~=0.3` | `~=1.0` | 0.3.x raises `AttributeError` on every server-side cursor fetch when paired with python-tds 1.x |
| `gitpython` | `~=3.1.34` | `>=3.1.50` | security |
| `paramiko` | — | `>=3.5,<6` | new `sftp` plugin |

New plugin extras: **`prefect`** (uses `requests`, no extra deps) and **`sftp`**.

Contributor-facing: `black`, `isort`, `pylint` and `pycln` are replaced by **`ruff ~=0.15.12`**;
`basedpyright` is pinned to `1.39.3`; typing stubs are added for Google APIs, requests, pandas and
scipy. Exasol integration-test deps move to a dedicated `exasol-test` extra.

---

## New connectors

:material-plus-circle:{ .om-additive }

| Type | Connector | Service type value |
|------|-----------|--------------------|
| Database | SAP BW/4HANA | `SapBw4Hana` |
| Dashboard | Omni | `Omni` |
| Pipeline | Prefect (Cloud + Server auth) | `Prefect` |
| Pipeline | SAP BW/4HANA | `SapBw4HanaPipeline` |

New connection schemas: `sapBw4HanaConnection.json`, `omniConnection.json`, `prefectConnection.json`
(+ `prefect/cloudAuth.json`, `prefect/serverAuth.json`), `sapBw4HanaPipelineConnection.json`.

---

## Connector configuration changes

### Default filter patterns now exclude system objects

:material-alert:{ .om-behavioral } **Behavioural** · Affects: existing services too

| Connector | Field | New default excludes |
|-----------|-------|----------------------|
| Redshift | `tableFilterPattern` | `^(?:.*\.)?mv_tbl__.*__\d+$` |
| Kafka | `topicFilterPattern` | `^__.*`, `^_schemas$`, `^_confluent.*` |
| Redpanda | `topicFilterPattern` | `^__.*`, `^_schemas$`, `^_confluent.*` |

!!! warning "Assets may disappear from the catalog"
    If you deliberately catalogued Redshift materialised-view backing tables or Kafka internal
    topics, set an explicit filter pattern — the next ingestion run will otherwise skip them and
    (with `markDeletedTables`/stale deletion enabled) soft-delete them.

### SSIS `databaseConnection` is now optional

:material-plus-circle:{ .om-additive } **Relaxed requirement**

```diff
- "required": ["databaseConnection", "packageConnection"]
+ "required": ["packageConnection"]
```

Supports file-only SSIS mode. Existing configurations are unaffected.

### Snowflake

:material-plus-circle:{ .om-additive }

- `includeSemanticViews` (default `false`) ingests Snowflake semantic views; `tableType` gains
  `SemanticView`.
- Opt-in `ACCESS_HISTORY` lineage path.
- `policyAgentConfig` is declared with defaults and **backfilled onto existing services** — see
  [Data Governance](data-governance.md#policyagentconfig-defaults-are-backfilled-onto-existing-services).
- Private key field gains `uiFieldType: fileOrInput` and is marked `recommended`.

### Other connector changes

| Connector | Change |
|-----------|--------|
| Unity Catalog | Incremental metadata extraction; `policyAgentConfig` added |
| Databricks | Partner User-Agent for telemetry attribution; `policyAgentConfig` defaults |
| Postgres | `policyAgentConfig` **removed** from the schema and stripped from stored rows |
| MySQL | Custom `queryHistoryTable` for usage & lineage |
| ADLS | `containerName` field on the storage connection |
| Exasol | Comment access and query usage support |
| PowerBI | Datamart support; per-workspace cache scoping |
| dbt | `includeMetrics` toggle for semantic-layer metrics |
| Pipeline metadata | `ownershipUpdateMode` (`replace` \| `append`) controls how source owners merge with existing Pipeline owners |
| Storage | Compressed archive support; auto-classification for containers |
| Kafka Connect | Lineage for `EventRouter` / `RegexRouter` routed topics |

---

## Stale-entity cleanup API

:material-plus-circle:{ .om-additive } **New pattern for connectors**

```http
DELETE /v1/tables/deleteStale
```

```json title="type/bulkDeleteStaleRequest.json"
{
  "scopeFqn": "service.database.schema",
  "scopeEntityType": "databaseSchema",
  "seenFqns": ["…", "…"],
  "dryRun": false,
  "hardDelete": false,
  "recursive": true
}
```

Entities inside the scope that are **not** in `seenFqns` are considered stale and soft-deleted
(default). `dryRun: true` lists what would be deleted without deleting.

Available on 18 entity types: tables, databases, database schemas, stored procedures, dashboards,
charts, dashboard data models, pipelines, topics, ML models, search indexes, containers, API
collections, API endpoints, and the four drive types.

!!! warning "Powerful by construction"
    A `seenFqns` list truncated by a partial connector run will mark everything else stale. Always
    exercise `dryRun` first when wiring this into custom connectors.

---

## Ingestion pipeline management

| Change | Class | Detail |
|--------|-------|--------|
| `agentType` list filter | Additive | `GET /v1/services/ingestionPipelines?agentType=metadata\|application` — no need to enumerate `pipelineType` values |
| Queued-status polling | Behavioural | The server no longer polls orchestrators for queued status, reducing Airflow API load |
| Force delete | Additive | Admins can force-delete ingestion pipelines |
| `policyAgent` pipeline type | Additive | New `pipelineType` value |
| `DELETE /v1/topics/{id}/sampleData` | Additive | Clear topic sample data |

---

## Connector framework internals

:material-alert:{ .om-behavioral } · Affects: **custom connector authors only**

2.0 continues the `BaseConnection` migration and related refactors:

- mlmodel, metadata, messaging, storage, search and drive connectors migrated to `BaseConnection`.
- `get_connection_dict` dropped from `BaseConnection`; data-diff gated via a `Protocol`.
- Duplicated test-connection helpers consolidated; Athena migrated to the declarative
  test-connection framework; a shared `GetPipelines` step added to the pipeline test-connection
  vertical.
- `ClassifiableEntityAdapter` replaces scattered `isinstance` checks.
- A `TagRegistry` domain layer is introduced.
- `SamplerInterface` collapses to a single typed config object.
- `ConnectionsRouterClassBase` enables pluggable connection routing in the UI.
- Comprehensive diagnostics added for the Airflow connection check.

!!! success "Action"
    Rebuild and re-test custom connectors against the 2.0 ingestion package before upgrading
    production agents.
