---
title: Data Governance Changes (1.13 → 2.0)
description: Glossary and ontology, classification and tags, policies and roles, domains and data products, governance workflows, Data Access Requests and the Policy Agent in OpenMetadata 2.0.
---

# Data Governance

**What changes for glossaries, classifications, policies, workflows and access governance.**

---

## Policies & roles

### Five new task operations

:material-alert:{ .om-behavioral } **Behavioural** · Affects: custom policies, non-admin users, bots

`resourceDescriptor.json` gains `CreateTask`, `EditTask`, `ResolveTask`, `CloseTask`, `ReassignTask`.
With the Task redesign, task actions are policy-governed rather than implicit.

The 2.0.0 migration seeds a new `TaskAuthorPolicy`, attaches it to the `DataConsumer` role, and adds
task rules to `DataConsumerPolicy` and `ApplicationBotPolicy`.

!!! warning "Custom policies are not backfilled"
    Seed policies are create-if-not-exists. If you replaced `DataConsumerPolicy` or
    `ApplicationBotPolicy` with your own definition, the migration will not touch it and your
    non-admin users will receive `403` when creating or editing tasks. Add the operations yourself:

    ```json
    {
      "name": "DataConsumerPolicy-CreateTask-Rule",
      "resources": ["task"],
      "operations": ["Create"],
      "effect": "allow"
    }
    ```

### Self-approval guard

:material-alert:{ .om-behavioral }

Task authorization in 2.0 refuses to let a task's creator approve their own task, even where policy
would otherwise allow it. Approval automation that submitted and approved with the same service
account must be split across two principals — or use `emptyAssigneeStrategy: assignAdmins`
(see below).

### AutoClassificationBotPolicy gains Topic

:material-plus-circle:{ .om-additive }

