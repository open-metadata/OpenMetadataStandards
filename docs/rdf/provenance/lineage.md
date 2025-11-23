
# Lineage Tracking

Data lineage using PROV-O.

## Example

```turtle
:target_table prov:wasDerivedFrom :source_table ;
              prov:wasGeneratedBy :etl_pipeline .

:etl_pipeline prov:used :source_table ;
              prov:wasAssociatedWith :data_eng_team .
```

## Querying Lineage

Use SPARQL to query lineage graphs.

## Related Documentation
- [PROV-O Mapping](prov-o.md)
- [Data Assets](../../schemas/entity/data-assets.md)
