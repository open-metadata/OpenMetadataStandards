
# REST API Schemas

REST API request and response schemas.

## Overview

All API endpoints use JSON Schema validated requests and responses.

## Common Patterns

### List Response
```json
{
  "data": [],
  "paging": {
    "after": "cursor",
    "total": 100
  }
}
```

### Create Request
```json
{
  "name": "entity_name",
  "description": "Description",
  "owner": {"type": "user", "id": "uuid"}
}
```

### Update Request (JSON Patch)
```json
[
  {
    "op": "replace",
    "path": "/description",
    "value": "New description"
  }
]
```

## Error Responses
```json
{
  "code": 400,
  "message": "Validation error",
  "details": "Field 'name' is required"
}
```

## Related Documentation
- [API Overview](index.md)
