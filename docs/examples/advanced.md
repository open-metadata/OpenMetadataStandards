
# Advanced Examples

Complex usage examples.

## Column-Level Lineage

```json
{
  "edge": {
    "fromEntity": {"fqn": "source.table"},
    "toEntity": {"fqn": "target.table"},
    "lineageDetails": {
      "columnsLineage": [
        {
          "fromColumns": ["source.col1", "source.col2"],
          "toColumn": "target.combined_col",
          "function": "CONCAT(col1, col2)"
        }
      ]
    }
  }
}
```

## Data Quality Suite

```json
{
  "name": "critical_table_tests",
  "tests": [
    {
      "name": "no_nulls_in_key",
      "testDefinition": "columnValuesToBeNotNull",
      "entityLink": "<#E::table::db.schema.table::columns::id>"
    }
  ]
}
```

## Custom Properties

```json
{
  "name": "financial_data",
  "customProperties": {
    "dataClassification": "Confidential",
    "retentionYears": 7,
    "costCenter": "FIN-001"
  }
}
```

## Related Documentation
- [Integration Examples](integration.md)
- [Use Cases](../getting-started/use-cases.md)
