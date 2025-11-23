
# Standards & Specifications

OpenMetadata Standards builds on established open standards and industry best practices.

## JSON Schema Standards

### JSON Schema Version

OpenMetadata schemas use **JSON Schema Draft-07** as the primary version, with migration to **Draft 2020-12** in progress.

**Key features used:**

- `$schema` - Schema version declaration
- `$ref` - Schema composition and reuse
- `$id` - Schema identification
- `definitions` - Reusable schema components
- `type`, `properties`, `required` - Basic validation
- `pattern`, `minLength`, `maxLength` - String validation
- `minimum`, `maximum` - Numeric validation
- `format` - Semantic validation (email, uri, date-time)

**Example:**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "$id": "https://open-metadata.org/schema/entity/data/table.json",
  "title": "Table",
  "description": "Schema for database table entity",
  "type": "object",
  "properties": {
    "id": {
      "$ref": "../../type/basic.json#/definitions/uuid"
    }
  },
  "required": ["id", "name"]
}
```

### Schema Organization

Schemas are organized hierarchically:

- **Entities** (`entity/`): Complete object definitions
- **Types** (`type/`): Reusable type definitions
- **Common patterns**: Shared across schemas via `$ref`

### Validation Rules

All schemas include comprehensive validation:

- **Required fields**: Essential properties
- **Data types**: Strict type checking
- **Constraints**: Length, range, pattern matching
- **Formats**: Email, URI, UUID, timestamp
- **Enumerations**: Fixed value sets

## RDF/OWL Standards

### RDF 1.1

OpenMetadata ontologies conform to [W3C RDF 1.1](https://www.w3.org/RDF/):

- **Triple model**: Subject-Predicate-Object
- **URIs**: Persistent identifiers for resources
- **Literals**: Data values with types
- **Blank nodes**: Anonymous resources

**Serialization formats:**

- **Turtle** (`.ttl`) - Primary format (human-readable)
- **RDF/XML** - XML serialization
- **N-Triples** - Line-based format
- **JSON-LD** - JSON-based RDF

### OWL 2

The OpenMetadata Ontology uses [OWL 2](https://www.w3.org/TR/owl2-overview/) features:

- **Classes**: Entity type definitions
- **Properties**: Relationships and attributes
- **Object Properties**: Entity-to-entity relationships
- **Datatype Properties**: Entity-to-value relationships
- **Class hierarchies**: `rdfs:subClassOf`
- **Property hierarchies**: `rdfs:subPropertyOf`
- **Domain and Range**: Property constraints
- **Inverse Properties**: Bidirectional relationships

**Example:**

```turtle
om:Table a owl:Class ;
    rdfs:subClassOf om:DataAsset ;
    rdfs:label "Table" ;
    rdfs:comment "Database table or view" .

om:contains a owl:ObjectProperty ;
    rdfs:domain om:Database ;
    rdfs:range om:Table ;
    owl:inverseOf om:belongsTo .
```

### RDFS

Uses [RDF Schema](https://www.w3.org/TR/rdf-schema/) for:

- `rdfs:Class` - Class definitions
- `rdfs:Property` - Property definitions
- `rdfs:subClassOf` - Class hierarchies
- `rdfs:subPropertyOf` - Property hierarchies
- `rdfs:domain` - Property subjects
- `rdfs:range` - Property objects
- `rdfs:label` - Human-readable names
- `rdfs:comment` - Documentation

## SHACL Standards

### SHACL Core

OpenMetadata shapes use [W3C SHACL](https://www.w3.org/TR/shacl/):

**Node Shapes:**

```turtle
om:TableShape a sh:NodeShape ;
    sh:targetClass om:Table ;
    sh:property [
        sh:path om:name ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
        sh:datatype xsd:string ;
        sh:minLength 1 ;
        sh:maxLength 256 ;
    ] .
```

**Property Shapes:**

- `sh:minCount`, `sh:maxCount` - Cardinality
- `sh:datatype` - Data type constraints
- `sh:class` - Object type constraints
- `sh:pattern` - Regular expressions
- `sh:minLength`, `sh:maxLength` - String length
- `sh:minInclusive`, `sh:maxInclusive` - Numeric ranges

**Validation:**

- `sh:severity` - Violation, Warning, Info
- `sh:message` - Custom error messages
- Automatic validation reports

## JSON-LD Standards

### JSON-LD 1.1

JSON-LD contexts conform to [JSON-LD 1.1](https://www.w3.org/TR/json-ld11/):

**Context features:**

- **@context**: Context definitions
- **@type**: Type coercion
- **@id**: URI mapping
- **@vocab**: Default vocabulary
- **@base**: Base URI
- **@language**: Language tags

**Example context:**

```json
{
  "@context": {
    "@vocab": "http://open-metadata.org/ontology#",
    "name": "http://schema.org/name",
    "owner": {
      "@id": "http://open-metadata.org/ontology#owner",
      "@type": "@id"
    },
    "tags": {
      "@id": "http://open-metadata.org/ontology#tag",
      "@container": "@set"
    }
  }
}
```

### Semantic Mapping

JSON-LD enables mapping between JSON and RDF:

```json
{
  "@context": "https://open-metadata.org/contexts/dataAsset.jsonld",
  "@id": "https://myorg.com/tables/customers",
  "@type": "Table",
  "name": "customers",
  "owner": "https://myorg.com/users/john"
}
```

Converts to RDF:

```turtle
<https://myorg.com/tables/customers>
    a om:Table ;
    om:name "customers" ;
    om:owner <https://myorg.com/users/john> .
