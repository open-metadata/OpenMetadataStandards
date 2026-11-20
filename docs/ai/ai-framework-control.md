# AIFrameworkControl

A single control within an AI Governance Framework (e.g. EU AI Act Article 10). Controls drive per-asset compliance assessments.

**Source schema:** `schemas/entity/ai/aiFrameworkControl.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` |  |
| `name` | `reference or object` | Control name (typically the code, e.g. 'art-10'). |
| `fullyQualifiedName` | `reference or object` |  |
| `displayName` | `string` | Human-readable label (e.g. 'Article 10 — Data and data governance'). |
| `description` | `reference or object` |  |
| `framework` | `reference or object` | Framework this control belongs to. |
| `code` | `string` | Stable short code for the control within its framework (e.g. 'art-10'). |
| `category` | `reference or object` |  |
| `evidenceRequirements` | `array` | What evidence assessors should attach to demonstrate this control is met. |
| `owners` | `reference or object` |  |
| `tags` | `array` |  |
| `version` | `reference or object` |  |
| `updatedAt` | `reference or object` |  |
| `updatedBy` | `string` |  |
| `href` | `reference or object` |  |
| `changeDescription` | `reference or object` |  |
| `incrementalChangeDescription` | `reference or object` |  |
| `deleted` | `boolean` |  |
| `extension` | `reference or object` |  |
| `domains` | `reference or object` |  |
| `lifeCycle` | `reference or object` |  |
| `sourceHash` | `string` |  |

## Enum fields

### definitions.controlCategory

**Allowed values:**

- `Risk`
- `Process`
- `Data`
- `Transparency`
- `Quality`
- `Governance`
