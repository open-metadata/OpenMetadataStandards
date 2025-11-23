# Examples

Practical examples demonstrating OpenMetadata Standards usage across all entity types.

---

## Quick Start Examples

### Table with Full Metadata

```json
{
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "name": "customers",
  "fullyQualifiedName": "postgres_prod.ecommerce.public.customers",
  "description": "# Customer Master Table\n\nContains all customer records with PII data.",
  "tableType": "Regular",
  "columns": [
    {
      "name": "customer_id",
      "dataType": "BIGINT",
      "description": "Unique customer identifier",
      "constraint": "PRIMARY_KEY",
      "ordinalPosition": 1
    },
    {
      "name": "email",
      "dataType": "VARCHAR",
      "dataLength": 255,
      "description": "Customer email address",
      "tags": [
        {"tagFQN": "PII.Email"},
        {"tagFQN": "Tier.Gold"}
      ],
      "ordinalPosition": 2
    },
    {
      "name": "created_at",
      "dataType": "TIMESTAMP",
      "description": "Account creation timestamp",
      "ordinalPosition": 3
    },
    {
      "name": "total_purchases",
      "dataType": "DECIMAL",
      "precision": 10,
      "scale": 2,
      "description": "Lifetime purchase amount",
      "ordinalPosition": 4
    }
  ],
  "tableConstraints": [
    {
      "constraintType": "PRIMARY_KEY",
      "columns": ["customer_id"]
    },
    {
      "constraintType": "UNIQUE",
      "columns": ["email"]
    }
  ],
  "owner": {
    "id": "user-uuid-123",
    "type": "user",
    "name": "jane.doe"
  },
  "tags": [
    {"tagFQN": "BusinessCritical"},
    {"tagFQN": "Governance.Approved"}
  ],
  "domain": {
    "id": "domain-uuid",
    "type": "domain",
    "name": "Customer Data"
  }
}
```

### Dashboard with Charts

```json
{
  "id": "dashboard-uuid-001",
  "name": "sales_overview",
  "displayName": "Sales Overview Dashboard",
  "description": "Executive dashboard showing sales KPIs and trends",
  "dashboardType": "Dashboard",
  "charts": [
    {
      "id": "chart-uuid-001",
      "type": "chart",
      "name": "revenue_by_region",
      "displayName": "Revenue by Region"
    },
    {
      "id": "chart-uuid-002",
      "type": "chart",
      "name": "sales_trend",
      "displayName": "Monthly Sales Trend"
    }
  ],
  "service": {
    "id": "tableau-prod-uuid",
    "type": "dashboardService",
    "name": "tableau_prod"
  },
  "owner": {
    "id": "team-uuid",
    "type": "team",
    "name": "Analytics Team"
  },
  "tags": [
    {"tagFQN": "Tier.Platinum"},
    {"tagFQN": "Department.Sales"}
  ]
}
```

### Data Pipeline

```json
{
  "id": "pipeline-uuid-001",
  "name": "customer_etl",
  "displayName": "Customer Data ETL",
  "description": "Daily ETL pipeline for customer data",
  "pipelineType": "ETL",
  "service": {
    "id": "airflow-prod-uuid",
    "type": "pipelineService",
    "name": "airflow_prod"
  },
  "tasks": [
    {
      "name": "extract_customers",
      "taskType": "PythonOperator",
      "description": "Extract customer data from source database",
      "displayName": "Extract Customers"
    },
    {
      "name": "transform_data",
      "taskType": "SparkSubmitOperator",
      "description": "Transform and clean customer data",
      "downstreamTasks": ["extract_customers"]
    },
    {
      "name": "load_warehouse",
      "taskType": "SQLOperator",
      "description": "Load data into warehouse",
      "downstreamTasks": ["transform_data"]
    }
  ],
  "scheduleInterval": {
    "scheduleExpression": "0 2 * * *",
    "scheduleType": "CRON"
  }
}
```

### Topic (Event Stream)

```json
{
  "id": "topic-uuid-001",
  "name": "user_events",
  "displayName": "User Events Stream",
  "description": "Real-time user activity events",
  "service": {
    "id": "kafka-prod-uuid",
    "type": "messagingService",
    "name": "kafka_prod"
  },
  "partitions": 12,
  "replicationFactor": 3,
  "retentionTime": 604800000,
  "schemaType": "Avro",
  "messageSchema": {
    "schemaText": "{\n  \"type\": \"record\",\n  \"name\": \"UserEvent\",\n  \"fields\": [\n    {\"name\": \"user_id\", \"type\": \"string\"},\n    {\"name\": \"event_type\", \"type\": \"string\"},\n    {\"name\": \"timestamp\", \"type\": \"long\"}\n  ]\n}",
    "schemaFields": [
      {
        "name": "user_id",
        "dataType": "STRING",
        "description": "User identifier",
        "tags": [{"tagFQN": "PII.UserId"}]
      },
      {
        "name": "event_type",
        "dataType": "STRING",
        "description": "Type of user event"
      },
      {
        "name": "timestamp",
        "dataType": "LONG",
        "description": "Event timestamp in milliseconds"
      }
    ]
  }
}
```

### ML Model

