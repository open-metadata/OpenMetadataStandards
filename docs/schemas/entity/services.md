
# Services

Services represent connections to external data systems and platforms in OpenMetadata.

## Overview

Services are the integration points between OpenMetadata and your data infrastructure. Each service represents a connection to a specific data platform or tool.

## Service Types

### Database Services

**Schema**: `schemas/entity/services/databaseService.json`

Connections to databases and data warehouses:

**Supported Platforms**:

- **Relational**: PostgreSQL, MySQL, Oracle, SQL Server, MariaDB
- **Data Warehouses**: Snowflake, BigQuery, Redshift, Synapse
- **NoSQL**: MongoDB, Cassandra, DynamoDB, Couchbase
- **Cloud Databases**: Aurora, Cloud SQL, Azure SQL
- **Analytics**: Databricks, Presto, Trino, Hive, Impala

**Connection Properties**:

- Host and port
- Authentication credentials
- Database name
- SSL/TLS configuration
- Connection pooling settings

### Dashboard Services

**Schema**: `schemas/entity/services/dashboardService.json`

Connections to BI and analytics platforms:

**Supported Platforms**:

- Tableau, Looker, PowerBI, Superset
- Metabase, Mode, Redash, Sigma
- QuickSight, Data Studio, Qlik

**Connection Properties**:

- Platform URL
- API credentials
- Workspace/project configuration

### Messaging Services

**Schema**: `schemas/entity/services/messagingService.json`

Connections to message brokers and streaming platforms:

**Supported Platforms**:

- Apache Kafka
- Apache Pulsar
- Amazon Kinesis, MSK
- Google Pub/Sub
- Azure Event Hubs
- RabbitMQ, ActiveMQ

**Connection Properties**:

- Bootstrap servers
- Security protocol
- Schema registry URL
- Consumer group configuration

### Pipeline Services

**Schema**: `schemas/entity/services/pipelineService.json`

Connections to workflow orchestration platforms:

**Supported Platforms**:

- Apache Airflow
- Prefect
- Dagster
- Azure Data Factory
- AWS Glue
- Google Cloud Composer
- Fivetran, dbt Cloud

**Connection Properties**:

- Platform URL/API endpoint
- Authentication
- Project/environment configuration

### ML Model Services

**Schema**: `schemas/entity/services/mlmodelService.json`

Connections to ML platforms:

**Supported Platforms**:

- MLflow
- SageMaker
- Databricks ML
- Vertex AI
- Azure ML

### Storage Services

**Schema**: `schemas/entity/services/storageService.json`

Connections to object storage:

**Supported Platforms**:

- Amazon S3
- Google Cloud Storage
- Azure Blob Storage / ADLS
- MinIO

### Search Services

**Schema**: `schemas/entity/services/searchService.json`

Connections to search platforms:

**Supported Platforms**:

- Elasticsearch
- OpenSearch

### Metadata Services

**Schema**: `schemas/entity/services/metadataService.json`

Connections to other metadata systems:

**Supported Platforms**:

- Amundsen
- Atlas
- Alation

## Service Configuration

### Authentication

Services support various authentication methods:

- **Basic Auth**: Username/password
- **API Keys**: Token-based authentication
- **OAuth 2.0**: OAuth flow for supported platforms
- **IAM Roles**: Cloud platform IAM
- **Service Accounts**: Platform-specific service accounts
- **SSL Certificates**: Certificate-based authentication

### Connection Testing

OpenMetadata can test service connections to verify:
- Connectivity to the platform
- Authentication validity
- Required permissions
- API availability

### Security

**Best Practices**:

- Store credentials securely (use secrets management)
- Use read-only accounts when possible
- Implement least-privilege access
- Rotate credentials regularly
- Enable SSL/TLS encryption

## Metadata Ingestion

Services are used by ingestion workflows to:

1. **Connect** to the platform
2. **Discover** metadata (databases, tables, dashboards, etc.)
3. **Extract** detailed metadata
4. **Transform** into OpenMetadata schema
5. **Load** into the metadata store

### Ingestion Filters

Configure what to include/exclude:

```json
{
  "filterPattern": {
    "includes": ["prod_*", "analytics_*"],
    "excludes": ["test_*", "temp_*"]
  }
}
```

## Service Entity Properties

All services share common properties:

```json
{
  "id": "uuid",
  "name": "my-postgres-prod",
  "serviceType": "Postgres",
  "description": "Production PostgreSQL database",
  "connection": {
    "config": {
      "host": "prod-db.example.com",
      "port": 5432,
      "database": "analytics",
      "username": "openmetadata",
      "authType": "basic"
    }
  },
  "owner": {
    "type": "team",
    "name": "data-engineering"
  },
  "version": 1.0
}
```

## Managing Services

### Creating Services

1. Define service type and name
2. Configure connection details
3. Test connection
4. Save service configuration
5. Set up ingestion workflows

### Updating Services

- Connection credentials can be updated
- Configuration changes are versioned
- Test connection after updates

### Deleting Services

- Soft delete (can be restored)
- Associated assets remain but become disconnected
- Ingestion workflows are disabled

## Best Practices

1. **Naming Convention**: Use consistent naming (e.g., `<platform>-<environment>`)
2. **Documentation**: Add detailed descriptions
3. **Ownership**: Assign service owners
4. **Secure Credentials**: Never hardcode credentials
5. **Connection Pooling**: Configure appropriately for load
6. **Monitoring**: Track service health and ingestion status
7. **Multiple Environments**: Create separate services for dev/staging/prod

## Related Documentation

- [Data Assets](data-assets.md) - Assets discovered from services
- [Metadata Ingestion](../metadataIngestion/index.md) - Ingestion workflows
- [Configuration](../configuration/index.md) - Service configuration options
