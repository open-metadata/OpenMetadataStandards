# LLMService

LLM Service Entity for managing Large Language Model providers such as OpenAI, Anthropic, Azure OpenAI, AWS Bedrock, etc.

**Source schema:** `schemas/entity/services/llmService.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of this LLM service instance |
| `name` | `reference or object` | Name that identifies this LLM service |
| `fullyQualifiedName` | `reference or object` | FullyQualifiedName same as `name` |
| `serviceType` | `reference or object` | Type of LLM service provider |
| `description` | `string` | Description of this LLM service instance |
| `displayName` | `string` | Display Name that identifies this LLM service |
| `version` | `reference or object` | Metadata version of the entity |
| `updatedAt` | `reference or object` | Last update time in Unix epoch milliseconds |
| `updatedBy` | `string` | User who made the update |
| `models` | `reference or object` | LLM Models registered with this service |
| `pipelines` | `reference or object` | References to pipelines deployed for this LLM service |
| `connection` | `reference or object` |  |
| `testConnectionResult` | `reference or object` | Last test connection results for this service |
| `tags` | `array` | Tags for this LLM Service |
| `owners` | `reference or object` | Owners of this LLM service |
| `href` | `reference or object` | Link to the resource corresponding to this LLM service |
| `changeDescription` | `reference or object` | Change that led to this version of the entity |
| `incrementalChangeDescription` | `reference or object` | Change that led to this version of the entity |
| `deleted` | `boolean` | When `true` indicates the entity has been soft deleted |
| `dataProducts` | `reference or object` | List of data products this entity is part of |
| `dataContract` | `reference or object` | Reference to the data contract for this entity. |
| `followers` | `reference or object` | Followers of this entity |
| `domains` | `reference or object` | Domains the LLM service belongs to |
| `ingestionRunner` | `reference or object` | The ingestion agent responsible for executing the ingestion pipeline |

## Enum fields

### definitions.llmServiceType

Type of LLM service provider

**Allowed values:**

- `OpenAI`
- `Anthropic`
- `AzureOpenAI`
- `Bedrock`
- `VertexAI`
- `Ollama`
- `HuggingFace`
- `CustomLLM`
