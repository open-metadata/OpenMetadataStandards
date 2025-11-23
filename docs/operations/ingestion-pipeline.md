
# Ingestion Pipeline

An **Ingestion Pipeline** in OpenMetadadata defines automated workflows for extracting, transforming, and loading metadata from various data sources into the OpenMetadata platform. Ingestion Pipelines enable continuous metadata synchronization and discovery.

## Overview

Ingestion Pipelines in OpenMetadata provide:

- **Automated Metadata Discovery**: Automatically discover tables, schemas, columns, and relationships
- **Scheduled Execution**: Run on schedules (hourly, daily, weekly) or triggered manually
- **Incremental Updates**: Detect and sync only changed metadata
- **Profiling & Sampling**: Collect data profiles and sample data
- **Usage Analytics**: Extract query logs and usage statistics
- **Lineage Extraction**: Discover data lineage from SQL queries and ETL pipelines
- **Quality Testing**: Execute data quality tests during ingestion

Ingestion types include:
- **Metadata Ingestion**: Extract schema, tables, columns, relationships
- **Usage Ingestion**: Extract query logs and access patterns
- **Lineage Ingestion**: Extract data lineage information
- **Profiler Ingestion**: Collect data profiles and statistics
- **Test Suite Ingestion**: Execute data quality tests
- **DBT Ingestion**: Ingest dbt models and lineage

## Hierarchy

```mermaid
graph LR
    A[Service] --> B[IngestionPipeline]
    B --> C1[Connector Config]
    B --> C2[Pipeline Config]
    B --> C3[Execution Runs]

    style A fill:#667eea,color:#fff
    style B fill:#4facfe,color:#fff,stroke:#4c51bf,stroke-width:3px
    style C1 fill:#00f2fe,color:#333
    style C2 fill:#00f2fe,color:#333
    style C3 fill:#00f2fe,color:#333

    click A "#service" "Service"
    click B "#ingestion-pipeline" "Ingestion Pipeline"
    click C1 "#connector-config" "Connector Config"
```

**Click on any node to learn more about that entity.**

## Relationships

Ingestion Pipelines have relationships with various entities in the metadata ecosystem:

```mermaid
graph TD
    subgraph Pipeline Configuration
        A[IngestionPipeline:<br/>Snowflake Metadata] --> B1[Connector:<br/>Snowflake]
        A --> B2[Schedule:<br/>Daily 2 AM]
        A --> B3[Run:<br/>2024-01-15 02:00]
        A --> B4[Run:<br/>2024-01-14 02:00]
    end

    subgraph Source
        A -.->|extracts from| C1[DatabaseService:<br/>Snowflake Production]
        C1 -.->|connects to| C2[Snowflake Instance]
    end

    subgraph Target Assets
        A -.->|creates/updates| D1[Database:<br/>sales_db]
        A -.->|creates/updates| D2[Table:<br/>customers]
        A -.->|creates/updates| D3[Table:<br/>orders]
        D1 --> D2
        D1 --> D3
    end

    subgraph Metadata Collected
        A -.->|extracts| E1[Schema Metadata]
        A -.->|extracts| E2[Column Metadata]
        A -.->|extracts| E3[Relationships]
        A -.->|extracts| E4[Tags & Descriptions]
    end

    subgraph Governance
        A -.->|owned by| F1[User:<br/>data.engineer]
        A -.->|managed by| F2[Team:<br/>Data Engineering]
        A -.->|in domain| F3[Domain:<br/>Operations]
    end

    subgraph Monitoring
        A -.->|triggers| G1[Alert:<br/>Ingestion Failure]
        A -.->|logs to| G2[AuditLog]
        A -.->|metrics in| G3[Dashboard:<br/>Ingestion Metrics]
    end

    style A fill:#4facfe,color:#fff,stroke:#4c51bf,stroke-width:3px
    style B1 fill:#00f2fe,color:#333
    style B2 fill:#00f2fe,color:#333
    style B3 fill:#ffd700,color:#333
    style B4 fill:#ffd700,color:#333
    style C1 fill:#667eea,color:#fff
    style C2 fill:#764ba2,color:#fff
    style D1 fill:#764ba2,color:#fff
    style D2 fill:#764ba2,color:#fff
    style D3 fill:#764ba2,color:#fff
    style E1 fill:#00f2fe,color:#333
    style E2 fill:#00f2fe,color:#333
    style E3 fill:#00f2fe,color:#333
    style E4 fill:#00f2fe,color:#333
    style F1 fill:#43e97b,color:#333
    style F2 fill:#43e97b,color:#333
    style F3 fill:#f093fb,color:#333
    style G1 fill:#f5576c,color:#fff
    style G2 fill:#ffd700,color:#333
    style G3 fill:#764ba2,color:#fff

    click A "#ingestion-pipeline" "Ingestion Pipeline"
    click C1 "../../data-assets/databases/database-service/" "Database Service"
    click D1 "../../data-assets/databases/database/" "Database"
    click D2 "../../data-assets/databases/table/" "Table"
    click F1 "../../teams-users/user/" "User"
    click F2 "../../teams-users/team/" "Team"
    click F3 "../../domains/domain/" "Domain"
    click G1 "../../data-quality/alert/" "Alert"
    click G3 "../../data-assets/dashboards/dashboard/" "Dashboard"
```

