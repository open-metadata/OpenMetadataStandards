
# Test Definition

**Reusable test templates for data quality validation**

---

## Overview

The **TestDefinition** entity represents reusable test templates that define the structure and logic for data quality tests. Test definitions are parameterized blueprints that can be instantiated into test cases applied to specific tables or columns.

## Relationship Diagram

```mermaid
graph TD
    %% Main entity
    TD[TestDefinition<br/>tableRowCountToBeBetween]

    %% Parameters
    TD -->|defines| PARAM1[Parameter<br/>minValue: INT]
    TD -->|defines| PARAM2[Parameter<br/>maxValue: INT]

    %% Test type classification
    TYPE[EntityType<br/>Table] -.->|applies to| TD
    PLATFORM1[TestPlatform<br/>OpenMetadata] -.->|supports| TD
    PLATFORM2[TestPlatform<br/>DBT] -.->|supports| TD
    PLATFORM3[TestPlatform<br/>GreatExpectations] -.->|supports| TD

    %% Instantiated test cases
    TD -->|template for| TC1[TestCase<br/>customers_row_count]
    TD -->|template for| TC2[TestCase<br/>orders_row_count]
    TD -->|template for| TC3[TestCase<br/>products_row_count]

    %% Test cases applied to tables
    TC1 -.->|tests| TBL1[Table<br/>customers]
    TC2 -.->|tests| TBL2[Table<br/>orders]
    TC3 -.->|tests| TBL3[Table<br/>products]

    %% Test suites
    TS1[TestSuite<br/>customers.testSuite] -->|contains| TC1
    TS2[TestSuite<br/>orders.testSuite] -->|contains| TC2

    %% Governance
    OWNER[User/Team<br/>Admin] -.->|owns| TD

    %% Other test definitions
    TD2[TestDefinition<br/>columnValuesToBeUnique] -->|template for| TC4[TestCase<br/>email_unique]
    TYPE2[EntityType<br/>Column] -.->|applies to| TD2
    TC4 -.->|tests| COL1[Column<br/>customer.email]

    TD3[TestDefinition<br/>columnValuesToBeBetween] -->|template for| TC5[TestCase<br/>age_range_check]
    TD3 -->|defines| PARAM3[Parameter<br/>minValue: DOUBLE]
    TD3 -->|defines| PARAM4[Parameter<br/>maxValue: DOUBLE]
    TC5 -.->|tests| COL2[Column<br/>customer.age]

    %% Data type constraints
    DT1[DataType<br/>NUMBER, INT] -.->|supported by| TD3

    %% Styling
    classDef definition fill:#8B5CF6,stroke:#7C3AED,color:#fff
    classDef testcase fill:#DC2626,stroke:#B91C1C,color:#fff
    classDef suite fill:#EF4444,stroke:#DC2626,color:#fff
    classDef parameter fill:#A78BFA,stroke:#8B5CF6,color:#fff
    classDef data fill:#2563EB,stroke:#1E40AF,color:#fff
    classDef governance fill:#059669,stroke:#047857,color:#fff
    classDef platform fill:#F59E0B,stroke:#D97706,color:#fff

    class TD,TD2,TD3 definition
    class TC1,TC2,TC3,TC4,TC5 testcase
    class TS1,TS2 suite
    class PARAM1,PARAM2,PARAM3,PARAM4 parameter
    class TBL1,TBL2,TBL3,COL1,COL2 data
    class OWNER governance
    class TYPE,TYPE2,PLATFORM1,PLATFORM2,PLATFORM3,DT1 platform
```

---

## Schema Specifications

