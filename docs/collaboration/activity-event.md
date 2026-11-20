# ActivityEvent

A lightweight activity notification for user dashboards and feeds. NOT for compliance, audit trails, or workflows - use entity version history and Task entity for those purposes.

**Source schema:** `schemas/entity/activity/activityEvent.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier for this activity event. |
| `eventType` | `reference or object` | Type of activity that occurred. |
| `entity` | `reference or object` | Reference to the entity that changed. |
| `about` | `string` | EntityLink string identifying the specific entity/field/column the activity is about. Format: <#E::entityType::fqn::fieldName::arrayFieldName::arrayFieldValue> |
| `domains` | `reference or object` | Domains this activity belongs to, inherited from the source entity for domain-scoped visibility. |
| `actor` | `reference or object` | User or bot who performed the action. May be absent for system events or hard-deleted users. |
| `timestamp` | `reference or object` | Timestamp when the activity occurred in Unix epoch time milliseconds. |
| `summary` | `string` | Human-readable summary of the activity for display. |
| `fieldName` | `string` | Name of the field that was changed, if applicable. |
| `oldValue` | `string` | Previous value (truncated for display, not for audit). |
| `newValue` | `string` | New value (truncated for display, not for audit). |
| `changeDescription` | `reference or object` | Optional structured change description with field-level details. |
| `reactions` | `reference or object` | Reactions for this activity event. |

## Enum fields

### definitions.activityEventType

Type of activity event.

**Allowed values:**

- `EntityCreated`
- `EntityUpdated`
- `EntityDeleted`
- `EntitySoftDeleted`
- `EntityRestored`
- `DescriptionUpdated`
- `TagsUpdated`
- `OwnerUpdated`
- `DomainUpdated`
- `TierUpdated`
- `CustomPropertyUpdated`
- `ColumnDescriptionUpdated`
- `ColumnTagsUpdated`
- `TestCaseStatusChanged`
- `PipelineStatusChanged`