**Key Relationships:**

- **Pipeline Configuration**: Includes connector, schedule, and execution history
- **Source**: Database Service or other service from which metadata is extracted
- **Target Assets**: Databases, tables, and other entities created/updated by ingestion
- **Metadata Collected**: Schema, columns, relationships, tags extracted during ingestion
- **Governance**: Owned and managed by users/teams, organized by domain
- **Monitoring**: Triggers alerts, creates audit logs, feeds monitoring dashboards

## Schema Specifications

=== "JSON Schema"

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/services/ingestionPipelines/ingestionPipeline.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "IngestionPipeline",
      "description": "An Ingestion Pipeline defines automated workflows for metadata ingestion.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.services.ingestionPipelines.IngestionPipeline",
      "javaInterfaces": [
        "org.openmetadata.schema.EntityInterface"
      ],
      "definitions": {
        "pipelineType": {
          "description": "Type of pipeline",
          "type": "string",
          "enum": [
            "metadata",
            "usage",
            "lineage",
            "profiler",
            "TestSuite",
            "dataInsight",
            "elasticSearchReindex",
            "dbt",
            "application"
          ],
          "javaEnums": [
            {
              "name": "metadata"
            },
            {
              "name": "usage"
            },
            {
              "name": "lineage"
            },
            {
              "name": "profiler"
            },
            {
              "name": "TestSuite"
            },
            {
              "name": "dataInsight"
            },
            {
              "name": "elasticSearchReindex"
            },
            {
              "name": "dbt"
            },
            {
              "name": "application"
            }
          ]
        },
        "pipelineStatus": {
          "type": "object",
          "description": "Status of a pipeline run",
          "properties": {
            "runId": {
              "description": "Unique identifier for the run",
              "type": "string"
            },
            "pipelineState": {
              "description": "State of the pipeline",
              "type": "string",
              "enum": [
                "queued",
                "running",
                "success",
                "failed",
                "partialSuccess"
              ]
            },
            "startDate": {
              "description": "Start time of the run",
              "$ref": "../../../../type/basic.json#/definitions/timestamp"
            },
            "endDate": {
              "description": "End time of the run",
              "$ref": "../../../../type/basic.json#/definitions/timestamp"
            },
            "timestamp": {
              "description": "Timestamp of the status",
              "$ref": "../../../../type/basic.json#/definitions/timestamp"
            }
          },
          "required": [
            "timestamp"
          ]
        },
        "airflowConfig": {
          "type": "object",
          "description": "Airflow-specific configuration",
          "properties": {
            "pausePipeline": {
              "description": "Pause the pipeline from running once the deploy is finished successfully",
              "type": "boolean",
              "default": false
            },
            "concurrency": {
              "description": "Concurrency of the Pipeline",
              "type": "integer",
              "default": 1
            },
            "pipelineTimezone": {
              "description": "Timezone in which pipeline going to be scheduled",
              "type": "string",
              "default": "UTC"
            },
            "retries": {
              "description": "Retry pipeline in case of failure",
              "type": "integer",
              "default": 3
            },
            "retryDelay": {
              "description": "Delay between retries in seconds",
              "type": "integer",
              "default": 300
            },
            "pipelineCatchup": {
              "description": "Run past executions if the start date is in the past",
              "type": "boolean",
              "default": false
            },
            "scheduleInterval": {
              "description": "Cron expression for schedule",
              "type": "string"
            },
            "maxActiveRuns": {
              "description": "Maximum number of active pipeline runs",
              "type": "integer",
              "default": 1
            },
            "workflowTimeout": {
              "description": "Timeout for the workflow in seconds",
              "type": "integer",
              "default": null
            },
            "workflowDefaultView": {
              "description": "Default view of the DAG",
              "type": "string",
              "enum": [
                "tree",
                "graph",
                "duration",
                "gantt",
                "landing_times"
              ],
              "default": "tree"
            }
          }
        },
        "sourceConfig": {
          "type": "object",
          "description": "Source configuration for ingestion",
          "properties": {
            "config": {
              "oneOf": [
                {
                  "$ref": "../../../../metadataIngestion/databaseServiceMetadataPipeline.json"
                },
                {
                  "$ref": "../../../../metadataIngestion/databaseServiceProfilerPipeline.json"
                },
                {
                  "$ref": "../../../../metadataIngestion/databaseServiceQueryUsagePipeline.json"
                },
                {
                  "$ref": "../../../../metadataIngestion/databaseServiceQueryLineagePipeline.json"
                }
              ]
            }
          }
        }
      },
      "properties": {
        "id": {
          "description": "Unique identifier of the ingestion pipeline",
          "$ref": "../../../../type/basic.json#/definitions/uuid"
        },
        "name": {
          "description": "Name that identifies this pipeline",
          "$ref": "../../../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "Fully qualified name of the pipeline",
          "$ref": "../../../../type/basic.json#/definitions/fullyQualifiedEntityName"
        },
        "displayName": {
          "description": "Display name for the pipeline",
          "type": "string"
        },
        "description": {
          "description": "Description of the pipeline",
          "$ref": "../../../../type/basic.json#/definitions/markdown"
        },
        "pipelineType": {
          "$ref": "#/definitions/pipelineType"
        },
        "sourceConfig": {
          "$ref": "#/definitions/sourceConfig"
        },
        "airflowConfig": {
          "$ref": "#/definitions/airflowConfig"
        },
        "service": {
          "description": "Link to the service for which this pipeline applies",
          "$ref": "../../../../type/entityReference.json"
        },
        "enabled": {
          "description": "Is the pipeline enabled",
          "type": "boolean",
          "default": true
        },
        "deployed": {
          "description": "Is the pipeline deployed to Airflow",
          "type": "boolean",
          "default": false
        },
        "pipelineStatuses": {
          "description": "Pipeline status for each execution",
          "type": "array",
          "items": {
            "$ref": "#/definitions/pipelineStatus"
          }
        },
        "loggerLevel": {
          "description": "Set the logging level for the workflow",
          "type": "string",
          "enum": [
            "INFO",
            "DEBUG",
            "WARNING",
            "ERROR"
          ],
          "default": "INFO"
        },
        "owner": {
          "description": "Owner of this pipeline",
          "$ref": "../../../../type/entityReference.json"
        },
        "version": {
          "description": "Metadata version of the entity",
          "$ref": "../../../../type/entityHistory.json#/definitions/entityVersion"
        },
        "updatedAt": {
          "description": "Last update time corresponding to the new version of the entity in Unix epoch time milliseconds",
          "$ref": "../../../../type/basic.json#/definitions/timestamp"
        },
        "updatedBy": {
          "description": "User who made the update",
          "type": "string"
        },
        "href": {
          "description": "Link to this ingestion pipeline resource",
          "$ref": "../../../../type/basic.json#/definitions/href"
        },
        "changeDescription": {
          "description": "Change that led to this version of the entity",
          "$ref": "../../../../type/entityHistory.json#/definitions/changeDescription"
        },
        "deleted": {
          "description": "When true indicates the entity has been soft deleted",
          "type": "boolean",
          "default": false
        },
        "domain": {
          "description": "Domain the pipeline belongs to",
          "$ref": "../../../../type/entityReference.json"
        }
      },
      "required": [
        "id",
        "name",
        "pipelineType",
        "service"
      ],
      "additionalProperties": false
    }
    ```

=== "RDF (Turtle)"

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix om-entity: <https://open-metadata.org/schema/entity/> .
    @prefix om-ingestion: <https://open-metadata.org/schema/entity/services/ingestionPipelines/> .
    @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2002/07/owl#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
    @prefix dcterms: <http://purl.org/dc/terms/> .
    @prefix skos: <http://www.w3.org/2004/02/skos/core#> .
    @prefix prov: <http://www.w3.org/ns/prov#> .

    # Ingestion Pipeline Class Definition
    om-ingestion:IngestionPipeline a owl:Class ;
        rdfs:label "Ingestion Pipeline" ;
        rdfs:comment "Automated workflow for extracting and loading metadata from data sources" ;
        rdfs:subClassOf om-entity:Entity ;
        rdfs:isDefinedBy om: .

    # Pipeline Type Class
    om-ingestion:PipelineType a owl:Class ;
        rdfs:label "Pipeline Type" ;
        rdfs:comment "Type of ingestion pipeline" ;
        rdfs:isDefinedBy om: .

    # Pipeline Status Class
    om-ingestion:PipelineStatus a owl:Class ;
        rdfs:label "Pipeline Status" ;
        rdfs:comment "Status of a pipeline execution run" ;
        rdfs:isDefinedBy om: .

    # Pipeline State Class
    om-ingestion:PipelineState a owl:Class ;
        rdfs:label "Pipeline State" ;
        rdfs:comment "State of pipeline execution" ;
        rdfs:isDefinedBy om: .

    # Properties
    om-ingestion:pipelineType a owl:ObjectProperty ;
        rdfs:label "pipeline type" ;
        rdfs:comment "Type of the ingestion pipeline" ;
        rdfs:domain om-ingestion:IngestionPipeline ;
        rdfs:range om-ingestion:PipelineType .

    om-ingestion:service a owl:ObjectProperty ;
        rdfs:label "service" ;
        rdfs:comment "Service from which metadata is ingested" ;
        rdfs:domain om-ingestion:IngestionPipeline ;
        rdfs:range om-entity:Service .

    om-ingestion:enabled a owl:DatatypeProperty ;
        rdfs:label "enabled" ;
        rdfs:comment "Indicates if the pipeline is enabled" ;
        rdfs:domain om-ingestion:IngestionPipeline ;
        rdfs:range xsd:boolean .

    om-ingestion:deployed a owl:DatatypeProperty ;
        rdfs:label "deployed" ;
        rdfs:comment "Indicates if the pipeline is deployed to orchestration" ;
        rdfs:domain om-ingestion:IngestionPipeline ;
        rdfs:range xsd:boolean .

    om-ingestion:hasStatus a owl:ObjectProperty ;
        rdfs:label "has status" ;
        rdfs:comment "Pipeline execution status" ;
        rdfs:domain om-ingestion:IngestionPipeline ;
        rdfs:range om-ingestion:PipelineStatus .

    om-ingestion:extractsFrom a owl:ObjectProperty ;
        rdfs:label "extracts from" ;
        rdfs:comment "Source service from which metadata is extracted" ;
        rdfs:domain om-ingestion:IngestionPipeline ;
        rdfs:range om-entity:Service .

    om-ingestion:createsOrUpdates a owl:ObjectProperty ;
        rdfs:label "creates or updates" ;
        rdfs:comment "Entities created or updated by this pipeline" ;
        rdfs:domain om-ingestion:IngestionPipeline ;
        rdfs:range om-entity:Entity .

    om-ingestion:scheduleInterval a owl:DatatypeProperty ;
        rdfs:label "schedule interval" ;
        rdfs:comment "Cron expression for pipeline schedule" ;
        rdfs:domain om-ingestion:IngestionPipeline ;
        rdfs:range xsd:string .

    om-ingestion:runId a owl:DatatypeProperty ;
        rdfs:label "run ID" ;
        rdfs:comment "Unique identifier for a pipeline run" ;
        rdfs:domain om-ingestion:PipelineStatus ;
        rdfs:range xsd:string .

    om-ingestion:pipelineState a owl:ObjectProperty ;
        rdfs:label "pipeline state" ;
        rdfs:comment "State of the pipeline run" ;
        rdfs:domain om-ingestion:PipelineStatus ;
        rdfs:range om-ingestion:PipelineState .

    om-ingestion:startDate a owl:DatatypeProperty ;
        rdfs:label "start date" ;
        rdfs:comment "Start time of pipeline run" ;
        rdfs:domain om-ingestion:PipelineStatus ;
        rdfs:range xsd:dateTime .

    om-ingestion:endDate a owl:DatatypeProperty ;
        rdfs:label "end date" ;
        rdfs:comment "End time of pipeline run" ;
        rdfs:domain om-ingestion:PipelineStatus ;
        rdfs:range xsd:dateTime .

    # Pipeline Type Individuals
    om-ingestion:Metadata a om-ingestion:PipelineType ;
        rdfs:label "Metadata" ;
        skos:definition "Pipeline for ingesting metadata (schemas, tables, columns)" .

    om-ingestion:Usage a om-ingestion:PipelineType ;
        rdfs:label "Usage" ;
        skos:definition "Pipeline for ingesting usage and query logs" .

    om-ingestion:Lineage a om-ingestion:PipelineType ;
        rdfs:label "Lineage" ;
        skos:definition "Pipeline for extracting data lineage" .

    om-ingestion:Profiler a om-ingestion:PipelineType ;
        rdfs:label "Profiler" ;
        skos:definition "Pipeline for collecting data profiles and statistics" .

    om-ingestion:TestSuite a om-ingestion:PipelineType ;
        rdfs:label "Test Suite" ;
        skos:definition "Pipeline for executing data quality tests" .

    om-ingestion:DBT a om-ingestion:PipelineType ;
        rdfs:label "DBT" ;
        skos:definition "Pipeline for ingesting dbt models and lineage" .

    # Pipeline State Individuals
    om-ingestion:Queued a om-ingestion:PipelineState ;
        rdfs:label "Queued" ;
        skos:definition "Pipeline run is queued" .

    om-ingestion:Running a om-ingestion:PipelineState ;
        rdfs:label "Running" ;
        skos:definition "Pipeline run is in progress" .

    om-ingestion:Success a om-ingestion:PipelineState ;
        rdfs:label "Success" ;
        skos:definition "Pipeline run completed successfully" .

    om-ingestion:Failed a om-ingestion:PipelineState ;
        rdfs:label "Failed" ;
        skos:definition "Pipeline run failed" .

    om-ingestion:PartialSuccess a om-ingestion:PipelineState ;
        rdfs:label "Partial Success" ;
        skos:definition "Pipeline run completed with some errors" .
    ```

