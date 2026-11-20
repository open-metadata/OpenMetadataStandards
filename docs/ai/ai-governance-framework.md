# AIGovernanceFramework

Workspace-level AI governance framework configuration. A framework is a library of controls that drives compliance assessments. Enabling a framework auto-applies it to in-scope AI assets via the autoApply rules.

**Source schema:** `schemas/entity/ai/aiGovernanceFramework.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of the AI Governance Framework. |
| `name` | `reference or object` | Name that identifies this framework (e.g. eu_ai_act). |
| `fullyQualifiedName` | `reference or object` | Fully qualified name of the framework. |
| `displayName` | `string` | Display name (e.g. 'EU AI Act'). |
| `description` | `reference or object` | Description of what this framework covers. |
| `reference` | `string` | External reference for the framework (e.g. 'Reg EU 2024/1689', 'AI 100-1', 'ISO/IEC 42001:2023'). |
| `region` | `string` | Geographic jurisdiction this framework covers (e.g. 'European Union', 'United States', 'Global'). |
| `source` | `reference or object` |  |
| `forkedFrom` | `reference or object` | When source is 'ForkedFrom', the framework this was forked from. |
| `enabled` | `boolean` | Whether this framework is enabled in the workspace. Disabled frameworks remain in the library but do not auto-apply. |
| `stewards` | `reference or object` | Users or teams responsible for this framework's assessments. |
| `assessmentCadence` | `reference or object` |  |
| `autoApply` | `reference or object` |  |
| `nextDeadline` | `reference or object` | Next certification or assessment deadline. |
| `owners` | `reference or object` | Owners of this framework configuration. |
| `tags` | `array` | Tags for this framework. |
| `version` | `reference or object` | Metadata version of the entity |
| `updatedAt` | `reference or object` | Last update time in Unix epoch milliseconds |
| `updatedBy` | `string` | User who made the update |
| `href` | `reference or object` | Link to this resource |
| `changeDescription` | `reference or object` | Change that led to this version |
| `incrementalChangeDescription` | `reference or object` | Change that led to this version |
| `deleted` | `boolean` | When true, indicates the entity has been soft deleted |
| `extension` | `reference or object` | Entity extension data with custom attributes |
| `domains` | `reference or object` | Domains this framework belongs to |
| `lifeCycle` | `reference or object` |  |
| `sourceHash` | `string` |  |

## Enum fields

### definitions.frameworkSource

Where the framework definition came from

**Allowed values:**

- `BuiltIn`
- `Custom`
- `ForkedFrom`

### definitions.assessmentCadence

How often this framework requires reassessment of in-scope assets

**Allowed values:**

- `Monthly`
- `Quarterly`
- `SemiAnnual`
- `Annual`
