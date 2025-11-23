
# Data Assets

Comprehensive catalog of all data asset types in OpenMetadata.

## Overview

Data assets are the core entities that represent actual data resources in your organization. OpenMetadata provides rich metadata schemas for **10+ data asset types**, enabling comprehensive discovery, lineage, quality, and governance.

---

## Database Assets

### Tables

**Schema**: [`schemas/entity/data/table.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/table.json)

Database tables and views - the most fundamental data asset.

**Properties**:

- **Identity**: Name, fully qualified name, display name
- **Structure**: Columns with data types, constraints, descriptions
- **Constraints**: Primary keys, foreign keys, unique, not null
- **Table Type**: Regular, View, Materialized View, External, Temporary
- **Partitioning**: Partition columns and configuration
- **Location**: Database and schema references
- **Service**: Connection to database service

**Column Definition**:

```json
{
  "name": "customer_email",
  "dataType": "VARCHAR",
  "dataLength": 255,
  "dataTypeDisplay": "varchar(255)",
  "description": "Customer email address",
  "ordinalPosition": 3,
  "constraint": "UNIQUE",
  "tags": [{"tagFQN": "PII.Email"}]
}
```

**Table Types**:

- `Regular` - Standard database table
- `View` - SQL view
- `MaterializedView` - Materialized view with physical storage
- `External` - External table (e.g., Hive external tables)
- `Temporary` - Temporary table
- `SecureView` - Secure view (Snowflake)
- `Transient` - Transient table (Snowflake)

### Databases

**Schema**: [`schemas/entity/data/database.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/database.json)

Database containers that group schemas.

**Properties**:

- Database name and description
- Owner and tags
- Service reference
- Associated schemas

### Database Schemas

**Schema**: [`schemas/entity/data/databaseSchema.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/databaseSchema.json)

Schema namespaces within databases.

**Properties**:

- Schema name
- Parent database
- Contained tables
- Retention policy

### Stored Procedures

**Schema**: [`schemas/entity/data/storedProcedure.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/storedProcedure.json)

Database stored procedures and functions.

**Properties**:

- Procedure name and code
- Parameters and return types
- Language (SQL, PL/SQL, T-SQL, etc.)
- Dependencies and usage

---

## Streaming Assets

### Topics

**Schema**: [`schemas/entity/data/topic.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/topic.json)

Message queue topics for event streaming platforms (Kafka, Pulsar, Kinesis).

**Properties**:

- **Topic Configuration**:
  - Name and description
  - Partition count
  - Replication factor
  - Retention policy (time and size)
  - Cleanup policy (delete, compact)

- **Message Schema**:
  - Schema type (Avro, Protobuf, JSON Schema)
  - Schema definition
  - Schema version
  - Schema evolution

- **Consumer Groups**:
  - Active consumers
  - Offset information

**Example**:

```json
{
  "name": "customer.events",
  "topicType": "Kafka",
  "partitions": 12,
  "replicationFactor": 3,
  "retentionTime": 604800000,
  "messageSchema": {
    "schemaType": "Avro",
    "schemaText": "{...avro schema...}"
  }
}
```

---

## BI & Analytics Assets

### Dashboards

**Schema**: [`schemas/entity/data/dashboard.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/dashboard.json)

Business intelligence dashboards from BI tools (Tableau, Looker, PowerBI, Superset).

**Properties**:

- **Dashboard Information**:
  - Name, description, URL
  - Dashboard type
  - Project/workspace
  - Tags and owner

- **Charts**: List of contained visualizations
- **Data Sources**: Tables and queries used
- **Filters**: Dashboard-level filters
- **Usage Statistics**: View counts, users

**Relationships**:

- Contains multiple charts
- Uses tables (lineage)
- Belongs to dashboard service

### Charts

**Schema**: [`schemas/entity/data/chart.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/chart.json)

Individual visualizations and reports.

**Properties**:

- **Chart Type**: Bar, Line, Pie, Table, Scatter, etc.
- **Data Source**: Query or table reference
- **Filters**: Chart-specific filters
- **Configuration**: Chart settings and styling

### Dashboard Data Models

**Schema**: [`schemas/entity/data/dashboardDataModel.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/dashboardDataModel.json)

Semantic layers and data models (Looker LookML, Tableau data sources).

**Properties**:

- Model definition
- Dimensions and measures
- Relationships
- SQL generation logic

---

## Pipeline & Processing Assets

### Pipelines

**Schema**: [`schemas/entity/data/pipeline.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/pipeline.json)

Data pipelines from orchestration tools (Airflow, Prefect, Dagster, dbt).

**Properties**:

- **Pipeline Configuration**:
  - Name and description
  - Schedule/trigger
  - Pipeline type

- **Tasks**: Ordered list of pipeline tasks
  - Task name and type
  - Task dependencies (DAG)
  - Upstream and downstream tasks

- **Execution History**:
  - Run status
  - Execution time
  - Success/failure rates

**Task Types**:

- SQL Task
- Python Task
- Spark Task
- dbt Task
- Shell Script
- Container Task

**Example**:

```json
{
  "name": "daily_customer_etl",
  "pipelineType": "Airflow",
  "tasks": [
    {
      "name": "extract_customers",
      "taskType": "SQL",
      "downstreamTasks": ["transform_customers"]
    },
    {
      "name": "transform_customers",
      "taskType": "Python",
      "downstreamTasks": ["load_customers"]
    }
  ]
}
```

---

## ML & AI Assets

### ML Models

**Schema**: [`schemas/entity/data/mlmodel.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/mlmodel.json)

