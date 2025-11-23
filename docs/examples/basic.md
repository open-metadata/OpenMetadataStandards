
# Basic Examples

Simple examples to get started.

## Table Metadata

```json
{
  "name": "users",
  "description": "User accounts",
  "columns": [
    {
      "name": "id",
      "dataType": "BIGINT",
      "constraint": "PRIMARY_KEY"
    },
    {
      "name": "email",
      "dataType": "VARCHAR",
      "dataLength": 255
    }
  ]
}
```

## Dashboard Metadata

```json
{
  "name": "sales_dashboard",
  "dashboardType": "Dashboard",
  "charts": [
    {
      "name": "revenue_chart",
      "chartType": "Line"
    }
  ]
}
```

## Service Connection

```json
{
  "name": "postgres_prod",
  "serviceType": "Postgres",
  "connection": {
    "host": "db.example.com",
    "port": 5432,
    "database": "analytics"
  }
}
```

## Related Documentation
- [Advanced Examples](advanced.md)
- [Quick Start](../getting-started/quick-start.md)