View the complete TestDefinition schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/data/testDefinition.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "TestDefinition",
      "description": "A `TestDefinition` is a reusable test template with parameters that can be applied to tables or columns.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.data.TestDefinition",

      "definitions": {
        "testPlatform": {
          "description": "Test platform",
          "type": "string",
          "enum": [
            "OpenMetadata", "GreatExpectations", "Deequ",
            "Soda", "DBT", "Custom"
          ]
        },
        "entityType": {
          "description": "Entity type this test applies to",
          "type": "string",
          "enum": ["Table", "Column"]
        },
        "testDataType": {
          "description": "Data types this test supports",
          "type": "string",
          "enum": [
            "NUMBER", "INT", "FLOAT", "DOUBLE",
            "DECIMAL", "TIMESTAMP", "TIME", "DATE",
            "DATETIME", "ARRAY", "MAP", "SET",
            "STRING", "BOOLEAN"
          ]
        },
        "parameterDefinition": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string",
              "description": "Parameter name"
            },
            "displayName": {
              "type": "string",
              "description": "Display name"
            },
            "dataType": {
              "$ref": "#/definitions/testDataType"
            },
            "description": {
              "type": "string"
            },
            "required": {
              "type": "boolean",
              "default": false
            },
            "optionValues": {
              "type": "array",
              "items": {"type": "string"}
            }
          },
          "required": ["name", "dataType"]
        }
      },

      "properties": {
        "id": {
          "description": "Unique identifier",
          "$ref": "../../type/basic.json#/definitions/uuid"
        },
        "name": {
          "description": "Test definition name",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "Fully qualified name",
          "$ref": "../../type/basic.json#/definitions/fullyQualifiedEntityName"
        },
        "displayName": {
          "description": "Display name",
          "type": "string"
        },
        "description": {
          "description": "Markdown description",
          "$ref": "../../type/basic.json#/definitions/markdown"
        },
        "entityType": {
          "$ref": "#/definitions/entityType"
        },
        "testPlatforms": {
          "description": "Platforms supporting this test",
          "type": "array",
          "items": {
            "$ref": "#/definitions/testPlatform"
          }
        },
        "supportedDataTypes": {
          "description": "Data types this test can validate",
          "type": "array",
          "items": {
            "$ref": "#/definitions/testDataType"
          }
        },
        "parameterDefinition": {
          "description": "Parameters for this test",
          "type": "array",
          "items": {
            "$ref": "#/definitions/parameterDefinition"
          }
        },
        "owner": {
          "description": "Owner (user or team)",
          "$ref": "../../type/entityReference.json"
        },
        "version": {
          "description": "Metadata version",
          "$ref": "../../type/entityHistory.json#/definitions/entityVersion"
        }
      },

      "required": ["id", "name", "entityType", "testPlatforms"]
    }
    ```

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/testDefinition.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2001/XMLSchema#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # TestDefinition Class Definition
    om:TestDefinition a owl:Class ;
        rdfs:subClassOf om:DataQualityAsset ;
        rdfs:label "TestDefinition" ;
        rdfs:comment "A reusable test template that can be instantiated with parameters" ;
        om:hierarchyLevel 1 .

    # Properties
    om:testDefinitionName a owl:DatatypeProperty ;
        rdfs:domain om:TestDefinition ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name of the test definition" .

    om:entityType a owl:DatatypeProperty ;
        rdfs:domain om:TestDefinition ;
        rdfs:range om:EntityType ;
        rdfs:label "entityType" ;
        rdfs:comment "Type of entity this test applies to: Table or Column" .

    om:testPlatform a owl:DatatypeProperty ;
        rdfs:domain om:TestDefinition ;
        rdfs:range om:TestPlatform ;
        rdfs:label "testPlatform" ;
        rdfs:comment "Platform that executes this test" .

    om:supportsDataType a owl:DatatypeProperty ;
        rdfs:domain om:TestDefinition ;
        rdfs:range om:DataType ;
        rdfs:label "supportedDataTypes" ;
        rdfs:comment "Data types this test can validate" .

    om:hasParameter a owl:ObjectProperty ;
        rdfs:domain om:TestDefinition ;
        rdfs:range om:ParameterDefinition ;
        rdfs:label "parameterDefinition" ;
        rdfs:comment "Parameters required for this test" .

    # EntityType Enumeration
    om:EntityType a owl:Class ;
        owl:oneOf (
            om:TableEntity
            om:ColumnEntity
        ) .

    # TestPlatform Enumeration
    om:TestPlatform a owl:Class ;
        owl:oneOf (
            om:OpenMetadataPlatform
            om:GreatExpectationsPlatform
            om:DeequPlatform
            om:SodaPlatform
            om:DBTPlatform
        ) .

    # Example Instance
    ex:tableRowCountToBeBetween a om:TestDefinition ;
        om:testDefinitionName "tableRowCountToBeBetween" ;
        om:displayName "Table Row Count To Be Between" ;
        om:description "Validates that the number of rows in a table is between min and max values" ;
        om:entityType om:TableEntity ;
        om:testPlatform om:OpenMetadataPlatform ;
        om:hasParameter ex:minValueParam ;
        om:hasParameter ex:maxValueParam .
    ```

    **[View Full RDF Ontology →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/ontology/openmetadata.ttl)**

