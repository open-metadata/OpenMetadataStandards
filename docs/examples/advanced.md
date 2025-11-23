# Advanced Examples

Complex real-world examples demonstrating advanced OpenMetadata features and patterns.

---

## Multi-Table Lineage with Transformations

Complete lineage graph showing data flow through multiple transformations:

```json
{
  "edges": [
    {
      "fromEntity": {
        "id": "source-customers-uuid",
        "type": "table",
        "fqn": "postgres_prod.raw.source_customers"
      },
      "toEntity": {
        "id": "staging-customers-uuid",
        "type": "table",
        "fqn": "postgres_prod.staging.stg_customers"
      },
      "lineageDetails": {
        "pipeline": {
          "id": "etl-pipeline-uuid",
          "type": "pipeline",
          "name": "customer_data_pipeline"
        },
        "source": "dbt",
        "columnsLineage": [
          {
            "fromColumns": ["postgres_prod.raw.source_customers.customer_id"],
            "toColumn": "postgres_prod.staging.stg_customers.id",
            "function": "CAST(customer_id AS BIGINT)"
          },
          {
            "fromColumns": [
              "postgres_prod.raw.source_customers.first_name",
              "postgres_prod.raw.source_customers.last_name"
            ],
            "toColumn": "postgres_prod.staging.stg_customers.full_name",
            "function": "CONCAT(first_name, ' ', last_name)"
          },
          {
            "fromColumns": ["postgres_prod.raw.source_customers.email"],
            "toColumn": "postgres_prod.staging.stg_customers.email_address",
            "function": "LOWER(TRIM(email))"
          }
        ]
      }
    },
    {
      "fromEntity": {
        "id": "staging-customers-uuid",
        "type": "table",
        "fqn": "postgres_prod.staging.stg_customers"
      },
      "toEntity": {
        "id": "mart-customers-uuid",
        "type": "table",
        "fqn": "postgres_prod.marts.dim_customers"
      },
      "lineageDetails": {
        "pipeline": {
          "id": "etl-pipeline-uuid",
          "type": "pipeline",
          "name": "customer_data_pipeline"
        },
        "columnsLineage": [
          {
            "fromColumns": ["postgres_prod.staging.stg_customers.id"],
            "toColumn": "postgres_prod.marts.dim_customers.customer_key",
            "function": "id"
          },
          {
            "fromColumns": [
              "postgres_prod.staging.stg_customers.full_name",
              "postgres_prod.staging.stg_customers.email_address"
            ],
            "toColumn": "postgres_prod.marts.dim_customers.customer_profile",
            "function": "JSON_BUILD_OBJECT('name', full_name, 'email', email_address)"
          }
        ]
      }
    }
  ]
}
```

---

## Comprehensive Data Quality Suite

Enterprise-grade data quality testing suite with multiple test types:

```json
{
  "testSuite": {
    "id": "enterprise-quality-suite-uuid",
    "name": "enterprise_data_quality",
    "executableEntityReference": null,
    "description": "Enterprise-wide data quality checks"
  },
  "testCases": [
    {
      "id": "test-1-uuid",
      "name": "customers_email_format",
      "displayName": "Customer Email Format Validation",
      "description": "Ensures all customer emails follow valid format",
      "testDefinition": "columnValuesToMatchRegex",
      "entityLink": "<#E::table::postgres_prod.marts.dim_customers::columns::email>",
      "testSuite": "enterprise_data_quality",
      "parameterValues": [
        {
          "name": "regex",
          "value": "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        }
      ],
      "computePassedFailedRowCount": true,
      "owner": {
        "id": "data-quality-team-uuid",
        "type": "team"
      }
    },
    {
      "id": "test-2-uuid",
      "name": "orders_amount_range",
      "displayName": "Order Amount Range Check",
      "description": "Validates order amounts are within expected range",
      "testDefinition": "columnValuesToBeBetween",
      "entityLink": "<#E::table::postgres_prod.marts.fct_orders::columns::order_amount>",
      "testSuite": "enterprise_data_quality",
      "parameterValues": [
        {"name": "minValue", "value": "0.01"},
        {"name": "maxValue", "value": "1000000.00"}
      ],
      "computePassedFailedRowCount": true
    },
    {
      "id": "test-3-uuid",
      "name": "daily_order_count",
      "displayName": "Daily Order Count Anomaly Detection",
      "description": "Detects anomalies in daily order counts",
      "testDefinition": "tableRowCountToBeBetween",
      "entityLink": "<#E::table::postgres_prod.marts.fct_orders>",
      "testSuite": "enterprise_data_quality",
      "parameterValues": [
        {"name": "minValue", "value": "100"},
        {"name": "maxValue", "value": "10000"}
      ]
    },
    {
      "id": "test-4-uuid",
      "name": "customer_id_uniqueness",
      "displayName": "Customer ID Uniqueness",
      "description": "Ensures customer IDs are unique",
      "testDefinition": "columnValuesToBeUnique",
      "entityLink": "<#E::table::postgres_prod.marts.dim_customers::columns::customer_key>",
      "testSuite": "enterprise_data_quality"
    },
    {
      "id": "test-5-uuid",
      "name": "order_date_not_future",
      "displayName": "Order Date Not in Future",
      "description": "Validates order dates are not in the future",
      "testDefinition": "columnValueMaxToBe",
      "entityLink": "<#E::table::postgres_prod.marts.fct_orders::columns::order_date>",
      "testSuite": "enterprise_data_quality",
      "parameterValues": [
        {"name": "maxValue", "value": "CURRENT_DATE"}
      ]
    }
  ]
}
```

