# PromptTemplate

Prompt Template entity representing a reusable prompt template for AI agents. Templates can include variables, system prompts, and examples for consistent AI behavior.

**Source schema:** `schemas/entity/ai/promptTemplate.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of the Prompt Template |
| `name` | `reference or object` | Name that identifies this Prompt Template |
| `fullyQualifiedName` | `reference or object` | Fully qualified name of the Prompt Template |
| `displayName` | `string` | Display name for the Prompt Template |
| `description` | `reference or object` | Description of the Prompt Template and its purpose |
| `templateContent` | `string` | The actual prompt template content with variables in {{variable}} format |
| `systemPrompt` | `string` | System prompt to set the AI's behavior and context |
| `variables` | `array` | Variables used in this template |
| `examples` | `array` | Examples demonstrating how to use this template |
| `templateType` | `string` | Type of prompt template |
| `templateVersion` | `string` | Template version for tracking changes |
| `parentTemplate` | `reference or object` | Reference to parent template if this is a version/fork |
| `usedByAgents` | `reference or object` | AI Agents using this template |
| `metrics` | `reference or object` |  |
| `tags` | `array` | Tags for this Prompt Template |
| `version` | `reference or object` | Metadata version of the entity |
| `owners` | `reference or object` | Owners of this Prompt Template |
| `followers` | `reference or object` | Followers of this Prompt Template |
| `domain` | `reference or object` | Domain the Prompt Template belongs to |
| `updatedAt` | `reference or object` | Last update time in Unix epoch milliseconds |
| `updatedBy` | `string` | User who made the update |
| `href` | `reference or object` | Link to this resource |
| `changeDescription` | `reference or object` | Change that led to this version |
| `incrementalChangeDescription` | `reference or object` | Change that led to this version |
| `deleted` | `boolean` | When true, indicates the entity has been soft deleted |
| `extension` | `reference or object` | Entity extension data with custom attributes |
| `domains` | `reference or object` | Domains the Prompt Template belongs to |
| `votes` | `reference or object` | Votes on the entity |
| `lifeCycle` | `reference or object` | Life Cycle properties of the entity |
| `sourceHash` | `string` | Source hash of the entity |

## Enum fields

### definitions.templateVariable.properties.dataType

Expected data type for this variable

**Allowed values:**

- `String`
- `Number`
- `Boolean`
- `Array`
- `Object`

### properties.templateType

Type of prompt template

**Allowed values:**

- `ChatCompletion`
- `TextGeneration`
- `CodeGeneration`
- `Embedding`
- `Classification`
- `Extraction`
- `Custom`
