
# DatabaseSchema

**Database schemas - logical namespaces for organizing tables**

---

## Overview

The **DatabaseSchema** entity represents a logical namespace within a database that groups related tables, views, and stored procedures. In PostgreSQL, these are schemas like `public` or `analytics`. In Snowflake, these are schemas within a database. For databases without explicit schema support (e.g., MySQL), OpenMetadata creates a `default` schema to maintain the consistent four-level hierarchy (`DatabaseService → Database → DatabaseSchema → Table/StoredProcedure`).

**Hierarchy**:
```mermaid
graph LR
    A[DatabaseService] --> B[Database]
    B --> C[Schema]
    C --> D1[Table]
    C --> D2[StoredProcedure]
    D1 --> E[Column]

    style A fill:#667eea,color:#fff
    style B fill:#4facfe,color:#fff
    style C fill:#00f2fe,color:#333
    style D1 fill:#00f2fe,color:#333
    style D2 fill:#00f2fe,color:#333
    style E fill:#e0f2fe,color:#333
```

---

## Relationships

### Parent Entities
- **Database**: The database containing this schema
- **DatabaseService**: The service hosting the database

### Child Entities
- **Table**: Tables within this schema
- **StoredProcedure**: Stored procedures in this schema

### Associated Entities
- **Owner**: User or team owning this schema
- **Domain**: Business domain assignment
- **Tag**: Classification tags

### Relationship Diagram

```mermaid
graph TD
    %% Hierarchical relationships - Up and down the hierarchy
    SVC[DatabaseService<br/>postgres_prod] -->|contains| DB[Database<br/>ecommerce]
    DB -->|contains| SCH[Schema<br/>public]
    SCH -->|contains| TBL1[Table<br/>customers]
    SCH -->|contains| TBL2[Table<br/>orders]
    SCH -->|contains| TBL3[Table<br/>products]
    SCH -->|contains| SP[StoredProcedure<br/>calc_total]
    TBL1 -->|has| COL1[Column<br/>customer_id]
    TBL1 -->|has| COL2[Column<br/>email]
    TBL2 -->|has| COL3[Column<br/>order_id]

    %% Cross-entity relationships - Ownership
    USR[User<br/>jane.doe] -.->|owns| SCH
    TEAM[Team<br/>Ecommerce] -.->|owns| SCH

    %% Cross-entity relationships - Governance
    DOM[Domain<br/>Sales] -.->|groups| SCH
    TAG1[Tag<br/>Tier.Gold] -.->|classifies| SCH
    TAG2[Tag<br/>DataCategory.Transactional] -.->|classifies| SCH
    GT[GlossaryTerm<br/>CustomerData] -.->|describes| TBL1

    %% Cross-entity relationships - Quality
    TS[TestSuite<br/>schema_suite] -.->|validates| TBL1
    TC1[TestCase<br/>row_count] -.->|tests| TBL1
    TC2[TestCase<br/>email_format] -.->|tests| COL2

    %% Cross-entity relationships - Lineage
    PIPE[Pipeline<br/>customer_etl] -.->|writes to| TBL1
    DASH[Dashboard<br/>Sales Dashboard] -.->|reads from| TBL2
    ML[MLModel<br/>churn_predictor] -.->|trains on| TBL1

    %% Styling
    classDef service fill:#7C3AED,stroke:#5B21B6,color:#fff
    classDef database fill:#2563EB,stroke:#1E40AF,color:#fff
    classDef schema fill:#3B82F6,stroke:#2563EB,color:#fff,stroke-width:3px
    classDef object fill:#60A5FA,stroke:#3B82F6,color:#fff
    classDef column fill:#93C5FD,stroke:#60A5FA,color:#000
    classDef governance fill:#059669,stroke:#047857,color:#fff
    classDef quality fill:#DC2626,stroke:#B91C1C,color:#fff
    classDef process fill:#F59E0B,stroke:#D97706,color:#fff

    class SVC service
    class DB database
    class SCH schema
    class TBL1,TBL2,TBL3,SP object
    class COL1,COL2,COL3 column
    class USR,TEAM,DOM,TAG1,TAG2,GT governance
    class TS,TC1,TC2 quality
    class PIPE,DASH,ML process
```

