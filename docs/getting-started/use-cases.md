
# Use Cases

Real-world applications of OpenMetadata Standards.

## Data Catalog

Build a comprehensive, searchable data catalog.

### Challenge

Organizations struggle with:
- Fragmented metadata across multiple tools
- No centralized search for data assets
- Difficulty discovering relevant datasets
- Lack of context about data quality and ownership

### Solution with OpenMetadata Standards

Use entity schemas to catalog all data assets:

```json
{
  "@context": "https://open-metadata.org/contexts/dataAsset.jsonld",
  "@type": "Table",
  "name": "customer_transactions",
  "fullyQualifiedName": "analytics.public.customer_transactions",
  "description": "Daily customer transaction records",
  "owner": {
    "type": "team",
    "name": "data-engineering"
  },
  "tags": [
    {"tagFQN": "Finance.Revenue"},
    {"tagFQN": "PII.Transactional"}
  ],
  "columns": [...],
  "tableProfile": {
    "rowCount": 1500000,
    "sizeInBytes": 850000000
  },
  "dataQualityTests": [
    {
      "name": "no_null_transaction_ids",
      "status": "Success"
    }
  ]
}
```

### Benefits

- Single source of truth for all data assets
- Rich search with faceted filtering
- Clear ownership and lineage
- Data quality visibility

## Data Governance

Implement enterprise-wide data governance.

### Challenge

- Ensuring compliance with regulations (GDPR, CCPA, HIPAA)
- Tracking sensitive data (PII, PHI)
- Enforcing access controls
- Maintaining audit trails

### Solution with OpenMetadata Standards

**1. Define Classifications and Tags**

```json
{
  "name": "PII",
  "displayName": "Personally Identifiable Information",
  "description": "Data that can identify individuals",
  "children": [
    {
      "name": "PII.Sensitive",
      "tags": [
        "PII.Sensitive.SSN",
        "PII.Sensitive.CreditCard",
        "PII.Sensitive.HealthRecord"
      ]
    },
    {
      "name": "PII.NonSensitive",
      "tags": [
        "PII.NonSensitive.Email",
        "PII.NonSensitive.Phone"
      ]
    }
  ]
}
```

**2. Apply Tags to Assets**

```json
{
  "name": "customers",
  "columns": [
    {
      "name": "email",
      "dataType": "VARCHAR",
      "tags": [{"tagFQN": "PII.NonSensitive.Email"}]
    },
    {
      "name": "ssn",
      "dataType": "VARCHAR",
      "tags": [{"tagFQN": "PII.Sensitive.SSN"}]
    }
  ]
}
```

**3. Define Policies**

```json
{
  "name": "PII_Access_Policy",
  "policyType": "AccessControl",
  "rules": [
    {
      "name": "restrict_sensitive_pii",
      "effect": "deny",
      "resources": ["tag:PII.Sensitive.*"],
      "operations": ["ViewAll"],
      "condition": "!hasRole('DataSteward')"
    }
  ]
}
```

### Benefits

- Automated compliance tracking
- Clear visibility into sensitive data
- Enforced access controls
- Complete audit trail

## Data Lineage

Track end-to-end data flow.

### Challenge

- Understanding data origins
- Tracking transformations
- Impact analysis for changes
- Debugging data quality issues

### Solution with OpenMetadata Standards

**Use PROV-O for lineage tracking:**

```turtle
@prefix prov: <http://www.w3.org/ns/prov#> .
@prefix om: <http://open-metadata.org/ontology#> .

# Source data
:raw_customers a prov:Entity, om:Table ;
    om:name "raw_customers" ;
    om:database :staging_db .

# ETL Pipeline
:customer_etl a prov:Activity, om:Pipeline ;
    prov:startedAtTime "2024-01-15T10:00:00Z"^^xsd:dateTime ;
    prov:endedAtTime "2024-01-15T10:30:00Z"^^xsd:dateTime ;
    prov:wasAssociatedWith :data_engineering_team ;
    prov:used :raw_customers .

# Derived table
:dim_customers a prov:Entity, om:Table ;
    om:name "dim_customers" ;
    om:database :analytics_db ;
    prov:wasDerivedFrom :raw_customers ;
    prov:wasGeneratedBy :customer_etl .

# Dashboard usage
:sales_dashboard a om:Dashboard ;
    prov:used :dim_customers .
```

**Column-level lineage:**

```json
{
  "edge": {
    "fromEntity": {
      "fqn": "staging.raw_customers",
      "type": "table"
    },
    "toEntity": {
      "fqn": "analytics.dim_customers",
      "type": "table"
    },
    "lineageDetails": {
      "pipeline": {"fqn": "airflow.customer_etl"},
      "columnsLineage": [
        {
          "fromColumns": ["raw_customers.email"],
          "toColumn": "dim_customers.customer_email"
        },
        {
          "fromColumns": [
            "raw_customers.first_name",
            "raw_customers.last_name"
          ],
          "toColumn": "dim_customers.full_name",
          "function": "CONCAT(first_name, ' ', last_name)"
        }
      ]
    }
  }
}
```

### Benefits

