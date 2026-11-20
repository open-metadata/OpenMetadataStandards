# QueryRunnerResponse

Query Runner Response

**Source schema:** `schemas/entity/automations/response/queryRunnerResponse.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `status` | `reference or object` | Status of the query execution |
| `message` | `string` | Error message in case of failure |
| `errorLog` | `string` | Detailed error log in case of failure |
| `duration` | `number` | Duration of the query execution in seconds |
| `results` | `reference or object` | Results of the query execution |
| `executedQuery` | `string` | The query that was executed, post-transpile but without the guardrail row LIMIT. If the user supplied their own LIMIT in the original query, it is preserved here. |
| `executionLimit` | `integer` | Row LIMIT injected by the query runner as a guardrail when the original query had no LIMIT. Null when the user's query already contained a LIMIT or when no cap was applied. |
| `resultPath` | `string` | S3 or GCS key path where the query results CSV is stored. Present when storage mode is enabled; mutually exclusive with 'results'. |

## Enum fields

### definitions.statusType

Enum defining possible Query Runner status

**Allowed values:**

- `Successful`
- `Failed`
- `Running`
