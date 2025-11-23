
# Data Assets

**Comprehensive metadata models for all data resources in your organization**

## Overview

OpenMetadata Standards model **10+ data asset types** organized hierarchically by service type. Each service type contains specific asset entities that represent actual data resources.

---

## Service Hierarchy

All data assets follow a consistent pattern:

```mermaid
graph TD
    A[Service] --> B1[Container 1]
    A[Service] --> B2[Container 2]
    B1 --> C1[Asset 1]
    B1 --> C2[Asset 2]
    B2 --> C3[Asset 3]
    C1 --> D1[Sub-Asset 1]
    C1 --> D2[Sub-Asset 2]
    C3 --> D3[Sub-Asset 3]

    style A fill:#667eea,color:#fff
    style B1 fill:#764ba2,color:#fff
    style B2 fill:#764ba2,color:#fff
    style C1 fill:#f093fb,color:#fff
    style C2 fill:#f093fb,color:#fff
    style C3 fill:#f093fb,color:#fff
    style D1 fill:#4facfe,color:#fff
    style D2 fill:#4facfe,color:#fff
    style D3 fill:#4facfe,color:#fff
```

**Examples**:
```
DatabaseService → Database → Schema → Table → Column
PipelineService → Pipeline → Task
MessagingService → Topic → Schema Fields
StorageService → Container → Files
```

This hierarchical organization provides:
- **Consistent structure** across all asset types
- **Clear ownership** at the service level
- **Logical grouping** of related assets
- **Simplified navigation** and discovery

---

## Database Assets

**Service Type**: `DatabaseService`

Relational and analytical databases across all platforms.

### Hierarchy

```mermaid
graph TD
    A[DatabaseService<br/>PostgreSQL, MySQL, Snowflake] --> B1[Database:<br/>ecommerce]
    A --> B2[Database:<br/>analytics]

    B1 --> C1[Schema:<br/>public]
    B1 --> C2[Schema:<br/>sales]

    C1 --> D1[Table:<br/>customers]
    C1 --> D2[Table:<br/>orders]
    C2 --> D3[StoredProcedure:<br/>calculate_revenue]

    D1 --> E1[Column: id]
    D1 --> E2[Column: email]
    D2 --> E3[Column: order_id]

    style A fill:#667eea,color:#fff
    style B1 fill:#764ba2,color:#fff
    style B2 fill:#764ba2,color:#fff
    style C1 fill:#f093fb,color:#fff
    style C2 fill:#f093fb,color:#fff
    style D1 fill:#4facfe,color:#fff
    style D2 fill:#4facfe,color:#fff
    style D3 fill:#00f2fe,color:#fff
    style E1 fill:#43e97b,color:#fff
    style E2 fill:#43e97b,color:#fff
    style E3 fill:#43e97b,color:#fff
```

### Entities

#### [Database Service](databases/database-service.md)
Connection to database systems - credentials, configuration, connection strings

**Supported Platforms**: PostgreSQL, MySQL, Oracle, SQL Server, Snowflake, BigQuery, Redshift, Databricks, Hive, Presto, Trino, ClickHouse, DynamoDB, MongoDB, Cassandra, and 50+ more

---

#### [Database](databases/database.md)
Database container grouping schemas

**Properties**: Name, description, owner, tags, retention policy

---

#### [Schema](databases/schema.md)
Namespace within a database containing tables and procedures

**Properties**: Name, database reference, contained tables, retention settings

---

#### [Table](databases/table.md) 📘 *Deep Dive*
Database tables, views, materialized views - the core data structure

**Properties**:

- Columns with types, constraints, descriptions
- Table type (Regular, View, MaterializedView, External, Temporary, SecureView, Transient)
- Primary/foreign keys
- Partitioning configuration
- Owner, domain, tags, glossary terms
- Data quality tests
- Lineage relationships
- Profiling results

**[View Complete Table Specification →](databases/table.md)**

---

#### [Stored Procedure](databases/stored-procedure.md)
Database procedures and functions

**Properties**: Procedure code, parameters, return type, language (SQL, PL/SQL, T-SQL), dependencies

---

## Pipeline Assets

**Service Type**: `PipelineService`

Data orchestration and transformation workflows.

### Hierarchy

