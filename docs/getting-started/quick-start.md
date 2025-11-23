
# Quick Start Guide

Get started with OpenMetadata Standards in minutes.

## Installation

### Using the Schemas

The JSON schemas are available in the `schemas/` directory of this repository.

```bash
# Clone the repository
git clone https://github.com/open-metadata/OpenMetadataStandards.git
cd OpenMetadataStandards
```

### Validate JSON Against Schemas

Using Python with `jsonschema`:

```bash
pip install jsonschema
```

```python
import json
import jsonschema

# Load the schema
with open('schemas/entity/data/table.json') as f:
    schema = json.load(f)

# Load your data
with open('my-table-metadata.json') as f:
    data = json.load(f)

# Validate
try:
    jsonschema.validate(instance=data, schema=schema)
    print("Valid!")
except jsonschema.ValidationError as e:
    print(f"Validation error: {e.message}")
```

Using JavaScript with `ajv`:

```bash
npm install ajv
```

```javascript
const Ajv = require('ajv');
const fs = require('fs');

const ajv = new Ajv();

// Load the schema
const schema = JSON.parse(fs.readFileSync('schemas/entity/data/table.json'));

// Load your data
const data = JSON.parse(fs.readFileSync('my-table-metadata.json'));

// Validate
const validate = ajv.compile(schema);
const valid = validate(data);

if (valid) {
  console.log('Valid!');
} else {
  console.log('Validation errors:', validate.errors);
}
```

## Basic Example: Table Metadata

Here's a minimal example of table metadata conforming to the schema:

```json
{
  "id": "uuid-12345",
  "name": "customers",
  "fullyQualifiedName": "mydb.public.customers",
  "displayName": "Customers",
  "description": "Customer master data table",
  "tableType": "Regular",
  "columns": [
    {
      "name": "customer_id",
      "dataType": "BIGINT",
      "dataTypeDisplay": "bigint",
      "description": "Unique customer identifier",
      "ordinalPosition": 1,
      "constraint": "PRIMARY_KEY"
    },
    {
      "name": "email",
      "dataType": "VARCHAR",
      "dataLength": 255,
      "dataTypeDisplay": "varchar(255)",
      "description": "Customer email address",
      "ordinalPosition": 2,
      "tags": [
        {
          "tagFQN": "PII.Email"
        }
      ]
    },
    {
      "name": "created_at",
      "dataType": "TIMESTAMP",
      "dataTypeDisplay": "timestamp",
      "description": "Record creation timestamp",
      "ordinalPosition": 3
    }
  ],
  "database": {
    "id": "uuid-db-001",
    "type": "database",
    "name": "mydb",
    "fullyQualifiedName": "myservice.mydb"
  },
  "databaseSchema": {
    "id": "uuid-schema-001",
    "type": "databaseSchema",
    "name": "public",
    "fullyQualifiedName": "myservice.mydb.public"
  },
  "service": {
    "id": "uuid-service-001",
    "type": "databaseService",
    "name": "myservice"
  },
  "serviceType": "Postgres"
}
```

## Working with RDF/OWL

### Loading the Ontology

Using Python with `rdflib`:

```bash
pip install rdflib
```

```python
from rdflib import Graph

# Load the OpenMetadata ontology
g = Graph()
g.parse('rdf/ontology/openmetadata.ttl', format='turtle')

# Query using SPARQL
query = """
PREFIX om: <http://open-metadata.org/ontology#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?class ?label
WHERE {
  ?class a rdfs:Class .
  ?class rdfs:label ?label .
}
"""

for row in g.query(query):
    print(f"{row.class}: {row.label}")
```

### Validating with SHACL

```python
from rdflib import Graph
from pyshacl import validate

# Load your data graph
data_graph = Graph()
data_graph.parse('my-metadata.ttl', format='turtle')

# Load SHACL shapes
shapes_graph = Graph()
shapes_graph.parse('rdf/shapes/openmetadata-shapes.ttl', format='turtle')

# Validate
conforms, results_graph, results_text = validate(
    data_graph,
    shacl_graph=shapes_graph,
    inference='rdfs',
    abort_on_first=False
)

if conforms:
    print("Data conforms to shapes!")
else:
    print("Validation errors:")
    print(results_text)
```

## Using JSON-LD Contexts

Convert your JSON metadata to linked data:

```json
{
  "@context": "https://open-metadata.org/contexts/dataAsset.jsonld",
  "@type": "Table",
  "@id": "https://myorg.com/metadata/tables/customers",
  "name": "customers",
  "description": "Customer master data",
  "owner": {
    "@id": "https://myorg.com/users/john.doe",
    "@type": "User",
    "name": "John Doe"
  },
  "tags": [
    {
      "@id": "https://myorg.com/tags/PII",
      "name": "PII"
    }
  ]
}
```

## Exploring the Schemas

### Schema Organization

Schemas are organized by category:

```
schemas/
├── entity/          # Core entities (tables, dashboards, etc.)
├── type/            # Reusable type definitions
├── api/             # API request/response schemas
├── events/          # Event schemas
├── configuration/   # Configuration schemas
├── metadataIngestion/ # Ingestion pipeline schemas
├── dataInsight/     # Analytics schemas
├── governance/      # Governance schemas
└── security/        # Security configuration schemas
```

### Finding a Schema

Use the schema reference to find specific schemas:

```bash
# Find all table-related schemas
find schemas -name "*table*.json"

# Search for schemas containing "lineage"
grep -r "lineage" schemas/ | grep ".json:"
```

### Understanding a Schema

Each JSON schema includes:

- **$schema**: JSON Schema version
- **title**: Human-readable name
- **description**: Purpose and usage
- **type**: Schema type (object, array, etc.)
- **properties**: Field definitions
- **required**: Required fields
- **definitions**: Reusable type definitions

Example:

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Table",
  "description": "Schema for database table entity",
  "type": "object",
  "properties": {
    "id": {
      "description": "Unique identifier",
      "$ref": "../../type/basic.json#/definitions/uuid"
    },
    "name": {
      "description": "Table name",
      "type": "string",
      "minLength": 1,
      "maxLength": 256
    }
  },
  "required": ["id", "name"]
}
```

## Code Generation

### Generate TypeScript Types

Using `json-schema-to-typescript`:

```bash
npm install -g json-schema-to-typescript

json2ts schemas/entity/data/table.json -o types/Table.ts
```

### Generate Python Classes

Using `datamodel-code-generator`:

```bash
pip install datamodel-code-generator

datamodel-codegen \
  --input schemas/entity/data/table.json \
  --output models/table.py \
  --input-file-type jsonschema
```

### Generate Java Classes

Using `jsonschema2pojo`:

```bash
jsonschema2pojo \
  --source schemas/entity/data \
  --target java/src/main/java/org/openmetadata/schema \
  --package org.openmetadata.schema.entity.data
```

## Next Steps

- [Core Concepts](core-concepts.md) - Understand the fundamentals
- [Schema Reference](../schemas/overview.md) - Explore all schemas
- [Examples](../examples/index.md) - See more examples
- [Developer Guide](../developer/contributing.md) - Contribute to the project
