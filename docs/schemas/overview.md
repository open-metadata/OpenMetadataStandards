
# JSON Schemas Overview

OpenMetadata Standards provides 700+ JSON schemas organized into logical categories. These schemas define the structure and validation rules for all metadata in the OpenMetadata ecosystem.

## Schema Categories

### Entity Schemas

Entity schemas define the core metadata objects in the system.

#### Data Entities

Schemas for data assets across different platforms:

- **Tables** (`entity/data/table.json`) - Database tables and views
- **Databases** (`entity/data/database.json`) - Database containers
- **Database Schemas** (`entity/data/databaseSchema.json`) - Schema namespaces
- **Topics** (`entity/data/topic.json`) - Messaging topics (Kafka, Pulsar)
- **Dashboards** (`entity/data/dashboard.json`) - BI dashboards
- **Charts** (`entity/data/chart.json`) - Visualization charts
- **Pipelines** (`entity/data/pipeline.json`) - Data pipelines (Airflow, etc.)
- **ML Models** (`entity/data/mlmodel.json`) - Machine learning models
- **Containers** (`entity/data/container.json`) - Object storage containers
- **Stored Procedures** (`entity/data/storedProcedure.json`) - Database procedures

#### Service Entities

Schemas for external service connections:

- **Database Services** (`entity/services/databaseService.json`) - Postgres, MySQL, Snowflake, etc.
- **Dashboard Services** (`entity/services/dashboardService.json`) - Tableau, Looker, etc.
- **Messaging Services** (`entity/services/messagingService.json`) - Kafka, Pulsar, etc.
- **Pipeline Services** (`entity/services/pipelineService.json`) - Airflow, Dagster, etc.
- **ML Model Services** (`entity/services/mlmodelService.json`) - MLflow, SageMaker, etc.
- **Storage Services** (`entity/services/storageService.json`) - S3, GCS, ADLS, etc.
- **Metadata Services** (`entity/services/metadataService.json`) - Metadata service connections

#### Governance Entities

Schemas for data governance:

- **Glossaries** (`entity/data/glossary.json`) - Business glossaries
- **Glossary Terms** (`entity/data/glossaryTerm.json`) - Business terminology
- **Tags** (`entity/classification/tag.json`) - Classification tags
- **Classifications** (`entity/classification/classification.json`) - Tag hierarchies
- **Policies** (`entity/policies/policy.json`) - Access and governance policies

#### Team & User Entities

Schemas for organizational structure:

- **Teams** (`entity/teams/team.json`) - Organizational teams
- **Users** (`entity/teams/user.json`) - Individual users
- **Roles** (`entity/teams/role.json`) - Permission roles
- **Personas** (`entity/teams/persona.json`) - User personas

#### Observability Entities

Schemas for data quality and monitoring:

- **Test Cases** (`entity/data/testCase.json`) - Data quality tests
- **Test Suites** (`entity/data/testSuite.json`) - Test collections
- **Test Definitions** (`entity/data/testDefinition.json`) - Test templates
- **Data Quality Metrics** - Quality measurements
- **Incidents** - Data incidents and issues

### Type System

Reusable type definitions used across entity schemas.

#### Basic Types (`type/basic.json`)

- **UUID** - Universally unique identifiers
- **Email** - Email addresses
- **Timestamp** - Date/time values
- **Duration** - Time durations
- **URI** - Uniform resource identifiers
- **Markdown** - Rich text content

#### Collection Types

- **Entity Reference** (`type/entityReference.json`) - References to other entities
- **Entity Relationship** (`type/entityRelationship.json`) - Typed relationships
- **Tag Label** (`type/tagLabel.json`) - Tag assignments
- **Change Description** (`type/changeDescription.json`) - Change tracking

#### Domain Types

- **Column** (`type/schema.json#/definitions/column`) - Table column definition
- **Field** - Generic field definition
- **Data Type** - SQL and programming data types
- **Constraint** - Database constraints
- **Partition** - Table partitioning

#### Custom Properties

- **Custom Property** (`type/customProperty.json`) - User-defined property definitions
- **Entity Extension** - Extension mechanism for entities

### API Schemas

Schemas for REST API operations.

#### Data Operations (`api/data/`)

- **Create Table** - Create table request/response
- **Patch Table** - Update table with JSON Patch
- **Restore Entity** - Restore soft-deleted entities

#### Feed & Activity (`api/feed/`)

- **Thread** - Discussion threads
- **Post** - Comments and replies
- **Reaction** - Emoji reactions
- **Task** - Action items