=== "JSON-LD Context"

    ```json
    {
      "@context": {
        "@vocab": "https://open-metadata.org/schema/entity/services/ingestionPipelines/",
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "owl": "http://www.w3.org/2002/07/owl#",
        "xsd": "http://www.w3.org/2001/XMLSchema#",
        "dcterms": "http://purl.org/dc/terms/",
        "skos": "http://www.w3.org/2004/02/skos/core#",
        "prov": "http://www.w3.org/ns/prov#",
        "om": "https://open-metadata.org/schema/",

        "IngestionPipeline": {
          "@id": "om:IngestionPipeline",
          "@type": "@id"
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
          "@id": "dcterms:description",
          "@type": "xsd:string"
        },
        "pipelineType": {
          "@id": "om:pipelineType",
          "@type": "@id"
        },
        "service": {
          "@id": "om:service",
          "@type": "@id"
        },
        "enabled": {
          "@id": "om:enabled",
          "@type": "xsd:boolean"
        },
        "deployed": {
          "@id": "om:deployed",
          "@type": "xsd:boolean"
        },
        "pipelineStatuses": {
          "@id": "om:hasStatus",
          "@type": "@id",
          "@container": "@set"
        },
        "extractsFrom": {
          "@id": "om:extractsFrom",
          "@type": "@id"
        },
        "createsOrUpdates": {
          "@id": "om:createsOrUpdates",
          "@type": "@id",
          "@container": "@set"
        },
        "owner": {
          "@id": "om:owner",
          "@type": "@id"
        },
        "domain": {
          "@id": "om:domain",
          "@type": "@id"
        },
        "version": {
          "@id": "om:version",
          "@type": "xsd:string"
        },
        "updatedAt": {
          "@id": "dcterms:modified",
          "@type": "xsd:dateTime"
        },
        "updatedBy": {
          "@id": "prov:wasAttributedTo",
          "@type": "xsd:string"
        },
        "href": {
          "@id": "om:href",
          "@type": "xsd:anyURI"
        }
      }
    }
    ```