The migration appends `AutoClassificationBotRule-Allow-Topic` (`EditAll`, `ViewAll` on `Topic`) so
the auto-classification bot can tag messaging assets. See
[Auto-classification for topics and containers](#auto-classification-extends-to-topics-and-containers).

### Reviewer authorization shortcut removed on create

:material-alert:{ .om-behavioral }

A shortcut that granted reviewer-level authorization on `CREATE` was removed. Flows that relied on
being a reviewer to create an entity now need an explicit `Create` grant.

---

## Glossary & ontology

### Native OWL/RDF ontology import

:material-plus-circle:{ .om-additive } **New capability**

```
PUT /v1/glossaries/name/{name}/importRdf
```

Imports an OWL/RDF ontology into a glossary, preserving identity for round-trips. Two new fields
support this:

| Entity | Field | Purpose |
|--------|-------|---------|
| `glossaryTerm` | `iri` | Canonical IRI of the term in its source ontology; used as the RDF subject when present |
| `glossary` | `namespaces[]` | `prefix` → `namespace` IRI mappings, so CURIEs render and re-export preserves identity |

!!! note "Not breaking, but note the round-trip contract"
    A glossary term created in the UI has no `iri`. Terms imported from an ontology carry one, and
    export re-emits it. Do not rewrite `iri` on update or you will break round-trip identity.

### Glossary term relation semantics

:material-plus-circle:{ .om-additive } · Affects: `glossaryTermRelationSettings`

Relation types gain OWL property characteristics used for RDF round-trip and optional validation
(**not enforced by default**):

| Field | Meaning |
|-------|---------|
| `domain[]` | Term FQNs / class IRIs a **source** term must be typed as. Empty = unconstrained |
| `range[]` | Term FQNs / class IRIs a **target** term must be typed as. Empty = unconstrained |
| `isFunctional` | A source term has at most one target |
| `isInverseFunctional` | A target term has at most one source |
| `isReflexive` / `isIrreflexive` | Every / no term relates to itself |
| `isAsymmetric` | A relates B implies B does not relate A |

Other 2.0 changes in this area:

- Glossary term relation types are readable by **any authenticated user** (previously restricted).
- Glossary term relation settings are **paginated**.
- All relation types between the same term pair are preserved (previously one could overwrite another).
- Glossary rename now cascades to child terms in the search index, and approval workflows stay valid
  across term move and rename.
- CSV import/export preserves `domains`, and `entityStatus` is parsed **case-insensitively**.

---

## Classification, tags & auto-classification

### Auto-classification extends to topics and containers { #auto-classification-extends-to-topics-and-containers }

:material-plus-circle:{ .om-additive } · Affects: PII/classification coverage and bot permissions

Two new pipeline schemas ship:

- `metadataIngestion/messagingServiceAutoClassificationPipeline.json`
- `metadataIngestion/storageServiceAutoClassificationPipeline.json`

Together with the `AutoClassificationBotPolicy` Topic rule, this means **topics and storage
containers are now auto-classified** where previously only database tables were.

!!! warning "New tags will appear on messaging and storage assets"
    If you have policies or alerts keyed on PII tags, expect coverage to widen after upgrade.

### PII recognizer accuracy changes

:material-alert:{ .om-behavioral } **Behavioural — existing tags may be wrong, new runs differ**

The `CvvRecognizer` regex is anchored by the 2.0.0 migration:

```sql
-- from  \b\d{3,4}\b   to   \A\d{3,4}\Z
```

The unanchored pattern matched the `125` inside values like `SCN-125`, so any column whose name
carried a CVV context word (`code`, `card`, `cvv`, …) and whose values contained a 3–4 digit run was
tagged `PII.Sensitive` — `scenario_code`, `error_code`. Because the context boost sets the score
straight to `MAX_SCORE`, a 0.5-confidence pattern became a certain match.

Related fixes in 2.0:

- Overly broad context keywords removed from PII recognizers.
- Plain code columns are no longer tagged as PII.
- Sibling-tag score ties are broken by column-name match.
- Temporal table period columns are excluded from auto-classification sampling.
- Recognizer inclusion is resolved correctly by language, including any-language recognizers.
- The content/column-name split was removed from classification scoring.

!!! success "Action"
    Review existing `PII.Sensitive` tags on columns named `*_code`. The migration fixes the
    recognizer; it does **not** retract tags already applied.

### Other classification changes

| Change | Class | Effect |
|--------|-------|--------|
| `tag_usage.metadata` JSON column added | Additive | Tag usage rows can carry metadata |
| `autoClassificationConfig` preserved on Classification `PUT` | Fix | Previously wiped by a full update |
| Tag recognizer config preserved on ingestion `PUT` | Fix | Previously wiped by connector updates |
| The `disabled` flag inherited from a Classification is no longer persisted on its tags | Behavioural | Tag `disabled` now reflects the tag's own state |
| Entities matching a classification tag among others are retained | Fix | Filtering no longer drops multi-tag matches |

---

## Governance workflows

### `userApprovalTask` gains task-lifecycle configuration

:material-plus-circle:{ .om-additive } · Affects: existing workflow definitions (backwards compatible)

```json title="userApprovalTask config additions"
{
  "emptyAssigneeStrategy": "none | assignAdmins",
  "stageId": "…",
  "stageDisplayName": "…",
  "taskStatus": "Open | InProgress | …",
  "assigneeStrategy": "…",
  "transitionMetadata": [ { "id": "approve", "label": "Approve" } ]
}
```

**`emptyAssigneeStrategy`** (default `none`) controls what happens when no reviewers, owners or
candidates resolve to an assignee:

| Value | Behaviour |
|-------|-----------|
| `none` (default, = 1.13 behaviour) | The gateway auto-approves event-driven approvals and leaves workflow-managed tasks unassigned |
| `assignAdmins` | Falls back to all platform admins, **excluding the requester** so self-approval can never happen |

The `stageId` / `stageDisplayName` / `taskStatus` / `transitionMetadata` fields are written onto the
Task while the user task is active — this is what surfaces workflow stage and available transitions
in the Tasks UI.

!!! success "Action"
    Existing workflow definitions keep working unchanged. Set `emptyAssigneeStrategy: assignAdmins`
    on approval nodes where unassigned tasks were silently auto-approving.

### New workflow node subtypes

:material-plus-circle:{ .om-additive }

| Node subtype | Purpose |
|--------------|---------|
| `policyAgentTask` | Grant/revoke database access through the Policy Agent |
| `createAndRunAIAutomationTask` | Trigger an AI automation from a workflow |

Definitions: `governance/workflows/elements/nodes/automatedTask/policyAgentTaskDefinition.json`,
`.../createAndRunAIAutomationTask.json`.

### Workflow trigger fields

:material-plus-circle:{ .om-additive }

`type/workflowTriggerFields.json` adds `entityStatus`; `inputPorts`, `outputPorts` and
`glossaryTerms` also become trigger fields.

### Workflows fire far sooner

:material-alert:{ .om-behavioral } **Behavioural** · Affects: every governance workflow

The 2.0.0 migration lowers three intervals on **existing** deployments:

| Setting | 1.13 | 2.0 |
|---------|------|-----|
| `WorkflowEventConsumer.pollInterval` | 10 s | **1 s** |
| `workflowSettings.executorConfiguration.asyncJobAcquisitionInterval` | 10 000 ms | **1 000 ms** |
| `workflowSettings.executorConfiguration.timerJobAcquisitionInterval` | 60 000 ms | **5 000 ms** |

Approval tasks now appear near-instantly after the triggering change instead of up to 10 s (or, under
load, minutes) later.

!!! warning "Increased database polling"
    Sub-second Flowable job acquisition raises steady-state query volume against the workflow tables.
    On very large clusters, monitor DB load after upgrade and raise the intervals if needed.

Workflow migrations run inside a try/catch in v200: a `WorkflowHandler` failure logs and continues
rather than aborting the rest of the data migration. If you see
*"Failed to initialize WorkflowHandler … in v200"* in the upgrade logs, restart the server to complete
workflow wiring.

---

## Data Access Requests & the Policy Agent

:material-plus-circle:{ .om-additive } **New capability**

2.0 introduces self-service data access requests backed by a Policy Agent that executes grants and
revokes against the source system.

| Piece | Where |
|-------|-------|
| Task type | `DataAccessRequest` (`category: DataAccess`) |
| Payload | `type/dataAccessRequestPayload.json` |
| Queue API | `GET /v1/tasks/dataAccessRequests` |
| Workflow node | `policyAgentTask` |
| Ingestion pipeline type | `policyAgent` |
| Pipeline config | `metadataIngestion/policyAgentPipeline.json` |
| Per-connector config | `metadataIngestion/policyagentconfig/databasePolicyConfig.json` |

```json title="databasePolicyConfig"
{
  "principalType": "USER | ROLE",
  "principal": "analyst@example.com",
  "databaseName": "…", "schemaName": "…", "tableName": "…",
  "accessType": "FullAccess | ColumnLevel | Masked | Revoke",
  "requestedAccess": "Read | Write | Admin"
}
```

`Revoke` tears down whatever the principal currently holds at the scope — it is not a
level-specific revoke.

### `policyAgentConfig` defaults are backfilled onto existing services

:material-alert:{ .om-behavioral } **Behavioural** · Affects: existing Snowflake, Databricks and
Unity Catalog services

Schema-level defaults only apply at create-time deserialisation, so the 2.0.0 migration rewrites
stored rows. Operator-set `true` values are preserved; only `false`/missing values are changed.

| Service type | `enabled` | `supportsFullAccess` | `supportsMaskedAccess` | `supportsColumnAccess` |
|--------------|-----------|----------------------|------------------------|------------------------|
| Snowflake | `true` | `true` | `true` | `false` |
| Databricks | `true` | `true` | `false` | `false` |
| Unity Catalog | `true` | `true` | `false` | `false` |
| Postgres | **removed** — Postgres no longer declares `policyAgentConfig` | | | |

An earlier revision of the migration forced Databricks `supportsMaskedAccess` to `true`; 2.0 includes
a corrective heal that resets it to `false` on every Databricks row.

!!! warning "Access-request availability changes"
    Data Access Requests are restricted by the connector's `policyAgentConfig`. After upgrade, the
    Request Access affordance appears on Snowflake / Databricks / Unity Catalog assets and disappears
    from Postgres. Set `enabled: false` explicitly on services where you do not want it.

`supportsPolicyAgent` is also declared as an identifier on **all** database connectors so the UI can
show or hide the Policy Agent option in the Add Agent dropdown.

---

## Domains & data products

:material-plus-circle:{ .om-additive } — no breaking changes in this area for 1.13 → 2.0.

| Change | Class |
|--------|-------|
| ODPS data product schema (`entity/domains/odps/odpsDataProduct.json`) | Additive |
| Data product support in the Observability UI and backend | Additive |
| Certification quick filter on the Data Products listing | Additive |
| Request-access button for data products | Additive |
| `assignedTo` relationship type | Additive |
| Domain-scoped activity-feed visibility (task domains backfilled by migration) | Additive |

!!! note
    Data-product → domain asset migration (changing a data product's domain migrates its assets)
    already exists in 1.13 and is unchanged in 2.0.

---

## Intake forms

:material-plus-circle:{ .om-additive } **New capability**

`governance/intakeForm.json` and `POST /v1/governance/intakeForms` add structured intake forms,
used together with `taskFormSchema` to drive request/approval workflows with typed inputs.

---

## AI Governance Studio

:material-plus-circle:{ .om-additive } **New namespace** · Collate distribution

A complete AI governance surface is added to the 2.0 spec:

| Entity / API | Purpose |
|--------------|---------|
| `aiGovernanceFramework` + `/v1/aiGovernanceFrameworks` | Control frameworks, forkable per tenant |
| `aiFrameworkControl` + `/v1/aiFrameworkControls` | Individual controls with evidence requirements |
| `auditReport` + `/v1/auditReports` | Generated audit reports with `requestSignature` dedup |
| `/v1/aiGovernance/dashboard`, `/activity` | Governance dashboard and activity |
| `/v1/aiGovernance/{entityType}/{id}/submitForReview\|approve\|reject` | Approval lifecycle for AI assets |
| `/v1/aiGovernance/{entityType}/{id}/policyStatus`, `/policies/{policyId}/violations` | Policy status and violations |
| `/v1/aiGovernance/intakeChecks/{entityType}/name/{fqn}` | Pre-registration checks |
| `/v1/aiGovernance/shadow/bulkTriage` | Bulk triage of shadow AI |
| `type/aiCompliance.json` (modified) | Compliance metadata on AI entities |

Backed by `ai_governance_framework_entity`, `ai_framework_control_entity` and `audit_report_entity`
tables created in the 2.0.0 migration.

### Collate AI agents removed

:material-close-octagon:{ .om-breaking }

`app.json`'s `agentType` enum drops `CollateAI`, `CollateAITierAgent` and `CollateAIQualityAgent` —
only `Metadata` remains. Their config schemas are deleted:

- `entity/applications/configuration/external/collateAIQualityAgentAppConfig.json`
- `entity/applications/configuration/external/collateAITierAgentAppConfig.json`
- `entity/applications/configuration/private/internal/collateAITierAgentAppPrivateConfig.json`

!!! success "Action"
    Remove references to these agent types from app configuration and any automation that filters
    ingestion pipelines by `agentType`. Use the new `agentType` filter values `metadata` /
    `application` on `GET /v1/services/ingestionPipelines` instead.
