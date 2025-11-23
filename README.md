# OpenMetadata Standards

> Comprehensive schemas, ontologies, and specifications for metadata management

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Documentation](https://img.shields.io/badge/docs-latest-brightgreen.svg)](https://openmetadatastandards.org)
[![Community](https://img.shields.io/badge/slack-join-orange.svg)](https://slack.open-metadata.org)

## Overview

OpenMetadata Standards is the official home for OpenMetadata schemas, RDF ontologies, and metadata specifications. It provides a unified, comprehensive model for representing metadata across the entire data ecosystem.

**What's included:**

- **700+ JSON Schemas** - Complete coverage of entities, APIs, configurations, and events
- **RDF/OWL Ontologies** - Semantic web standards for knowledge graphs
- **SHACL Shapes** - Validation constraints for data quality
- **JSON-LD Contexts** - Semantic interoperability

## Quick Links

- **Documentation**: [openmetadatastandards.org](https://openmetadatastandards.org)
- **OpenMetadata**: [open-metadata.org](https://open-metadata.org)
- **Community**: [Slack](https://slack.open-metadata.org)

## Repository Structure

```
OpenMetadataStandards/
├── schemas/              # 700+ JSON Schema files
│   ├── entity/          # Entity schemas (tables, dashboards, etc.)
│   ├── type/            # Type system definitions
│   ├── api/             # API request/response schemas
│   ├── events/          # Event schemas
│   ├── configuration/   # Configuration schemas
│   └── ...
├── rdf/                 # RDF/OWL ontologies and SHACL shapes
│   ├── ontology/       # OpenMetadata ontology
│   ├── shapes/         # SHACL validation shapes
│   └── contexts/       # JSON-LD contexts
├── docs/                # Documentation source
├── examples/            # Example metadata files
└── README.md
```

## Getting Started

### Prerequisites

- Python 3.8+ (for MkDocs and schema validation)
- Node.js 16+ (for schema validation and code generation)

### Installation

```bash
# Clone the repository
git clone https://github.com/open-metadata/OpenMetadataStandards.git
cd OpenMetadataStandards

# Install Python dependencies
pip install -r requirements.txt

# Install Node.js dependencies
npm install
```

### View Documentation Locally

```bash
# Serve documentation locally
mkdocs serve

# Open http://localhost:8000 in your browser
```

### Validate JSON Against Schemas

Python example:

```python
import json
import jsonschema

# Load schema
with open('schemas/entity/data/table.json') as f:
    schema = json.load(f)

# Load your data
with open('my-table.json') as f:
    data = json.load(f)

# Validate
jsonschema.validate(instance=data, schema=schema)
```

JavaScript example:

```javascript
const Ajv = require('ajv');
const fs = require('fs');

const ajv = new Ajv();
const schema = JSON.parse(fs.readFileSync('schemas/entity/data/table.json'));
const data = JSON.parse(fs.readFileSync('my-table.json'));

const validate = ajv.compile(schema);
const valid = validate(data);
console.log(valid ? 'Valid!' : validate.errors);
```

## Key Features

### Comprehensive Entity Coverage

Schemas for all metadata entities:

- **Data Assets**: Tables, topics, dashboards, pipelines, ML models
- **Services**: Database, messaging, dashboard, pipeline services
- **Governance**: Glossaries, tags, policies, classifications
- **Teams & Users**: Organizations, teams, users, roles
- **Observability**: Data quality, profiling, lineage, usage

### Rich Type System

- Basic types (UUID, email, timestamp, markdown)
- Collection types (arrays, entity references)
- SQL and programming data types
- Custom properties and extensions

### RDF & Semantic Web

- Full OWL ontology for knowledge graphs
- PROV-O for lineage tracking
- SHACL shapes for validation
- JSON-LD contexts for interoperability

### API Specifications

Complete schemas for:

- RESTful CRUD operations
- Search and filtering
- Feed and activity streams
- Webhooks and notifications

## Use Cases

- **Data Catalogs** - Build searchable data catalogs
- **Data Governance** - Implement governance policies and access controls
- **Data Lineage** - Track end-to-end data lineage
- **Data Quality** - Define and monitor data quality rules
- **Knowledge Graphs** - Build semantic knowledge graphs
- **Compliance** - Ensure regulatory compliance

## Documentation

Full documentation available at [openmetadatastandards.org](https://openmetadatastandards.org):

- [Introduction](https://openmetadatastandards.org/getting-started/introduction/)
- [Quick Start](https://openmetadatastandards.org/getting-started/quick-start/)
- [Schema Reference](https://openmetadatastandards.org/schemas/overview/)
- [RDF & Ontologies](https://openmetadatastandards.org/rdf/overview/)
- [Examples](https://openmetadatastandards.org/examples/)

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## Standards Compliance

OpenMetadata Standards adheres to:

- [JSON Schema](https://json-schema.org/) - Draft 07 and 2020-12
- [RDF/OWL](https://www.w3.org/RDF/) - W3C RDF 1.1 and OWL 2
- [SHACL](https://www.w3.org/TR/shacl/) - W3C SHACL
- [JSON-LD](https://json-ld.org/) - JSON for Linking Data
- [PROV-O](https://www.w3.org/TR/prov-o/) - W3C Provenance Ontology

## Community

- **GitHub**: [OpenMetadata Standards](https://github.com/open-metadata/OpenMetadataStandards)
- **Slack**: [Join the community](https://slack.open-metadata.org)
- **Website**: [OpenMetadata.org](https://open-metadata.org)

## License

OpenMetadata Standards is released under the [Apache License 2.0](LICENSE).

## Acknowledgements

Built by the OpenMetadata community with contributions from organizations worldwide.
