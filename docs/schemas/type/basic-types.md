
# Basic Types

Fundamental type definitions used throughout OpenMetadata schemas.

## Overview

Basic types are the building blocks for all OpenMetadata schemas. They provide standardized, reusable type definitions.

## String Types

### UUID

**Definition**: `type/basic.json#/definitions/uuid`

RFC 4122 compliant universally unique identifiers:

```json
{
  "type": "string",
  "format": "uuid",
  "pattern": "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"
}
```

**Usage**: Entity IDs, references

### Email

**Definition**: `type/basic.json#/definitions/email`

RFC 5322 email addresses:

```json
{
  "type": "string",
  "format": "email",
  "pattern": "^[\\w\\.\\-]+@[\\w\\-]+\\.[\\w\\-\\.]+$"
}
```

### Markdown

**Definition**: `type/basic.json#/definitions/markdown`

CommonMark formatted text for rich descriptions:

```json
{
  "type": "string",
  "description": "Markdown formatted text"
}
```

### URI

**Definition**: `type/basic.json#/definitions/href`

HTTP/HTTPS URIs:

```json
{
  "type": "string",
  "format": "uri"
}
```

## Temporal Types

### Timestamp

**Definition**: `type/basic.json#/definitions/timestamp`

ISO 8601 timestamps:

```json
{
  "type": "number",
  "description": "Unix epoch timestamp in milliseconds"
}
```

**Example**: `1704067200000` (2024-01-01T00:00:00Z)

### Date

**Definition**: `type/basic.json#/definitions/date`

ISO 8601 dates:

```json
{
  "type": "string",
  "format": "date",
  "pattern": "^\\d{4}-\\d{2}-\\d{2}$"
}
```

**Example**: `"2024-01-01"`

### Time

**Definition**: `type/basic.json#/definitions/time`

ISO 8601 times:

```json
{
  "type": "string",
  "format": "time"
}
```

**Example**: `"14:30:00"`

### Duration

**Definition**: `type/basic.json#/definitions/duration`

ISO 8601 durations:

```json
{
  "type": "string",
  "format": "duration"
}
```

**Example**: `"P1DT12H30M"` (1 day, 12 hours, 30 minutes)

## Numeric Types

### Integer

Standard JSON integer:

```json
{
  "type": "integer"
}
```

### Number

JSON number (float/double):

```json
{
  "type": "number"
}
```

## Boolean

Standard JSON boolean:

```json
{
  "type": "boolean"
}
```

## Expression Types

### SQL Expression

**Definition**: `type/basic.json#/definitions/sqlQuery`

SQL query strings:

```json
{
  "type": "string",
  "description": "SQL expression or query"
}
```

### SQL Function

SQL function expressions:

```json
{
  "type": "string",
  "description": "SQL function like COUNT(*), SUM(column)"
}
```

## Entity Links

### Entity Link

**Definition**: `type/basic.json#/definitions/entityLink`

Links to specific entities or entity fields:

```turtle
<#E::table::db.schema.table>
<#E::table::db.schema.table::columns::column_name>
```

Format: `<#E::{entityType}::{fqn}[::{field}::{fieldValue}]>`

## Enum Types

### Style Enums

Constrained string values:

```json
{
  "type": "string",
  "enum": ["Regular", "View", "MaterializedView", "Temporary"]
}
```

## Validation Patterns

### Name Pattern

Valid entity names:

```json
{
  "type": "string",
  "minLength": 1,
  "maxLength": 256,
  "pattern": "^[a-zA-Z0-9_.-]+$"
}
```

### FQN Pattern

Fully qualified names:

```json
{
  "type": "string",
  "minLength": 1,
  "maxLength": 3072
}
```

## Best Practices

1. **Use Standard Types**: Always reference basic types instead of redefining
2. **Validation**: Leverage format and pattern validations
3. **Constraints**: Add min/max length where appropriate
4. **Documentation**: Document custom constraints

## Related Documentation

- [Collection Types](collection-types.md)
- [Custom Properties](custom-properties.md)
- [Schema Overview](../overview.md)