---

## Schema Specifications

View the complete DatabaseSchema schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/data/databaseSchema.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "Database Schema",
      "$comment": "@om-entity-type",
      "description": "This schema defines the Database Schema entity. A `Database Schema` is collection of tables, views, stored procedures, and other database objects.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.data.DatabaseSchema",
      "javaInterfaces": ["org.openmetadata.schema.EntityInterface"],

      "definitions": {},

      "properties": {
        "id": {
          "description": "Unique identifier that identifies this schema instance.",
          "$ref": "../../type/basic.json#/definitions/uuid"
        },
        "name": {
          "description": "Name that identifies the schema.",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "Name that uniquely identifies a schema in the format 'ServiceName.DatabaseName.SchemaName'.",
          "$ref": "../../type/basic.json#/definitions/fullyQualifiedEntityName"
        },
        "displayName": {
          "description": "Display Name that identifies this schema.",
          "type": "string"
        },
        "description": {
          "description": "Description of the schema instance.",
          "$ref": "../../type/basic.json#/definitions/markdown"
        },
        "dataProducts": {
          "description": "List of data products this entity is part of.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "version": {
          "description": "Metadata version of the entity.",
          "$ref": "../../type/entityHistory.json#/definitions/entityVersion"
        },
        "updatedAt": {
          "description": "Last update time corresponding to the new version of the entity in Unix epoch time milliseconds.",
          "$ref": "../../type/basic.json#/definitions/timestamp"
        },
        "updatedBy": {
          "description": "User who made the update.",
          "type": "string"
        },
        "impersonatedBy": {
          "description": "Bot user that performed the action on behalf of the actual user.",
          "$ref": "../../type/basic.json#/definitions/impersonatedBy"
        },
        "href": {
          "description": "Link to the resource corresponding to this entity.",
          "$ref": "../../type/basic.json#/definitions/href"
        },
        "owners": {
          "description": "Owner of this schema.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "service": {
          "description": "Link to the database cluster/service where this schema is hosted in.",
          "$ref": "../../type/entityReference.json"
        },
        "serviceType": {
          "description": "Service type where this schema is hosted in.",
          "$ref": "../services/databaseService.json#/definitions/databaseServiceType"
        },
        "database": {
          "description": "Reference to Database that contains this table.",
          "$ref": "../../type/entityReference.json"
        },
        "tables": {
          "description": "References to tables in the schema.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "usageSummary": {
          "description": "Latest usage information for this database.",
          "$ref": "../../type/usageDetails.json",
          "default": null
        },
        "tags": {
          "description": "Tags for this Database Schema Service.",
          "type": "array",
          "items": {
            "$ref": "../../type/tagLabel.json"
          },
          "default": []
        },
        "changeDescription": {
          "description": "Change that lead to this version of the entity.",
          "$ref": "../../type/entityHistory.json#/definitions/changeDescription"
        },
        "incrementalChangeDescription": {
          "description": "Change that lead to this version of the entity.",
          "$ref": "../../type/entityHistory.json#/definitions/changeDescription"
        },
        "deleted": {
          "description": "When `true` indicates the entity has been soft deleted.",
          "type": "boolean",
          "default": false
        },
        "retentionPeriod": {
          "description": "Retention period of the data in the database schema. Period is expressed as duration in ISO 8601 format in UTC. Example - `P23DT23H`. When not set, the retention period is inherited from the parent database, if it exists.",
          "$ref": "../../type/basic.json#/definitions/duration"
        },
        "extension": {
          "description": "Entity extension data with custom attributes added to the entity.",
          "$ref": "../../type/basic.json#/definitions/entityExtension"
        },
        "sourceUrl": {
          "description": "Source URL of database schema.",
          "$ref": "../../type/basic.json#/definitions/sourceUrl"
        },
        "domains": {
          "description": "Domains the Database Schema belongs to. When not set, the Schema inherits the domain from the database it belongs to.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "votes": {
          "description": "Votes on the entity.",
          "$ref": "../../type/votes.json"
        },
        "lifeCycle": {
          "description": "Life Cycle properties of the entity",
          "$ref": "../../type/lifeCycle.json"
        },
        "followers": {
          "description": "Followers of this entity.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "certification": {
          "$ref": "../../type/assetCertification.json"
        },
        "sourceHash": {
          "description": "Source hash of the entity",
          "type": "string",
          "minLength": 1,
          "maxLength": 32
        },
        "databaseSchemaProfilerConfig": {
          "type": "object",
          "javaType": "org.openmetadata.schema.type.DatabaseSchemaProfilerConfig",
          "description": "This schema defines the type for Schema profile config.",
          "properties": {
            "profileSample": {
              "description": "Percentage of data or no. of rows we want to execute the profiler and tests on",
              "type": "number",
              "default": null
            },
            "profileSampleType": {
              "$ref": "./table.json#/definitions/profileSampleType"
            },
            "sampleDataCount": {
              "description": "Number of row of sample data to be generated",
              "type": "integer",
              "default": 50,
              "title": "Sample Data Rows Count"
            },
            "samplingMethodType": {
              "$ref": "./table.json#/definitions/samplingMethodType"
            },
            "sampleDataStorageConfig": {
              "title": "Storage Config for Sample Data",
              "$ref": "../services/connections/connectionBasicType.json#/definitions/sampleDataStorageConfig"
            },
            "randomizedSample": {
              "description": "Whether to randomize the sample data or not.",
              "type": "boolean",
              "default": true
            }
          }
        },
        "entityStatus": {
          "description": "Status of the DatabaseSchema.",
          "$ref": "../../type/status.json"
        }
      },

      "required": ["id", "name", "database", "service"],
      "additionalProperties": false
    }
    ```

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/databaseSchema.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2002/07/owl#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
    @prefix dcat: <http://www.w3.org/ns/dcat#> .

    # DatabaseSchema Class Definition
    om:DatabaseSchema a owl:Class ;
        rdfs:subClassOf om:DataAsset, dcat:Catalog ;
        rdfs:label "Database Schema" ;
        rdfs:comment "This schema defines the Database Schema entity. A Database Schema is collection of tables, views, stored procedures, and other database objects." .

    # Core Identity Properties
    om:id a owl:DatatypeProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range xsd:string ;
        rdfs:label "id" ;
        rdfs:comment "Unique identifier that identifies this schema instance." .

    om:name a owl:DatatypeProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name that identifies the schema." .

    om:fullyQualifiedName a owl:DatatypeProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range xsd:string ;
        rdfs:label "fullyQualifiedName" ;
        rdfs:comment "Name that uniquely identifies a schema in the format 'ServiceName.DatabaseName.SchemaName'." .

    # Relationship Properties
    om:belongsToDatabase a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:Database ;
        rdfs:label "database" ;
        rdfs:comment "Reference to Database that contains this table." .

    om:belongsToService a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:DatabaseService ;
        rdfs:label "service" ;
        rdfs:comment "Link to the database cluster/service where this schema is hosted in." .

    om:hasServiceType a owl:DatatypeProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range xsd:string ;
        rdfs:label "serviceType" ;
        rdfs:comment "Service type where this schema is hosted in." .

    om:hasTable a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:Table ;
        rdfs:label "tables" ;
        rdfs:comment "References to tables in the schema." .

    # Governance Properties
    om:hasOwners a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:EntityReference ;
        rdfs:label "owners" ;
        rdfs:comment "Owner of this schema." .

    om:hasDomains a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:Domain ;
        rdfs:label "domains" ;
        rdfs:comment "Domains the Database Schema belongs to." .

    om:hasTag a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:TagLabel ;
        rdfs:label "tags" ;
        rdfs:comment "Tags for this Database Schema Service." .

    om:hasFollowers a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:EntityReference ;
        rdfs:label "followers" ;
        rdfs:comment "Followers of this entity." .

    om:hasDataProducts a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:DataProduct ;
        rdfs:label "dataProducts" ;
        rdfs:comment "List of data products this entity is part of." .

    # Operational Properties
    om:isDeleted a owl:DatatypeProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range xsd:boolean ;
        rdfs:label "deleted" ;
        rdfs:comment "When true indicates the entity has been soft deleted." .

    om:retentionPeriod a owl:DatatypeProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range xsd:duration ;
        rdfs:label "retentionPeriod" ;
        rdfs:comment "Retention period of the data in the database schema. Period is expressed as duration in ISO 8601 format." .

    om:hasUsageSummary a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:UsageDetails ;
        rdfs:label "usageSummary" ;
        rdfs:comment "Latest usage information for this database." .

    om:hasProfilerConfig a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:DatabaseSchemaProfilerConfig ;
        rdfs:label "databaseSchemaProfilerConfig" ;
        rdfs:comment "Schema profiler configuration." .

    # Versioning Properties
    om:version a owl:DatatypeProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range xsd:decimal ;
        rdfs:label "version" ;
        rdfs:comment "Metadata version of the entity." .

    om:updatedAt a owl:DatatypeProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range xsd:long ;
        rdfs:label "updatedAt" ;
        rdfs:comment "Last update time in Unix epoch time milliseconds." .

    om:updatedBy a owl:DatatypeProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range xsd:string ;
        rdfs:label "updatedBy" ;
        rdfs:comment "User who made the update." .

    # Additional Properties
    om:hasVotes a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:Votes ;
        rdfs:label "votes" ;
        rdfs:comment "Votes on the entity." .

    om:hasLifeCycle a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:LifeCycle ;
        rdfs:label "lifeCycle" ;
        rdfs:comment "Life Cycle properties of the entity." .

    om:hasCertification a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:AssetCertification ;
        rdfs:label "certification" ;
        rdfs:comment "Certification status of the entity." .

    om:hasEntityStatus a owl:ObjectProperty ;
        rdfs:domain om:DatabaseSchema ;
        rdfs:range om:Status ;
        rdfs:label "entityStatus" ;
        rdfs:comment "Status of the DatabaseSchema." .

    # Example Instance
    ex:publicSchema a om:DatabaseSchema ;
        om:id "c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f" ;
        om:name "public" ;
        om:fullyQualifiedName "postgres_prod.ecommerce.public" ;
        om:belongsToDatabase ex:ecommerceDb ;
        om:belongsToService ex:postgresProd ;
        om:hasOwners ex:ecommerceTeam ;
        om:hasTag ex:tierGold ;
        om:hasTable ex:customersTable, ex:ordersTable ;
        om:isDeleted false ;
        om:version 1.3 .
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
        "dcat": "http://www.w3.org/ns/dcat#",

        "DatabaseSchema": {
          "@id": "om:DatabaseSchema",
          "@type": ["om:DataAsset", "dcat:Catalog"]
        },
        "id": {
          "@id": "om:id",
          "@type": "xsd:string"
        },
        "name": {
          "@id": "om:name",
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
        "database": {
          "@id": "om:belongsToDatabase",
          "@type": "@id"
        },
        "service": {
          "@id": "om:belongsToService",
          "@type": "@id"
        },
        "serviceType": {
          "@id": "om:hasServiceType",
          "@type": "xsd:string"
        },
        "tables": {
          "@id": "om:hasTable",
          "@type": "@id",
          "@container": "@set"
        },
        "owners": {
          "@id": "om:hasOwners",
          "@type": "@id",
          "@container": "@set"
        },
        "domains": {
          "@id": "om:hasDomains",
          "@type": "@id",
          "@container": "@set"
        },
        "tags": {
          "@id": "om:hasTag",
          "@type": "@id",
          "@container": "@set"
        },
        "dataProducts": {
          "@id": "om:hasDataProducts",
          "@type": "@id",
          "@container": "@set"
        },
        "followers": {
          "@id": "om:hasFollowers",
          "@type": "@id",
          "@container": "@set"
        },
        "deleted": {
          "@id": "om:isDeleted",
          "@type": "xsd:boolean"
        },
        "retentionPeriod": {
          "@id": "om:retentionPeriod",
          "@type": "xsd:duration"
        },
        "usageSummary": {
          "@id": "om:hasUsageSummary",
          "@type": "@json"
        },
        "databaseSchemaProfilerConfig": {
          "@id": "om:hasProfilerConfig",
          "@type": "@json"
        },
        "version": {
          "@id": "om:version",
          "@type": "xsd:decimal"
        },
        "updatedAt": {
          "@id": "om:updatedAt",
          "@type": "xsd:long"
        },
        "updatedBy": {
          "@id": "om:updatedBy",
          "@type": "xsd:string"
        },
        "votes": {
          "@id": "om:hasVotes",
          "@type": "@json"
        },
        "lifeCycle": {
          "@id": "om:hasLifeCycle",
          "@type": "@json"
        },
        "certification": {
          "@id": "om:hasCertification",
          "@type": "@json"
        },
        "entityStatus": {
          "@id": "om:hasEntityStatus",
          "@type": "@json"
        }
      }
    }
    ```

    **Example JSON-LD Instance**:

    ```json
    {
      "@context": "https://open-metadata.org/context/dataAsset.jsonld",
      "@type": "DatabaseSchema",
      "@id": "https://example.com/data/schemas/public",

      "id": "c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f",
      "name": "public",
      "fullyQualifiedName": "postgres_prod.ecommerce.public",
      "displayName": "Public Schema",
      "description": "Main application schema containing customer, order, and product tables",
      "deleted": false,
      "retentionPeriod": "P2555D",

      "database": {
        "@id": "https://example.com/data/databases/ecommerce",
        "@type": "Database",
        "id": "b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e",
        "name": "ecommerce",
        "type": "database"
      },

      "service": {
        "@id": "https://example.com/services/postgres_prod",
        "@type": "DatabaseService",
        "id": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d",
        "name": "postgres_prod",
        "type": "databaseService"
      },
      "serviceType": "Postgres",

      "tables": [
        {
          "@id": "https://example.com/data/tables/customers",
          "@type": "Table",
          "id": "d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a",
          "name": "customers",
          "type": "table"
        },
        {
          "@id": "https://example.com/data/tables/orders",
          "@type": "Table",
          "id": "e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b",
          "name": "orders",
          "type": "table"
        }
      ],

      "owners": [
        {
          "@id": "https://example.com/teams/ecommerce",
          "@type": "Team",
          "id": "e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b",
          "name": "ecommerce",
          "displayName": "E-commerce Team",
          "type": "team"
        }
      ],

      "domains": [
        {
          "@id": "https://example.com/domains/sales",
          "@type": "Domain",
          "id": "f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c",
          "name": "Sales",
          "type": "domain"
        }
      ],

      "tags": [
        {
          "tagFQN": "Tier.Gold",
          "source": "Classification",
          "labelType": "Manual",
          "state": "Confirmed"
        }
      ],

      "followers": [],
      "dataProducts": [],

      "usageSummary": {
        "dailyStats": {
          "count": 250,
          "percentileRank": 90.0
        },
        "weeklyStats": {
          "count": 1750,
          "percentileRank": 88.0
        },
        "monthlyStats": {
          "count": 7500,
          "percentileRank": 85.0
        },
        "date": "2024-01-03"
      },

      "databaseSchemaProfilerConfig": {
        "profileSample": 50,
        "profileSampleType": "PERCENTAGE",
        "sampleDataCount": 50,
        "randomizedSample": true
      },

      "votes": {
        "upVotes": 8,
        "downVotes": 0,
        "upVoters": [],
        "downVoters": []
      },

      "version": 1.3,
      "updatedAt": 1704240000000,
      "updatedBy": "jane.doe"
    }
    ```

    **[View Full JSON-LD Context →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/contexts/dataAsset.jsonld)**