```

## PROV-O Standards

### W3C PROV-O

Lineage tracking uses [PROV-O](https://www.w3.org/TR/prov-o/):

**Core classes:**

- `prov:Entity` - Data and artifacts
- `prov:Activity` - Processes and actions
- `prov:Agent` - People, systems, organizations

**Core properties:**

- `prov:wasDerivedFrom` - Entity derivation
- `prov:wasGeneratedBy` - Activity generation
- `prov:used` - Activity usage
- `prov:wasAssociatedWith` - Agent association
- `prov:wasAttributedTo` - Entity attribution

**Example:**

```turtle
:customers_table a prov:Entity, om:Table ;
    prov:wasDerivedFrom :raw_data ;
    prov:wasGeneratedBy :etl_pipeline ;
    prov:wasAttributedTo :data_team .

:etl_pipeline a prov:Activity, om:Pipeline ;
    prov:used :raw_data ;
    prov:startedAtTime "2024-01-15T10:00:00Z"^^xsd:dateTime .
```

## Industry Standards

### OpenAPI

API schemas can be converted to OpenAPI specifications for REST API documentation.

### DCAT

Data Catalog Vocabulary ([DCAT](https://www.w3.org/TR/vocab-dcat-2/)) mapping:

- `dcat:Dataset` → `om:Table`
- `dcat:Distribution` → File formats
- `dcat:DataService` → `om:Service`

### Dublin Core

Dublin Core metadata elements:

- `dc:title` → `om:displayName`
- `dc:description` → `om:description`
- `dc:creator` → `om:owner`
- `dc:created` → `om:createdAt`

### Schema.org

Schema.org vocabulary integration:

- `schema:name` → `om:name`
- `schema:description` → `om:description`
- `schema:author` → `om:owner`

## Compliance & Regulations

### GDPR Compliance

Support for GDPR requirements:

- **Data inventory**: Catalog all personal data
- **Purpose tracking**: Record processing purposes
- **Consent tracking**: Link to consent records
- **Right to erasure**: Soft delete with restoration
- **Data lineage**: Track data flow
- **Access controls**: Policy-based access

**Tags for GDPR:**

```json
{
  "classification": "GDPR",
  "tags": [
    "GDPR.PersonalData",
    "GDPR.SensitiveData",
    "GDPR.ConsentRequired"
  ]
}
```

### CCPA Compliance

California Consumer Privacy Act support:

- Personal information inventory
- Data selling tracking
- Consumer rights management
- Opt-out tracking

### HIPAA Compliance

Healthcare data protection:

- PHI (Protected Health Information) tagging
- Access audit trails
- Encryption metadata
- Minimum necessary tracking

### SOC 2 Compliance

Service Organization Control compliance:

- Access control documentation
- Change tracking
- Audit logging
- Data classification

## Best Practices

### Schema Versioning

- Semantic versioning (MAJOR.MINOR.PATCH)
- Backward compatibility maintenance
- Deprecation notices
- Migration guides

### URI Design

- Persistent URIs
- Dereferenceable URIs
- Content negotiation
- HTTP URI scheme

### Validation Strategy

1. JSON Schema validation for structure
2. SHACL validation for semantics
3. Custom business rules
4. Continuous validation

### Interoperability

- Standard vocabularies where possible
- Clear namespace management
- Documented extensions
- Example data and mappings

## Version History

### Current Version: 1.0.0

- Initial release of schemas
- Complete entity coverage
- RDF ontology and SHACL shapes
- JSON-LD contexts

### Roadmap

- JSON Schema 2020-12 migration
- Enhanced SHACL constraints
- Additional JSON-LD contexts
- DCAT alignment
- Schema.org mappings

## Resources

- [JSON Schema Specification](https://json-schema.org/)
- [RDF 1.1 Primer](https://www.w3.org/TR/rdf11-primer/)
- [OWL 2 Primer](https://www.w3.org/TR/owl2-primer/)
- [SHACL Specification](https://www.w3.org/TR/shacl/)
- [JSON-LD 1.1](https://www.w3.org/TR/json-ld11/)
- [PROV-O](https://www.w3.org/TR/prov-o/)
