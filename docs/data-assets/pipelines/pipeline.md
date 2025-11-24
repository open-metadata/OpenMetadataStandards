
# Pipeline

**Data workflows and DAGs - orchestrating data transformations**

---

## Overview

The **Pipeline** entity represents data workflows, DAGs (Directed Acyclic Graphs), or data pipelines that orchestrate data processing tasks. Pipelines define the sequence and dependencies of tasks that move and transform data across systems.

**Hierarchy**:

```mermaid
graph LR
    SVC[Pipeline Service] --> PIPE[Pipeline]
    PIPE --> TASK[Task]

    style SVC fill:#667eea,color:#fff
    style PIPE fill:#4facfe,color:#fff,stroke:#4c51bf,stroke-width:3px
    style TASK fill:#00f2fe,color:#333
```

---

## Schema Specifications

View the complete Pipeline schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/data/pipeline.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "Pipeline",
      "description": "A `Pipeline` entity represents a workflow or DAG that orchestrates data processing tasks.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.data.Pipeline",

      "definitions": {
        "pipelineStatus": {
          "description": "Pipeline execution status",
          "type": "string",
          "enum": [
            "Successful", "Failed", "Pending", "Running",
            "Stopped", "Skipped", "UpForRetry", "Queued"
          ]
        },
        "scheduleInterval": {
          "description": "Pipeline schedule",
          "type": "object",
          "properties": {
            "scheduleExpression": {
              "description": "Cron or rate expression",
              "type": "string"
            },
            "startDate": {
              "description": "Schedule start date",
              "type": "string",
              "format": "date-time"
            },
            "endDate": {
              "description": "Schedule end date",
              "type": "string",
              "format": "date-time"
            }
          }
        }
      },

      "properties": {
        "id": {
          "description": "Unique identifier",
          "$ref": "../../type/basic.json#/definitions/uuid"
        },
        "name": {
          "description": "Pipeline name",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "Fully qualified name: service.pipeline",
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
        "pipelineUrl": {
          "description": "URL to pipeline in orchestration tool",
          "type": "string",
          "format": "uri"
        },
        "sourceUrl": {
          "description": "URL to pipeline source code",
          "type": "string",
          "format": "uri"
        },
        "tasks": {
          "description": "Pipeline tasks",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "scheduleInterval": {
          "$ref": "#/definitions/scheduleInterval"
        },
        "pipelineStatus": {
          "$ref": "#/definitions/pipelineStatus"
        },
        "startDate": {
          "description": "Pipeline creation/start date",
          "type": "string",
          "format": "date-time"
        },
        "concurrency": {
          "description": "Maximum concurrent runs",
          "type": "integer"
        },
        "pipelineLocation": {
          "description": "Pipeline code location",
          "type": "string"
        },
        "service": {
          "description": "Pipeline service",
          "$ref": "../../type/entityReference.json"
        },
        "owner": {
          "description": "Owner (user or team)",
          "$ref": "../../type/entityReference.json"
        },
        "domain": {
          "description": "Data domain",
          "$ref": "../../type/entityReference.json"
        },
        "tags": {
          "description": "Classification tags",
          "type": "array",
          "items": {
            "$ref": "../../type/tagLabel.json"
          }
        },
        "glossaryTerms": {
          "description": "Business glossary terms",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "version": {
          "description": "Metadata version",
          "$ref": "../../type/entityHistory.json#/definitions/entityVersion"
        }
      },

      "required": ["id", "name", "service"]
    }
    ```

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/pipeline.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2001/XMLSchema#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # Pipeline Class Definition
    om:Pipeline a owl:Class ;
        rdfs:subClassOf om:DataAsset ;
        rdfs:label "Pipeline" ;
        rdfs:comment "A workflow or DAG that orchestrates data processing tasks" ;
        om:hierarchyLevel 2 .

    # Properties
    om:pipelineName a owl:DatatypeProperty ;
        rdfs:domain om:Pipeline ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name of the pipeline" .

    om:fullyQualifiedName a owl:DatatypeProperty ;
        rdfs:domain om:Pipeline ;
        rdfs:range xsd:string ;
        rdfs:label "fullyQualifiedName" ;
        rdfs:comment "Complete hierarchical name: service.pipeline" .

    om:pipelineUrl a owl:DatatypeProperty ;
        rdfs:domain om:Pipeline ;
        rdfs:range xsd:anyURI ;
        rdfs:label "pipelineUrl" ;
        rdfs:comment "URL to pipeline in orchestration tool" .

    om:scheduleInterval a owl:DatatypeProperty ;
        rdfs:domain om:Pipeline ;
        rdfs:range xsd:string ;
        rdfs:label "scheduleInterval" ;
        rdfs:comment "Cron or rate expression for pipeline schedule" .

    om:pipelineStatus a owl:DatatypeProperty ;
        rdfs:domain om:Pipeline ;
        rdfs:range om:PipelineStatus ;
        rdfs:label "pipelineStatus" ;
        rdfs:comment "Current execution status" .

    om:hasTask a owl:ObjectProperty ;
        rdfs:domain om:Pipeline ;
        rdfs:range om:Task ;
        rdfs:label "hasTask" ;
        rdfs:comment "Tasks in this pipeline" .

    om:belongsToPipelineService a owl:ObjectProperty ;
        rdfs:domain om:Pipeline ;
        rdfs:range om:PipelineService ;
        rdfs:label "belongsToService" ;
        rdfs:comment "Service managing this pipeline" .

    om:pipelineOwnedBy a owl:ObjectProperty ;
        rdfs:domain om:Pipeline ;
        rdfs:range om:Owner ;
        rdfs:label "ownedBy" ;
        rdfs:comment "User or team that owns this pipeline" .

    om:pipelineHasTag a owl:ObjectProperty ;
        rdfs:domain om:Pipeline ;
        rdfs:range om:Tag ;
        rdfs:label "hasTag" ;
        rdfs:comment "Classification tags applied to pipeline" .

    om:pipelineLinkedToGlossaryTerm a owl:ObjectProperty ;
        rdfs:domain om:Pipeline ;
        rdfs:range om:GlossaryTerm ;
        rdfs:label "linkedToGlossaryTerm" ;
        rdfs:comment "Business glossary terms" .

    # Pipeline Status Enumeration
    om:PipelineStatus a owl:Class ;
        owl:oneOf (
            om:Successful
            om:Failed
            om:Pending
            om:Running
            om:Stopped
        ) .

    # Example Instance
    ex:customerEtlPipeline a om:Pipeline ;
        om:pipelineName "customer_etl" ;
        om:fullyQualifiedName "airflow_prod.customer_etl" ;
        om:displayName "Customer ETL Pipeline" ;
        om:scheduleInterval "0 2 * * *" ;
        om:pipelineStatus om:Successful ;
        om:belongsToPipelineService ex:airflowProdService ;
        om:pipelineOwnedBy ex:dataEngTeam ;
        om:pipelineHasTag ex:tierGold ;
        om:hasTask ex:extractCustomersTask ;
        om:hasTask ex:transformCustomersTask ;
        om:hasTask ex:loadCustomersTask .
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

        "Pipeline": "om:Pipeline",
        "name": {
          "@id": "om:pipelineName",
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
        "pipelineUrl": {
          "@id": "om:pipelineUrl",
          "@type": "xsd:anyURI"
        },
        "scheduleInterval": {
          "@id": "om:scheduleInterval"
        },
        "pipelineStatus": {
          "@id": "om:pipelineStatus",
          "@type": "@vocab"
        },
        "tasks": {
          "@id": "om:hasTask",
          "@type": "@id",
          "@container": "@list"
        },
        "service": {
          "@id": "om:belongsToPipelineService",
          "@type": "@id"
        },
        "owner": {
          "@id": "om:pipelineOwnedBy",
          "@type": "@id"
        },
        "domain": {
          "@id": "om:inDomain",
          "@type": "@id"
        },
        "tags": {
          "@id": "om:pipelineHasTag",
          "@type": "@id",
          "@container": "@set"
        },
        "glossaryTerms": {
          "@id": "om:pipelineLinkedToGlossaryTerm",
          "@type": "@id",
          "@container": "@set"
        }
      }
    }
    ```

    **Example JSON-LD Instance**:

    ```json
    {
      "@context": "https://open-metadata.org/context/pipeline.jsonld",
      "@type": "Pipeline",
      "@id": "https://example.com/pipelines/customer_etl",

      "name": "customer_etl",
      "fullyQualifiedName": "airflow_prod.customer_etl",
      "displayName": "Customer ETL Pipeline",
      "description": "Daily ETL pipeline for customer data",
      "pipelineUrl": "https://airflow.company.com/dags/customer_etl",
      "sourceUrl": "https://github.com/company/pipelines/blob/main/dags/customer_etl.py",

      "scheduleInterval": {
        "scheduleExpression": "0 2 * * *",
        "startDate": "2024-01-01T00:00:00Z"
      },

      "pipelineStatus": "Successful",
      "concurrency": 1,

      "service": {
        "@id": "https://example.com/services/airflow_prod",
        "@type": "PipelineService",
        "name": "airflow_prod"
      },

      "owner": {
        "@id": "https://example.com/teams/data-engineering",
        "@type": "Team",
        "name": "data-engineering",
        "displayName": "Data Engineering"
      },

      "tags": [
        {
          "@id": "https://open-metadata.org/tags/Tier/Gold",
          "tagFQN": "Tier.Gold"
        },
        {
          "@id": "https://open-metadata.org/tags/Schedule/Daily",
          "tagFQN": "Schedule.Daily"
        }
      ],

      "glossaryTerms": [
        {
          "@id": "https://example.com/glossary/ETL",
          "@type": "GlossaryTerm",
          "fullyQualifiedName": "BusinessGlossary.ETL"
        }
      ],

      "tasks": [
        {
          "@type": "Task",
          "@id": "https://example.com/pipelines/customer_etl/tasks/extract_customers",
          "name": "extract_customers"
        },
        {
          "@type": "Task",
          "@id": "https://example.com/pipelines/customer_etl/tasks/transform_customers",
          "name": "transform_customers"
        },
        {
          "@type": "Task",
          "@id": "https://example.com/pipelines/customer_etl/tasks/load_customers",
          "name": "load_customers"
        }
      ]
    }
    ```

    **[View Full JSON-LD Context →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/contexts/pipeline.jsonld)**

---

## Use Cases

- Document ETL/ELT workflows and data pipelines
- Track pipeline schedules and execution history
- Monitor pipeline success rates and failures
- Capture data lineage through pipelines
- Define pipeline ownership and responsibilities
- Apply governance tags to critical pipelines
- Link pipelines to business processes
- Audit data transformation logic

---

## JSON Schema Specification

### Core Properties

#### `id` (uuid)
**Type**: `string` (UUID format)
**Required**: Yes (system-generated)
**Description**: Unique identifier for this pipeline instance

```json
{
  "id": "2a3b4c5d-6e7f-8a9b-0c1d-2e3f4a5b6c7d"
}
```

---

#### `name` (entityName)
**Type**: `string`
**Required**: Yes
**Pattern**: `^[^.]*$` (no dots allowed)
**Min Length**: 1
**Max Length**: 256
**Description**: Name of the pipeline (unqualified)

```json
{
  "name": "customer_etl"
}
```

---

#### `fullyQualifiedName` (fullyQualifiedEntityName)
**Type**: `string`
**Required**: Yes (system-generated)
**Pattern**: `^((?!::).)*$`
**Description**: Fully qualified name in the format `service.pipeline`

```json
{
  "fullyQualifiedName": "airflow_prod.customer_etl"
}
```

---

#### `displayName`
**Type**: `string`
**Required**: No
**Description**: Human-readable display name

```json
{
  "displayName": "Customer ETL Pipeline"
}
```

---

#### `description` (markdown)
**Type**: `string` (Markdown format)
**Required**: No
**Description**: Rich text description of the pipeline's purpose and logic

```json
{
  "description": "# Customer ETL Pipeline\n\nDaily pipeline that extracts customer data from MongoDB, transforms it, and loads into PostgreSQL.\n\n## Schedule\n- Runs daily at 2 AM UTC\n- Average duration: 45 minutes\n\n## Data Flow\n1. Extract from MongoDB `customers` collection\n2. Deduplicate and validate\n3. Enrich with geographic data\n4. Load to PostgreSQL `public.customers` table"
}
```

---

### Pipeline Configuration Properties

#### `pipelineUrl` (URI)
**Type**: `string` (URI format)
**Required**: No
**Description**: URL to view pipeline in orchestration tool

```json
{
  "pipelineUrl": "https://airflow.company.com/dags/customer_etl"
}
```

---

#### `sourceUrl` (URI)
**Type**: `string` (URI format)
**Required**: No
**Description**: URL to pipeline source code repository

```json
{
  "sourceUrl": "https://github.com/company/pipelines/blob/main/dags/customer_etl.py"
}
```

---

#### `scheduleInterval` (ScheduleInterval)
**Type**: `object`
**Required**: No
**Description**: Pipeline execution schedule

**ScheduleInterval Object Properties**:

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `scheduleExpression` | string | No | Cron expression or rate |
| `startDate` | string (ISO 8601) | No | Schedule start date |
| `endDate` | string (ISO 8601) | No | Schedule end date |

**Example - Cron Schedule**:

```json
{
  "scheduleInterval": {
    "scheduleExpression": "0 2 * * *",
    "startDate": "2024-01-01T00:00:00Z"
  }
}
```

**Example - Rate Expression**:

```json
{
  "scheduleInterval": {
    "scheduleExpression": "@hourly",
    "startDate": "2024-01-01T00:00:00Z",
    "endDate": "2024-12-31T23:59:59Z"
  }
}
```

---

#### `pipelineStatus` (PipelineStatus enum)
**Type**: `string` enum
**Required**: No (system-populated from latest run)
**Allowed Values**:

- `Successful` - Last run completed successfully
- `Failed` - Last run failed
- `Pending` - Waiting to start
- `Running` - Currently executing
- `Stopped` - Manually stopped
- `Skipped` - Skipped execution
- `UpForRetry` - Failed, waiting for retry
- `Queued` - In execution queue

```json
{
  "pipelineStatus": "Successful"
}
```

---

#### `concurrency` (integer)
**Type**: `integer`
**Required**: No
**Description**: Maximum number of concurrent pipeline runs

```json
{
  "concurrency": 1
}
```

---

#### `pipelineLocation` (string)
**Type**: `string`
**Required**: No
**Description**: File path or location of pipeline definition

```json
{
  "pipelineLocation": "/opt/airflow/dags/customer_etl.py"
}
```

---

#### `startDate` (timestamp)
**Type**: `string` (ISO 8601 date-time)
**Required**: No
**Description**: Pipeline creation or first run date

```json
{
  "startDate": "2024-01-01T00:00:00Z"
}
```

---

### Structure Properties

#### `tasks[]` (Task[])
**Type**: `array` of EntityReference
**Required**: No
**Description**: List of tasks in the pipeline

```json
{
  "tasks": [
    {
      "id": "3b4c5d6e-7f8a-9b0c-1d2e-3f4a5b6c7d8e",
      "type": "task",
      "name": "extract_customers",
      "fullyQualifiedName": "airflow_prod.customer_etl.extract_customers"
    },
    {
      "id": "4c5d6e7f-8a9b-0c1d-2e3f-4a5b6c7d8e9f",
      "type": "task",
      "name": "transform_customers",
      "fullyQualifiedName": "airflow_prod.customer_etl.transform_customers"
    },
    {
      "id": "5d6e7f8a-9b0c-1d2e-3f4a-5b6c7d8e9f0a",
      "type": "task",
      "name": "load_customers",
      "fullyQualifiedName": "airflow_prod.customer_etl.load_customers"
    }
  ]
}
```

---

### Location Properties

#### `service` (EntityReference)
**Type**: `object`
**Required**: Yes
**Description**: Reference to parent pipeline service

```json
{
  "service": {
    "id": "1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d",
    "type": "pipelineService",
    "name": "airflow_prod",
    "fullyQualifiedName": "airflow_prod"
  }
}
```

---

### Governance Properties

#### `owner` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: User or team that owns this pipeline

```json
{
  "owner": {
    "id": "6e7f8a9b-0c1d-2e3f-4a5b-6c7d8e9f0a1b",
    "type": "team",
    "name": "data-engineering",
    "displayName": "Data Engineering Team"
  }
}
```

---

#### `domain` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: Data domain this pipeline belongs to

```json
{
  "domain": {
    "id": "7f8a9b0c-1d2e-3f4a-5b6c-7d8e9f0a1b2c",
    "type": "domain",
    "name": "CustomerData",
    "fullyQualifiedName": "CustomerData"
  }
}
```

---

#### `tags[]` (TagLabel[])
**Type**: `array`
**Required**: No
**Description**: Classification tags applied to the pipeline

```json
{
  "tags": [
    {
      "tagFQN": "Tier.Gold",
      "description": "Critical production pipeline",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    },
    {
      "tagFQN": "Schedule.Daily",
      "source": "Classification",
      "labelType": "Automated",
      "state": "Confirmed"
    }
  ]
}
```

---

#### `glossaryTerms[]` (GlossaryTerm[])
**Type**: `array`
**Required**: No
**Description**: Business glossary terms linked to this pipeline

```json
{
  "glossaryTerms": [
    {
      "fullyQualifiedName": "BusinessGlossary.ETL"
    },
    {
      "fullyQualifiedName": "BusinessGlossary.CustomerData"
    }
  ]
}
```

---

### Lineage Properties

#### `upstream` (EntityLineage)
**Type**: `array`
**Required**: No (system-populated)
**Description**: Upstream data assets (tables, files, etc.)

```json
{
  "upstream": [
    {
      "id": "source-table-uuid",
      "type": "table",
      "name": "customers",
      "fullyQualifiedName": "mongodb_prod.crm.customers"
    }
  ]
}
```

---

#### `downstream` (EntityLineage)
**Type**: `array`
**Required**: No (system-populated)
**Description**: Downstream data assets

```json
{
  "downstream": [
    {
      "id": "target-table-uuid",
      "type": "table",
      "name": "customers",
      "fullyQualifiedName": "postgres_prod.ecommerce.public.customers"
    }
  ]
}
```

---

### Versioning Properties

#### `version` (entityVersion)
**Type**: `number`
**Required**: Yes (system-managed)
**Description**: Metadata version number, incremented on changes

```json
{
  "version": 3.1
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
  "updatedBy": "john.doe"
}
```

---

#### `changeDescription` (ChangeDescription)
**Type**: `object`
**Required**: No
**Description**: Details of what changed in this version

```json
{
  "changeDescription": {
    "fieldsAdded": [
      {
        "name": "tasks.data_quality_check",
        "newValue": "Task for validating data quality"
      }
    ],
    "fieldsUpdated": [
      {
        "name": "scheduleInterval.scheduleExpression",
        "oldValue": "0 1 * * *",
        "newValue": "0 2 * * *"
      }
    ],
    "fieldsDeleted": [],
    "previousVersion": 3.0
  }
}
```

---

## Complete Example

```json
{
  "id": "2a3b4c5d-6e7f-8a9b-0c1d-2e3f4a5b6c7d",
  "name": "customer_etl",
  "fullyQualifiedName": "airflow_prod.customer_etl",
  "displayName": "Customer ETL Pipeline",
  "description": "# Customer ETL Pipeline\n\nDaily pipeline that extracts customer data from MongoDB, transforms it, and loads into PostgreSQL.",
  "pipelineUrl": "https://airflow.company.com/dags/customer_etl",
  "sourceUrl": "https://github.com/company/pipelines/blob/main/dags/customer_etl.py",
  "scheduleInterval": {
    "scheduleExpression": "0 2 * * *",
    "startDate": "2024-01-01T00:00:00Z"
  },
  "pipelineStatus": "Successful",
  "concurrency": 1,
  "startDate": "2024-01-01T00:00:00Z",
  "tasks": [
    {
      "id": "3b4c5d6e-7f8a-9b0c-1d2e-3f4a5b6c7d8e",
      "type": "task",
      "name": "extract_customers"
    },
    {
      "id": "4c5d6e7f-8a9b-0c1d-2e3f-4a5b6c7d8e9f",
      "type": "task",
      "name": "transform_customers"
    },
    {
      "id": "5d6e7f8a-9b0c-1d2e-3f4a-5b6c7d8e9f0a",
      "type": "task",
      "name": "load_customers"
    }
  ],
  "service": {
    "id": "1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d",
    "type": "pipelineService",
    "name": "airflow_prod"
  },
  "owner": {
    "id": "6e7f8a9b-0c1d-2e3f-4a5b-6c7d8e9f0a1b",
    "type": "team",
    "name": "data-engineering"
  },
  "domain": {
    "id": "7f8a9b0c-1d2e-3f4a-5b6c-7d8e9f0a1b2c",
    "type": "domain",
    "name": "CustomerData"
  },
  "tags": [
    {"tagFQN": "Tier.Gold"},
    {"tagFQN": "Schedule.Daily"}
  ],
  "glossaryTerms": [
    {"fullyQualifiedName": "BusinessGlossary.ETL"}
  ],
  "version": 3.1,
  "updatedAt": 1704240000000,
  "updatedBy": "john.doe"
}
```

---

## RDF Representation

### Ontology Class

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl: <http://www.w3.org/2001/XMLSchema#> .

om:Pipeline a owl:Class ;
    rdfs:subClassOf om:DataAsset ;
    rdfs:label "Pipeline" ;
    rdfs:comment "A workflow or DAG that orchestrates data processing" ;
    om:hasProperties [
        om:name "string" ;
        om:tasks "Task[]" ;
        om:scheduleInterval "string" ;
        om:service "PipelineService" ;
        om:owner "Owner" ;
        om:tags "Tag[]" ;
    ] .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://example.com/pipelines/> .

ex:customer_etl a om:Pipeline ;
    om:pipelineName "customer_etl" ;
    om:fullyQualifiedName "airflow_prod.customer_etl" ;
    om:displayName "Customer ETL Pipeline" ;
    om:description "Daily pipeline that extracts customer data" ;
    om:pipelineUrl "https://airflow.company.com/dags/customer_etl"^^xsd:anyURI ;
    om:scheduleInterval "0 2 * * *" ;
    om:pipelineStatus "Successful" ;
    om:belongsToPipelineService ex:airflow_prod ;
    om:pipelineOwnedBy ex:data_engineering_team ;
    om:pipelineHasTag ex:tier_gold ;
    om:hasTask ex:extract_customers ;
    om:hasTask ex:transform_customers ;
    om:hasTask ex:load_customers .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "om": "https://open-metadata.org/schema/",
    "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
    "Pipeline": "om:Pipeline",
    "name": "om:pipelineName",
    "fullyQualifiedName": "om:fullyQualifiedName",
    "displayName": "om:displayName",
    "description": "om:description",
    "pipelineUrl": "om:pipelineUrl",
    "scheduleInterval": "om:scheduleInterval",
    "tasks": {
      "@id": "om:hasTask",
      "@type": "@id",
      "@container": "@list"
    },
    "service": {
      "@id": "om:belongsToPipelineService",
      "@type": "@id"
    },
    "owner": {
      "@id": "om:pipelineOwnedBy",
      "@type": "@id"
    },
    "tags": {
      "@id": "om:pipelineHasTag",
      "@type": "@id",
      "@container": "@set"
    }
  }
}
```

### JSON-LD Example

```json
{
  "@context": "https://open-metadata.org/context/pipeline.jsonld",
  "@type": "Pipeline",
  "@id": "https://example.com/pipelines/customer_etl",
  "name": "customer_etl",
  "fullyQualifiedName": "airflow_prod.customer_etl",
  "displayName": "Customer ETL Pipeline",
  "pipelineUrl": "https://airflow.company.com/dags/customer_etl",
  "scheduleInterval": {
    "scheduleExpression": "0 2 * * *"
  },
  "service": {
    "@id": "https://example.com/services/airflow_prod",
    "@type": "PipelineService"
  },
  "owner": {
    "@id": "https://example.com/teams/data-engineering",
    "@type": "Team"
  },
  "tags": [
    {"@id": "https://open-metadata.org/tags/Tier/Gold"}
  ]
}
```

---

## Relationships

Pipeline has comprehensive relationships with entities across the metadata platform:

```mermaid
graph TD
    subgraph Hierarchy
        SVC[PipelineService<br/>airflow_prod]
        SVC --> PIPE[Pipeline<br/>customer_etl]
    end

    subgraph Tasks
        PIPE --> TASK1[Task<br/>extract_customers]
        PIPE --> TASK2[Task<br/>transform_customers]
        PIPE --> TASK3[Task<br/>load_customers]
        PIPE --> TASK4[Task<br/>data_quality_check]
        TASK1 --> TASK2
        TASK2 --> TASK3
        TASK3 --> TASK4
    end

    subgraph Source Tables
        SRC1[Table<br/>mongodb.crm.customers] -.->|extracted by| PIPE
        SRC2[Table<br/>postgres.raw.customer_data] -.->|read by| PIPE
    end

    subgraph Target Tables
        PIPE -.->|loads to| TGT1[Table<br/>warehouse.customers]
        PIPE -.->|creates| TGT2[Table<br/>warehouse.customer_summary]
        PIPE -.->|updates| TGT3[Table<br/>warehouse.customer_metrics]
    end

    subgraph Downstream
        TGT1 -.->|feeds| DASH[Dashboard<br/>Customer Analytics]
        TGT1 -.->|trains| ML[MLModel<br/>churn_predictor]
        TGT2 -.->|consumed by| API[ApiEndpoint<br/>customer_stats]
    end

    subgraph Ownership
        PIPE -.->|owned by| TEAM[Team<br/>Data Engineering]
        PIPE -.->|owned by| USER[User<br/>etl.admin]
    end

    subgraph Governance
        PIPE -.->|in domain| DOM[Domain<br/>Customer Data]
        PIPE -.->|tagged| TAG1[Tag<br/>Tier.Gold]
        PIPE -.->|tagged| TAG2[Tag<br/>Schedule.Daily]
        PIPE -.->|tagged| TAG3[Tag<br/>Production]
        PIPE -.->|linked to| GT[GlossaryTerm<br/>ETL Process]
    end

    subgraph Quality
        TC1[TestCase<br/>execution_success] -.->|validates| PIPE
        TC2[TestCase<br/>data_freshness] -.->|monitors| TGT1
        TC3[TestCase<br/>row_count_check] -.->|validates| TGT1
        TC4[TestCase<br/>schema_validation] -.->|checks| TGT2
    end

    subgraph Monitoring
        MON[Dashboard<br/>Pipeline Monitor] -.->|tracks| PIPE
        ALERT[Alert<br/>failure_notification] -.->|watches| PIPE
        LOG[Logs<br/>execution_history] -.->|records| PIPE
    end

    subgraph Configuration
        REPO[Repository<br/>github.com/pipelines] -.->|source code| PIPE
        SCHED[Schedule<br/>Daily at 2 AM UTC] -.->|triggers| PIPE
        CONFIG[Config<br/>pipeline_config.yaml] -.->|configures| PIPE
    end

    style SVC fill:#667eea,color:#fff
    style PIPE fill:#4facfe,color:#fff,stroke:#4c51bf,stroke-width:3px
    style TASK1 fill:#00f2fe,color:#333
    style TASK2 fill:#00f2fe,color:#333
    style TASK3 fill:#00f2fe,color:#333
    style TASK4 fill:#00f2fe,color:#333
    style SRC1 fill:#764ba2,color:#fff
    style SRC2 fill:#764ba2,color:#fff
    style TGT1 fill:#764ba2,color:#fff
    style TGT2 fill:#764ba2,color:#fff
    style TGT3 fill:#764ba2,color:#fff
    style DASH fill:#ff6b6b,color:#fff
    style ML fill:#ff6b6b,color:#fff
    style API fill:#ff6b6b,color:#fff
    style TEAM fill:#43e97b,color:#fff
    style USER fill:#43e97b,color:#fff
    style DOM fill:#fa709a,color:#fff
    style TAG1 fill:#f093fb,color:#fff
    style TAG2 fill:#f093fb,color:#fff
    style TAG3 fill:#f093fb,color:#fff
    style GT fill:#ffd700,color:#333
    style TC1 fill:#9b59b6,color:#fff
    style TC2 fill:#9b59b6,color:#fff
    style TC3 fill:#9b59b6,color:#fff
    style TC4 fill:#9b59b6,color:#fff
    style MON fill:#00ac69,color:#fff
    style ALERT fill:#00ac69,color:#fff
    style LOG fill:#00ac69,color:#fff
    style REPO fill:#f5576c,color:#fff
    style SCHED fill:#f5576c,color:#fff
    style CONFIG fill:#f5576c,color:#fff