---

## Use Cases

- Organize tables by application, function, or purpose
- Separate transactional tables from analytics views
- Isolate staging data from production tables
- Apply schema-level access controls and permissions
- Track schema-level ownership
- Document schema purpose and usage guidelines
- Manage data retention policies by schema
- Group related database objects together

---

## JSON Schema Specification

### Core Properties

#### `id` (uuid)
**Type**: `string` (UUID format)
**Required**: Yes (system-generated)
**Description**: Unique identifier for this database schema instance

```json
{
  "id": "c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f"
}
```

---

#### `name` (entityName)
**Type**: `string`
**Required**: Yes
**Pattern**: `^[^.]*$` (no dots allowed)
**Min Length**: 1
**Max Length**: 256
**Description**: Name of the schema

```json
{
  "name": "public"
}
```

---

#### `fullyQualifiedName` (fullyQualifiedEntityName)
**Type**: `string`
**Required**: Yes (system-generated)
**Pattern**: `^((?!::).)*$`
**Description**: Fully qualified name in the format `service.database.schema`

```json
{
  "fullyQualifiedName": "postgres_prod.ecommerce.public"
}
```

---

#### `displayName`
**Type**: `string`
**Required**: No
**Description**: Human-readable display name

```json
{
  "displayName": "Public Schema"
}
```

