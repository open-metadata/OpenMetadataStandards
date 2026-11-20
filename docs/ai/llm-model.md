# LLMModel

LLM Model entity representing a registered Large Language Model deployment, fine-tune, or base model. Models are independent entities that can be referenced by multiple AI agents.

**Source schema:** `schemas/entity/ai/llmModel.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of the LLM Model |
| `name` | `reference or object` | Name that identifies this LLM Model |
| `fullyQualifiedName` | `reference or object` | Fully qualified name of the LLM Model |
| `displayName` | `string` | Display name for the LLM Model |
| `description` | `reference or object` | Description of the LLM Model, its purpose, and capabilities |
| `service` | `reference or object` | OPTIONAL reference to LLMService where this model is hosted |
| `modelType` | `reference or object` |  |
| `baseModel` | `string` | Base model name (e.g., 'gpt-4', 'claude-3-opus', 'llama-2-70b') |
| `modelVersion` | `string` | Version of the model |
| `modelProvider` | `string` | Model provider (e.g., 'OpenAI', 'Anthropic', 'Meta') |
| `providerModelId` | `string` | Provider's internal model ID |
| `capabilities` | `array` | Capabilities of this model |
| `modelSpecifications` | `reference or object` |  |
| `trainingMetadata` | `reference or object` |  |
| `modelEvaluation` | `reference or object` |  |
| `usedByAgents` | `reference or object` | AI Agents that use this model |
| `governanceStatus` | `string` | Governance status - tracks unauthorized/shadow AI models |
| `detection` | `reference or object` | Origin of Shadow AI detection — auto-discovered from outbound API traffic, SSO logs, connector audits, etc. Populated for models that were not registered through the intake wizard. |
| `evidence` | `reference or object` | Supporting documentation URLs (DPIA, model card, fairness analysis, technical docs) |
| `remediationActions` | `array` | Structured remediation actions with assignee, due date, priority, and status |
| `certifications` | `array` | Certifications this model has received |
| `regulatoryCompliance` | `array` | Regulatory compliance standards met |
| `costMetrics` | `reference or object` |  |
| `deploymentInfo` | `reference or object` |  |
| `owners` | `reference or object` | Owners of this LLM Model |
| `followers` | `reference or object` | Followers of this LLM Model |
| `domain` | `reference or object` | Domain the LLM Model belongs to |
| `dataProducts` | `reference or object` | Data products this model is part of |
| `dataContract` | `reference or object` | Reference to the data contract for this entity. |
| `tags` | `array` | Tags for this LLM Model |
| `version` | `reference or object` | Metadata version of the entity |
| `updatedAt` | `reference or object` | Last update time in Unix epoch milliseconds |
| `updatedBy` | `string` | User who made the update |
| `href` | `reference or object` | Link to this resource |
| `changeDescription` | `reference or object` | Change that led to this version |
| `incrementalChangeDescription` | `reference or object` | Change that led to this version |
| `deleted` | `boolean` | When true, indicates the entity has been soft deleted |
| `certification` | `reference or object` |  |
| `extension` | `reference or object` | Entity extension data with custom attributes |
| `domains` | `reference or object` | Domains the LLMModel belongs to |
| `votes` | `reference or object` | Votes on the entity |
| `reviewers` | `reference or object` | Risk Council reviewers responsible for approving this LLM Model. |
| `entityStatus` | `reference or object` | Governance approval status of the LLM Model. |
| `lifeCycle` | `reference or object` | Life Cycle properties of the entity |
| `sourceHash` | `string` | Source hash of the entity |

## Enum fields

### definitions.modelType

Type of LLM model

**Allowed values:**

- `BaseModel`
- `FineTuned`
- `Quantized`
- `Distilled`
- `Adapter`
- `Custom`

### definitions.modelCapability

**Allowed values:**

- `TextGeneration`
- `CodeGeneration`
- `Embeddings`
- `Chat`
- `Vision`
- `Audio`
- `FunctionCalling`
- `ToolUse`

### definitions.trainingMetadata.properties.trainingType

**Allowed values:**

- `FullFineTune`
- `LoRA`
- `QLoRA`
- `PrefixTuning`
- `PromptTuning`
- `RLHF`

### definitions.trainingMetadata.properties.dataLineage.items.properties.sensitivityLevel

**Allowed values:**

- `Public`
- `Internal`
- `Confidential`
- `Restricted`

### definitions.deploymentInfo.properties.deploymentType

**Allowed values:**

- `API`
- `SelfHosted`
- `Hybrid`
- `OnPremise`

### properties.governanceStatus

Governance status - tracks unauthorized/shadow AI models

**Allowed values:**

- `Approved`
- `PendingReview`
- `Rejected`
- `Unauthorized`
