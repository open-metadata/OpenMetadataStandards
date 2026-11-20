# Task

A Task represents an actionable work item for data governance workflows such as data access requests, glossary approvals, metadata updates, and custom workflows. Tasks have their own lifecycle, assignments, and tracking capabilities.

**Source schema:** `schemas/entity/tasks/task.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier (UUID) for this task. |
| `taskId` | `string` | Human-readable task identifier (e.g., TASK-00001). |
| `name` | `reference or object` |  |
| `displayName` | `string` | Display name for the task. |
| `fullyQualifiedName` | `reference or object` |  |
| `description` | `reference or object` | Description of the task in Markdown format. |
| `category` | `reference or object` |  |
| `type` | `reference or object` |  |
| `status` | `reference or object` |  |
| `priority` | `reference or object` |  |
| `about` | `reference or object` | Reference to the entity this task is about. |
| `aboutFqnHash` | `string` | Hash of the target entity's fully qualified name for efficient querying. Computed from about.fullyQualifiedName using FullyQualifiedName.buildHash(). |
| `domains` | `reference or object` | Domains this task belongs to, inherited from the target entity for visibility scoping. |
| `createdBy` | `reference or object` | User who created this task. |
| `createdById` | `string` | UUID of the user who created this task. Stored in JSON for efficient querying via generated column index. |
| `approvedBy` | `reference or object` | User who approved this task (set when an approval transition fires; distinct from resolution.resolvedBy which is set only on terminal transitions). |
| `approvedById` | `string` | UUID of the user who approved this task. Stored in JSON for efficient querying via generated column index. |
| `approvedAt` | `reference or object` | Timestamp when the task was approved. |
| `assignees` | `reference or object` | Users or teams assigned to complete this task. |
| `reviewers` | `reference or object` | Users or teams who should review this task. |
| `watchers` | `reference or object` | Users following this task for updates. |
| `payload` | `object` | Task-specific payload validated at runtime by the resolved TaskFormSchema for the task type and category. |
| `resolution` | `reference or object` | Resolution details when task is completed. |
| `dueDate` | `reference or object` | Due date for task completion. |
| `externalReference` | `reference or object` | Reference to external system (JIRA, ServiceNow, etc.). |
| `workflowInstanceId` | `reference or object` | ID of the workflow instance managing this task. |
| `workflowDefinitionId` | `reference or object` | ID of the workflow definition bound to this task lifecycle. |
| `workflowStageId` | `string` | Current workflow stage identifier for this task. |
| `workflowStageDisplayName` | `string` | Human-readable workflow stage name shown to users. |
| `availableTransitions` | `array` | Transitions available from the current workflow stage. |
| `taskFormSchemaId` | `reference or object` | ID of the resolved TaskFormSchema used to validate and render this task. |
| `taskFormSchemaVersion` | `reference or object` | Version of the resolved TaskFormSchema captured when this task was created. |
| `comments` | `array` | Comments on this task. |
| `commentCount` | `integer` | Number of comments on this task. |
| `tags` | `array` | Tags for this task. |
| `createdAt` | `reference or object` | Timestamp when the task was created. |
| `version` | `reference or object` | Metadata version of the entity. |
| `updatedAt` | `reference or object` | Last update timestamp. |
| `updatedBy` | `string` | User who made the last update. |
| `href` | `reference or object` | Link to the resource. |
| `changeDescription` | `reference or object` | Change that lead to this version of the task. |
| `deleted` | `boolean` | When true indicates the entity has been soft deleted. |

## Enum fields

### definitions.taskCategory

Category of task for grouping similar task types.

**Allowed values:**

- `Approval`
- `DataAccess`
- `MetadataUpdate`
- `Incident`
- `Review`
- `Custom`

### definitions.taskType

Type of task determining the workflow and required payload.

**Allowed values:**

- `GlossaryApproval`
- `RequestApproval`
- `DataAccessRequest`
- `DescriptionUpdate`
- `TagUpdate`
- `OwnershipUpdate`
- `TierUpdate`
- `DomainUpdate`
- `Suggestion`
- `TestCaseResolution`
- `IncidentResolution`
- `PipelineReview`
- `DataQualityReview`
- `RecognizerFeedbackApproval`
- `CustomTask`

### definitions.taskStatus

Current status of the task in its lifecycle.

**Default:** `Open`

**Allowed values:**

- `Open`
- `InProgress`
- `Pending`
- `Approved`
- `Granted`
- `ManualRevoke`
- `Rejected`
- `Completed`
- `Cancelled`
- `Failed`
- `Revoked`
- `Expired`

### definitions.taskPriority

Priority level of the task.

**Default:** `Medium`

**Allowed values:**

- `Critical`
- `High`
- `Medium`
- `Low`

### definitions.resolutionType

How the task was resolved.

**Allowed values:**

- `Approved`
- `Rejected`
- `Completed`
- `Cancelled`
- `TimedOut`
- `AutoApproved`
- `AutoRejected`
- `Revoked`
- `Expired`

### definitions.externalReference.properties.syncStatus

Status of sync with external system.

**Default:** `synced`

**Allowed values:**

- `synced`
- `pending`
- `conflict`
- `error`
