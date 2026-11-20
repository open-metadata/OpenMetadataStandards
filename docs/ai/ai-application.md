# AIApplication

AI Application entity representing AI systems including chatbots, agents, copilots, and other AI-powered applications. Applications can use multiple LLM models and integrate with various tools and data sources.

**Source schema:** `schemas/entity/ai/aiApplication.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of the AI Application. |
| `name` | `reference or object` | Name that identifies this AI Application. |
| `fullyQualifiedName` | `reference or object` | Fully qualified name of the AI Application. |
| `displayName` | `string` | Display name for the AI Application. |
| `description` | `reference or object` | Description of the AI Application, its purpose, and usage. |
| `applicationType` | `reference or object` |  |
| `developmentStage` | `reference or object` |  |
| `modelConfigurations` | `array` | Multiple LLM models this application can use for different purposes |
| `primaryModel` | `reference or object` | Primary/default LLM model used by this application |
| `promptTemplates` | `reference or object` | Prompt templates used by this application |
| `tools` | `reference or object` | MCP tools or other tools available to this application |
| `mcpServers` | `reference or object` | MCP servers this application connects to for tools, resources, and prompts |
| `dataSources` | `reference or object` | Data sources (tables, APIs, etc.) this application can access |
| `knowledgeBases` | `reference or object` | Vector databases, document stores used for RAG |
| `upstreamApplications` | `reference or object` | Other AI applications this application depends on (multi-agent orchestration) |
| `downstreamApplications` | `reference or object` | AI applications that depend on this application |
| `framework` | `reference or object` |  |
| `governanceMetadata` | `reference or object` |  |
| `biasMetrics` | `reference or object` |  |
| `performanceMetrics` | `reference or object` |  |
| `qualityMetrics` | `reference or object` |  |
| `safetyMetrics` | `reference or object` |  |
| `testSuites` | `reference or object` | Test suites for validating this AI application |
| `sourceCode` | `string` | Link to source code repository |
| `deploymentUrl` | `string` | Production deployment endpoint |
| `documentation` | `string` | Link to external documentation |
| `owners` | `reference or object` | Owners of this AI Application |
| `followers` | `reference or object` | Followers of this AI Application |
| `domain` | `reference or object` | Domain the AI Application belongs to |
| `dataProducts` | `reference or object` | Data products this AI Application is part of |
| `dataContract` | `reference or object` | Reference to the data contract for this entity. |
| `tags` | `array` | Tags for this AI Application |
| `version` | `reference or object` | Metadata version of the entity |
| `updatedAt` | `reference or object` | Last update time in Unix epoch milliseconds |
| `updatedBy` | `string` | User who made the update |
| `href` | `reference or object` | Link to this resource |
| `changeDescription` | `reference or object` | Change that led to this version |
| `incrementalChangeDescription` | `reference or object` | Change that led to this version |
| `deleted` | `boolean` | When true, indicates the entity has been soft deleted |
| `certification` | `reference or object` |  |
| `extension` | `reference or object` | Entity extension data with custom attributes |
| `domains` | `reference or object` | Domains the AI Application belongs to |
| `votes` | `reference or object` | Votes on the entity |
| `reviewers` | `reference or object` | Risk Council reviewers responsible for approving this AI Application. |
| `entityStatus` | `reference or object` | Governance approval status of the AI Application. |
| `lifeCycle` | `reference or object` | Life Cycle properties of the entity |
| `sourceHash` | `string` | Source hash of the entity |

## Enum fields

### definitions.applicationType

Type of AI application based on primary function and interaction pattern

**Allowed values:**

- `Chatbot`
- `Agent`
- `Copilot`
- `Assistant`
- `RAG`
- `CodeGenerator`
- `DataAnalyst`
- `AutomationBot`
- `MultiAgent`
- `Custom`

### definitions.developmentStage

Development stage of the AI application. 'Unauthorized' indicates Shadow AI that needs governance review.

**Allowed values:**

- `Proposal`
- `Development`
- `Testing`
- `Staging`
- `Production`
- `Deprecated`
- `Unauthorized`

### definitions.modelConfiguration.properties.purpose

Purpose of this model in the application workflow

**Allowed values:**

- `Primary`
- `Reasoning`
- `Embedding`
- `CodeGeneration`
- `Fallback`
- `CostOptimization`

### definitions.governanceMetadata.properties.registrationStatus

Registration status - used to track Shadow AI

**Allowed values:**

- `Registered`
- `Unregistered`
- `PendingApproval`
- `Approved`
- `Rejected`

### definitions.governanceMetadata.properties.riskAssessment.properties.riskLevel

**Allowed values:**

- `Low`
- `Medium`
- `High`
- `Critical`

### definitions.frameworkInfo.properties.name

**Allowed values:**

- `LangChain`
- `LlamaIndex`
- `AutoGen`
- `CrewAI`
- `Semantic Kernel`
- `Haystack`
- `Custom`

### definitions.frameworkInfo.properties.language

**Allowed values:**

- `Python`
- `TypeScript`
- `JavaScript`
- `Java`
- `C#`
- `Go`