## Use Cases

### Metadata Ingestion Pipeline

Ingest schema metadata from a Snowflake database:

```json
{
  "name": "SnowflakeMetadataIngestion",
  "displayName": "Snowflake Production Metadata",
  "pipelineType": "metadata",
  "description": "Ingest metadata from Snowflake production databases",
  "service": {
    "type": "databaseService",
    "name": "SnowflakeProduction"
  },
  "sourceConfig": {
    "config": {
      "type": "DatabaseMetadata",
      "schemaFilterPattern": {
        "includes": ["sales", "marketing", "analytics"]
      },
      "tableFilterPattern": {
        "excludes": [".*_temp$", ".*_backup$"]
      },
      "includeTables": true,
      "includeViews": true,
      "includeTags": true,
      "markDeletedTables": true
    }
  },
  "airflowConfig": {
    "scheduleInterval": "0 2 * * *",
    "pausePipeline": false,
    "concurrency": 1,
    "retries": 3,
    "retryDelay": 300
  },
  "enabled": true,
  "owner": {
    "type": "team",
    "name": "DataEngineering"
  }
}
```

### Usage Ingestion Pipeline

Extract query logs and usage statistics:

```json
{
  "name": "SnowflakeUsageIngestion",
  "displayName": "Snowflake Usage Analytics",
  "pipelineType": "usage",
  "description": "Extract query logs and usage patterns",
  "service": {
    "type": "databaseService",
    "name": "SnowflakeProduction"
  },
  "sourceConfig": {
    "config": {
      "type": "DatabaseUsage",
      "queryLogDuration": 7,
      "stageFileLocation": "/tmp/query_logs",
      "resultLimit": 1000
    }
  },
  "airflowConfig": {
    "scheduleInterval": "0 * * * *",
    "retries": 2
  },
  "enabled": true,
  "owner": {
    "type": "user",
    "name": "data.engineer"
  }
}
```

