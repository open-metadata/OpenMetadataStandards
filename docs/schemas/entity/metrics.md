
# Metrics

Metrics and KPIs in OpenMetadata.

## Overview

Metrics represent business and operational measurements tracked in OpenMetadata.

## Metric Entity

**Schema**: `schemas/entity/data/metrics.json`

### Metric Properties

```json
{
  "id": "uuid",
  "name": "monthly_revenue",
  "displayName": "Monthly Revenue",
  "description": "Total revenue per month",
  "metricType": "SUM",
  "formula": "SUM(order_total)",
  "unitOfMeasurement": "USD",
  "dataSource": {
    "id": "table-uuid",
    "type": "table",
    "name": "orders"
  },
  "granularity": "monthly",
  "owner": {
    "type": "team",
    "name": "Finance"
  }
}
```

## Metric Types

- **Count**: COUNT(*)
- **Sum**: SUM(column)
- **Average**: AVG(column)
- **Min/Max**: MIN/MAX(column)
- **Percentage**: Calculated ratios
- **Custom**: Complex formulas

## Data Insights

Metrics power data insights:
- Usage trends
- Quality scores
- Coverage statistics
- Adoption metrics

## Related Documentation

- [Data Assets](data-assets.md)
- [Data Insights](../dataInsight/index.md)
