
# SHACL Validation Rules

Validation constraints using SHACL.

## Example Shape

```turtle
om:TableShape a sh:NodeShape ;
    sh:targetClass om:Table ;
    sh:property [
        sh:path om:name ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
        sh:datatype xsd:string ;
    ] .
```

## Validation

Use SHACL processor to validate data.

## Related Documentation
- [Shapes Overview](overview.md)
