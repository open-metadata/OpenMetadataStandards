# JSON Schemas

Comprehensive JSON Schema specifications for OpenMetadata entities, types, APIs, and configurations.

---

## Overview

OpenMetadata Standards 2.0 includes **911 JSON Schema** files that define the structure, validation rules, and documentation for all metadata entities and types.

The snapshot is synchronized from OpenMetadata's `2.0.0-release` tag. See the
[2.0 schema change inventory](../reference/schema-changes-2.0.md) for provenance, compatibility
notes, and the complete file-level delta.

## Schema Categories

### Entity Schemas

Complete schemas for all metadata entities:

- **Data Assets**: Tables, topics, dashboards, pipelines, ML models
- **Services**: Database, messaging, dashboard, pipeline services
- **Governance**: Glossaries, tags, policies, classifications
- **Teams & Users**: Organizations, teams, users, roles, personas
- **Observability**: Data quality, profiling, lineage, usage metrics

### Type System

Rich type definitions including:

- Basic types (UUID, email, timestamp, markdown)
- Collection types (arrays, entity references)
- SQL and programming data types
- Custom properties and extensions

### API Schemas

OpenAPI specifications for RESTful operations

### Event Schemas

Change events, lifecycle events, and audit logs

### Configuration Schemas

Service connectors and system configurations

## Related Documentation

- [Overview](overview.md)
- [RDF & OWL](rdf-ontology.md)
- [JSON-LD Contexts](jsonld-contexts.md)
- [SHACL Validation](shacl-validation.md)