---

#### `description` (markdown)
**Type**: `string` (Markdown format)
**Required**: No
**Description**: Rich text description of the schema's purpose and usage

```json
{
  "description": "# Public Schema\n\nMain application schema for e-commerce platform.\n\n## Tables\n- **customers**: Customer master data\n- **orders**: Order transactions\n- **products**: Product catalog\n\n## Usage\nAll application tables should be created in this schema."
}
```

---

### Classification Properties

#### `schemaType` (SchemaType enum)
**Type**: `string` enum
**Required**: No
**Allowed Values**:

- `Application` - Application/transactional tables
- `Analytics` - Analytics and reporting objects
- `Reporting` - Reporting views and aggregates
- `Staging` - Staging/ETL tables
- `Audit` - Audit logs and history
- `Archive` - Archive/historical data
- `Public` - Default/public schema

```json
{
  "schemaType": "Application"
}
```

---

#### `retentionPeriod` (number)
**Type**: `number`
**Required**: No
**Description**: Data retention period in days for tables in this schema

```json
{
  "retentionPeriod": 2555
}
```

---

### Location Properties

#### `database` (EntityReference)
**Type**: `object`
**Required**: Yes
**Description**: Reference to parent database

```json
{
  "database": {
    "id": "b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e",
    "type": "database",
    "name": "ecommerce",
    "fullyQualifiedName": "postgres_prod.ecommerce"
  }
}
```

