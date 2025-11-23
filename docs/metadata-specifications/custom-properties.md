
# Custom Properties & Extensions

**Custom Properties** in OpenMetadata allow extending any entity with organization-specific metadata fields without modifying the core schema. This enables tailoring OpenMetadata to unique business needs while maintaining compatibility with the standard schema.

## Overview

Custom Properties provide:

- **Schema Extension**: Add custom fields to any entity type
- **Type Safety**: Define data types and validation rules
- **No Code Changes**: Extend entities without modifying OpenMetadata code
- **API Support**: Access custom properties through standard APIs
- **UI Integration**: Custom fields appear in the OpenMetadata UI
- **Migration Safe**: Survive platform upgrades
- **Multi-tenancy**: Different properties for different teams/domains

## How Custom Properties Work

### Extension Mechanism

OpenMetadata entities support an `extension` field that stores custom properties:

```json
{
  "id": "table-uuid",
  "name": "customers",
  "description": "Customer master table",
  "extension": {
    "dataClassification": "Internal",
    "costCenter": "CC-12345",
    "retentionYears": 7,
    "complianceApproved": true,
    "applicationOwner": "CustomerApp",
    "customTags": ["critical", "pii", "financial"]
  }
}
```

### Custom Property Definition

Custom properties are defined through the Type system:

```json
{
  "name": "dataClassification",
  "propertyType": {
    "id": "classification-type-id",
    "type": "enum",
    "name": "DataClassification"
  },
  "description": "Data classification level",
  "customPropertyConfig": {
    "config": {
      "values": ["Public", "Internal", "Confidential", "Restricted"]
    }
  }
}
```

## Supported Property Types

### String Properties

```json
{
  "name": "applicationOwner",
  "propertyType": {
    "type": "string"
  },
  "description": "Name of the owning application"
}
```

### Integer Properties

```json
{
  "name": "retentionYears",
  "propertyType": {
    "type": "integer"
  },
  "description": "Data retention period in years"
}
```

### Number Properties (Decimal)

```json
{
  "name": "monthlyCost",
  "propertyType": {
    "type": "number"
  },
  "description": "Monthly cost in dollars"
}
```

### Boolean Properties

```json
{
  "name": "complianceApproved",
  "propertyType": {
    "type": "boolean"
  },
  "description": "Whether compliance team approved"
}
```

### Date/Time Properties

```json
{
  "name": "certificationDate",
  "propertyType": {
    "type": "dateTime"
  },
  "description": "Date of last security certification"
}
```

### Enum Properties

```json
{
  "name": "dataClassification",
  "propertyType": {
    "type": "enum",
    "config": {
      "values": ["Public", "Internal", "Confidential", "Restricted"]
    }
  },
  "description": "Data sensitivity classification"
}
```

### Entity Reference Properties

```json
{
  "name": "relatedTable",
  "propertyType": {
    "type": "entityReference",
    "config": {
      "entityType": "table"
    }
  },
  "description": "Reference to related table"
}
```

### Array Properties

```json
{
  "name": "supportedRegions",
  "propertyType": {
    "type": "array",
    "config": {
      "arrayItemType": "string"
    }
  },
  "description": "List of supported geographic regions"
}
```

### Markdown Properties

```json
{
  "name": "technicalNotes",
  "propertyType": {
    "type": "markdown"
  },
  "description": "Detailed technical documentation"
}
```

## Schema Specifications

