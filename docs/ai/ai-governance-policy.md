# AIGovernancePolicy

AI Governance Policy entity representing organizational policies and rules for AI/LLM usage, compliance, and risk management. Enforces standards for model approval, data access, bias thresholds, and regulatory compliance.

**Source schema:** `schemas/entity/ai/aiGovernancePolicy.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of the AI Governance Policy |
| `name` | `reference or object` | Name that identifies this AI Governance Policy |
| `fullyQualifiedName` | `reference or object` | Fully qualified name of the AI Governance Policy |
| `displayName` | `string` | Display name for the AI Governance Policy |
| `description` | `reference or object` | Description of the policy and its purpose |
| `policyType` | `reference or object` |  |
| `rules` | `array` | Rules that make up this policy |
| `biasThresholds` | `reference or object` |  |
| `dataAccessControls` | `reference or object` |  |
| `costControls` | `reference or object` |  |
| `complianceRequirements` | `array` | Compliance requirements this policy enforces |
| `performanceStandards` | `reference or object` |  |
| `appliesTo` | `reference or object` | Entities this policy applies to |
| `enforcementLevel` | `string` | How strictly to enforce this policy |
| `enabled` | `boolean` | Whether this policy is currently active |
| `effectiveDate` | `reference or object` | Date when policy becomes effective |
| `expirationDate` | `reference or object` | Date when policy expires |
| `approvedBy` | `string` | Who approved this policy |
| `violations` | `array` | Recent policy violations |
| `owners` | `reference or object` | Owners of this AI Governance Policy |
| `followers` | `reference or object` | Followers of this AI Governance Policy |
| `domain` | `reference or object` | Domain the policy belongs to |
| `tags` | `array` | Tags for this AI Governance Policy |
| `version` | `reference or object` | Metadata version of the entity |
| `updatedAt` | `reference or object` | Last update time in Unix epoch milliseconds |
| `updatedBy` | `string` | User who made the update |
| `href` | `reference or object` | Link to this resource |
| `changeDescription` | `reference or object` | Change that led to this version |
| `incrementalChangeDescription` | `reference or object` | Change that led to this version |
| `deleted` | `boolean` | When true, indicates the entity has been soft deleted |
| `extension` | `reference or object` | Entity extension data with custom attributes |
| `domains` | `reference or object` | Domains the policy belongs to |
| `votes` | `reference or object` | Votes on the entity |
| `lifeCycle` | `reference or object` | Life Cycle properties of the entity |
| `sourceHash` | `string` | Source hash of the entity |

## Enum fields

### definitions.policyType

**Allowed values:**

- `ModelApproval`
- `DataAccess`
- `BiasThreshold`
- `ComplianceCheck`
- `CostControl`
- `PerformanceStandard`
- `SecurityControl`

### definitions.policyRule.properties.ruleType

Type of rule

**Allowed values:**

- `Threshold`
- `Approval`
- `Prohibition`
- `Requirement`
- `Notification`

### definitions.policyRule.properties.action

Action to take when rule is triggered

**Allowed values:**

- `Block`
- `Warn`
- `Notify`
- `Require_Approval`
- `Log`

### definitions.policyRule.properties.severity

**Allowed values:**

- `Low`
- `Medium`
- `High`
- `Critical`

### definitions.biasThreshold.properties.evaluationFrequency

How often to evaluate bias

**Allowed values:**

- `Continuous`
- `Daily`
- `Weekly`
- `Monthly`
- `OnDemand`

### definitions.dataAccessControl.properties.maxSensitivityLevel

Maximum data sensitivity level allowed

**Allowed values:**

- `Public`
- `Internal`
- `Confidential`
- `Restricted`

### definitions.complianceRequirement.properties.standard

Compliance standard

**Allowed values:**

- `GDPR`
- `HIPAA`
- `SOC2`
- `ISO27001`
- `NIST_AI_RMF`
- `EU_AI_Act`
- `OWASP_LLM_Top10`
- `Custom`

### definitions.complianceRequirement.properties.auditFrequency

**Allowed values:**

- `Continuous`
- `Weekly`
- `Monthly`
- `Quarterly`
- `Annually`

### properties.enforcementLevel

How strictly to enforce this policy

**Default:** `Warning`

**Allowed values:**

- `Advisory`
- `Warning`
- `Blocking`
