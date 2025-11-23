
# OpenMetadata Standards

<div class="hero-section" markdown>

<div style="display: inline-block; background: linear-gradient(135deg, #7147E8 0%, #8D6AF1 100%); color: white; padding: 0.4rem 1rem; border-radius: 2rem; font-size: 0.85rem; font-weight: 600; margin-bottom: 1.5rem; box-shadow: 0 2px 8px rgba(113, 71, 232, 0.3);">
📦 Version 1.11.0 — November 2025
</div>

## Open Standard for Metadata

**A comprehensive collection of schemas, ontologies, and specifications for metadata management**

Welcome to the official home of OpenMetadata Standards - **unified metadata standards and schemas** powering the entire data ecosystem.

</div>

## What is OpenMetadata Standards?

OpenMetadata Standards is an open-source project that provides **unified metadata standards and schemas** for comprehensive metadata management across the data ecosystem. It delivers:

- **700+ JSON Schemas** - Comprehensive schemas covering entities, APIs, configurations, events, and more
- **RDF Ontologies** - Semantic web standards for linked metadata and knowledge graphs
- **SHACL Shapes** - Validation constraints for ensuring data quality and compliance
- **JSON-LD Contexts** - Semantic contexts for interoperability with other systems

## Why OpenMetadata Standards?

### Unified Metadata Model

OpenMetadata Standards provides a single, cohesive model for representing metadata across your entire data stack - from databases and data warehouses to ML models and dashboards.

### Interoperability

Built on open standards (JSON Schema, RDF, SHACL, JSON-LD), OpenMetadata enables seamless integration with existing tools and systems.

### Extensibility

The type system and custom properties framework allows you to extend schemas to meet your specific organizational needs while maintaining compatibility.

### Community-Driven

Developed in collaboration with the OpenMetadata community, these standards reflect real-world use cases and best practices.

## Key Features

### Entity Schemas

Comprehensive schemas for all metadata entities:

- **Data Assets**: Tables, databases, schemas, columns, topics, dashboards, pipelines
- **Services**: Database services, messaging services, dashboard services, ML model services
- **Governance**: Glossaries, tags, policies, classifications
- **Teams & Users**: Organizations, teams, users, roles, personas
- **Observability**: Data quality tests, profiling, lineage, usage metrics

### Rich Type System

A flexible type system supporting:

- Basic types (string, number, boolean, etc.)
- Complex types (objects, arrays, unions)
- Custom properties and extensions
- Entity references and relationships

### API Specifications

Complete API schemas for:

- RESTful CRUD operations
- Search and filtering
- Feed and activity streams
- Webhooks and notifications
- Bulk operations

### Event System

Comprehensive event schemas for:

- Entity lifecycle events (create, update, delete)
- Change events with before/after states
- Custom application events
- Audit logging

### Configuration Schemas

Schemas for configuring:

- Authentication and authorization
- Ingestion pipelines and connectors
- Event handlers and webhooks
- Search and indexing
- Security and encryption

## RDF & Semantic Web

OpenMetadata Standards includes full RDF/OWL ontologies and SHACL shapes for:

- **Knowledge Graph Integration** - Export metadata as RDF for integration with knowledge graphs
- **Linked Data** - Connect metadata across systems using URIs and SPARQL
- **Validation** - Ensure metadata quality using SHACL constraint validation
- **Provenance Tracking** - Track metadata lineage using W3C PROV-O ontology

## Getting Started

<div class="grid cards" markdown>

-   :material-clock-fast:{ .lg .middle } __Quick Start__

    ---

    Get up and running with OpenMetadata Standards in minutes

    [:octicons-arrow-right-24: Quick Start](getting-started/quick-start.md)

-   :material-book-open-variant:{ .lg .middle } __Core Concepts__

    ---

    Learn the fundamental concepts behind OpenMetadata Standards

    [:octicons-arrow-right-24: Core Concepts](getting-started/core-concepts.md)

-   :material-file-code:{ .lg .middle } __Schema Reference__

    ---

    Explore the complete schema documentation

    [:octicons-arrow-right-24: Schemas](metadata-specifications/overview.md)

-   :material-web:{ .lg .middle } __RDF & Ontologies__

    ---

    Discover semantic web capabilities

    [:octicons-arrow-right-24: RDF](metadata-standards/rdf-ontology.md)

</div>

## Use Cases

OpenMetadata Standards powers a wide range of metadata management use cases:

- **Data Catalogs** - Build comprehensive data catalogs with searchable metadata
- **Data Governance** - Implement governance policies, classifications, and access controls
- **Data Lineage** - Track end-to-end data lineage across pipelines and transformations
- **Data Quality** - Define and monitor data quality rules and tests
- **Compliance** - Ensure regulatory compliance with metadata policies
- **Knowledge Graphs** - Build semantic knowledge graphs from metadata

## Schema Statistics

- **Total Schemas**: 707 JSON schemas
- **Entity Types**: 100+ entity schemas
- **Type Definitions**: 200+ reusable type definitions
- **API Endpoints**: 50+ API operation schemas
- **Event Types**: 30+ event schemas
- **Configuration Options**: 100+ configuration schemas

## Standards Compliance

OpenMetadata Standards adheres to:

- [JSON Schema](https://json-schema.org/) - Draft 07 and 2020-12
- [RDF/OWL](https://www.w3.org/RDF/) - W3C RDF 1.1 and OWL 2
- [SHACL](https://www.w3.org/TR/shacl/) - W3C SHACL for validation
- [JSON-LD](https://json-ld.org/) - JSON for Linking Data
- [PROV-O](https://www.w3.org/TR/prov-o/) - W3C Provenance Ontology

## Community & Support

- **GitHub**: [OpenMetadata Standards Repository](https://github.com/open-metadata/OpenMetadataStandards)
- **Slack**: [Join the OpenMetadata Community](https://slack.open-metadata.org)
- **Documentation**: [OpenMetadata Docs](https://docs.open-metadata.org)
- **Website**: [OpenMetadata.org](https://open-metadata.org)

## Contributing

We welcome contributions from the community! See our [Contributing Guide](developer/contributing.md) to get started.

## License

OpenMetadata Standards is released under the Apache License 2.0. See [LICENSE](reference/license.md) for details.
