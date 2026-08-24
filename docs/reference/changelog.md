
# Change Log

Version history and changes for OpenMetadata Standards.

---

## Version 2.0.0 (Current)

**Release Date**: August 24, 2026

### Schema Snapshot

- Synchronized all 911 JSON schemas from OpenMetadata
  [`2.0.0-release`](https://github.com/open-metadata/OpenMetadata/releases/tag/2.0.0-release)
  at commit [`6861999f`](https://github.com/open-metadata/OpenMetadata/commit/6861999f332b75ce46c5f01b31b71c71168314ba).
- Compared with the prior standards snapshot: 98 schemas added, 135 modified, and 3 removed.
- Compared with the official 1.13.4 release: 86 schemas added, 107 modified, and 3 removed.

### Major Additions

- First-class Tasks, Announcements, Activity Stream events, task form schemas, and governance intake forms.
- Context Center schemas for pages, files, folders, attachments, and reusable context memories.
- AI governance frameworks, framework controls, evidence audit reports, and related API contracts.
- Batch lineage hydration, service overview, data quality batch reporting, and async job contracts.
- New Omni, Prefect, SAP BW/4HANA, SAP S/4HANA, QuestDB, and SAP SuccessFactors connection schemas.
- Top-level LLM and embedding configuration plus Sentry configuration.

### Compatibility and Migration

- Added a complete [schema change inventory](schema-changes-2.0.md), including every synchronized file.
- Added the [1.13 → 2.0 breaking-change guide](../breaking-changes/index.md) covering APIs, search,
  collaboration, governance, data quality, lineage, ingestion, applications, platform configuration,
  security, and UI customization.
- Documented validation tightening, removed app configuration fields, Databricks Pipeline auth
  migration, semantic-search configuration relocation, profiler defaults, and MCP cursor paging.

### Semantic Standards

- Bumped the OpenMetadata ontology to 2.0.0.
- Extended the ontology, SHACL validation, and JSON-LD contexts for AI governance, Context Center,
  Tasks, Announcements, Activity Stream, and intake forms.

---

## Version 1.13.0

**Standards Snapshot Date**: April 23, 2026

- Synchronized 816 schemas from the OpenMetadata 1.13 branch.
- Added the LLM, MCP, AI application, AI governance policy, prompt template, agent execution,
  learning resource, and column context schema families.
- Extended the RDF ontology, SHACL shapes, and JSON-LD contexts for the 1.13 entity surface.

---

## Version 1.11.0

**Release Date**: November 2025

### Major Enhancements

#### Comprehensive API Documentation
- ✅ Added complete API operations for all major entities (200+ endpoints documented)
- ✅ Database entities: Table, Database, Schema with profiling and sample data operations
- ✅ Storage entities: Container, Directory, Spreadsheet, Worksheet with data model management
- ✅ Pipeline entities: Pipeline with task and status management operations
- ✅ Messaging entities: Topic with message schema management
- ✅ Dashboard entities: Dashboard and Chart with usage statistics
- ✅ ML entities: MLModel with features and hyperparameters management
- ✅ API entities: API Collection and Endpoint with authentication and rate limiting
- ✅ Governance entities: Glossary and Glossary Term with comprehensive metadata
- ✅ Data Quality entities: Test Case with incident management and dimension results

#### Enhanced Examples
- ✅ Comprehensive examples for all entity types
- ✅ Advanced examples: Multi-table lineage, ML pipelines, data products
- ✅ Real-world integration patterns
- ✅ API usage examples with curl and Python SDK
- ✅ Data quality suite examples

#### Documentation Improvements
- ✅ Updated logo to "OpenMetadata Standards" branding
- ✅ Enhanced navigation and organization
- ✅ Improved cross-references between entities
- ✅ Better code examples with realistic data

### API Operations Added

All API operations now include:
- List operations with filtering and pagination
- Full CRUD operations (Create, Read, Update, Delete)
- Entity-specific operations (schemas, profiling, status tracking)
- Version management
- Social features (followers, voting where applicable)
- Bulk operations
- Async operations for long-running tasks

### Breaking Changes
None - This is a documentation enhancement release.

### Migration Guide
No migration required. All existing schemas and APIs remain compatible.

---

## Version 1.0.0

**Release Date**: Initial Release

### Features
- 700+ JSON schemas
- RDF/OWL ontologies
- SHACL shapes
- JSON-LD contexts
- Comprehensive documentation
- Basic API reference

## Related Documentation
- [Getting Started](../getting-started/introduction.md)