---

#### `service` (EntityReference)
**Type**: `object`
**Required**: Yes
**Description**: Reference to database service

```json
{
  "service": {
    "id": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d",
    "type": "databaseService",
    "name": "postgres_prod",
    "fullyQualifiedName": "postgres_prod"
  }
}
```

---

#### `tables[]` (EntityReference[])
**Type**: `array`
**Required**: No (system-populated)
**Description**: List of tables in this schema

```json
{
  "tables": [
    {
      "id": "d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a",
      "type": "table",
      "name": "customers",
      "fullyQualifiedName": "postgres_prod.ecommerce.public.customers"
    },
    {
      "id": "e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b",
      "type": "table",
      "name": "orders",
      "fullyQualifiedName": "postgres_prod.ecommerce.public.orders"
    }
  ]
}
```

---

#### `storedProcedures[]` (EntityReference[])
**Type**: `array`
**Required**: No (system-populated)
**Description**: List of stored procedures in this schema

```json
{
  "storedProcedures": [
    {
      "id": "f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c",
      "type": "storedProcedure",
      "name": "calculate_order_total",
      "fullyQualifiedName": "postgres_prod.ecommerce.public.calculate_order_total"
    }
  ]
}
```

---

### Governance Properties

#### `owner` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: User or team that owns this schema

