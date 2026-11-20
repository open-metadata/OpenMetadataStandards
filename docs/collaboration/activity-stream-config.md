# ActivityStreamConfig

Configuration for activity stream behavior at global or domain level.

**Source schema:** `schemas/entity/activity/activityStreamConfig.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier for this configuration. |
| `scope` | `reference or object` | Whether this config applies globally or to a specific domain. |
| `scopeReference` | `reference or object` | Reference to the domain this config applies to (when scope is 'domain'). |
| `enabled` | `boolean` | Whether to generate activity events for this scope. |
| `retentionDays` | `integer` | How long to keep activity events before automatic deletion. |
| `excludeEventTypes` | `array` | Event types to exclude from the activity stream. |
| `excludeEntityTypes` | `array` | Entity types to exclude from the activity stream. |
| `visibility` | `reference or object` | Who can see activity events in this scope. |

## Enum fields

### definitions.activityStreamScope

Scope of the activity stream configuration.

**Default:** `domain`

**Allowed values:**

- `global`
- `domain`

### definitions.activityStreamVisibility

Who can see activity events.

**Default:** `domainOnly`

**Allowed values:**

- `domainOnly`
- `organization`
