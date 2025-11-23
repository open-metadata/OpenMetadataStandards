
# PROV-O Mapping

Mapping OpenMetadata to W3C PROV-O.

## Entity Mapping

```turtle
om:Table rdfs:subClassOf prov:Entity
```

## Activity Mapping

```turtle
om:Pipeline rdfs:subClassOf prov:Activity
```

## Agent Mapping

```turtle
om:User rdfs:subClassOf prov:Agent
```

## Properties

- prov:wasDerivedFrom
- prov:wasGeneratedBy
- prov:used

## Related Documentation
- [Introduction](introduction.md)
- [Lineage](lineage.md)