#### Search (`api/search/`)

- **Search Request** - Search query format
- **Search Response** - Search results format
- **Aggregations** - Faceted search

### Events

Event schemas for change tracking and notifications.

#### Entity Events (`events/`)

- **Entity Created** - New entity events
- **Entity Updated** - Modification events
- **Entity Deleted** - Soft deletion events
- **Entity Restored** - Restoration events

#### Change Events

- **Change Event** (`type/changeEvent.json`) - Detailed change information
- **Field Change** - Individual field changes

#### Webhook Events

- **Webhook** (`entity/events/webhook.json`) - Webhook configuration
- **Event Subscription** (`entity/events/eventSubscription.json`) - Event filters

### Configuration

Configuration schemas for system setup.

#### Authentication (`configuration/authenticationConfiguration.json`)

- **LDAP Configuration**
- **SAML Configuration**
- **OAuth Configuration**
- **OIDC Configuration**
- **JWT Configuration**

#### Authorization

- **Authorization Configuration**
- **RBAC Settings**
- **Policy Configuration**

#### Ingestion (`configuration/`)

- **Pipeline Service Client** - Airflow, Prefect integration
- **Workflow Settings** - Ingestion workflows
- **Connection Configuration** - Service connections

#### Infrastructure

- **Event Handler Configuration** - Event processing
- **Kafka Configuration** - Event streaming
- **Elasticsearch Configuration** - Search indexing

### Metadata Ingestion

Schemas for metadata extraction pipelines.

#### Workflow (`metadataIngestion/workflow.json`)

- **Source** - Metadata source configuration
- **Sink** - Metadata destination
- **Stage** - Processing stages
- **Bulk Sink** - Bulk operations

#### Connectors

Connector-specific schemas for:

- **Database Connectors** (100+ database types)
- **Dashboard Connectors** (20+ BI tools)
- **Pipeline Connectors** (15+ orchestrators)
- **Storage Connectors** (S3, GCS, ADLS, etc.)
- **API Connectors** (REST, GraphQL)

### Data Insights

Schemas for analytics and reporting.

#### Reports (`dataInsight/`)

- **Data Asset Reports** - Asset statistics
- **Web Analytics** - Usage tracking
- **Cost Analysis** - Resource costs

#### KPIs

- **KPI** (`dataInsight/kpi/kpi.json`) - Key performance indicators
- **Data Asset KPI** - Asset-specific KPIs

## Schema Features

### Versioning

All schemas include version information:

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "version": "1.2.0"
}
```

### $ref and Reusability

Schemas use `$ref` for composition:

```json
{
  "properties": {
    "owner": {
      "$ref": "../../type/entityReference.json"
    },
    "tags": {
      "type": "array",
      "items": {
        "$ref": "../../type/tagLabel.json"
      }
    }
  }
}
```

### Validation Constraints

Rich validation rules:

```json
{
  "name": {
    "type": "string",
    "minLength": 1,
    "maxLength": 256,
    "pattern": "^[a-zA-Z0-9_.-]+$"
  },
  "email": {
    "type": "string",
    "format": "email"
  }
}
```

### Documentation

Inline documentation in schemas:

```json
{
  "description": "Table name as defined in the data source",
  "title": "Table Name",
  "examples": ["customers", "orders", "products"]
}
```

## Using the Schemas

### Validation

Validate JSON data against schemas using standard JSON Schema validators.

### Code Generation

Generate type-safe code in any language:

- TypeScript interfaces
- Python dataclasses
- Java POJOs
- Go structs

### IDE Support

Most modern IDEs provide:

- Auto-completion
- Inline documentation
- Schema validation
- Error highlighting

### API Documentation

Generate OpenAPI specifications from schemas for automatic API documentation.

## Schema Evolution

### Backward Compatibility

We maintain backward compatibility by:

- Never removing required fields
- Adding new fields as optional
- Deprecating fields before removal
- Providing migration guides

### Versioning Strategy

- **Major version**: Breaking changes
- **Minor version**: New features (backward compatible)
- **Patch version**: Bug fixes

### Deprecation Process

1. Mark field as deprecated in schema
2. Add deprecation notice in documentation
3. Maintain for at least 2 major versions
4. Remove in future major version

## Next Steps

- [Entity Schemas](entity/index.md) - Deep dive into entity schemas
- [Type System](type/index.md) - Explore the type system
- [API Schemas](api/index.md) - Learn about API schemas
- [Complete Reference](reference.md) - Browse all schemas
