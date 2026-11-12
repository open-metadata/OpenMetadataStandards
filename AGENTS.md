# AGENTS.md

Guidance for AI agents and contributors working in this repository.

## What this repository is

OpenMetadata Standards is the reference site for the OpenMetadata JSON Schemas, RDF ontologies, and metadata specifications. It is built with MkDocs (`mkdocs.yml`) and published at openmetadatastandards.org.

| Path | Content |
|---|---|
| `schemas/` | Copy of the OpenMetadata JSON Schemas |
| `docs/` | Hand-written reference pages, one per entity or concept |
| `rdf/` | RDF contexts, ontology, and SHACL shapes |
| `scripts/check-docs.sh` | Documentation validation. Run it before committing |

## Source of truth

The source of truth for every schema is the `openmetadata-spec` module of the OpenMetadata repository:

`openmetadata-spec/src/main/resources/json/schema/`

Never invent or hand-edit values in `schemas/`. If a schema here differs from the source, update it to match the source.

## Keeping schemas in sync

1. Copy the changed files from `openmetadata-spec/src/main/resources/json/schema/` into `schemas/`, keeping the same relative paths.
2. Add new schema files. Remove schema files that no longer exist upstream.
3. Compare the schemas ignoring formatting-only differences (such as the `$schema` draft URL and generic suffixes on `javaType` or `EntityInterface`) so that only real content changes are reviewed.

## Updating entity pages in `docs/`

Whenever a schema changes, update the matching page in `docs/`:

- **Enum fields**: Every field whose schema uses `enum` must list all allowed values on the page, with a short description of each value. Do not document an enum field as a plain `string`. Include the default value when the schema defines one.
- **Embedded schema**: Update the JSON Schema block on the page so it matches the source schema, including new `definitions` and `properties`.
- **Field reference**: Add a section for each new property and remove sections for deleted ones. Keep required, default, and type information accurate.
- **Examples**: Use only valid values. Check every example payload against the schema's enums, types, and required fields.
- **API examples**: Check request and response samples against the current `create*` schemas in `schemas/api/`.
- **RDF**: If a property or enum is added, removed, or renamed, update the matching files in `rdf/`.

## Custom properties

Custom properties are defined per deployment, so their definitions and allowed values cannot be listed in this repository. Entity pages should point readers to the Custom Properties settings in the product, or to the metadata types API:

`GET /api/v1/metadata/types/name/{entityType}?fields=customProperties`

## Before you commit

1. Run `scripts/check-docs.sh`.
2. Build the site locally (`mkdocs build`) and check for warnings.
3. Confirm that every enum value you wrote appears in the source schema, spelled exactly the same.