```

**Relationship Types**:

- **Solid lines (→)**: Hierarchical containment (Service contains Pipeline, Pipeline contains Tasks)
- **Dashed lines (-.->)**: References and associations (ownership, governance, lineage)

### Parent Entities
- **PipelineService**: The service managing this pipeline

### Child Entities
- **Task**: Individual tasks/steps within the pipeline

### Associated Entities
- **Owner**: User or team owning this pipeline
- **Domain**: Business domain assignment
- **Tag**: Classification tags
- **GlossaryTerm**: Business terminology
- **Table**: Source tables (upstream) and target tables (downstream)
- **Dashboard**: Dashboards consuming pipeline outputs or monitoring pipeline health
- **MLModel**: ML models trained on pipeline outputs
- **ApiEndpoint**: APIs serving pipeline outputs
- **TestCase**: Pipeline execution, data quality, and schema validation tests
- **Alert**: Failure notifications and monitoring alerts

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

## Followers

Users can follow pipelines to receive notifications about configuration changes, task modifications, and schedule updates. See **[Followers](../../metadata-specifications/followers.md)** for details.

---

## API Operations

All Pipeline operations are available under the `/v1/pipelines` endpoint.

### List Pipelines

Get a list of pipelines, optionally filtered by service.

```http
GET /v1/pipelines
Query Parameters:
  - fields: Fields to include (tasks, tags, owner, lineage, pipelineStatus, etc.)
  - service: Filter by pipeline service name
  - limit: Number of results (1-1000000, default 10)
  - before/after: Cursor-based pagination
  - include: all | deleted | non-deleted (default: non-deleted)

