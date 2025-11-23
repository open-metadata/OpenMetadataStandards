
# RDF & Ontologies Overview

OpenMetadata provides a complete semantic web stack built on W3C standards, enabling knowledge graph integration, semantic reasoning, and linked data capabilities.

## Components

### OpenMetadata Ontology

The core **OpenMetadata Ontology** (`rdf/ontology/openmetadata.ttl`) defines:

- **Classes**: Formal definitions of entity types (Table, Dashboard, Pipeline, etc.)
- **Properties**: Relationships and attributes
- **Hierarchies**: Class and property taxonomies
- **Constraints**: Domain and range restrictions
- **Annotations**: Rich metadata about the ontology itself

**Size**: ~48KB, comprehensive coverage of all OpenMetadata concepts

**Format**: Turtle (TTL) - human-readable RDF syntax

### Provenance Ontology

The **OpenMetadata Provenance Ontology** (`rdf/ontology/openmetadata-prov.ttl`) extends W3C PROV-O for:

- **Data Lineage**: Track data transformations and dependencies
- **Activity Tracking**: Record metadata operations
- **Attribution**: Identify responsible agents (users, systems)
- **Derivation**: Capture how entities are derived from others
- **Usage**: Track which entities were used to create others

**Based on**: [W3C PROV-O](https://www.w3.org/TR/prov-o/)

### SHACL Shapes

The **OpenMetadata SHACL Shapes** (`rdf/shapes/openmetadata-shapes.ttl`) provide:

- **Validation Rules**: Ensure data quality and consistency
- **Constraints**: Cardinality, data types, value ranges
- **Business Rules**: Domain-specific validation logic
- **Quality Checks**: Automated metadata validation

**Based on**: [W3C SHACL](https://www.w3.org/TR/shacl/)

**Size**: ~9KB of validation shapes

### JSON-LD Contexts

**JSON-LD Contexts** (`rdf/contexts/*.jsonld`) enable:

- **Semantic JSON**: Add meaning to JSON data
- **URI Mapping**: Link JSON properties to RDF properties
- **Type Coercion**: Specify data types for properties
- **Language Tags**: Support internationalization
- **Interoperability**: Exchange data with other systems

**Available contexts**:

- `base.jsonld` - Core context definitions
- `dataAsset.jsonld` - Data asset context (basic)
- `dataAsset-complete.jsonld` - Complete data asset context
- `entityRelationship.jsonld` - Relationship context
- `governance.jsonld` - Governance context
- `operations.jsonld` - Operational context
- `quality.jsonld` - Data quality context
- `service.jsonld` - Service context
- `team.jsonld` - Team and user context
- `thread.jsonld` - Discussion thread context

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                      Applications                        │
│  (Knowledge Graphs, Semantic Search, Reasoning)          │
└─────────────────────────────────────────────────────────┘
                           │
┌─────────────────────────────────────────────────────────┐
│                    SPARQL Query Layer                    │
│      (Query metadata using SPARQL endpoints)             │
└─────────────────────────────────────────────────────────┐
                           │
┌─────────────────────────────────────────────────────────┐
│                 SHACL Validation Layer                   │
│         (Validate data against constraints)              │
└─────────────────────────────────────────────────────────┘
                           │
┌─────────────────────────────────────────────────────────┐
│                  JSON-LD Mapping Layer                   │
│        (Convert JSON to RDF using contexts)              │
└─────────────────────────────────────────────────────────┘
                           │
┌─────────────────────────────────────────────────────────┐
│              OpenMetadata Ontology Layer                 │
│    (Semantic definitions, classes, properties)           │
└─────────────────────────────────────────────────────────┘
```

## Use Cases

### 1. Knowledge Graph Construction

Build enterprise knowledge graphs by:

1. Converting JSON metadata to RDF using JSON-LD contexts
2. Loading RDF into a triple store (GraphDB, Stardog, Virtuoso)
3. Querying with SPARQL for insights
4. Running semantic reasoning to infer new knowledge

**Example**: Find all tables containing PII across the organization using semantic queries.

### 2. Semantic Search

Enable semantic search capabilities:

- **Concept-based search**: Find entities by meaning, not just keywords
- **Relationship traversal**: Discover connected entities
- **Faceted browsing**: Navigate by semantic categories
- **Query expansion**: Automatically expand searches using ontology

**Example**: Search for "customer data" finds tables with "client", "consumer", "user" based on ontology relationships.

### 3. Data Lineage & Provenance

Track complete data lineage using PROV-O:

```turtle
:customers_table a prov:Entity ;
    prov:wasDerivedFrom :raw_customer_data ;
    prov:wasGeneratedBy :etl_pipeline_123 ;
    prov:wasAttributedTo :data_engineering_team .

:etl_pipeline_123 a prov:Activity ;
    prov:startedAtTime "2024-01-15T10:00:00Z"^^xsd:dateTime ;
    prov:endedAtTime "2024-01-15T10:30:00Z"^^xsd:dateTime ;
    prov:used :raw_customer_data .
```

### 4. Metadata Validation

Ensure metadata quality using SHACL:

```turtle
:TableShape a sh:NodeShape ;
    sh:targetClass om:Table ;
    sh:property [
        sh:path om:name ;
        sh:minLength 1 ;
        sh:maxLength 256 ;
        sh:pattern "^[a-zA-Z][a-zA-Z0-9_]*$" ;
    ] ;
    sh:property [
        sh:path om:owner ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
        sh:class om:User ;
    ] .
```

### 5. Interoperability

Exchange metadata with other systems:

- **DCAT**: Publish data catalogs
- **Schema.org**: Enhance SEO
- **Dublin Core**: Library systems integration
- **Custom ontologies**: Domain-specific extensions

### 6. Semantic Reasoning

Infer new knowledge automatically:

- **Class hierarchies**: If X is a Table and Table is a DataAsset, then X is a DataAsset
- **Property chains**: If Table A contains Column B and Column B has Tag C, infer relationships
- **Inverse properties**: If User owns Table, then Table is owned by User

## Working with RDF

### Loading Ontologies

Using Python (rdflib):

```python
from rdflib import Graph

# Create a graph
g = Graph()

# Load OpenMetadata ontology
g.parse('rdf/ontology/openmetadata.ttl', format='turtle')

# Load provenance ontology
g.parse('rdf/ontology/openmetadata-prov.ttl', format='turtle')

print(f"Loaded {len(g)} triples")
```

### Querying with SPARQL

```python
query = """
PREFIX om: <http://open-metadata.org/ontology#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?table ?owner
WHERE {
  ?table a om:Table ;
         om:owner ?owner ;
         om:database ?db .
  ?db om:name "production" .
}
"""

results = g.query(query)
for row in results:
    print(f"Table: {row.table}, Owner: {row.owner}")
```

### Converting JSON to RDF

```python
from rdflib import Graph
from rdflib.plugins.parsers.jsonld import JsonLDParser

# Your JSON metadata with context
json_data = {
    "@context": "https://open-metadata.org/contexts/dataAsset.jsonld",
    "@type": "Table",
    "@id": "https://myorg.com/tables/customers",
    "name": "customers",
    "owner": {
        "@id": "https://myorg.com/users/john",
        "name": "John Doe"
    }
}

# Parse as JSON-LD
g = Graph()
g.parse(data=json.dumps(json_data), format='json-ld')

# Now query or export as RDF
print(g.serialize(format='turtle'))
```

### Validating with SHACL

```python
from rdflib import Graph
from pyshacl import validate

# Load data
data_graph = Graph()
data_graph.parse('my-metadata.ttl', format='turtle')

# Load shapes
shapes_graph = Graph()
shapes_graph.parse('rdf/shapes/openmetadata-shapes.ttl', format='turtle')

# Validate
conforms, results_graph, results_text = validate(
    data_graph,
    shacl_graph=shapes_graph,
    inference='rdfs'
)

if not conforms:
    print("Validation errors:")
    print(results_text)
```

## Ontology Structure

### Core Classes

```turtle
om:Entity a rdfs:Class ;
    rdfs:label "Entity" ;
    rdfs:comment "Base class for all OpenMetadata entities" .

om:DataAsset a rdfs:Class ;
    rdfs:subClassOf om:Entity ;
    rdfs:label "Data Asset" .

om:Table a rdfs:Class ;
    rdfs:subClassOf om:DataAsset ;
    rdfs:label "Table" .

om:Dashboard a rdfs:Class ;
    rdfs:subClassOf om:DataAsset ;
    rdfs:label "Dashboard" .
```

### Core Properties

```turtle
om:name a rdf:Property ;
    rdfs:domain om:Entity ;
    rdfs:range xsd:string ;
    rdfs:label "name" .

om:owner a rdf:Property ;
    rdfs:domain om:Entity ;
    rdfs:range om:User ;
    rdfs:label "owner" .

om:contains a rdf:Property ;
    rdfs:domain om:Database ;
    rdfs:range om:Table ;
    rdfs:label "contains" .
```

## Best Practices

### 1. Use Persistent URIs

```turtle
# Good
:table-001 a om:Table ;
    om:name "customers" .

# Better
<https://myorg.com/metadata/tables/customers> a om:Table ;
    om:name "customers" .
```

### 2. Leverage JSON-LD Contexts

Instead of manually converting JSON to RDF, use JSON-LD contexts for automatic mapping.

### 3. Validate Early

Always validate your RDF data against SHACL shapes before loading into production systems.

### 4. Use Standard Vocabularies

Reuse standard vocabularies (PROV-O, DCAT, Dublin Core) where appropriate instead of creating custom properties.

### 5. Document Custom Extensions

If extending the ontology, document your extensions thoroughly with rdfs:comment and examples.

## Integration Patterns

### Triple Store Integration

Load OpenMetadata RDF into enterprise triple stores:

- **Apache Jena** (TDB/Fuseki)
- **GraphDB** (Ontotext)
- **Stardog**
- **Virtuoso**
- **Amazon Neptune**

### Knowledge Graph Platforms

Integrate with knowledge graph platforms:

- **Neo4j** (via neosemantics plugin)
- **TigerGraph**
- **ArangoDB**

### Semantic Search Engines

Power semantic search with:

- **Elasticsearch** (with RDF plugins)
- **Apache Solr**
- **Weaviate**

## Resources

- [OpenMetadata Ontology Documentation](ontology/introduction.md)
- [Provenance Ontology Guide](provenance/introduction.md)
- [SHACL Shapes Reference](shapes/overview.md)
- [JSON-LD Contexts Guide](contexts/overview.md)
- [Best Practices](best-practices.md)

## Standards Compliance

OpenMetadata RDF components comply with:

- **RDF 1.1** - W3C Recommendation
- **OWL 2** - Web Ontology Language
- **SHACL** - Shapes Constraint Language
- **JSON-LD 1.1** - JSON for Linking Data
- **PROV-O** - Provenance Ontology
- **SPARQL 1.1** - Query language
