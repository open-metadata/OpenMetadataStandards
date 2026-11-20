# ODPSDataProduct

Open Data Product Standard (ODPS) v4.1 data product representation for import/export. See https://opendataproducts.org/v4.1/.

**Source schema:** `schemas/entity/domains/odps/odpsDataProduct.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `schema` | `string` | URL of the ODPS schema (required per ODPS). |
| `version` | `reference or object` | ODPS specification version (required per ODPS). |
| `product` | `reference or object` | Product metadata container (required per ODPS). |

## Enum fields

### definitions.odpsApiVersion

ODPS specification version.

**Default:** `4.1`

**Allowed values:**

- `4.1`
- `4.0`

### definitions.odpsVisibility

Visibility level of the data product per ODPS v4.1.

**Allowed values:**

- `private`
- `invitation`
- `organisation`
- `dataspace`
- `public`

### definitions.odpsStatus

Lifecycle status of the data product per ODPS v4.1.

**Allowed values:**

- `announcement`
- `draft`
- `development`
- `testing`
- `acceptance`
- `production`
- `sunset`
- `retired`

### definitions.odpsType

Type of the data product per ODPS v4.1 taxonomy.

**Allowed values:**

- `raw data`
- `derived data`
- `dataset`
- `reports`
- `analytic view`
- `3D visualisation`
- `algorithm`
- `decision support`
- `automated decision-making`
- `data-enhanced product`
- `data-driven service`
- `data-enabled performance`
- `bi-directional`

### definitions.odpsPortfolioPriority

Portfolio-level priority of the data product.

**Allowed values:**

- `critical`
- `high`
- `medium`
- `low`

### definitions.odpsGovernanceProfile

Governance maturity level of the data product per ODPS v4.1.

**Allowed values:**

- `structured`
- `enforced`
- `automated`
- `audit_ready`