Response: PipelineList
```

### Create Pipeline

Create a new pipeline under a pipeline service.

```http
POST /v1/pipelines
Content-Type: application/json

{
  "name": "customer_etl",
  "service": "airflow_prod",
  "description": "Customer data ETL pipeline",
  "scheduleInterval": {
    "scheduleExpression": "0 2 * * *",
    "scheduleType": "CRON"
  },
  "tasks": [
    {
      "name": "extract_customers",
      "taskType": "PythonOperator",
      "description": "Extract customer data from source"
    },
    {
      "name": "transform_data",
      "taskType": "SparkSubmitOperator",
      "downstreamTasks": ["extract_customers"]
    },
    {
      "name": "load_to_warehouse",
      "taskType": "PostgresOperator",
      "downstreamTasks": ["transform_data"]
    }
  ]
}

Response: Pipeline
```

### Get Pipeline by Name

Get a pipeline by its fully qualified name.

```http
GET /v1/pipelines/name/{fqn}
Query Parameters:
  - fields: Fields to include (tasks, tags, owner, lineage, etc.)
  - include: all | deleted | non-deleted

Example:
GET /v1/pipelines/name/airflow_prod.customer_etl?fields=tasks,tags,owner,lineage,pipelineStatus

Response: Pipeline
```

### Get Pipeline by ID

Get a pipeline by its unique identifier.

```http
GET /v1/pipelines/{id}
Query Parameters:
  - fields: Fields to include
  - include: all | deleted | non-deleted