```json
{
  "owner": {
    "id": "e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b",
    "type": "team",
    "name": "ecommerce",
    "displayName": "E-commerce Team"
  }
}
```

---

#### `domain` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: Data domain this schema belongs to

```json
{
  "domain": {
    "id": "f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c",
    "type": "domain",
    "name": "Sales",
    "fullyQualifiedName": "Sales"
  }
}
```

---

#### `tags[]` (TagLabel[])
**Type**: `array`
**Required**: No
**Description**: Classification tags applied to the schema

```json
{
  "tags": [
    {
      "tagFQN": "Tier.Gold",
      "description": "Critical production schema",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    },
    {
      "tagFQN": "DataCategory.Transactional",
      "source": "Classification",
      "labelType": "Automated",
      "state": "Confirmed"
    }
  ]
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
  "version": 1.3
}
```

---

#### `updatedAt` (timestamp)
**Type**: `integer` (Unix epoch milliseconds)
**Required**: Yes (system-managed)
**Description**: Last update timestamp

```json
{
  "updatedAt": 1704240000000
}
```

---

#### `updatedBy` (string)
**Type**: `string`
**Required**: Yes (system-managed)
**Description**: User who made the update

```json
{
  "updatedBy": "jane.doe"
}
```

---

## Complete Example

```json
{
  "id": "c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f",
  "name": "public",
  "fullyQualifiedName": "postgres_prod.ecommerce.public",
  "displayName": "Public Schema",
  "description": "# Public Schema\n\nMain application schema containing customer, order, and product tables.",
  "schemaType": "Application",
  "retentionPeriod": 2555,
  "database": {
    "id": "b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e",
    "type": "database",
    "name": "ecommerce"
  },
  "service": {
    "id": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d",
    "type": "databaseService",
    "name": "postgres_prod"
  },
  "tables": [
    {
      "id": "d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a",
      "type": "table",
      "name": "customers"
    },
    {
      "id": "e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b",
      "type": "table",
      "name": "orders"
    }
  ],
  "storedProcedures": [
    {
      "id": "f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c",
      "type": "storedProcedure",
      "name": "calculate_order_total"
    }
  ],
  "owner": {
    "id": "e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b",
    "type": "team",
    "name": "ecommerce"
  },
  "domain": {
    "id": "f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c",
    "type": "domain",
    "name": "Sales"
  },
  "tags": [
    {"tagFQN": "Tier.Gold"},
    {"tagFQN": "DataCategory.Transactional"}
  ],
  "version": 1.3,
  "updatedAt": 1704240000000,
  "updatedBy": "jane.doe"
}
```

