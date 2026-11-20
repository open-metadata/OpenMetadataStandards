# WorkflowDefinition

Defines a workflow, having all the different pieces and attributes.

**Source schema:** `schemas/governance/workflows/workflowDefinition.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of this workflow definition. |
| `name` | `reference or object` | Name that identifies this workflow definition. |
| `displayName` | `string` | Display Name that identifies this workflow definition. |
| `fullyQualifiedName` | `reference or object` | FullyQualifiedName same as `name`. |
| `description` | `reference or object` | Description of the workflow definition. |
| `owners` | `reference or object` | Owners of this workflow definition. |
| `version` | `reference or object` | Metadata version of the entity. |
| `updatedAt` | `reference or object` | Last update time corresponding to the new version of the entity in Unix epoch time milliseconds. |
| `updatedBy` | `string` | User who made the update. |
| `href` | `reference or object` | Link to the resource corresponding to this entity. |
| `changeDescription` | `reference or object` | Change that lead to this version of the entity. |
| `incrementalChangeDescription` | `reference or object` | Change that lead to this version of the entity. |
| `deleted` | `boolean` | When `true` indicates the entity has been soft deleted. |
| `deployed` | `boolean` | When `true` indicates the workflow is deployed. |
| `suspended` | `boolean` | When `true` indicates the workflow is suspended and not accepting new executions. |
| `config` | `reference or object` |  |
| `trigger` | `reference or object` | Workflow Trigger. |
| `nodes` | `array` | List of nodes used on the workflow. |
| `edges` | `array` | List of edges that connect the workflow elements and guide its flow. |

## Enum fields

### definitions.type

**Allowed values:**

- `eventBasedEntity`
- `noOp`
- `periodicBatchEntity`