### Lineage Ingestion Pipeline

Extract data lineage from SQL queries:

```json
{
  "name": "SnowflakeLineageIngestion",
  "displayName": "Snowflake Lineage Extraction",
  "pipelineType": "lineage",
  "description": "Extract data lineage from query history",
  "service": {
    "type": "databaseService",
    "name": "SnowflakeProduction"
  },
  "sourceConfig": {
    "config": {
      "type": "DatabaseLineage",
      "queryLogDuration": 30,
      "parsingTimeoutLimit": 300,
      "filterCondition": "query_type = 'INSERT' OR query_type = 'CTAS'"
    }
  },
  "airflowConfig": {
    "scheduleInterval": "0 3 * * *",
    "retries": 3
  },
  "enabled": true
}
```

### Profiler Pipeline

Collect data profiles and statistics:

```json
{
  "name": "CustomerDataProfiler",
  "displayName": "Customer Data Profiling",
  "pipelineType": "profiler",
  "description": "Profile customer tables and collect statistics",
  "service": {
    "type": "databaseService",
    "name": "PostgresCustomer"
  },
  "sourceConfig": {
    "config": {
      "type": "Profiler",
      "generateSampleData": true,
      "profileSample": 100,
      "profileSampleType": "PERCENTAGE",
      "sampleDataCount": 50,
      "schemaFilterPattern": {
        "includes": ["customer"]
      },
      "tableFilterPattern": {
        "includes": ["customer.*", "account.*"]
      },
      "profileQuery": "SELECT * FROM {table} WHERE active = true"
    }
  },
  "airflowConfig": {
    "scheduleInterval": "0 0 * * 0",
    "workflowTimeout": 7200
  },
  "enabled": true,
  "owner": {
    "type": "team",
    "name": "DataQuality"
  }
}
```

