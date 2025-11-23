
# Ontology Core Concepts

Core concepts in the OpenMetadata ontology.

## Entity Hierarchy

```turtle
om:Entity
  ├── om:DataAsset
  │   ├── om:Table
  │   ├── om:Dashboard
  │   └── om:Pipeline
  ├── om:Service
  └── om:Team
```

## Relationships

Entities are connected through object properties.

## Related Documentation
- [Introduction](introduction.md)
- [Classes](classes.md)
