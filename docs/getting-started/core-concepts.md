
# Core Concepts

Understanding the fundamental concepts of OpenMetadata Standards.

## Entities

Entities are the core objects in the OpenMetadata model. Every piece of metadata is represented as an entity with a defined schema.

### Entity Properties

All entities share common properties:

#### Identity

- **id** (`UUID`): Unique identifier
- **name** (`string`): Human-readable name
- **fullyQualifiedName** (`string`): Unique hierarchical name
- **displayName** (`string`): User-friendly display name

Example:
```json
{
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "name": "customers",
  "fullyQualifiedName": "mydb.public.customers",
  "displayName": "Customers Table"
}
```

#### Metadata

- **description** (`markdown`): Rich text description
- **owner** (`EntityReference`): Entity owner
- **tags** (`TagLabel[]`): Classification tags
- **version** (`number`): Entity version for change tracking
- **updatedAt** (`timestamp`): Last modification time
- **updatedBy** (`string`): User who made the change
- **href** (`URI`): API endpoint for the entity

#### Relationships

- References to related entities (database, service, etc.)
- Collections of child entities (columns, fields, etc.)

### Entity Types

#### Data Assets

Physical data containers:

- **Table**: Database tables and views
- **Topic**: Message queue topics
- **Dashboard**: BI dashboards
- **Chart**: Visualizations
- **Pipeline**: Data pipelines
- **MLModel**: ML models
- **Container**: Object storage containers

#### Services

Connections to external systems:

- **DatabaseService**: Postgres, MySQL, Snowflake, etc.
- **MessagingService**: Kafka, Pulsar, etc.
- **DashboardService**: Tableau, Looker, etc.
- **PipelineService**: Airflow, Prefect, etc.
- **MLModelService**: MLflow, SageMaker, etc.
- **StorageService**: S3, GCS, ADLS, etc.

#### Organizational

People and teams:

- **User**: Individual users
- **Team**: Groups of users
- **Role**: Permission roles
- **Persona**: User archetypes

#### Governance

Metadata governance:

- **Glossary**: Business glossaries
- **GlossaryTerm**: Business terminology
- **Tag**: Classification tags
- **Policy**: Access and governance policies
- **Classification**: Tag hierarchies

## Relationships

Entities are connected through typed relationships.

### Relationship Types

#### Containment

Hierarchical parent-child relationships:

```
DatabaseService
  └── Database
        └── Schema
              └── Table
                    └── Column
```

#### Ownership

Who owns what:

```
Team owns Dashboard
User owns Table
```

#### Usage

What uses what:

```
Dashboard uses Table
Pipeline uses Table
Query produces Table
```

#### Derivation

Data lineage:

```
Table derives from Table
Column derives from Column
```

### Entity References

Relationships are represented using `EntityReference`:

```json
{
  "id": "uuid-123",
  "type": "user",
  "name": "john.doe",
  "fullyQualifiedName": "john.doe",
  "displayName": "John Doe",
  "href": "https://api.example.com/v1/users/uuid-123"
}
```

Benefits:
- Consistent reference format
- Includes enough info to display without dereferencing
- Provides link to fetch full details

## Type System

OpenMetadata uses a rich type system for schema validation and code generation.

### Basic Types

Defined in `type/basic.json`:

- **uuid**: RFC 4122 UUIDs
- **email**: RFC 5322 email addresses
- **timestamp**: ISO 8601 timestamps
- **duration**: ISO 8601 durations
- **date**: ISO 8601 dates
- **time**: ISO 8601 times
- **markdown**: CommonMark markdown
- **expression**: SQL expressions
- **entityLink**: Entity reference links

### Collection Types

- **Arrays**: Ordered collections
- **Objects**: Key-value maps
- **Entity Reference**: References to other entities
- **Entity Reference List**: Multiple references

### Data Types

SQL and programming language data types:

- **Numeric**: INT, BIGINT, DECIMAL, FLOAT, DOUBLE
- **String**: VARCHAR, CHAR, TEXT
- **Date/Time**: DATE, TIMESTAMP, TIME
- **Boolean**: BOOLEAN
- **Binary**: BINARY, VARBINARY, BLOB
- **JSON**: JSON, JSONB
- **Array**: ARRAY
- **Struct**: STRUCT, ROW
- **Map**: MAP

### Custom Properties

Extend any entity with custom properties:

```json
{
  "name": "customers",
  "customProperties": {
    "department": "Sales",
    "criticality": "high",
    "pii_level": "3"
  }
}
```

Custom properties are:
- Schema-less (no predefined structure)
- Searchable and filterable
- Type-safe when using property definitions

## Versioning & Change Tracking

Every entity has built-in versioning and change tracking.

### Version Numbers

- Incremented on every change
- Used for optimistic locking
- Enables conflict detection

### Change Description

Track what changed:

```json
{
  "changeDescription": {
    "fieldsAdded": [
      {
        "name": "tags",
        "newValue": "[{\"tagFQN\": \"PII.Email\"}]"
      }
    ],
    "fieldsUpdated": [
      {
        "name": "description",
        "oldValue": "Old description",
        "newValue": "New description"
      }
    ],
    "fieldsDeleted": []
  }
}
```

