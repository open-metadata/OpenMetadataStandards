# AuditReport

An asynchronously-generated evidence pack scoped to a framework, domain, or single AI asset. Bundles compliance records, control coverage, workflow history, remediation snapshot, and per-asset documents into machine-readable JSON (and optionally PDF) for auditors and regulators.

**Source schema:** `schemas/entity/ai/auditReport.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier |
| `name` | `reference or object` | Unique short name for this report |
| `displayName` | `string` | Display name for the audit report |
| `fullyQualifiedName` | `reference or object` | FQN that uniquely identifies the audit report |
| `description` | `reference or object` | Free-text description / notes attached to this report |
| `framework` | `reference or object` | Framework this audit pack is scoped to (omit for an estate-wide multi-framework pack) |
| `scope` | `reference or object` |  |
| `scopeTarget` | `reference or object` | Reference to the domain or asset when scope is not Estate |
| `format` | `reference or object` |  |
| `status` | `reference or object` |  |
| `asOfDate` | `reference or object` | Snapshot date — the pack assembles state as it was at this time |
| `includeRedacted` | `boolean` | Whether to include normally-redacted evidence (DPIAs, model cards, etc.) |
| `requestedBy` | `reference or object` | User who requested the report |
| `requestedAt` | `reference or object` | When the report was requested |
| `startedAt` | `reference or object` | When job execution started |
| `completedAt` | `reference or object` | When job execution finished (success or failure) |
| `failureReason` | `string` | Stack/message if status=Failed |
| `runningOn` | `string` | Identifier of the server node that claimed and is running this job. Used to detect and recover jobs orphaned by a pod restart. |
| `requestSignature` | `string` | Deterministic hash of the request parameters (scope, target, framework, format, asOfDate, includeRedacted). Backs an indexed lookup so a retried submission dedupes to the in-flight report instead of generating the same pack twice. |
| `artifacts` | `array` | Generated artifacts available for download |
| `manifest` | `reference or object` |  |
| `owners` | `reference or object` | Owners of this audit report |
| `tags` | `array` | Tags for this audit report |
| `domains` | `reference or object` | Domains the audit report belongs to |
| `version` | `reference or object` | Metadata version of the entity |
| `updatedAt` | `reference or object` | Last update time corresponding to the new version of the entity in Unix epoch time milliseconds |
| `updatedBy` | `string` | User who made the update |
| `href` | `reference or object` | Link to this entity |
| `changeDescription` | `reference or object` | Change that led to this version of the entity |
| `incrementalChangeDescription` | `reference or object` | Change that led to this version of the entity |
| `deleted` | `boolean` | When true, indicates the entity has been soft deleted |
| `extension` | `reference or object` | Custom extension JSON |

## Enum fields

### definitions.reportScope

Breadth of the audit pack

**Allowed values:**

- `Estate`
- `Domain`
- `Asset`

### definitions.reportFormat

Artifact format(s) to generate

**Allowed values:**

- `Json`
- `Pdf`
- `Both`

### definitions.reportStatus

Current state of the audit pack job

**Allowed values:**

- `Queued`
- `Running`
- `Completed`
- `Failed`
- `Cancelled`