### DBT Ingestion Pipeline

Ingest dbt models, tests, and lineage:

```json
{
  "name": "DBTIngestion",
  "displayName": "DBT Models & Lineage",
  "pipelineType": "dbt",
  "description": "Ingest dbt models, tests, and lineage from manifest",
  "service": {
    "type": "databaseService",
    "name": "SnowflakeProduction"
  },
  "sourceConfig": {
    "config": {
      "type": "DBT",
      "dbtConfigSource": {
        "dbtManifestFilePath": "s3://my-bucket/dbt/manifest.json",
        "dbtCatalogFilePath": "s3://my-bucket/dbt/catalog.json",
        "dbtRunResultsFilePath": "s3://my-bucket/dbt/run_results.json"
      },
      "dbtUpdateDescriptions": true,
      "includeTags": true,
      "dbtClassificationName": "dbtTags"
    }
  },
  "airflowConfig": {
    "scheduleInterval": "0 4 * * *"
  },
  "enabled": true,
  "owner": {
    "type": "team",
    "name": "Analytics"
  }
}
```

### Test Suite Pipeline

Execute data quality tests:

```json
{
  "name": "CustomerQualityTests",
  "displayName": "Customer Data Quality Tests",
  "pipelineType": "TestSuite",
  "description": "Run quality tests on customer data",
  "service": {
    "type": "databaseService",
    "name": "PostgresCustomer"
  },
  "sourceConfig": {
    "config": {
      "type": "TestSuite",
      "entityFullyQualifiedName": "PostgresCustomer.customer.public.customers"
    }
  },
  "airflowConfig": {
    "scheduleInterval": "0 */6 * * *"
  },
  "enabled": true,
  "owner": {
    "type": "team",
    "name": "DataQuality"
  }
}
```