Machine learning models and their metadata.

**Properties**:

- **Model Information**:
  - Model name and version
  - Algorithm (XGBoost, Random Forest, Neural Network, etc.)
  - Model type (Classification, Regression, Clustering, etc.)
  - Dashboard for monitoring

- **Training Data**:
  - Source tables (lineage)
  - Training dataset size
  - Training date

- **Features**:
  - Feature names and types
  - Feature sources (lineage to source tables)
  - Feature engineering logic

- **Hyperparameters**:
  - Learning rate, max depth, etc.
  - Training configuration

- **Performance Metrics**:
  - Accuracy, precision, recall
  - AUC, F1 score
  - Custom metrics

**Example**:

```json
{
  "name": "customer_churn_predictor_v2",
  "algorithm": "XGBoost",
  "mlHyperParameters": [
    {"name": "max_depth", "value": "6"},
    {"name": "learning_rate", "value": "0.1"}
  ],
  "mlFeatures": [
    {
      "name": "customer_lifetime_value",
      "dataType": "numerical",
      "featureSources": [
        {"dataSource": "analytics.customer_metrics"}
      ]
    }
  ]
}
```

### ML Model Services

Track model serving endpoints and deployment information.

---

## Storage Assets

### Containers

**Schema**: [`schemas/entity/data/container.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/container.json)

Object storage containers (S3 buckets, GCS buckets, Azure containers, ADLS folders).

**Properties**:

- **Container Information**:
  - Name and full path
  - Container type (S3, GCS, Azure)
  - Size and object count

- **Data Structure**:
  - File formats (Parquet, CSV, JSON, Avro)
  - Schema information
  - Partitioning scheme

- **Access Patterns**:
  - Read/write frequency
  - Access users

**Example**:

```json
{
  "name": "customer-data-lake",
  "containerType": "S3",
  "fullPath": "s3://my-datalake/customer/",
  "fileFormats": ["parquet"],
  "numberOfObjects": 1500,
  "size": 850000000
}
```

### Directories

**Schema**: [`schemas/entity/data/directory.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/directory.json)

Logical directories within containers.

---

## API Assets

### API Collections

**Schema**: [`schemas/entity/data/apiCollection.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/apiCollection.json)

Collections of related API endpoints.

### API Endpoints

**Schema**: [`schemas/entity/data/apiEndpoint.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/apiEndpoint.json)

Individual REST API endpoints.

**Properties**:

- Endpoint URL and method (GET, POST, etc.)
- Request/response schemas
- Authentication requirements
- Rate limits

---

## Search Assets

### Search Indexes

**Schema**: [`schemas/entity/data/searchIndex.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/searchIndex.json)

Search indexes from Elasticsearch, OpenSearch.

**Properties**:

- Index name and mappings
- Field definitions
- Document count
- Index settings

---

## Data Contracts

**Schema**: [`schemas/entity/data/dataContract.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/dataContract.json)

Formal agreements about data structure and quality.

**Properties**:

- Schema requirements
- Data quality requirements
- SLAs
- Stakeholders

---

## Common Metadata

All data assets share these common properties:

### Identity

```json
{
  "id": "uuid",
  "name": "asset_name",
  "fullyQualifiedName": "service.database.schema.asset_name",
  "displayName": "Asset Display Name"
}
```

### Documentation

```json
{
  "description": "Markdown description",
  "tags": [
    {"tagFQN": "PII.Sensitive"},
    {"tagFQN": "Tier.Gold"}
  ],
  "glossaryTerms": [
    {"fullyQualifiedName": "BusinessGlossary.Customer"}
  ]
}
```

### Ownership

```json
{
  "owner": {
    "id": "uuid",
    "type": "user",
    "name": "john.doe"
  },
  "domain": {
    "id": "domain-uuid",
    "name": "Sales"
  },
  "experts": [
    {"id": "user-uuid", "type": "user"}
  ]
}
```

### Versioning & Audit

```json
{
  "version": 1.3,
  "updatedAt": 1704240000000,
  "updatedBy": "john.doe",
  "changeDescription": {
    "fieldsUpdated": [...]
  }
}
```

### Lifecycle

```json
{
  "deleted": false,
  "extension": {},
  "href": "https://api/v1/tables/uuid"
}
```

---

## Asset Relationships

### Hierarchical Relationships

```
Service
  └── Database
        └── Schema
              └── Table
                    └── Column
```

### Lineage Relationships

```
Source Table → Pipeline → Target Table → Dashboard
```

### Usage Relationships

```
Dashboard uses Table
Query uses Table
ML Model uses Table (for training)
```

---

## Next Steps

- **[Data Quality](../../getting-started/use-cases.md#data-quality)** - Quality tests and profiling
- **[Governance](glossary.md)** - Classifications and glossaries
- **[Services](services.md)** - Service connections
- **[Lineage](../../rdf/provenance/lineage.md)** - Data lineage tracking
