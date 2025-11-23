
# Versioning

Schema versioning strategy.

## Semantic Versioning

OpenMetadata schemas use semantic versioning: MAJOR.MINOR.PATCH

### MAJOR
Breaking changes:
- Removing required fields
- Changing field types
- Removing enum values

### MINOR
New features (backward compatible):
- Adding optional fields
- Adding enum values
- New entity types

### PATCH
Bug fixes and clarifications.

## Schema Version

Each schema includes version:

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "version": "1.2.0"
}
```

## API Versioning

API endpoints versioned independently.

## Related Documentation
- [Schema Evolution](schema-evolution.md)
- [Standards Overview](overview.md)
