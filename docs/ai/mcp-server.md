# McpServer

MCP (Model Context Protocol) Server entity representing an MCP server deployment for AI governance. MCP servers expose tools, resources, and prompts that can be used by AI applications. This entity enables comprehensive governance including risk assessment, compliance, shadow AI detection, and data access tracking.

**Source schema:** `schemas/entity/ai/mcpServer.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of the MCP Server. |
| `name` | `reference or object` | Name that identifies this MCP Server. |
| `fullyQualifiedName` | `reference or object` | Fully qualified name of the MCP Server. |
| `displayName` | `string` | Display name for the MCP Server. |
| `description` | `reference or object` | Description of the MCP Server, its purpose, and capabilities. |
| `service` | `reference or object` | Reference to the MCP Service that contains this MCP Server. |
| `serverType` | `reference or object` |  |
| `transportType` | `reference or object` |  |
| `protocolVersion` | `string` | MCP protocol version supported by this server |
| `developmentStage` | `reference or object` |  |
| `serverInfo` | `reference or object` |  |
| `connectionConfig` | `reference or object` |  |
| `capabilities` | `reference or object` |  |
| `tools` | `array` | Tools exposed by this MCP Server |
| `resources` | `array` | Resources exposed by this MCP Server |
| `prompts` | `array` | Prompt templates exposed by this MCP Server |
| `governanceMetadata` | `reference or object` |  |
| `dataAccessSummary` | `reference or object` |  |
| `usageMetrics` | `reference or object` |  |
| `securityMetrics` | `reference or object` |  |
| `usedByApplications` | `reference or object` | AI Applications that use this MCP Server |
| `sourceCode` | `string` | Link to source code repository |
| `deploymentUrl` | `string` | Deployment endpoint URL |
| `documentation` | `string` | Link to external documentation |
| `owners` | `reference or object` | Owners of this MCP Server |
| `followers` | `reference or object` | Followers of this MCP Server |
| `domain` | `reference or object` | Domain the MCP Server belongs to |
| `dataProducts` | `reference or object` | Data products this MCP Server is part of |
| `tags` | `array` | Tags for this MCP Server |
| `version` | `reference or object` | Metadata version of the entity |
| `updatedAt` | `reference or object` | Last update time in Unix epoch milliseconds |
| `updatedBy` | `string` | User who made the update |
| `href` | `reference or object` | Link to this resource |
| `changeDescription` | `reference or object` | Change that led to this version |
| `incrementalChangeDescription` | `reference or object` | Change that led to this version |
| `deleted` | `boolean` | When true, indicates the entity has been soft deleted |
| `certification` | `reference or object` |  |
| `extension` | `reference or object` | Entity extension data with custom attributes |
| `domains` | `reference or object` | Domains the MCP Server belongs to |
| `votes` | `reference or object` | Votes on the entity |
| `reviewers` | `reference or object` | Risk Council reviewers responsible for approving this MCP Server. |
| `entityStatus` | `reference or object` | Governance approval status of the MCP Server. |
| `lifeCycle` | `reference or object` | Life Cycle properties of the entity |
| `sourceHash` | `string` | Source hash of the entity |

## Enum fields

### definitions.serverType

Type of MCP server based on its primary function

**Allowed values:**

- `DataAccess`
- `FileSystem`
- `WebAPI`
- `Database`
- `Cloud`
- `Security`
- `Development`
- `Communication`
- `Custom`

### definitions.transportType

Transport protocol used by the MCP server

**Allowed values:**

- `Stdio`
- `SSE`
- `StreamableHTTP`

### definitions.developmentStage

Development stage of the MCP server. 'Unauthorized' indicates Shadow AI that needs governance review.

**Allowed values:**

- `Proposal`
- `Development`
- `Testing`
- `Staging`
- `Production`
- `Deprecated`
- `Unauthorized`

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

### definitions.dataAccessSummary.properties.accessPatterns.items

**Allowed values:**

- `Read`
- `Write`
- `Execute`

### definitions.dataAccessSummary.properties.sensitivityLevel

Highest sensitivity level of data accessed

**Allowed values:**

- `Public`
- `Internal`
- `Confidential`
- `Restricted`

### definitions.toolCategory

Category of the MCP tool based on its primary function

**Allowed values:**

- `FileOperation`
- `WebOperation`
- `DataOperation`
- `DatabaseOperation`
- `SystemOperation`
- `SecurityOperation`
- `CommunicationOperation`
- `CodeOperation`
- `SearchOperation`
- `Custom`

### definitions.riskLevel

Risk level based on capabilities and data access

**Allowed values:**

- `Low`
- `Medium`
- `High`
- `Critical`

### definitions.sensitivityLevel

Sensitivity level of data

**Allowed values:**

- `Public`
- `Internal`
- `Confidential`
- `Restricted`

### definitions.resourceType

Type of MCP resource

**Allowed values:**

- `File`
- `Directory`
- `URL`
- `Database`
- `API`
- `Blob`
- `Stream`
- `Document`
- `Custom`

### definitions.mcpResource.properties.accessLevel

**Allowed values:**

- `ReadOnly`
- `ReadWrite`
- `Full`

### definitions.promptType

Type of MCP prompt

**Allowed values:**

- `Analysis`
- `Generation`
- `Transformation`
- `Validation`
- `Query`
- `Summarization`
- `Extraction`
- `Classification`
- `Custom`

### definitions.promptArgument.properties

**Default:** `{'description': 'Default value'}`

**Allowed values:**

- `type`
- `description`

### definitions.promptArgument.properties.type

**Allowed values:**

- `String`
- `Number`
- `Boolean`
- `Array`
- `Object`

### definitions.promptMessage.properties.role

**Allowed values:**

- `user`
- `assistant`
- `system`
