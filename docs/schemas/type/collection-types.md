
# Collection Types

Collection and composite types in OpenMetadata.

## Overview

Collection types define arrays, objects, and complex structures used across schemas.

## Entity Reference

**Schema**: `type/entityReference.json`

Reference to another entity:

```json
{
  "id": "uuid",
  "type": "table",
  "name": "customers",
  "fullyQualifiedName": "db.schema.customers",
  "description": "Customer master table",
  "displayName": "Customers",
  "deleted": false,
  "href": "https://api.example.com/v1/tables/uuid"
}
```

### Properties

- `id`: Entity UUID
- `type`: Entity type (table, dashboard, user, etc.)
- `name`: Entity name
- `fullyQualifiedName`: Unique FQN
- `description`: Optional description
- `displayName`: Display name
- `deleted`: Soft delete flag
- `href`: API endpoint

### Usage

References are used for:
- Ownership
- Lineage
- Relationships
- Service connections

## Entity Relationship

**Schema**: `type/entityRelationship.json`

Typed relationship between entities:

```json
{
  "fromEntity": {
    "id": "source-uuid",
    "type": "table"
  },
  "toEntity": {
    "id": "target-uuid",
    "type": "table"
  },
  "relationshipType": "contains"
}
```

### Relationship Types

- `contains`: Hierarchical containment
- `uses`: Usage dependency
- `owns`: Ownership
- `createdBy`: Creation attribution
- `upstream`: Lineage (data flows from)
- `downstream`: Lineage (data flows to)

## Tag Label

**Schema**: `type/tagLabel.json`

Tag assignment to an entity:

```json
{
  "tagFQN": "PII.Email",
  "description": "Personal email address",
  "source": "Classification",
  "labelType": "Manual",
  "state": "Confirmed"
}
```

### Tag Sources

- `Classification`: From taxonomy
- `Glossary`: From business glossary
- `Derived`: Automatically derived

### Label Types

- `Manual`: User-applied
- `Automated`: Rule-based
- `Propagated`: Inherited from parent
- `Derived`: ML/pattern-detected

## Change Description

**Schema**: `type/changeDescription.json`

Tracks field-level changes:

```json
{
  "fieldsAdded": [
    {
      "name": "tags",
      "newValue": "[{\"tagFQN\": \"PII.Email\"}]"
    }
  ],
  "fieldsUpdated": [
    {
      "name": "description",
      "oldValue": "Old description",
      "newValue": "Updated description"
    }
  ],
  "fieldsDeleted": [
    {
      "name": "customProperty",
      "oldValue": "value"
    }
  ],
  "previousVersion": 1.0
}
```

## Life Cycle

**Schema**: `type/lifeCycle.json`

Entity lifecycle information:

```json
{
  "created": {
    "timestamp": 1704067200000,
    "user": "john.doe"
  },
  "updated": {
    "timestamp": 1704153600000,
    "user": "jane.smith"
  },
  "accessed": {
    "timestamp": 1704240000000
  }
}
```

## Usage Summary

**Schema**: `type/usageDetails.json`

Usage statistics:

```json
{
  "dailyStats": {
    "count": 150,
    "percentileRank": 0.85
  },
  "weeklyStats": {
    "count": 1050,
    "percentileRank": 0.90
  },
  "date": "2024-01-01"
}
```

## Profile

Data profiling information:

```json
{
  "profileDate": "2024-01-01",
  "rowCount": 1000000,
  "columnCount": 25,
  "sizeInBytes": 850000000
}
```

## Array Types

Generic arrays:

```json
{
  "type": "array",
  "items": {
    "$ref": "entityReference.json"
  }
}
```

Common arrays:
- Tags: `TagLabel[]`
- References: `EntityReference[]`
- Users: `EntityReference[]` (type=user)
- Teams: `EntityReference[]` (type=team)

## Related Documentation

- [Basic Types](basic-types.md)
- [Custom Properties](custom-properties.md)
- [Entity Schemas](../entity/index.md)
