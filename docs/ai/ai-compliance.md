# AICompliance

Reusable AI compliance and regulatory framework assessments. Can be applied to AI Applications, LLM Models, MCP Servers, and other AI entities.

**Source schema:** `schemas/type/aiCompliance.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `complianceRecords` | `array` | List of compliance assessments for different frameworks |

## Enum fields

### definitions.complianceFramework

Type of AI compliance framework

**Allowed values:**

- `EU_AI_Act`
- `Singapore_Model_AI_Governance`
- `Canada_AIDA`
- `US_AI_Bill_of_Rights`
- `NIST_AI_RMF`
- `ISO_IEC_42001`
- `UK_AI_Regulation`
- `China_AI_Regulations`
- `Custom`

### definitions.euAIActCompliance.properties.riskClassification

Risk classification under EU AI Act

**Allowed values:**

- `Minimal`
- `Limited`
- `High`
- `Unacceptable`

### definitions.euAIActCompliance.properties.conformityAssessment.properties.assessmentType

Type of conformity assessment

**Allowed values:**

- `Internal`
- `ThirdParty`
- `NotRequired`

### definitions.ethicalAIAssessment.properties.privacyLevel

Level of privacy-sensitive data accessed

**Allowed values:**

- `Public`
- `Sensitive`
- `PersonalData`

### definitions.ethicalAIAssessment.properties.fairnessRisk

Risk level for fairness and discrimination

**Allowed values:**

- `Low`
- `Medium`
- `High`

### definitions.ethicalAIAssessment.properties.biasMitigationCoverage

Coverage of bias mitigation measures

**Allowed values:**

- `None`
- `Partial`
- `Full`

### definitions.ethicalAIAssessment.properties.reliabilitySafetyRisk

Risk level for reliability and safety

**Allowed values:**

- `Low`
- `Moderate`
- `High`

### definitions.ethicalAIAssessment.properties.transparencyLevel

Level of transparency in AI operations

**Allowed values:**

- `None`
- `Partial`
- `FullDisclosure`

### definitions.ethicalAIAssessment.properties.environmentalConsciousness

Environmental impact risk level (carbon footprint, energy consumption)

**Allowed values:**

- `LowRisk`
- `MediumRisk`
- `HighRisk`

### definitions.aiComplianceRecord.properties.status

Compliance status

**Allowed values:**

- `Compliant`
- `PartiallyCompliant`
- `NonCompliant`
- `UnderReview`
- `NotApplicable`

### definitions.aiComplianceRecord.properties.scopeAndDeployment.properties.scope

Scope of AI usage

**Allowed values:**

- `Internal`
- `External`
- `Both`

### definitions.aiDetection.properties.source

How this AI asset was detected

**Allowed values:**

- `OutboundApiTraffic`
- `SSOLogs`
- `ConnectorAudit`
- `ManualUpload`
- `Other`

### definitions.aiDetection.properties.flags.items

**Allowed values:**

- `PiiWithoutDpa`
- `NoOwner`
- `NewDeployment`
- `OrgWideEnable`
- `PrivilegedData`

### definitions.aiDetection.properties.severity

Triage severity assigned to this detection

**Allowed values:**

- `High`
- `Medium`
- `Low`

### definitions.remediationAction.properties.priority

**Allowed values:**

- `High`
- `Medium`
- `Low`

### definitions.remediationAction.properties.status

**Allowed values:**

- `Open`
- `InProgress`
- `Done`
- `Deferred`