=== "JSON-LD"

    **JSON-LD Context and Example**

    ```json
    {
      "@context": {
        "@vocab": "https://open-metadata.org/schema/",
        "om": "https://open-metadata.org/schema/",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "xsd": "http://www.w3.org/2001/XMLSchema#",

        "TestDefinition": "om:TestDefinition",
        "name": {
          "@id": "om:testDefinitionName",
          "@type": "xsd:string"
        },
        "fullyQualifiedName": {
          "@id": "om:fullyQualifiedName",
          "@type": "xsd:string"
        },
        "displayName": {
          "@id": "om:displayName",
          "@type": "xsd:string"
        },
        "description": {
          "@id": "om:description",
          "@type": "xsd:string"
        },
        "entityType": {
          "@id": "om:entityType",
          "@type": "@vocab"
        },
        "testPlatforms": {
          "@id": "om:testPlatform",
          "@type": "@vocab",
          "@container": "@set"
        },
        "supportedDataTypes": {
          "@id": "om:supportsDataType",
          "@type": "@vocab",
          "@container": "@set"
        },
        "parameterDefinition": {
          "@id": "om:hasParameter",
          "@type": "@id",
          "@container": "@list"
        },
        "owner": {
          "@id": "om:ownedBy",
          "@type": "@id"
        }
      }
    }
    ```

    **Example JSON-LD Instance**:

    ```json
    {
      "@context": "https://open-metadata.org/context/testDefinition.jsonld",
      "@type": "TestDefinition",
      "@id": "https://open-metadata.org/testDefinitions/tableRowCountToBeBetween",

      "name": "tableRowCountToBeBetween",
      "displayName": "Table Row Count To Be Between",
      "description": "Validates that the number of rows in a table is between min and max values",
      "entityType": "Table",
      "testPlatforms": ["OpenMetadata", "DBT"],

      "parameterDefinition": [
        {
          "name": "minValue",
          "displayName": "Minimum Value",
          "dataType": "INT",
          "description": "Minimum expected row count",
          "required": false
        },
        {
          "name": "maxValue",
          "displayName": "Maximum Value",
          "dataType": "INT",
          "description": "Maximum expected row count",
          "required": false
        }
      ],

      "owner": {
        "@id": "https://example.com/users/system",
        "@type": "User",
        "name": "admin"
      }
    }
    ```

    **[View Full JSON-LD Context →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/contexts/testDefinition.jsonld)**

---

## Use Cases

- Define standard data quality test templates across the organization
- Create custom test definitions for specific business rules
- Support multiple testing platforms (Great Expectations, Deequ, Soda, DBT)
- Parameterize tests for reusability
- Validate different data types and entity types
- Build test libraries for common quality checks
- Enable test catalog and discovery

---

## JSON Schema Specification

### Core Properties

#### `id` (uuid)
**Type**: `string` (UUID format)
**Required**: Yes (system-generated)
**Description**: Unique identifier for this test definition

```json
{
  "id": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d"
}
```

---

#### `name` (entityName)
**Type**: `string`
**Required**: Yes
**Pattern**: `^[a-zA-Z0-9_]+$`
**Description**: Unique name of the test definition (camelCase convention)

```json
{
  "name": "tableRowCountToBeBetween"
}
```

---

#### `fullyQualifiedName` (fullyQualifiedEntityName)
**Type**: `string`
**Required**: Yes (system-generated)
**Description**: Fully qualified name

```json
{
  "fullyQualifiedName": "tableRowCountToBeBetween"
}
```

---

#### `displayName`
**Type**: `string`
**Required**: No
**Description**: Human-readable display name

