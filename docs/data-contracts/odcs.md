# ODCSDataContract

Open Data Contract Standard (ODCS) v3.1.0 data contract representation for import/export.

**Source schema:** `schemas/entity/datacontract/odcs/odcsDataContract.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `apiVersion` | `reference or object` | ODCS standard version. |
| `kind` | `reference or object` | Document type (always 'DataContract'). |
| `id` | `string` | Unique identifier (UUID recommended). |
| `name` | `string` | Contract name. |
| `version` | `string` | Current version number. |
| `status` | `reference or object` | Contract status. |
| `tenant` | `string` | Primary property association. |
| `domain` | `string` | Logical data domain name. |
| `dataProduct` | `string` | Data product name. |
| `tags` | `array` | Categorical labels. |
| `description` | `reference or object` | Purpose, limitations, usage details. |
| `authoritativeDefinitions` | `array` | External reference links. |
| `schema` | `array` | Schema definition with objects and properties. |
| `quality` | `array` | Data quality rules. |
| `support` | `array` | Support channels. |
| `price` | `reference or object` | Pricing information. |
| `team` | `array` | Team members. |
| `roles` | `array` | IAM roles. |
| `slaDefaultElement` | `string` | Default element for SLA checks. |
| `slaProperties` | `array` | SLA specifications. |
| `servers` | `array` | Infrastructure and server definitions. |
| `customProperties` | `array` | Non-standard key-value pairs. |
| `contractCreatedTs` | `string` | ISO 8601 UTC creation timestamp. |

## Enum fields

### definitions.odcsApiVersion

ODCS API version.

**Default:** `v3.1.0`

**Allowed values:**

- `v3.1.0`
- `v3.0.2`
- `v3.0.1`
- `v3.0.0`
- `v2.2.2`
- `v2.2.1`
- `v2.2.0`

### definitions.odcsKind

Kind of ODCS document.

**Default:** `DataContract`

**Allowed values:**

- `DataContract`

### definitions.odcsStatus

Status of the ODCS data contract.

**Allowed values:**

- `proposed`
- `draft`
- `active`
- `deprecated`
- `retired`

### definitions.odcsSchemaElement.properties.logicalType

Logical data type per ODCS v3.1.0 spec.

**Allowed values:**

- `string`
- `text`
- `date`
- `timestamp`
- `time`
- `number`
- `integer`
- `decimal`
- `float`
- `double`
- `long`
- `object`
- `array`
- `boolean`
- `bytes`
- `null`

### definitions.odcsQualityRule.properties.type

Quality rule type.

**Default:** `library`

**Allowed values:**

- `text`
- `library`
- `sql`
- `custom`

### definitions.odcsQualityRule.properties.dimension

KPI classification.

**Allowed values:**

- `accuracy`
- `completeness`
- `conformity`
- `consistency`
- `coverage`
- `timeliness`
- `uniqueness`
- `ac`
- `cp`
- `cf`
- `cs`
- `cv`
- `tm`
- `uq`

### definitions.odcsQualityMetric

Standard quality metrics library supported by ODCS 3.1.0.

**Allowed values:**

- `rowCount`
- `nullValues`
- `invalidValues`
- `duplicateValues`
- `missingValues`
- `uniqueValues`
- `distinctValues`
- `completeness`
- `freshness`

### definitions.odcsSupportChannel.properties.tool

Channel tool type.

**Allowed values:**

- `email`
- `slack`
- `teams`
- `discord`
- `ticket`
- `other`

### definitions.odcsSupportChannel.properties.scope

Channel scope.

**Allowed values:**

- `interactive`
- `announcements`
- `issues`

### definitions.odcsRole.properties.access

Access type.

**Allowed values:**

- `read`
- `write`
- `readWrite`

### definitions.odcsSlaProperty.properties.driver

SLA driver.

**Allowed values:**

- `regulatory`
- `analytics`
- `operational`

### definitions.odcsServer.properties.environment

Environment type.

**Allowed values:**

- `prod`
- `preprod`
- `dev`
- `uat`
