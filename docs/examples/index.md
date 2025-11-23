
# Examples

Practical examples demonstrating OpenMetadata Standards usage.

## Quick Examples

### Table Metadata

```json
{
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "name": "customers",
  "fullyQualifiedName": "postgres_prod.public.customers",
  "description": "Customer master data table",
  "tableType": "Regular",
  "columns": [
    {
      "name": "customer_id",
      "dataType": "BIGINT",
      "description": "Primary key",
      "constraint": "PRIMARY_KEY"
    },
    {
      "name": "email",
      "dataType": "VARCHAR",
      "dataLength": 255,
      "tags": [{"tagFQN": "PII.Email"}]
    }
  ],
  "owner": {
    "id": "user-123",
    "type": "user",
    "name": "john.doe"
  }
}
```

### Dashboard Metadata

```json
{
  "id": "dashboard-001",
  "name": "sales_overview",
  "displayName": "Sales Overview Dashboard",
  "dashboardType": "Dashboard",
  "charts": [
    {
      "id": "chart-001",
      "type": "chart",
      "name": "revenue_by_region"
    }
  ],
  "service": {
    "id": "tableau-prod",
    "type": "dashboardService"
  }
}
```

### Pipeline Metadata

```json
{
  "id": "pipeline-001",
  "name": "daily_etl",
  "displayName": "Daily ETL Pipeline",
  "pipelineType": "ETL",
  "tasks": [
    {
      "name": "extract_data",
      "taskType": "SQL"
    },
    {
      "name": "transform_data",
      "taskType": "Python"
    }
  ]
}
```

## More Examples

- [Basic Examples](basic.md) - Simple, straightforward examples
- [Advanced Examples](advanced.md) - Complex use cases
- [Integration Examples](integration.md) - Real-world integrations

## Example Repository

Find more examples in the `/examples` directory of the repository.