```json
{
  "displayName": "Table Row Count To Be Between"
}
```

---

#### `description` (markdown)
**Type**: `string` (Markdown format)
**Required**: No
**Description**: Description of what this test validates

```json
{
  "description": "# Table Row Count Range Test\n\nValidates that the number of rows in a table falls within a specified range.\n\n## Usage\n- Set `minValue` for minimum threshold\n- Set `maxValue` for maximum threshold\n- Leave either empty for one-sided bounds"
}
```

---

### Test Configuration Properties

#### `entityType` (EntityType enum)
**Type**: `string` enum
**Required**: Yes
**Allowed Values**:

- `Table` - Test applies to tables
- `Column` - Test applies to columns

```json
{
  "entityType": "Table"
}
```

---

#### `testPlatforms[]` (TestPlatform[])
**Type**: `array` of string enum
**Required**: Yes
**Allowed Values**: `OpenMetadata`, `GreatExpectations`, `Deequ`, `Soda`, `DBT`, `Custom`
**Description**: Platforms that support this test

```json
{
  "testPlatforms": ["OpenMetadata", "DBT"]
}
```

---

#### `supportedDataTypes[]` (TestDataType[])
**Type**: `array` of string enum
**Required**: No
**Allowed Values**: `NUMBER`, `INT`, `FLOAT`, `DOUBLE`, `DECIMAL`, `TIMESTAMP`, `TIME`, `DATE`, `DATETIME`, `ARRAY`, `MAP`, `SET`, `STRING`, `BOOLEAN`
**Description**: Data types this test can validate (for column tests)

```json
{
  "supportedDataTypes": ["NUMBER", "INT", "FLOAT", "DOUBLE"]
}
```

---

#### `parameterDefinition[]` (ParameterDefinition[])
**Type**: `array` of ParameterDefinition objects
**Required**: No
**Description**: Parameters that can be configured when creating test cases

**ParameterDefinition Object Properties**:

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `name` | string | Yes | Parameter name (camelCase) |
| `displayName` | string | No | Display name |
| `dataType` | TestDataType | Yes | Parameter data type |
| `description` | string | No | Parameter description |
| `required` | boolean | No | Whether parameter is required (default: false) |
| `optionValues` | string[] | No | Allowed values (for enums) |

**Example**:

```json
{
  "parameterDefinition": [
    {
      "name": "minValue",
      "displayName": "Minimum Value",
      "dataType": "INT",
      "description": "Minimum expected row count (inclusive)",
      "required": false
    },
    {
      "name": "maxValue",
      "displayName": "Maximum Value",
      "dataType": "INT",
      "description": "Maximum expected row count (inclusive)",
      "required": false
    }
  ]
}
```

---

### Governance Properties

#### `owner` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: User or team that owns this test definition

```json
{
  "owner": {
    "id": "d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a",
    "type": "user",
    "name": "admin",
    "displayName": "Administrator"
  }
}
```

---

### Versioning Properties

#### `version` (entityVersion)
**Type**: `number`
**Required**: Yes (system-managed)
**Description**: Metadata version number

```json
{
  "version": 1.0
}
```

---

## Complete Examples

### Table-Level Test Definition

```json
{
  "id": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d",
  "name": "tableRowCountToBeBetween",
  "fullyQualifiedName": "tableRowCountToBeBetween",
  "displayName": "Table Row Count To Be Between",
  "description": "Validates that the number of rows in a table is between min and max values",
  "entityType": "Table",
  "testPlatforms": ["OpenMetadata", "DBT"],
  "parameterDefinition": [
    {
      "name": "minValue",
      "displayName": "Minimum Value",
      "dataType": "INT",
      "description": "Minimum expected row count",
      "required": false
    },
    {
      "name": "maxValue",
      "displayName": "Maximum Value",
      "dataType": "INT",
      "description": "Maximum expected row count",
      "required": false
    }
  ],
  "owner": {
    "id": "system-user-id",
    "type": "user",
    "name": "admin"
  },
  "version": 1.0
}
```

### Column-Level Test Definition

