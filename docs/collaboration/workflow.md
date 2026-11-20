# Workflow

A unit of work that will be triggered as an API call to the OpenMetadata server.

**Source schema:** `schemas/entity/automations/workflow.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of this workflow instance. |
| `name` | `reference or object` | Name of the workflow. |
| `displayName` | `string` | Display Name that identifies this workflow definition. |
| `description` | `reference or object` | Description of the test connection def. |
| `fullyQualifiedName` | `reference or object` | FullyQualifiedName same as `name`. |
| `workflowType` | `reference or object` | Type of the workflow. |
| `status` | `reference or object` | Workflow computation status. |
| `request` | `reference or object` | Request body for a specific workflow type |
| `response` | `reference or object` | Response to the request. |
| `openMetadataServerConnection` | `reference or object` |  |
| `owners` | `reference or object` | Owners of this workflow. |
| `version` | `reference or object` | Metadata version of the entity. |
| `updatedAt` | `reference or object` | Last update time corresponding to the new version of the entity in Unix epoch time milliseconds. |
| `updatedBy` | `string` | User who made the update. |
| `impersonatedBy` | `reference or object` | Bot user that performed the action on behalf of the actual user. |
| `href` | `reference or object` | Link to the resource corresponding to this entity. |
| `changeDescription` | `reference or object` | Change that lead to this version of the entity. |
| `incrementalChangeDescription` | `reference or object` | Change that lead to this version of the entity. |
| `deleted` | `boolean` | When `true` indicates the entity has been soft deleted. |
| `domains` | `reference or object` | Domains the asset belongs to. When not set, the asset inherits the domain from the parent it belongs to. |
| `dataProducts` | `reference or object` | List of data products this entity is part of. |

## Enum fields

### definitions.workflowType

This enum defines the type for which this workflow applies to.

**Allowed values:**

- `TEST_CONNECTION`
- `REVERSE_INGESTION`
- `QUERY_RUNNER`
- `TEST_SPARK_ENGINE_CONNECTION`

### definitions.workflowStatus

Enum defining possible Workflow status

**Allowed values:**

- `Pending`
- `Successful`
- `Failed`
- `Running`