## Pipeline Types

| Type | Description | Frequency | Output |
|------|-------------|-----------|--------|
| **metadata** | Extracts schema, tables, columns, relationships | Daily | Database, Table, Column entities |
| **usage** | Extracts query logs and access patterns | Hourly | Usage statistics, popular queries |
| **lineage** | Extracts data lineage from queries/ETL | Daily | Lineage edges between entities |
| **profiler** | Collects data profiles and statistics | Weekly | Data profiles, column statistics |
| **TestSuite** | Executes data quality tests | Multiple times daily | Test results |
| **dbt** | Ingests dbt models and lineage | Daily after dbt runs | DBT models, tests, lineage |

## Pipeline States

| State | Description | Actions |
|-------|-------------|---------|
| **queued** | Pipeline is waiting to execute | Monitor queue |
| **running** | Pipeline is currently executing | Monitor progress |
| **success** | Pipeline completed successfully | Review metrics |
| **failed** | Pipeline encountered errors | Check logs, retry |
| **partialSuccess** | Pipeline completed with some errors | Review warnings |

## Airflow Configuration

Common Airflow settings for ingestion pipelines:

```json
{
  "scheduleInterval": "0 2 * * *",
  "pausePipeline": false,
  "concurrency": 1,
  "pipelineTimezone": "UTC",
  "retries": 3,
  "retryDelay": 300,
  "pipelineCatchup": false,
  "maxActiveRuns": 1,
  "workflowTimeout": 3600,
  "workflowDefaultView": "tree"
}
```