```json
{
  "id": "b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e",
  "name": "columnValuesToBeBetween",
  "fullyQualifiedName": "columnValuesToBeBetween",
  "displayName": "Column Values To Be Between",
  "description": "Validates that all values in a column fall within a specified numeric range",
  "entityType": "Column",
  "testPlatforms": ["OpenMetadata", "GreatExpectations", "Soda"],
  "supportedDataTypes": ["NUMBER", "INT", "FLOAT", "DOUBLE", "DECIMAL"],
  "parameterDefinition": [
    {
      "name": "minValue",
      "displayName": "Minimum Value",
      "dataType": "DOUBLE",
      "description": "Minimum expected value (inclusive)",
      "required": false
    },
    {
      "name": "maxValue",
      "displayName": "Maximum Value",
      "dataType": "DOUBLE",
      "description": "Maximum expected value (inclusive)",
      "required": false
    }
  ],
  "version": 1.2
}
```

### Custom Enum Test Definition

```json
{
  "id": "c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f",
  "name": "columnValuesToBeInSet",
  "fullyQualifiedName": "columnValuesToBeInSet",
  "displayName": "Column Values To Be In Set",
  "description": "Validates that all column values are within an allowed set of values",
  "entityType": "Column",
  "testPlatforms": ["OpenMetadata"],
  "supportedDataTypes": ["STRING", "INT"],
  "parameterDefinition": [
    {
      "name": "allowedValues",
      "displayName": "Allowed Values",
      "dataType": "ARRAY",
      "description": "List of allowed values (comma-separated)",
      "required": true
    }
  ],
  "version": 1.0
}
```

---

## RDF Representation

### Ontology Class

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl: <http://www.w3.org/2001/XMLSchema#> .

om:TestDefinition a owl:Class ;
    rdfs:subClassOf om:DataQualityAsset ;
    rdfs:label "TestDefinition" ;
    rdfs:comment "A reusable test template with parameters" ;
    om:hasProperties [
        om:name "string" ;
        om:entityType "EntityType" ;
        om:testPlatforms "TestPlatform[]" ;
        om:parameterDefinition "ParameterDefinition[]" ;
    ] .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://example.com/tests/> .

ex:tableRowCountToBeBetween a om:TestDefinition ;
    om:name "tableRowCountToBeBetween" ;
    om:displayName "Table Row Count To Be Between" ;
    om:description "Validates row count range" ;
    om:entityType "Table" ;
    om:testPlatform "OpenMetadata" ;
    om:hasParameter ex:minValueParam ;
    om:hasParameter ex:maxValueParam .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "TestDefinition": "om:TestDefinition",
    "name": "om:testDefinitionName",
    "entityType": {
      "@id": "om:entityType",
      "@type": "@vocab"
    },
    "testPlatforms": {
      "@id": "om:testPlatform",
      "@container": "@set"
    },
    "parameterDefinition": {
      "@id": "om:hasParameter",
      "@container": "@list"
    }
  }
}
```

---

## Relationships

### Child Entities
- **TestCase**: Instances created from this definition

### Associated Entities
- **Owner**: User or team owning this definition

---

## Custom Properties

This entity supports custom properties through the `extension` field.
Common custom properties include:

- **Data Classification**: Sensitivity level
- **Cost Center**: Billing allocation
- **Retention Period**: Data retention requirements
- **Application Owner**: Owning application/team

See [Custom Properties](../metadata-specifications/custom-properties.md)
for details on defining and using custom properties.

---

## API Operations

### List Test Definitions

```http
GET /api/v1/testDefinitions
```

### Get Test Definition

```http
GET /api/v1/testDefinitions/name/tableRowCountToBeBetween
```

### Create Test Definition

```http
POST /api/v1/testDefinitions
Content-Type: application/json

{
  "name": "customTestDefinition",
  "entityType": "Column",
  "testPlatforms": ["Custom"],
  "parameterDefinition": [
    {
      "name": "threshold",
      "dataType": "DOUBLE",
      "required": true
    }
  ]
}
```

---

## Related Documentation

- **[Test Case](test-case.md)** - Test instances
- **[Test Suite](test-suite.md)** - Test collections
- **[Table](../data-assets/databases/table.md)** - Table entity
- **[Data Quality Overview](overview.md)** - Quality framework