Response: Pipeline
```

### Update Pipeline

Update a pipeline using JSON Patch.

```http
PATCH /v1/pipelines/name/{fqn}
Content-Type: application/json-patch+json

[
  {"op": "replace", "path": "/scheduleInterval/scheduleExpression", "value": "0 3 * * *"},
  {"op": "add", "path": "/tags/-", "value": {"tagFQN": "Critical"}},
  {"op": "replace", "path": "/description", "value": "Updated ETL pipeline"}
]

Response: Pipeline
```

### Create or Update Pipeline

Create a new pipeline or update if it exists.

```http
PUT /v1/pipelines
Content-Type: application/json

{
  "name": "orders_pipeline",
  "service": "airflow_prod",
  "scheduleInterval": {...},
  "tasks": [...]
}

Response: Pipeline
```

### Delete Pipeline

Delete a pipeline by fully qualified name.

```http
DELETE /v1/pipelines/name/{fqn}
Query Parameters:
  - hardDelete: Permanently delete (default: false)

Response: 200 OK
```

### Update Pipeline Tasks

Update tasks in a pipeline.

```http
PUT /v1/pipelines/{id}/tasks
Content-Type: application/json

{
  "tasks": [
    {
      "name": "data_quality_check",
      "taskType": "PythonOperator",
      "description": "Run data quality tests"
    }
  ]
}