---

## Custom Properties

This entity supports custom properties through the `extension` field.
Common custom properties include:

- **Data Classification**: Sensitivity level
- **Cost Center**: Billing allocation
- **Retention Period**: Data retention requirements
- **Application Owner**: Owning application/team

See [Custom Properties](../../metadata-specifications/custom-properties.md)
for details on defining and using custom properties.

---

## API Operations

### Create Database Schema

```http
POST /api/v1/databaseSchemas
Content-Type: application/json

{
  "name": "public",
  "database": "postgres_prod.ecommerce",
  "description": "Main application schema"
}
```

### Get Database Schema

```http
GET /api/v1/databaseSchemas/name/postgres_prod.ecommerce.public?fields=tables,storedProcedures,owner,tags
```

### Update Database Schema

```http
PATCH /api/v1/databaseSchemas/{id}
Content-Type: application/json-patch+json

[
  {
    "op": "add",
    "path": "/tags/-",
    "value": {"tagFQN": "DataCategory.Transactional"}
  }
]
```

### List Schemas in Database

```http
GET /api/v1/databaseSchemas?database=postgres_prod.ecommerce
```

---

## Related Documentation

- **[Database Service](database-service.md)** - Parent service entity
- **[Database](database.md)** - Parent database entity
- **[Table](table.md)** - Child table entity
- **[Stored Procedure](stored-procedure.md)** - Child stored procedure entity
- **[Access Control](../../security/access-control.md)** - Schema-level permissions
