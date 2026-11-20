# Governance Workflows and Intake

Enum fields for workflow nodes, sink and certification tasks, workflow state, and intake forms.

## NodeType

**Source schema:** `schemas/governance/workflows/elements/nodeType.json`

## Enum fields

### (schema)

Type of the Node.

**Allowed values:**

- `automatedTask`
- `userTask`
- `endEvent`
- `startEvent`
- `gateway`

## NodeSubType

**Source schema:** `schemas/governance/workflows/elements/nodeSubType.json`

## Enum fields

### (schema)

SubType of the Node.

**Allowed values:**

- `userApprovalTask`
- `checkEntityAttributesTask`
- `setEntityAttributeTask`
- `setEntityCertificationTask`
- `setGlossaryTermStatusTask`
- `endEvent`
- `startEvent`
- `createAndRunIngestionPipelineTask`
- `runAppTask`
- `rollbackEntityTask`
- `dataCompletenessTask`
- `parallelGateway`
- `sinkTask`
- `createRecognizerFeedbackApprovalTask`
- `applyRecognizerFeedbackTask`
- `rejectRecognizerFeedbackTask`
- `checkChangeDescriptionTask`
- `policyAgentTask`
- `createAndRunAIAutomationTask`

## WorkflowDefinition

**Source schema:** `schemas/governance/workflows/workflowDefinition.json`

## Enum fields

### definitions.type

**Allowed values:**

- `eventBasedEntity`
- `noOp`
- `periodicBatchEntity`

## WorkflowInstance

**Source schema:** `schemas/governance/workflows/workflowInstance.json`

## Enum fields

### definitions.workflowStatus

**Allowed values:**

- `RUNNING`
- `FINISHED`
- `FAILURE`
- `EXCEPTION`
- `SUPERSEDED`

## WorkflowInstanceState

**Source schema:** `schemas/governance/workflows/workflowInstanceState.json`

## Enum fields

This schema defines no enum properties.

## IntakeForm

**Source schema:** `schemas/governance/intakeForm.json`

## Enum fields

### definitions.targetEntityType

Entity types supported by IntakeForm today.

**Allowed values:**

- `dataProduct`
- `domain`
- `glossaryTerm`

### definitions.fieldKind

Whether a required field refers to a native entity attribute or a custom property defined via the Type system.

**Allowed values:**

- `native`
- `customProperty`

### definitions.intakeFormField.properties.fieldKind

Whether a form field refers to a native entity attribute or a custom property defined via the Type system.

**Allowed values:**

- `native`
- `customProperty`

## SinkTaskDefinition

**Source schema:** `schemas/governance/workflows/elements/nodes/automatedTask/sinkTask.json`

## Enum fields

### definitions.sinkType

Type of sink destination.

**Allowed values:**

- `git`
- `webhook`
- `httpEndpoint`

### definitions.syncMode

How entities should be synchronized to the sink.

**Default:** `overwrite`

**Allowed values:**

- `append`
- `overwrite`
- `merge`

### definitions.outputFormat

Format for serialized entity output.

**Default:** `yaml`

**Allowed values:**

- `yaml`
- `json`

## SetEntityCertificationTaskDefinition

**Source schema:** `schemas/governance/workflows/elements/nodes/automatedTask/setEntityCertificationTask.json`

## Enum fields

### definitions.certificationEnum

**Allowed values:**

- ``
- `Certification.Gold`
- `Certification.Silver`
- `Certification.Bronze`
