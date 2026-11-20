# LearningResource

A learning resource such as an in-product tutorial, Storylane walkthrough, or expert video contextualized for product surfaces.

**Source schema:** `schemas/entity/learning/learningResource.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` |  |
| `name` | `reference or object` |  |
| `fullyQualifiedName` | `reference or object` |  |
| `displayName` | `string` | Display label presented to users. |
| `description` | `reference or object` |  |
| `resourceType` | `reference or object` |  |
| `categories` | `array` | Topic categories the resource belongs to. |
| `difficulty` | `reference or object` |  |
| `source` | `reference or object` |  |
| `estimatedDuration` | `integer` | Approximate viewing time in seconds. |
| `contexts` | `array` | List of contexts where this resource should surface. |
| `status` | `string` | Lifecycle state for controllable publishing. |
| `tags` | `array` | Tags attached to the learning resource. |
| `owners` | `reference or object` | Owners accountable for maintaining this resource. |
| `reviewers` | `reference or object` |  |
| `followers` | `reference or object` |  |
| `changeDescription` | `reference or object` |  |
| `incrementalChangeDescription` | `reference or object` |  |
| `deleted` | `boolean` | Soft delete marker. |
| `version` | `reference or object` |  |
| `updatedAt` | `reference or object` |  |
| `updatedBy` | `string` |  |
| `impersonatedBy` | `reference or object` |  |
| `href` | `reference or object` |  |
| `extension` | `reference or object` |  |

## Enum fields

### definitions.resourceType

Kind of learning asset represented.

**Allowed values:**

- `Storylane`
- `Video`
- `Article`

### definitions.resourceCategory

Primary topic grouping for the resource.

**Allowed values:**

- `Discovery`
- `Administration`
- `DataGovernance`
- `DataQuality`
- `Observability`
- `AI`

### definitions.resourceDifficulty

Suggested proficiency tier for the resource.

**Allowed values:**

- `Intro`
- `Intermediate`
- `Advanced`

### properties.status

Lifecycle state for controllable publishing.

**Default:** `Active`

**Allowed values:**

- `Draft`
- `Active`
- `Deprecated`
