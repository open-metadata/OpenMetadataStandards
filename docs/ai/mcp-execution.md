# McpExecution

MCP Execution entity representing a single execution session of an MCP server. Tracks tool calls, resource accesses, prompt uses, and data lineage for audit trails and governance. This is a time-series entity for observability and compliance.

**Source schema:** `schemas/entity/ai/mcpExecution.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of the MCP Execution |
| `server` | `reference or object` | MCP Server that was executed |
| `serverId` | `reference or object` | ID of the MCP Server (for indexing) |
| `timestamp` | `reference or object` | Execution start timestamp |
| `endTimestamp` | `reference or object` | Execution end timestamp |
| `durationMs` | `number` | Total execution duration in milliseconds |
| `status` | `reference or object` |  |
| `executedBy` | `string` | User or system that initiated the execution |
| `applicationContext` | `reference or object` | AI Application that triggered this execution, if applicable |
| `sessionId` | `string` | Session ID for grouping related executions |
| `toolCalls` | `array` | Tool invocations during this execution |
| `resourceAccesses` | `array` | Resource accesses during this execution |
| `promptUses` | `array` | Prompt uses during this execution |
| `dataAccessed` | `array` | All data sources accessed during execution |
| `complianceChecks` | `array` | Compliance checks performed during execution |
| `metrics` | `reference or object` |  |
| `errorMessage` | `string` | Error message if execution failed |
| `errorStack` | `string` | Error stack trace if available |
| `environment` | `string` | Environment where execution occurred |
| `serverVersion` | `string` | Version of the MCP server at execution time |
| `protocolVersion` | `string` | MCP protocol version used |
| `metadata` | `object` | Additional execution metadata |
| `deleted` | `boolean` | When true, indicates the entity has been soft deleted |

## Enum fields

### definitions.executionStatus

Status of the MCP execution

**Allowed values:**

- `Running`
- `Success`
- `Failed`
- `Timeout`
- `Cancelled`

### definitions.accessType

Type of data access

**Allowed values:**

- `Read`
- `Write`
- `Delete`

### definitions.sensitivityLevel

Sensitivity level of data accessed

**Allowed values:**

- `Public`
- `Internal`
- `Confidential`
- `Restricted`

### definitions.complianceSeverity

Severity level for compliance checks

**Allowed values:**

- `Info`
- `Warning`
- `Error`
- `Critical`

### properties.environment

Environment where execution occurred

**Allowed values:**

- `Development`
- `Testing`
- `Staging`
- `Production`
