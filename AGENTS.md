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

1. Pin the upstream release tag and commit that the site will describe (for example `2.0.7-release`). Read the schemas from that tag, not from `main`, so the site never describes unreleased changes.
2. Copy the changed files from `openmetadata-spec/src/main/resources/json/schema/` at that tag into `schemas/`, keeping the same relative paths.
3. Add new schema files. Remove schema files that no longer exist upstream.
4. Compare the schemas so that real content changes can be reviewed. Only ignore differences that cannot change meaning, such as whitespace or key order. Treat a change to the `$schema` draft URL as a semantic change: draft versions apply validation keywords differently (for example, draft-07 ignores keywords placed next to a `$ref`, while draft 2020-12 applies them), so a dialect change needs an explicit compatibility review.
5. Update the public snapshot information: the version label in `docs/index.md`, the version badge in `README.md`, and a new section in `docs/reference/changelog.md` that records the release tag, the upstream commit, the schema count, and the number of schemas added, modified, and removed.

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
