# WorkflowInstance

Defines a workflow instance.

**Source schema:** `schemas/governance/workflows/workflowInstance.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of this workflow instance state. |
| `workflowDefinitionId` | `reference or object` | Workflow Definition Id. |
| `startedAt` | `reference or object` | Timestamp on which the workflow instance started. |
| `endedAt` | `reference or object` | Timestamp on which the workflow instance ended. |
| `variables` | `object` |  |
| `timestamp` | `reference or object` | Timestamp on which the workflow instance state was created. |
| `status` | `reference or object` |  |
| `exception` | `string` |  |

## Enum fields

### definitions.workflowStatus

**Allowed values:**

- `RUNNING`
- `FINISHED`
- `FAILURE`
- `EXCEPTION`
- `SUPERSEDED`