=== "JSON Schema"

    ```json
    {
      "$id": "https://open-metadata.org/schema/type/customProperty.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "CustomProperty",
      "description": "Custom property definition for extending entities.",
      "type": "object",
      "definitions": {
        "propertyType": {
          "description": "Type of custom property",
          "type": "object",
          "properties": {
            "id": {
              "$ref": "./basic.json#/definitions/uuid"
            },
            "type": {
              "type": "string",
              "enum": [
                "string",
                "integer",
                "number",
                "boolean",
                "date",
                "dateTime",
                "time",
                "duration",
                "email",
                "uri",
                "enum",
                "entityReference",
                "entityReferenceList",
                "markdown",
                "array"
              ]
            },
            "name": {
              "type": "string"
            },
            "description": {
              "type": "string"
            }
          },
          "required": ["type"]
        },
        "customPropertyConfig": {
          "description": "Configuration for the custom property",
          "type": "object",
          "properties": {
            "config": {
              "type": "object",
              "properties": {
                "values": {
                  "description": "Allowed values for enum type",
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                },
                "entityType": {
                  "description": "Entity type for entityReference",
                  "type": "string"
                },
                "multiSelect": {
                  "description": "Allow multiple selections for enum",
                  "type": "boolean"
                },
                "arrayItemType": {
                  "description": "Type of items in array",
                  "type": "string"
                }
              }
            }
          }
        }
      },
      "properties": {
        "name": {
          "description": "Name of the custom property",
          "type": "string",
          "pattern": "^[a-zA-Z][a-zA-Z0-9_]*$"
        },
        "description": {
          "description": "Description of the custom property",
          "type": "string"
        },
        "propertyType": {
          "$ref": "#/definitions/propertyType"
        },
        "customPropertyConfig": {
          "$ref": "#/definitions/customPropertyConfig"
        }
      },
      "required": ["name", "propertyType"],
      "additionalProperties": false
    }
    ```

=== "RDF (Turtle)"

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix om-custom: <https://open-metadata.org/schema/type/> .
    @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2002/07/owl#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # Custom Property Class
    om-custom:CustomProperty a owl:Class ;
        rdfs:label "Custom Property" ;
        rdfs:comment "Custom property definition for extending entities" ;
        rdfs:isDefinedBy om: .

    # Properties
    om-custom:propertyName a owl:DatatypeProperty ;
        rdfs:label "property name" ;
        rdfs:comment "Name of the custom property" ;
        rdfs:domain om-custom:CustomProperty ;
        rdfs:range xsd:string .

    om-custom:propertyType a owl:DatatypeProperty ;
        rdfs:label "property type" ;
        rdfs:comment "Data type of the property" ;
        rdfs:domain om-custom:CustomProperty ;
        rdfs:range xsd:string .

    om-custom:hasExtension a owl:ObjectProperty ;
        rdfs:label "has extension" ;
        rdfs:comment "Custom property extension" ;
        rdfs:range om-custom:CustomProperty .
    ```

=== "JSON-LD Context"

    ```json
    {
      "@context": {
        "@vocab": "https://open-metadata.org/schema/type/",
        "om": "https://open-metadata.org/schema/",
        "xsd": "http://www.w3.org/2001/XMLSchema#",

        "CustomProperty": {
          "@id": "om:CustomProperty",
          "@type": "@id"
        },
        "name": {
          "@id": "om:propertyName",
          "@type": "xsd:string"
        },
        "propertyType": {
          "@id": "om:propertyType",
          "@type": "xsd:string"
        },
        "extension": {
          "@id": "om:hasExtension",
          "@type": "@id"
        }
      }
    }
    ```

## Use Cases

### Business Metadata

Add business-specific fields:

```json
{
  "name": "customers",
  "extension": {
    "businessOwner": "Sales Department",
    "costCenter": "CC-SALES-001",
    "projectCode": "PROJ-2024-001",
    "budgetCategory": "Operations"
  }
}
```

### Compliance Tracking

Track regulatory requirements:

```json
{
  "name": "customer_data",
  "extension": {
    "dataClassification": "Confidential",
    "gdprApplicable": true,
    "hipaaCompliant": false,
    "retentionYears": 7,
    "complianceApprovalDate": "2024-01-15",
    "lastAuditDate": "2024-01-10",
    "nextAuditDue": "2024-07-10"
  }
}
```

### Technical Metadata

Add technical details:

```json
{
  "name": "sales_data",
  "extension": {
    "storageClass": "STANDARD",
    "compressionType": "SNAPPY",
    "partitionStrategy": "DATE",
    "replicationFactor": 3,
    "backupEnabled": true,
    "encryptionAlgorithm": "AES-256"
  }
}
```

### Cost Management

Track data costs:

```json
{
  "name": "analytics_warehouse",
  "extension": {
    "monthlyCost": 15000.50,
    "costCenter": "CC-12345",
    "costAllocationTag": "analytics-team",
    "storageGB": 50000,
    "queryCreditsMonthly": 10000
  }
}
```

### Application Context

Link to applications:

```json
{
  "name": "orders",
  "extension": {
    "applicationName": "E-Commerce Platform",
    "applicationVersion": "2.5.1",
    "deploymentEnvironment": "Production",
    "serviceLevel": "Tier-1",
    "oncallTeam": "Platform Engineering"
  }
}
```

## Creating Custom Properties

### Via API

```http
POST /api/v1/metadata/types/{entityType}/customProperties
Content-Type: application/json