- Complete visibility into data flow
- Impact analysis for changes
- Root cause analysis for data issues
- Regulatory compliance (audit trails)

## Data Quality

Define and monitor data quality.

### Challenge

- Ensuring data accuracy and completeness
- Detecting data anomalies
- Monitoring SLAs
- Preventing downstream failures

### Solution with OpenMetadata Standards

**Define test cases:**

```json
{
  "name": "email_not_null",
  "testDefinition": "columnValuesToBeNotNull",
  "entityLink": "<#E::table::mydb.customers::columns::email>",
  "parameterValues": [
    {"name": "columnName", "value": "email"}
  ]
}
```

**Create test suites:**

```json
{
  "name": "customers_critical_tests",
  "executableEntityReference": {
    "type": "table",
    "fullyQualifiedName": "mydb.customers"
  },
  "tests": [
    "email_not_null",
    "email_valid_format",
    "customer_id_unique",
    "revenue_positive"
  ]
}
```

**Track results:**

```json
{
  "testCase": "email_not_null",
  "timestamp": "2024-01-15T14:00:00Z",
  "testCaseStatus": "Failed",
  "result": "Found 42 null values",
  "sampleData": [
    "customer_id=1001",
    "customer_id=1042"
  ],
  "incidentId": "INC-2024-001"
}
```

### Benefits

- Proactive quality monitoring
- Automated testing
- Clear quality metrics
- Integration with alerting

## Knowledge Graph

Build enterprise knowledge graphs.

### Challenge

- Connecting disparate data sources
- Discovering relationships
- Semantic search
- Knowledge discovery

### Solution with OpenMetadata Standards

**Convert metadata to RDF:**

```python
from rdflib import Graph
import json

# Load JSON-LD with context
metadata = {
    "@context": "https://open-metadata.org/contexts/dataAsset.jsonld",
    "@id": "https://myorg.com/tables/customers",
    "@type": "Table",
    "name": "customers",
    "owner": {
        "@id": "https://myorg.com/teams/data-engineering",
        "@type": "Team"
    },
    "relatedTerms": [
        {
            "@id": "https://myorg.com/glossary/Customer",
            "@type": "GlossaryTerm"
        }
    ]
}

# Parse as RDF
g = Graph()
g.parse(data=json.dumps(metadata), format='json-ld')

# Load into triple store
# ... upload to GraphDB, Stardog, etc.
```

**Query with SPARQL:**

```sparql
PREFIX om: <http://open-metadata.org/ontology#>
PREFIX org: <https://myorg.com/>

SELECT ?table ?owner ?term
WHERE {
  ?table a om:Table ;
         om:owner ?owner ;
         om:relatedTerm ?term .

  ?owner a om:Team ;
         om:name "data-engineering" .

  ?term a om:GlossaryTerm .
}
```

### Benefits

- Semantic understanding of metadata
- Relationship discovery
- Enhanced search capabilities
- Integration with enterprise knowledge bases

## ML Model Management

Track ML models and features.

### Challenge

- Model versioning and lineage
- Feature engineering tracking
- Model performance monitoring
- Reproducibility

### Solution with OpenMetadata Standards

```json
{
  "name": "customer_churn_predictor_v2",
  "algorithm": "XGBoost",
  "mlFeatures": [
    {
      "name": "customer_lifetime_value",
      "dataType": "numerical",
      "featureSources": [
        {
          "dataSource": "analytics.customer_metrics",
          "dataType": "table"
        }
      ]
    }
  ],
  "mlHyperParameters": [
    {"name": "max_depth", "value": "6"},
    {"name": "learning_rate", "value": "0.1"}
  ],
  "dashboard": {
    "type": "dashboard",
    "fullyQualifiedName": "mlflow.model_monitoring"
  },
  "version": "2.1.0"
}
```

### Benefits

- Complete model lineage
- Feature provenance
- Performance tracking
- Experiment reproducibility

## Multi-Cloud Metadata

Unify metadata across cloud platforms.

### Challenge

- Data distributed across AWS, Azure, GCP
- Different metadata formats
- No unified catalog
- Difficult to track cross-cloud lineage

### Solution with OpenMetadata Standards

Define services for each cloud:

```json
{
  "name": "aws_s3_prod",
  "serviceType": "S3",
  "connection": {
    "awsRegion": "us-east-1"
  }
}
```

```json
{
  "name": "azure_adls_prod",
  "serviceType": "ADLS",
  "connection": {
    "accountName": "myorgstorage"
  }
}
```

Catalog assets with unified schema:

```json
{
  "name": "customer_data",
  "containerType": "Bucket",
  "service": {
    "type": "storageService",
    "name": "aws_s3_prod"
  },
  "dataModel": {
    "columns": [...]
  }
}
```

### Benefits

- Unified view across clouds
- Consistent metadata format
- Cross-cloud lineage tracking
- Cloud-agnostic tooling

## Next Steps

- [Schema Reference](../schemas/overview.md) - Explore schemas for your use case
- [Examples](../examples/index.md) - See detailed examples
- [RDF & Ontologies](../rdf/overview.md) - Learn about semantic capabilities
