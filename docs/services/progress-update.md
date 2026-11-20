# ProgressUpdate

Real-time progress update for SSE streaming during ingestion pipeline execution

**Source schema:** `schemas/entity/services/ingestionPipelines/progressUpdate.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `runId` | `string` | Pipeline run ID |
| `timestamp` | `reference or object` | When this update was created |
| `updateType` | `reference or object` | Type of progress update |
| `stepName` | `string` | Name of the current step |
| `progress` | `reference or object` | Root of the hierarchical progress tree for this run |
| `globalCounters` | `array` | Run-level counters that survive scope pruning (e.g. Database, DatabaseSchema, Workspace). Each carries done and an optional upfront total. |
| `estimatedSecondsRemaining` | `['integer', 'null']` | Estimated seconds until the run completes; null when not yet computable |
| `totalAssetsIngested` | `['integer', 'null']` | Monotonic count of leaf assets ingested so far (tables + stored procedures + other leaf entities). Survives scope pruning and is present on the terminal PIPELINE_COMPLETE event, so it carries the run's final asset total. |
| `currentEntity` | `string` | FQN of the entity currently being processed |
| `message` | `string` | Human-readable status message |

## Enum fields

### definitions.progressUpdateType

Type of progress update

**Allowed values:**

- `DISCOVERY`
- `PROCESSING`
- `STEP_COMPLETE`
- `PIPELINE_COMPLETE`
- `ERROR`