{
  "name": "dataClassification",
  "description": "Data classification level",
  "propertyType": {
    "type": "enum",
    "config": {
      "values": ["Public", "Internal", "Confidential", "Restricted"]
    }
  }
}
```

### Via UI

1. Navigate to Settings → Custom Properties
2. Select entity type (Table, Dashboard, etc.)
3. Click "Add Custom Property"
4. Define name, type, and configuration
5. Save and apply to entities

## Using Custom Properties

### Set Custom Property Value

```http
PATCH /api/v1/tables/{id}
Content-Type: application/json-patch+json

[
  {
    "op": "add",
    "path": "/extension/dataClassification",
    "value": "Confidential"
  }
]
```

### Query by Custom Property

```http
GET /api/v1/search/query?q=extension.dataClassification:Confidential
```

### Filter in UI

Use advanced search to filter by custom properties:
```
extension.costCenter:"CC-12345"
extension.complianceApproved:true
extension.retentionYears:>5
```

## Best Practices

### 1. Use Consistent Naming
Follow camelCase convention: `dataClassification` not `data_classification`

### 2. Provide Clear Descriptions
Document what each property means and when to use it

### 3. Use Enums for Controlled Values
Prefer enums over free text for standardized values

### 4. Don't Duplicate Standard Fields
Use custom properties for organization-specific needs only

### 5. Plan for Governance
Define who can create and modify custom properties

### 6. Document Usage
Maintain documentation of custom property definitions

### 7. Validate Data
Use appropriate types and validation rules

### 8. Consider Performance
Limit the number of custom properties (< 20 per entity type)

## Common Custom Property Patterns

### Compliance Pattern

```json
{
  "dataClassification": "enum",
  "regulatoryFramework": "array<string>",
  "retentionPeriod": "integer",
  "privacyImpactAssessment": "boolean",
  "lastAuditDate": "date"
}
```

### Cost Management Pattern

```json
{
  "costCenter": "string",
  "monthlyCost": "number",
  "budgetOwner": "string",
  "chargeback": "boolean"
}
```

### Application Ownership Pattern

```json
{
  "applicationName": "string",
  "applicationOwner": "string",
  "serviceLevel": "enum",
  "supportTeam": "string"
}
```

### Data Quality Pattern

```json
{
  "qualityScore": "number",
  "lastValidationDate": "date",
  "validationStatus": "enum",
  "knownIssues": "markdown"
}
```

## Integration with Entity Pages

All entity pages support custom properties through the `extension` field. When documenting entities, reference custom properties:

```markdown
## Custom Properties

This entity supports custom properties through the `extension` field.
Common custom properties include:

- **Data Classification**: Sensitivity level
- **Cost Center**: Billing allocation
- **Retention Period**: Data retention requirements
- **Application Owner**: Owning application/team

See [Custom Properties](../metadata-specifications/custom-properties.md)
for details on defining and using custom properties.
```

## API Operations

### List Custom Properties for Entity Type

```http
GET /api/v1/metadata/types/{entityType}
```

### Add Custom Property

```http
POST /api/v1/metadata/types/{entityType}/customProperties
```

### Update Custom Property Definition

```http
PUT /api/v1/metadata/types/{entityType}/customProperties/{propertyName}
```

### Delete Custom Property

```http
DELETE /api/v1/metadata/types/{entityType}/customProperties/{propertyName}
```

## Related Documentation

- All entity pages support custom properties via the `extension` field
- See individual entity pages for entity-specific examples
- [Table](../data-assets/databases/table.md) - Table custom properties
- [Dashboard](../data-assets/dashboards/dashboard.md) - Dashboard custom properties
- [Pipeline](../data-assets/pipelines/pipeline.md) - Pipeline custom properties
