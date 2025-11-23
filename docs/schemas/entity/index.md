
# Entity Schemas

Entity schemas define the core metadata objects in OpenMetadata.

## Overview

Entities represent the fundamental building blocks of metadata in OpenMetadata. Each entity has a well-defined schema that specifies its properties, relationships, and validation rules.

## Categories

### Data Assets

- [Data Assets](data-assets.md) - Tables, topics, dashboards, pipelines, ML models
- [Services](services.md) - Database, messaging, dashboard, pipeline services

### Organization

- [Teams & Users](teams-users.md) - Organizations, teams, users, roles
- [Policies & Roles](policies-roles.md) - Access control and permissions

### Governance

- [Glossary](glossary.md) - Business glossaries and terminology

### Metrics

- [Metrics](metrics.md) - KPIs and measurements

## Common Properties

All entities share these common properties:

- **id**: Unique identifier (UUID)
- **name**: Entity name
- **fullyQualifiedName**: Hierarchical unique name
- **description**: Rich text description
- **owner**: Entity owner reference
- **tags**: Classification tags
- **version**: Entity version number
- **updatedAt**: Last update timestamp
- **updatedBy**: User who made the update
- **href**: API endpoint URL

## Entity Relationships

Entities are connected through typed relationships:

- **Contains**: Hierarchical containment
- **Owns**: Ownership
- **Uses**: Usage relationships
- **Produces**: Creation relationships
- **DerivedFrom**: Lineage relationships

## Next Steps

Explore specific entity categories to learn more about each schema type.