## Best Practices

### 1. Start with Metadata Ingestion
Begin with basic metadata ingestion before adding usage, lineage, and profiling.

### 2. Use Appropriate Schedules
- Metadata: Daily
- Usage: Hourly
- Lineage: Daily
- Profiler: Weekly

### 3. Filter Appropriately
Use schema and table filters to avoid ingesting unnecessary metadata.

### 4. Handle Failures Gracefully
Configure retries and alerts for pipeline failures.

### 5. Monitor Performance
Track ingestion duration, entity counts, and error rates.

### 6. Incremental Updates
Enable incremental ingestion to detect only changed metadata.

### 7. Test Before Production
Test ingestion pipelines in non-production environments first.

### 8. Document Configuration
Maintain clear documentation of pipeline configurations and filters.

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

### Create Ingestion Pipeline

```http
POST /api/v1/services/ingestionPipelines
Content-Type: application/json

{
  "name": "SnowflakeMetadata",
  "pipelineType": "metadata",
  "service": {...},
  "sourceConfig": {...},
  "airflowConfig": {...}
}
```

### Get Ingestion Pipeline

```http
GET /api/v1/services/ingestionPipelines/{id}
```

### Deploy Pipeline

```http
POST /api/v1/services/ingestionPipelines/deploy/{id}
```

### Trigger Pipeline Run

```http
POST /api/v1/services/ingestionPipelines/trigger/{id}
```

### Get Pipeline Status

```http
GET /api/v1/services/ingestionPipelines/{id}/pipelineStatus?startTs=1234567890&endTs=1234567999
```

### Update Pipeline

```http
PATCH /api/v1/services/ingestionPipelines/{id}
Content-Type: application/json-patch+json

[
  {
    "op": "replace",
    "path": "/enabled",
    "value": false
  }
]
```

### Delete Pipeline

```http
DELETE /api/v1/services/ingestionPipelines/{id}
```

### List Pipelines

```http
GET /api/v1/services/ingestionPipelines?service=SnowflakeProduction&pipelineType=metadata
```

## Related Entities

- **[Database Service](../data-assets/databases/database-service.md)**: Source services for metadata ingestion
- **[Pipeline Service](../data-assets/pipelines/pipeline-service.md)**: ETL pipeline services
- **[Database](../data-assets/databases/database.md)**: Databases created/updated by ingestion
- **[Table](../data-assets/databases/table.md)**: Tables created/updated by ingestion
- **[Alert](../data-quality/alert.md)**: Alerts for pipeline failures
- **[Domain](../domains/domain.md)**: Domains for organizing pipelines
- **[User](../teams-users/user.md)**: Pipeline owners
- **[Team](../teams-users/team.md)**: Teams managing pipelines