```mermaid
graph TD
    A[PipelineService<br/>Airflow, Dagster, Prefect] --> B1[Pipeline:<br/>daily_etl_pipeline]
    A --> B2[Pipeline:<br/>ml_training_workflow]

    B1 --> C1[Task:<br/>extract_data]
    B1 --> C2[Task:<br/>transform_data]
    B1 --> C3[Task:<br/>load_to_warehouse]

    B2 --> C4[Task:<br/>prepare_features]
    B2 --> C5[Task:<br/>train_model]

    style A fill:#667eea,color:#fff
    style B1 fill:#764ba2,color:#fff
    style B2 fill:#764ba2,color:#fff
    style C1 fill:#f093fb,color:#fff
    style C2 fill:#f093fb,color:#fff
    style C3 fill:#f093fb,color:#fff
    style C4 fill:#f093fb,color:#fff
    style C5 fill:#f093fb,color:#fff
```

### Entities

#### [Pipeline Service](pipelines/pipeline-service.md)
Connection to orchestration platforms

**Supported Platforms**: Airflow, Dagster, Prefect, Fivetran, dbt, Glue, Data Factory, NiFi, Airbyte

---

#### [Pipeline](pipelines/pipeline.md) 📘 *Deep Dive*
Complete data pipeline with tasks and dependencies

**Properties**:

- Pipeline schedule/trigger
- Tasks with DAG structure
- Upstream/downstream task dependencies
- Execution history and status
- Owner and tags
- Lineage to source and target tables

**[View Complete Pipeline Specification →](pipelines/pipeline.md)**

---

#### [Task](pipelines/task.md)
Individual task within a pipeline

**Properties**: Task type (SQL, Python, Spark, dbt, Shell, Container), dependencies, configuration

---

## Messaging Assets

**Service Type**: `MessagingService`

Event streaming and message queue platforms.

### Hierarchy

```mermaid
graph TD
    A[MessagingService<br/>Kafka, Pulsar, Kinesis] --> B1[Topic:<br/>user_events]
    A --> B2[Topic:<br/>order_notifications]

    B1 --> C1[Schema Field:<br/>user_id]
    B1 --> C2[Schema Field:<br/>event_type]
    B1 --> C3[Schema Field:<br/>timestamp]

    B2 --> C4[Schema Field:<br/>order_id]
    B2 --> C5[Schema Field:<br/>status]

    style A fill:#667eea,color:#fff
    style B1 fill:#764ba2,color:#fff
    style B2 fill:#764ba2,color:#fff
    style C1 fill:#f093fb,color:#fff
    style C2 fill:#f093fb,color:#fff
    style C3 fill:#f093fb,color:#fff
    style C4 fill:#f093fb,color:#fff
    style C5 fill:#f093fb,color:#fff
```

### Entities

#### [Messaging Service](messaging/messaging-service.md)
Connection to message brokers

**Supported Platforms**: Kafka, Pulsar, Kinesis, RabbitMQ, SQS, Azure Event Hub

---

#### [Topic](messaging/topic.md) 📘 *Deep Dive*
Message queue topic for event streaming

**Properties**:

- Partition count and replication factor
- Retention policy (time and size)
- Cleanup policy (delete, compact)
- Message schema (Avro, Protobuf, JSON Schema)
- Schema evolution and versions
- Consumer groups
- Owner and tags

**[View Complete Topic Specification →](messaging/topic.md)**

---

## Dashboard Assets

**Service Type**: `DashboardService`

Business intelligence and analytics platforms.

### Hierarchy

```mermaid
graph TD
    A[DashboardService<br/>Tableau, Looker, PowerBI] --> B1[Dashboard:<br/>Sales Performance]
    A --> B2[Dashboard:<br/>Customer Analytics]
    A --> B3[Data Model:<br/>Sales Metrics]

    B1 --> C1[Chart:<br/>Monthly Revenue]
    B1 --> C2[Chart:<br/>Top Products]

    B2 --> C3[Chart:<br/>Customer Segments]
    B2 --> C4[Chart:<br/>Retention Rate]

    style A fill:#667eea,color:#fff
    style B1 fill:#764ba2,color:#fff
    style B2 fill:#764ba2,color:#fff
    style B3 fill:#764ba2,color:#fff
    style C1 fill:#f093fb,color:#fff
    style C2 fill:#f093fb,color:#fff
    style C3 fill:#f093fb,color:#fff
    style C4 fill:#f093fb,color:#fff
```

### Entities

#### [Dashboard Service](dashboards/dashboard-service.md)
Connection to BI platforms

**Supported Platforms**: Tableau, Looker, PowerBI, Superset, Metabase, Mode, QuickSight, Redash, Sigma

---

#### [Dashboard Data Model](dashboards/dashboard-data-model.md)
Semantic layer and data model (LookML, Tableau Data Source)

**Properties**: Model definition, dimensions, measures, relationships, SQL generation logic

---