### Soft Deletes

Entities are soft-deleted by default:

- **deleted**: Boolean flag
- **updatedAt**: Deletion timestamp
- **updatedBy**: Who deleted it

Can be restored with full history.

## Tags & Classifications

Organize and classify entities using tags.

### Tag Structure

```
PII
├── Sensitive
│   ├── SSN
│   └── CreditCard
└── NonSensitive
    ├── Email
    └── Phone
```

### Tag Usage

Apply tags to entities:

```json
{
  "name": "customers",
  "tags": [
    {
      "tagFQN": "PII.Sensitive.Email",
      "source": "Classification",
      "labelType": "Manual"
    }
  ]
}
```

Tags can be:
- **Manual**: Applied by users
- **Automated**: Applied by rules
- **Propagated**: Inherited from parents

## Glossaries

Define business terminology.

### Glossary Terms

```json
{
  "name": "Customer",
  "fullyQualifiedName": "BusinessGlossary.Customer",
  "displayName": "Customer",
  "description": "An individual or organization that purchases our products",
  "synonyms": ["Client", "Consumer", "Buyer"],
  "relatedTerms": [
    {
      "fullyQualifiedName": "BusinessGlossary.Account"
    }
  ],
  "reviewers": [
    {
      "id": "uuid-123",
      "type": "user",
      "name": "jane.smith"
    }
  ],
  "status": "Approved"
}
```

### Term Relationships

- **Synonyms**: Alternative names
- **Related Terms**: Conceptually related
- **Is-A**: Hierarchy (Customer is-a Person)
- **Part-Of**: Composition (Address is part-of Customer)

## Data Quality

Define and track data quality.

### Test Cases

```json
{
  "name": "column_values_not_null",
  "displayName": "Email should not be null",
  "entityLink": "<#E::table::mydb.public.customers::columns::email>",
  "testDefinition": {
    "name": "columnValuesToBeNotNull"
  },
  "parameterValues": [
    {
      "name": "columnName",
      "value": "email"
    }
  ]
}
```

### Test Suites

Group related tests:

```json
{
  "name": "customers_quality_suite",
  "displayName": "Customers Table Quality Suite",
  "tests": [
    "test_email_not_null",
    "test_email_format",
    "test_customer_id_unique"
  ]
}
```

### Test Results

Track test execution:

```json
{
  "timestamp": "2024-01-15T10:00:00Z",
  "testCaseStatus": "Failed",
  "result": "Found 15 null values in email column",
  "sampleData": ["row_id_123", "row_id_456"]
}
```

## Lineage

Track data flow through the system.

### Column-Level Lineage

```json
{
  "edge": {
    "fromEntity": {
      "id": "source-table-uuid",
      "type": "table",
      "fqn": "source.schema.customers"
    },
    "toEntity": {
      "id": "target-table-uuid",
      "type": "table",
      "fqn": "target.schema.dim_customers"
    },
    "lineageDetails": {
      "columnsLineage": [
        {
          "fromColumns": ["customers.email"],
          "toColumn": "dim_customers.customer_email"
        }
      ],
      "sqlQuery": "INSERT INTO dim_customers SELECT email as customer_email FROM customers",
      "pipeline": {
        "id": "pipeline-uuid",
        "type": "pipeline"
      }
    }
  }
}
```

### Lineage Graphs

Build complete lineage graphs:

```
Source Table
    ↓
  Pipeline A
    ↓
Staging Table
    ↓
  Pipeline B
    ↓
Analytics Table
    ↓
Dashboard
```

## Events & Notifications

Real-time notifications for metadata changes.

### Event Types

- **entityCreated**: New entity
- **entityUpdated**: Modified entity
- **entityDeleted**: Deleted entity
- **entityRestored**: Restored entity

### Event Payload

```json
{
  "eventType": "entityUpdated",
  "entity": {
    "id": "uuid-123",
    "type": "table",
    "fullyQualifiedName": "mydb.public.customers"
  },
  "previousVersion": 1.2,
  "currentVersion": 1.3,
  "changeDescription": {
    "fieldsUpdated": [...]
  },
  "timestamp": "2024-01-15T10:00:00Z",
  "userName": "john.doe"
}
```

### Webhooks

Subscribe to events:

```json
{
  "name": "slack_notifications",
  "endpoint": "https://hooks.slack.com/services/xxx",
  "eventFilters": [
    {
      "entityType": "table",
      "eventType": "entityUpdated",
      "filters": [
        {
          "field": "tags",
          "condition": "matchAny",
          "values": ["PII.Sensitive"]
        }
      ]
    }
  ]
}
```

## Next Steps

- [Use Cases](use-cases.md) - See real-world examples
- [Schema Reference](../schemas/overview.md) - Explore the schemas
- [RDF & Ontologies](../rdf/overview.md) - Learn about semantic web features
