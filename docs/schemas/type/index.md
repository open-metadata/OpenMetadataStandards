
# Type System

The OpenMetadata type system provides reusable type definitions used across all schemas.

## Overview

Types are fundamental building blocks that are referenced by entity schemas. They ensure consistency and enable schema composition.

## Type Categories

### [Basic Types](basic-types.md)

Core primitive types:
- UUID, Email, Timestamp, Duration
- URI, Markdown, Expression
- Entity links and references

### [Collection Types](collection-types.md)

Composite types:
- Arrays and lists
- Entity references
- Tag labels
- Change descriptions

### [Custom Properties](custom-properties.md)

Extension mechanism:
- User-defined properties
- Type-safe extensions
- Schema-less flexibility

## Usage

Types are referenced using JSON Schema `$ref`:

```json
{
  "owner": {
    "$ref": "../../type/entityReference.json"
  }
}
```

This enables:
- **Reusability**: Define once, use everywhere
- **Consistency**: Same type across all entities
- **Validation**: Centralized validation rules
- **Documentation**: Single source of truth