#### [Dashboard](dashboards/dashboard.md) 📘 *Deep Dive*
Complete dashboard with visualizations

**Properties**:

- Dashboard URL and project
- Contained charts
- Data sources (lineage to tables)
- Dashboard-level filters
- View count and usage statistics
- Owner and tags

**[View Complete Dashboard Specification →](dashboards/dashboard.md)**

---

#### [Chart](dashboards/chart.md)
Individual visualization within dashboards

**Properties**: Chart type (Bar, Line, Pie, Table, Scatter), query, filters, configuration

---

## ML Assets

**Service Type**: `MLModelService`

Machine learning models and serving endpoints.

### Hierarchy

```mermaid
graph TD
    A[MLModelService<br/>MLflow, SageMaker, Vertex AI] --> B1[MLModel:<br/>churn_predictor]
    A --> B2[MLModel:<br/>recommendation_engine]

    B1 --> C1[Feature:<br/>user_tenure]
    B1 --> C2[Feature:<br/>activity_score]
    B1 --> C3[Feature:<br/>support_tickets]

    B2 --> C4[Feature:<br/>user_preferences]
    B2 --> C5[Feature:<br/>purchase_history]

    style A fill:#667eea,color:#fff
    style B1 fill:#764ba2,color:#fff
    style B2 fill:#764ba2,color:#fff
    style C1 fill:#f093fb,color:#fff
    style C2 fill:#f093fb,color:#fff
    style C3 fill:#f093fb,color:#fff
    style C4 fill:#f093fb,color:#fff
    style C5 fill:#f093fb,color:#fff
```

### Entities

#### [ML Model Service](ml/mlmodel-service.md)
Connection to ML platforms

**Supported Platforms**: MLflow, SageMaker, Vertex AI, Azure ML, Databricks ML

---

#### [ML Model](ml/mlmodel.md) 📘 *Deep Dive*
Trained machine learning model

**Properties**:

- Algorithm (XGBoost, Random Forest, Neural Network, etc.)
- Model type (Classification, Regression, Clustering, etc.)
- Features with sources (lineage to tables)
- Hyperparameters (learning rate, max depth, etc.)
- Performance metrics (accuracy, precision, recall, AUC, F1)
- Training data references
- Model version
- Dashboard for monitoring
- Owner and tags

**[View Complete ML Model Specification →](ml/mlmodel.md)**

---

## Storage Assets

**Service Type**: `StorageService`

Object storage and data lakes.

### Hierarchy

```mermaid
graph TD
    A[StorageService<br/>S3, GCS, Azure Blob] --> B1[Container:<br/>data-lake-raw]
    A --> B2[Container:<br/>data-lake-processed]

    B1 --> C1[File:<br/>events/2024/01/data.parquet]
    B1 --> C2[File:<br/>events/2024/02/data.parquet]

    B2 --> C3[File:<br/>analytics/users.parquet]
    B2 --> C4[File:<br/>analytics/orders.parquet]

    style A fill:#667eea,color:#fff
    style B1 fill:#764ba2,color:#fff
    style B2 fill:#764ba2,color:#fff
    style C1 fill:#f093fb,color:#fff
    style C2 fill:#f093fb,color:#fff
    style C3 fill:#f093fb,color:#fff
    style C4 fill:#f093fb,color:#fff
```

### Entities

#### [Storage Service](storage/storage-service.md)
Connection to object storage

**Supported Platforms**: S3, GCS, Azure Blob Storage, ADLS, MinIO

---

#### [Container](storage/container.md) 📘 *Deep Dive*
Storage bucket or container

**Properties**:

- Full path and naming
- File formats (Parquet, CSV, JSON, Avro, ORC)
- Schema information
- Partitioning scheme
- Object count and total size
- Access patterns
- Owner and tags

**[View Complete Container Specification →](storage/container.md)**

---

## API Assets

**Service Type**: `APIService`

REST APIs and endpoints.

### Hierarchy

```mermaid
graph TD
    A[APIService<br/>REST API Platform] --> B1[APICollection:<br/>User Management]
    A --> B2[APICollection:<br/>Payment Processing]

    B1 --> C1[APIEndpoint:<br/>GET /users]
    B1 --> C2[APIEndpoint:<br/>POST /users]
    B1 --> C3[APIEndpoint:<br/>PUT /users/:id]

    B2 --> C4[APIEndpoint:<br/>POST /payments]
    B2 --> C5[APIEndpoint:<br/>GET /payments/:id]

    style A fill:#667eea,color:#fff
    style B1 fill:#764ba2,color:#fff
    style B2 fill:#764ba2,color:#fff
    style C1 fill:#f093fb,color:#fff
    style C2 fill:#f093fb,color:#fff
    style C3 fill:#f093fb,color:#fff
    style C4 fill:#f093fb,color:#fff
    style C5 fill:#f093fb,color:#fff
```