```json
{
  "id": "mlmodel-uuid-001",
  "name": "churn_predictor",
  "displayName": "Customer Churn Predictor",
  "description": "XGBoost model predicting customer churn probability",
  "algorithm": "XGBoost",
  "service": {
    "id": "mlflow-prod-uuid",
    "type": "mlmodelService",
    "name": "mlflow_prod"
  },
  "mlFeatures": [
    {
      "name": "days_since_last_purchase",
      "dataType": "integer",
      "description": "Days since customer's last purchase",
      "featureSources": [
        {
          "name": "customer_activity",
          "dataType": "integer"
        }
      ]
    },
    {
      "name": "total_spend",
      "dataType": "numerical",
      "description": "Total lifetime spend"
    },
    {
      "name": "support_tickets",
      "dataType": "integer",
      "description": "Number of support tickets filed"
    }
  ],
  "mlHyperParameters": [
    {"name": "max_depth", "value": "6"},
    {"name": "learning_rate", "value": "0.1"},
    {"name": "n_estimators", "value": "100"}
  ],
  "target": "churned"
}
```

### API Collection & Endpoint

```json
{
  "id": "api-collection-uuid",
  "name": "payments_api",
  "displayName": "Payments API",
  "description": "REST API for payment processing",
  "service": {
    "id": "api-service-uuid",
    "type": "apiService",
    "name": "production_api_gateway"
  },
  "basePath": "/api/v2/payments",
  "apiVersion": {
    "version": "v2",
    "versioningScheme": "URL",
    "deprecated": false
  },
  "authentication": {
    "required": true,
    "methods": ["OAuth2", "APIKey"],
    "scopes": ["payments.read", "payments.write"]
  },
  "rateLimit": {
    "requestsPerMinute": 1000,
    "requestsPerHour": 50000
  }
}
```

### Glossary & Terms

```json
{
  "glossary": {
    "id": "glossary-uuid",
    "name": "BusinessGlossary",
    "displayName": "Business Glossary",
    "description": "Enterprise business terminology",
    "owner": {
      "id": "team-uuid",
      "type": "team",
      "name": "Data Governance"
    },
    "reviewers": [
      {
        "id": "user-uuid-1",
        "type": "user"
      }
    ]
  },
  "term": {
    "id": "term-uuid",
    "name": "Customer",
    "displayName": "Customer",
    "description": "An individual or organization that purchases goods or services",
    "glossary": "BusinessGlossary",
    "synonyms": [
      {"name": "Client", "source": "Business"},
      {"name": "Account", "source": "CRM"}
    ],
    "relatedTerms": [
      {"id": "order-term-uuid", "type": "glossaryTerm"},
      {"id": "revenue-term-uuid", "type": "glossaryTerm"}
    ],
    "status": "Approved"
  }
}
```

### Test Case & Suite

```json
{
  "testSuite": {
    "id": "suite-uuid",
    "name": "customers.testSuite",
    "executableEntityReference": "postgres_prod.ecommerce.public.customers",
    "testCases": []
  },
  "testCase": {
    "id": "testcase-uuid",
    "name": "customers_row_count_check",
    "displayName": "Customer Table Row Count Check",
    "description": "Validates customer table has expected row count",
    "testDefinition": "tableRowCountToBeBetween",
    "entityLink": "<#E::table::postgres_prod.ecommerce.public.customers>",
    "testSuite": "postgres_prod.ecommerce.public.customers.testSuite",
    "parameterValues": [
      {"name": "minValue", "value": "10000"},
      {"name": "maxValue", "value": "50000"}
    ],
    "computePassedFailedRowCount": true
  }
}
```

---

## Example Categories

### [Basic Examples](basic.md)
Simple, straightforward examples for getting started with each entity type.

### [Advanced Examples](advanced.md)
Complex real-world scenarios including:
- Multi-table lineage
- Cross-domain data products
- Complex API integrations
- ML pipelines with feature stores

### [Integration Examples](integration.md)
Real-world integration patterns:
- CI/CD pipelines
- Data quality automation
- Governance workflows
- API automation

---

## Example Repository Structure

```
examples/
├── basic/
│   ├── tables/
│   ├── dashboards/
│   ├── pipelines/
│   └── ...
├── advanced/
│   ├── lineage/
│   ├── data-products/
│   └── ...
└── integration/
    ├── ci-cd/
    ├── governance/
    └── ...
```

---

## Using These Examples

### 1. With the API

```bash
# Create a table using the API
curl -X POST "http://localhost:8585/api/v1/tables" \
  -H "Content-Type: application/json" \
  -d @examples/basic/tables/customers.json
```

### 2. With Python SDK

```python
from metadata.generated.schema.entity.data.table import Table
from metadata.ingestion.ometa.ometa_api import OpenMetadata

# Initialize client
metadata = OpenMetadata(config)

# Create table from example
with open('examples/basic/tables/customers.json') as f:
    table_data = json.load(f)
    table = Table(**table_data)
    metadata.create_or_update(table)
```

### 3. For Testing

Use these examples as fixtures for:
- Unit tests
- Integration tests
- Schema validation
- API testing

---

## Related Documentation

- **[Quick Start Guide](../getting-started/quick-start.md)** - Get started quickly
- **[Core Concepts](../getting-started/core-concepts.md)** - Understand the basics
- **[API Operations](../data-assets/databases/table.md#api-operations)** - API reference
- **[Use Cases](../getting-started/use-cases.md)** - Real-world applications
