# JSON-LD Contexts

Semantic contexts for metadata interoperability.

---

## Overview

JSON-LD contexts enable OpenMetadata JSON documents to be interpreted as linked data, enabling semantic interoperability with other systems.

## Features

### Semantic Interoperability

Transform JSON metadata into RDF using JSON-LD contexts.

### Vocabulary Mapping

Map OpenMetadata terms to standard vocabularies and ontologies.

### Linked Data

Enable URIs and semantic relationships in JSON documents.

## Usage

JSON-LD contexts allow metadata to be both:
- Valid JSON for easy consumption by applications
- Valid RDF for semantic web applications

## Version 2.0 Contexts

Alongside the base, data asset, service, governance, quality, team, and operations mappings, version
2.0 adds dedicated contexts for:

- `activity.jsonld` — Activity Stream events and configuration
- `ai.jsonld` — AI, LLM, MCP, AI governance frameworks, controls, and audit reports
- `announcement.jsonld` — standalone announcements
- `contextCenter.jsonld` — Context Center content, files, folders, attachments, and memories
- `intakeForm.jsonld` — governance intake forms
- `task.jsonld` — first-class tasks and task form schemas

The `Task` term in `task.jsonld` maps to `om:GovernanceTask`. This keeps the new first-class task
entity distinct from the pre-existing `om:Task` term used for a task nested inside a data pipeline.

## Related Documentation

- [Overview](overview.md)
- [JSON Schemas](json-schemas.md)
- [RDF & OWL](rdf-ontology.md)
- [SHACL Validation](shacl-validation.md)
