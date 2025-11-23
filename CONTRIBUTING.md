# Contributing to OpenMetadata Standards

Thank you for your interest in contributing to OpenMetadata Standards! This document provides guidelines for contributing to this project.

## Code of Conduct

We are committed to providing a welcoming and inclusive environment. Please be respectful and professional in all interactions.

## How to Contribute

### Reporting Issues

If you find a bug, inconsistency, or have a suggestion:

1. Check if the issue already exists in [GitHub Issues](https://github.com/open-metadata/OpenMetadataStandards/issues)
2. If not, create a new issue with:
   - Clear title and description
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Schema version information
   - Example data (if applicable)

### Proposing Schema Changes

For significant schema changes:

1. **Open a discussion** first in GitHub Discussions or Slack
2. **Create a proposal** outlining:
   - Problem being solved
   - Proposed solution
   - Impact on existing schemas
   - Backward compatibility considerations
   - Migration path (if breaking change)
3. **Wait for feedback** from maintainers and community
4. **Implement** after consensus is reached

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/your-feature-name`
3. **Make your changes**
4. **Test your changes** (see Testing section below)
5. **Commit with clear messages**: Follow conventional commits format
6. **Push to your fork**
7. **Create a Pull Request** with:
   - Description of changes
   - Related issue number
   - Testing performed
   - Documentation updates

## Schema Development Guidelines

### JSON Schema Best Practices

1. **Use $ref for reusability**
   ```json
   {
     "owner": {
       "$ref": "../../type/entityReference.json"
     }
   }
   ```

2. **Provide clear descriptions**
   ```json
   {
     "name": {
       "description": "Name of the entity as defined in the source system",
       "type": "string"
     }
   }
   ```

3. **Use examples**
   ```json
   {
     "name": {
       "type": "string",
       "examples": ["customers", "orders", "products"]
     }
   }
   ```

4. **Set appropriate constraints**
   ```json
   {
     "name": {
       "type": "string",
       "minLength": 1,
       "maxLength": 256,
       "pattern": "^[a-zA-Z0-9_.-]+$"
     }
   }
   ```

5. **Include version information**
   ```json
   {
     "$schema": "http://json-schema.org/draft-07/schema#",
     "version": "1.2.0"
   }
   ```

### Backward Compatibility

To maintain backward compatibility:

- **DO**:
  - Add new optional fields
  - Extend enums with new values
  - Relax constraints (e.g., remove minimum length)
  - Add new schemas

- **DON'T**:
  - Remove required fields
  - Make optional fields required
  - Change field types
  - Tighten constraints
  - Remove enum values

### Breaking Changes

If a breaking change is necessary:

1. Document the change in CHANGELOG.md
2. Increment major version
3. Provide migration guide
4. Deprecate old schema for 2 major versions before removal

## RDF/OWL Development Guidelines

### Ontology Best Practices

1. **Use standard vocabularies** where possible (RDFS, OWL, PROV-O, DCAT)

2. **Provide clear labels and comments**
   ```turtle
   om:Table a rdfs:Class ;
       rdfs:label "Table" ;
       rdfs:comment "Represents a database table or view" ;
       rdfs:subClassOf om:DataAsset .
   ```

3. **Define domains and ranges**
   ```turtle
   om:owner a rdf:Property ;
       rdfs:domain om:Entity ;
       rdfs:range om:User ;
       rdfs:label "owner" .
   ```

4. **Use persistent URIs**
   ```turtle
   # Good
   <http://open-metadata.org/ontology#Table>

   # Avoid
   :Table
   ```

### SHACL Shape Guidelines

1. **One shape per entity type**

2. **Include constraints for required properties**
   ```turtle
   om:TableShape a sh:NodeShape ;
       sh:targetClass om:Table ;
       sh:property [
           sh:path om:name ;
           sh:minCount 1 ;
           sh:maxCount 1 ;
           sh:datatype xsd:string ;
       ] .
   ```

3. **Validate data types and ranges**

4. **Provide clear error messages**
   ```turtle
   sh:property [
       sh:path om:email ;
       sh:pattern "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$" ;
       sh:message "Email must be a valid email address" ;
   ] .
   ```

## Documentation Guidelines

### Writing Documentation

1. **Use clear, concise language**
2. **Provide examples** for complex concepts
3. **Include code samples** in multiple languages
4. **Add diagrams** where helpful
5. **Link to related documentation**

### Documentation Structure

- **Getting Started**: Introductory material
- **Schemas**: In-depth schema documentation
- **RDF**: Ontology and semantic web documentation
- **Examples**: Practical examples
- **Developer Guide**: Contributing and development

### Markdown Style

- Use ATX-style headers (`#`)
- Include table of contents for long pages
- Use code fences with language identifiers
- Add links to schemas and entities
- Use admonitions for important notes

## Testing

### Validate Schemas

Before submitting:

```bash
# Validate all JSON schemas
npm run validate:schemas

# Validate examples against schemas
npm run validate:examples
```

### Validate RDF

```python
# Validate RDF syntax
from rdflib import Graph

g = Graph()
g.parse('rdf/ontology/openmetadata.ttl', format='turtle')

# Validate SHACL shapes
from pyshacl import validate

conforms, results_graph, results_text = validate(
    data_graph,
    shacl_graph=shapes_graph
)
assert conforms, results_text
```

### Test Documentation

```bash
# Build documentation
mkdocs build --strict

# Serve locally
mkdocs serve
```

## Versioning

We use [Semantic Versioning](https://semver.org/):

- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes

## Commit Messages

Use conventional commits format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

Examples:
```
feat(schemas): add support for ML feature store

Add new schema for ML feature store entities including
feature groups, features, and feature values.

Closes #123
```

```
fix(rdf): correct domain for owner property

The owner property should have domain om:Entity instead
of om:Table to allow all entities to have owners.
```

## Release Process

1. Update version in schemas
2. Update CHANGELOG.md
3. Create release branch
4. Test thoroughly
5. Create GitHub release
6. Deploy documentation
7. Announce in community channels

## Getting Help

- **Slack**: [Join #openmetadata-standards](https://slack.open-metadata.org)
- **GitHub Discussions**: [Ask questions](https://github.com/open-metadata/OpenMetadataStandards/discussions)
- **Documentation**: [Read the docs](https://openmetadatastandards.org)

## Recognition

Contributors will be recognized in:

- CONTRIBUTORS.md file
- Release notes
- Documentation acknowledgements

Thank you for contributing to OpenMetadata Standards!