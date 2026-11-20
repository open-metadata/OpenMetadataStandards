# ContextMemory

Reusable context memory for Context Center and AI-assisted retrieval.

**Source schema:** `schemas/entity/context/contextMemory.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of the memory. |
| `name` | `reference or object` | Stable system name for the memory. |
| `fullyQualifiedName` | `reference or object` | Fully qualified name of the memory. |
| `displayName` | `string` | Display name of the memory. |
| `description` | `reference or object` | Optional markdown description for the memory. |
| `title` | `string` | Short title shown in Context Center. |
| `summary` | `string` | Optional summary of the memory. |
| `question` | `string` | Canonical question or instruction represented by this memory. |
| `answer` | `string` | Canonical answer or retained guidance represented by this memory. |
| `memoryType` | `reference or object` |  |
| `memoryScope` | `reference or object` |  |
| `status` | `reference or object` |  |
| `pinned` | `boolean` | Whether this memory is globally pinned in Context Center. |
| `shareConfig` | `reference or object` |  |
| `primaryEntity` | `reference or object` | Primary entity this memory should attach to for reuse. |
| `relatedEntities` | `reference or object` | Additional related entities this memory applies to. |
| `sourceType` | `reference or object` |  |
| `sourceConversation` | `reference or object` | Conversation identifier that produced this memory. |
| `sourceHumanMessage` | `reference or object` | Human message identifier used to produce this memory. |
| `sourceAssistantMessage` | `reference or object` | Assistant message identifier used to produce this memory. |
| `sourceFile` | `reference or object` | Deprecated: use sourceEntity. The Context Center file this memory was extracted from. |
| `sourceEntity` | `reference or object` | The Context Center entity (file or page) this memory was extracted from. |
| `rootMemory` | `reference or object` | Root memory in an append-style memory thread. |
| `parentMemory` | `reference or object` | Immediate parent memory in an append-style thread. |
| `machineRepresentation` | `reference or object` |  |
| `memoryStats` | `reference or object` |  |
| `derivedEntities` | `reference or object` | Derived: glossary terms and metrics created by the Memory Agent from this memory (DERIVED_FROM edges, agent-owned). |
| `reusedEntities` | `reference or object` | Derived: glossary terms and metrics reused (not created) by the Memory Agent from this memory (RELATED_TO edges). |
| `usageCount` | `integer` | How many times this memory has been used in AI-assisted retrieval. |
| `lastUsedAt` | `reference or object` | Last time the memory was used by AI-assisted retrieval. |
| `owners` | `reference or object` | Owners of this memory. |
| `tags` | `array` | Tags associated with this memory. |
| `domains` | `reference or object` | Domains this memory belongs to. |
| `version` | `reference or object` | Metadata version of the entity. |
| `updatedAt` | `reference or object` | Last update time in Unix epoch time milliseconds. |
| `updatedBy` | `string` | User who made the update. |
| `href` | `reference or object` | Link to this resource. |
| `changeDescription` | `reference or object` | Change that led to this version. |
| `incrementalChangeDescription` | `reference or object` | Incremental change that led to this version. |
| `deleted` | `boolean` | When true indicates the entity has been soft deleted. |

## Enum fields

### definitions.memoryType

High-level type of reusable memory.

**Default:** `Note`

**Allowed values:**

- `Preference`
- `UseCase`
- `Note`
- `Runbook`
- `Faq`

### definitions.memoryScope

Scope where the memory should be applied.

**Default:** `EntityScoped`

**Allowed values:**

- `UserGlobal`
- `EntityScoped`

### definitions.memoryStatus

Lifecycle state of the memory. Any status may be set at creation (e.g. importing an already-archived memory); the Draft -> Active -> Archived transition rules are only enforced on subsequent updates.

**Default:** `Active`

**Allowed values:**

- `Draft`
- `Active`
- `Archived`

### definitions.sourceType

How the memory was created.

**Default:** `Manual`

**Allowed values:**

- `Manual`
- `ChatPromotion`
- `RememberRequest`
- `FileExtraction`
- `PageExtraction`

### definitions.shareVisibility

Visibility level for the memory.

**Default:** `Private`

**Allowed values:**

- `Private`
- `Entity`
- `Shared`

### definitions.shareRole

Role granted to a shared principal.

**Default:** `Viewer`

**Allowed values:**

- `Viewer`
- `Editor`

### definitions.machineRepresentationStatus

Availability state of the machine-oriented representation.

**Default:** `Pending`

**Allowed values:**

- `Pending`
- `Ready`
- `Stale`
- `Failed`

### definitions.memoryProcessingStatus

Lifecycle status of the asynchronous Memory Agent derivation for a memory.

**Allowed values:**

- `Queued`
- `Processing`
- `Processed`
- `Failed`