Response: Pipeline
```

### Get Pipeline Status

Get the execution status of a pipeline.

```http
GET /v1/pipelines/{id}/pipelineStatus

Response: PipelineStatus (latest runs, success/failure, execution time)
```

### Update Pipeline Status

Update the status of a pipeline execution.

```http
PUT /v1/pipelines/{id}/pipelineStatus
Content-Type: application/json

{
  "executionStatus": "Successful",
  "timestamp": 1700000000,
  "executionDate": "2024-01-15"
}

Response: PipelineStatus
```

### Get Pipeline Versions

Get all versions of a pipeline.

```http
GET /v1/pipelines/{id}/versions

Response: EntityHistory
```

### Follow Pipeline

Add a follower to a pipeline.

```http
PUT /v1/pipelines/{id}/followers/{userId}

Response: ChangeEvent
```

### Get Followers

Get all followers of a pipeline.

```http
GET /v1/pipelines/{id}/followers

Response: EntityReference[]
```

### Bulk Operations

Create or update multiple pipelines.

```http
PUT /v1/pipelines/bulk
Content-Type: application/json

{
  "entities": [...]
}

Response: BulkOperationResult
```

---

## Related Documentation

- **[Pipeline Service](pipeline-service.md)** - Service configuration
- **[Task](task.md)** - Task specification
- **[Lineage](../../lineage/overview.md)** - Pipeline lineage tracking
- **[Data Quality](../../data-quality/overview.md)** - Testing pipeline outputs