---

## Cross-Domain Data Product

Data product spanning multiple domains with comprehensive metadata:

```json
{
  "id": "data-product-uuid",
  "name": "customer_360",
  "displayName": "Customer 360 View",
  "description": "# Customer 360 Data Product\n\nComprehensive customer view combining data from multiple sources and domains.",
  "fullyQualifiedName": "customer_360",
  "domain": {
    "id": "customer-domain-uuid",
    "type": "domain",
    "name": "Customer Experience"
  },
  "experts": [
    {"id": "expert-1-uuid", "type": "user"},
    {"id": "expert-2-uuid", "type": "user"}
  ],
  "owner": {
    "id": "product-team-uuid",
    "type": "team",
    "name": "Customer Analytics Team"
  },
  "assets": [
    {
      "id": "dim-customers-uuid",
      "type": "table",
      "name": "dim_customers",
      "fullyQualifiedName": "postgres_prod.marts.dim_customers"
    },
    {
      "id": "fct-transactions-uuid",
      "type": "table",
      "name": "fct_transactions",
      "fullyQualifiedName": "postgres_prod.marts.fct_transactions"
    },
    {
      "id": "customer-dashboard-uuid",
      "type": "dashboard",
      "name": "customer_insights_dashboard"
    },
    {
      "id": "customer-ml-model-uuid",
      "type": "mlmodel",
      "name": "customer_churn_predictor"
    }
  ],
  "tags": [
    {"tagFQN": "Tier.Platinum"},
    {"tagFQN": "DataProduct.Certified"},
    {"tagFQN": "PII.Contains"}
  ]
}
```

---

## ML Pipeline with Feature Store Integration

Complete ML pipeline with feature engineering and model serving:

```json
{
  "pipeline": {
    "id": "ml-pipeline-uuid",
    "name": "churn_prediction_pipeline",
    "displayName": "Customer Churn Prediction Pipeline",
    "description": "End-to-end ML pipeline for customer churn prediction",
    "pipelineType": "ML",
    "service": {
      "id": "airflow-ml-uuid",
      "type": "pipelineService"
    },
    "tasks": [
      {
        "name": "feature_extraction",
        "taskType": "PythonOperator",
        "description": "Extract features from customer data",
        "sourceUrl": "https://github.com/org/ml-pipelines/blob/main/features.py"
      },
      {
        "name": "feature_store_write",
        "taskType": "PythonOperator",
        "description": "Write features to feature store",
        "downstreamTasks": ["feature_extraction"]
      },
      {
        "name": "model_training",
        "taskType": "PythonOperator",
        "description": "Train XGBoost model",
        "downstreamTasks": ["feature_store_write"]
      },
      {
        "name": "model_evaluation",
        "taskType": "PythonOperator",
        "description": "Evaluate model performance",
        "downstreamTasks": ["model_training"]
      },
      {
        "name": "model_registration",
        "taskType": "PythonOperator",
        "description": "Register model in MLflow",
        "downstreamTasks": ["model_evaluation"]
      }
    ]
  },
  "mlModel": {
    "id": "churn-model-uuid",
    "name": "customer_churn_v2",
    "algorithm": "XGBoost",
    "mlFeatures": [
      {
        "name": "customer_tenure_days",
        "dataType": "integer",
        "description": "Days since customer signup",
        "featureSources": [
          {
            "name": "dim_customers",
            "dataType": "integer",
            "dataSource": {
              "name": "postgres_prod.marts.dim_customers",
              "type": "table"
            }
          }
        ]
      },
      {
        "name": "avg_monthly_spend",
        "dataType": "numerical",
        "description": "Average monthly spend over last 6 months",
        "featureSources": [
          {
            "name": "fct_transactions",
            "dataType": "decimal",
            "dataSource": {
              "name": "postgres_prod.marts.fct_transactions",
              "type": "table"
            }
          }
        ],
        "featureAlgorithm": "AVG(amount) OVER (PARTITION BY customer_id ORDER BY transaction_date ROWS BETWEEN 180 PRECEDING AND CURRENT ROW)"
      },
      {
        "name": "support_ticket_count",
        "dataType": "integer",
        "description": "Number of support tickets in last 90 days",
        "featureSources": [
          {
            "name": "support_tickets",
            "dataType": "integer",
            "dataSource": {
              "name": "zendesk_prod.tickets",
              "type": "table"
            }
          }
        ]
      }
    ],
    "mlHyperParameters": [
      {"name": "max_depth", "value": "8"},
      {"name": "learning_rate", "value": "0.05"},
      {"name": "n_estimators", "value": "200"},
      {"name": "subsample", "value": "0.8"},
      {"name": "colsample_bytree", "value": "0.8"}
    ],
    "mlStore": {
      "storage": "s3://ml-models/churn-prediction/",
      "imageRepository": "ecr.amazonaws.com/churn-model:v2.0"
    },
    "target": "churned_90_days"
  }
}
```

