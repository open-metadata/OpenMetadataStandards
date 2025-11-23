
# Custom Properties

Extending entities with custom metadata properties.

## Overview

Custom properties allow organizations to extend OpenMetadata schemas with additional fields specific to their needs.

## Custom Property Definition

**Schema**: `type/customProperty.json`

Define a custom property:

```json
{
  "name": "dataClassification",
  "description": "Internal data classification level",
  "propertyType": {
    "name": "enum",
    "values": ["Public", "Internal", "Confidential", "Restricted"]
  }
}
```

## Property Types

### String

```json
{
  "name": "projectCode",
  "propertyType": {
    "name": "string"
  }
}
```

### Integer

```json
{
  "name": "retentionDays",
  "propertyType": {
    "name": "integer"
  }
}
```

### Enum

```json
{
  "name": "criticality",
  "propertyType": {
    "name": "enum",
    "values": ["Low", "Medium", "High", "Critical"]
  }
}
```

### Markdown

```json
{
  "name": "processingNotes",
  "propertyType": {
    "name": "markdown"
  }
}
```

### Entity Reference

```json
{
  "name": "dataOwnerTeam",
  "propertyType": {
    "name": "entityReference",
    "entityType": "team"
  }
}
```

## Using Custom Properties

### On Tables

```json
{
  "name": "customers",
  "customProperties": {
    "dataClassification": "Confidential",
    "projectCode": "CRM-2024",
    "retentionDays": 2555
  }
}
```

### On Dashboards

```json
{
  "name": "sales_dashboard",
  "customProperties": {
    "refreshFrequency": "hourly",
    "businessUnit": "Sales"
  }
}
```

## Entity Extension

Add custom properties to entity types:

```json
{
  "entityType": "table",
  "customProperties": [
    {
      "name": "costCenter",
      "propertyType": {"name": "string"}
    },
    {
      "name": "dataRetentionPolicy",
      "propertyType": {"name": "enum", "values": ["30days", "90days", "1year", "indefinite"]}
    }
  ]
}
```

## Best Practices

1. **Naming**: Use camelCase
2. **Types**: Choose appropriate types
3. **Validation**: Use enums for controlled values
4. **Documentation**: Always add descriptions
5. **Consistency**: Use same properties across similar entities
6. **Migration**: Plan for property evolution

## Related Documentation

- [Basic Types](basic-types.md)
- [Collection Types](collection-types.md)
- [Entity Schemas](../entity/index.md)