### Entities

#### [API Service](apis/api-service.md)
Connection to API platforms

**Properties**: Base URL, authentication, version

---

#### [API Collection](apis/api-collection.md)
Group of related API endpoints

**Properties**: Collection name, description, endpoints

---

#### [API Endpoint](apis/api-endpoint.md) 📘 *Deep Dive*
Individual REST API endpoint

**Properties**:

- HTTP method (GET, POST, PUT, DELETE)
- Endpoint URL and path parameters
- Request schema (headers, body)
- Response schema (status codes, body)
- Authentication requirements
- Rate limits
- Owner and tags

**[View Complete API Endpoint Specification →](apis/api-endpoint.md)**

---

## Search Assets

**Service Type**: `SearchService`

Search indexes from Elasticsearch, OpenSearch.

### Hierarchy

```mermaid
graph TD
    A[SearchService<br/>Elasticsearch, OpenSearch] --> B1[SearchIndex:<br/>products]
    A --> B2[SearchIndex:<br/>customers]

    B1 --> C1[Field:<br/>product_name]
    B1 --> C2[Field:<br/>description]
    B1 --> C3[Field:<br/>price]

    B2 --> C4[Field:<br/>customer_id]
    B2 --> C5[Field:<br/>email]

    style A fill:#667eea,color:#fff
    style B1 fill:#764ba2,color:#fff
    style B2 fill:#764ba2,color:#fff
    style C1 fill:#f093fb,color:#fff
    style C2 fill:#f093fb,color:#fff
    style C3 fill:#f093fb,color:#fff
    style C4 fill:#f093fb,color:#fff
    style C5 fill:#f093fb,color:#fff
```

### Entities

#### [Search Service](search/search-service.md)
Connection to search platforms

**Supported Platforms**: Elasticsearch, OpenSearch

---

#### [Search Index](search/search-index.md)
Search index with mappings and settings

**Properties**: Index name, field mappings, analyzers, document count, index settings, owner

---

## Cross-Asset Concepts

These entities apply across all asset types:

### [Data Contracts](../data-contracts/overview.md)
Formal SLA agreements for any data asset - tables, topics, dashboards, ML models, APIs

### [Lineage](../lineage/overview.md)
Relationships showing data flow between any assets

### [Data Quality](../data-quality/overview.md)
Tests and profiling applicable to tables, topics, containers

### [Governance](../governance/overview.md)
Tags, glossary terms, and classifications on all assets

### [Ownership](../teams-users/overview.md)
Users and teams owning any asset

---

## Common Properties

All data assets share these properties:

### Identity
- `id`: UUID
- `name`: Entity name
- `fullyQualifiedName`: Complete hierarchical name
- `displayName`: Human-readable name

### Documentation
- `description`: Markdown description
- `tags[]`: Classification tags
- `glossaryTerms[]`: Business definitions

### Ownership
- `owner`: User or team
- `domain`: Business domain
- `experts[]`: Subject matter experts

### Versioning
- `version`: Metadata version
- `updatedAt`: Last update timestamp
- `updatedBy`: User who updated
- `changeDescription`: Change details

### Lifecycle
- `deleted`: Soft delete flag
- `extension`: Custom properties
- `href`: API resource link

---

## Next Steps

### Explore by Service Type

Choose a service type to see detailed entity specifications:

- **[Databases](databases/table.md)** - Tables, schemas, stored procedures
- **[Pipelines](pipelines/pipeline.md)** - Workflows and tasks
- **[Messaging](messaging/topic.md)** - Topics and schemas
- **[Dashboards](dashboards/dashboard.md)** - Dashboards and charts
- **[ML Models](ml/mlmodel.md)** - Models and features
- **[Storage](storage/container.md)** - Buckets and containers
- **[APIs](apis/api-endpoint.md)** - REST endpoints

### Understand Cross-Cutting Concepts

Learn how these concepts apply to all assets:

- **[Lineage](../lineage/overview.md)** - Data flow tracking
- **[Governance](../governance/overview.md)** - Tags and glossaries
- **[Data Quality](../data-quality/overview.md)** - Testing and profiling
- **[Data Contracts](../data-contracts/overview.md)** - Formal agreements

### See Examples

View real-world examples:

- **[Examples](../examples/index.md)** - Complete use cases