---

##  Complex API Integration with Rate Limiting

API collection with sophisticated authentication and rate limiting:

```json
{
  "apiCollection": {
    "id": "enterprise-api-uuid",
    "name": "enterprise_api_v3",
    "displayName": "Enterprise API v3",
    "basePath": "/api/v3",
    "apiVersion": {
      "version": "3.0.0",
      "versioningScheme": "URL",
      "deprecated": false,
      "releaseDate": "2024-01-15T00:00:00Z",
      "changelog": "https://docs.example.com/api/v3/changelog"
    },
    "authentication": {
      "required": true,
      "methods": ["OAuth2", "APIKey", "JWT"],
      "scopes": [
        "read:customers",
        "write:customers",
        "read:orders",
        "write:orders",
        "admin:all"
      ],
      "oauth2Config": {
        "authorizationUrl": "https://auth.example.com/oauth/authorize",
        "tokenUrl": "https://auth.example.com/oauth/token",
        "refreshUrl": "https://auth.example.com/oauth/refresh"
      }
    },
    "rateLimit": {
      "requestsPerMinute": 1000,
      "requestsPerHour": 50000,
      "requestsPerDay": 1000000,
      "burstLimit": 100,
      "strategy": "sliding_window"
    }
  },
  "apiEndpoints": [
    {
      "name": "create_customer",
      "endpointURL": "/api/v3/customers",
      "httpMethod": "POST",
      "requestSchema": {
        "schemaType": "JSON",
        "contentType": "application/json",
        "schemaDefinition": {
          "type": "object",
          "properties": {
            "email": {"type": "string", "format": "email"},
            "name": {"type": "string", "minLength": 1},
            "metadata": {"type": "object"}
          },
          "required": ["email", "name"]
        }
      },
      "responseSchemas": [
        {
          "statusCode": 201,
          "description": "Customer created successfully",
          "schemaType": "JSON",
          "contentType": "application/json",
          "schemaDefinition": {
            "type": "object",
            "properties": {
              "id": {"type": "string", "format": "uuid"},
              "email": {"type": "string"},
              "created_at": {"type": "string", "format": "date-time"}
            }
          }
        },
        {
          "statusCode": 429,
          "description": "Rate limit exceeded",
          "headers": {
            "X-RateLimit-Limit": "1000",
            "X-RateLimit-Remaining": "0",
            "X-RateLimit-Reset": "1609459200"
          }
        }
      ]
    }
  ]
}
```

---

## Governance Workflow with Approval Process

Complete governance workflow with multi-stage approval:

```json
{
  "glossary": {
    "name": "EnterpriseGlossary",
    "reviewers": [
      {"id": "governance-lead-uuid", "type": "user"},
      {"id": "data-steward-uuid", "type": "user"}
    ],
    "mutuallyExclusive": false
  },
  "terms": [
    {
      "name": "PII_Data",
      "status": "Draft",
      "description": "Personally Identifiable Information requiring special handling",
      "synonyms": [
        {"name": "Personal Data", "source": "GDPR"},
        {"name": "Protected Information", "source": "CCPA"}
      ],
      "references": [
        {
          "name": "GDPR Article 4",
          "endpoint": "https://gdpr-info.eu/art-4-gdpr/"
        },
        {
          "name": "CCPA Definition",
          "endpoint": "https://oag.ca.gov/privacy/ccpa"
        }
      ],
      "reviewers": [
        {"id": "legal-team-uuid", "type": "team"},
        {"id": "compliance-officer-uuid", "type": "user"}
      ]
    }
  ],
  "policy": {
    "name": "pii_data_access_policy",
    "displayName": "PII Data Access Policy",
    "description": "Defines access controls for PII data",
    "policyType": "AccessControl",
    "rules": [
      {
        "name": "restrict_pii_access",
        "description": "Only authorized roles can access PII data",
        "effect": "Deny",
        "resources": [
          "tag:PII.*"
        ],
        "operations": [
          "ViewAll",
          "ViewBasic"
        ],
        "condition": "!hasAnyRole('DataSteward', 'ComplianceOfficer', 'Admin')"
      }
    ],
    "enabled": true
  }
}
```

---

## Related Documentation

- **[Basic Examples](basic.md)** - Simple examples to get started
- **[Integration Examples](integration.md)** - Real-world integration patterns
- **[API Operations](../data-assets/databases/table.md#api-operations)** - Complete API reference
- **[Lineage](../lineage/overview.md)** - Data lineage documentation
- **[Data Quality](../data-quality/overview.md)** - Data quality framework
