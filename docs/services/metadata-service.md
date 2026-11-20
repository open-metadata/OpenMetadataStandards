# Metadata Service

This schema defines the Metadata Service entity, such as Amundsen, Atlas etc.

**Source schema:** `schemas/entity/services/metadataService.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of this database service instance. |
| `name` | `reference or object` | Name that identifies this database service. |
| `fullyQualifiedName` | `reference or object` | FullyQualifiedName same as `name`. |
| `displayName` | `string` | Display Name that identifies this database service. |
| `serviceType` | `reference or object` | Type of database service such as MySQL, BigQuery, Snowflake, Redshift, Postgres... |
| `description` | `reference or object` | Description of a database service instance. |
| `connection` | `reference or object` |  |
| `pipelines` | `reference or object` | References to pipelines deployed for this database service to extract metadata, usage, lineage etc.. |
| `version` | `reference or object` | Metadata version of the entity. |
| `updatedAt` | `reference or object` | Last update time corresponding to the new version of the entity in Unix epoch time milliseconds. |
| `updatedBy` | `string` | User who made the update. |
| `impersonatedBy` | `reference or object` | Bot user that performed the action on behalf of the actual user. |
| `testConnectionResult` | `reference or object` | Last test connection results for this service |
| `tags` | `array` | Tags for this Metadata Service. |
| `owners` | `reference or object` | Owners of this database service. |
| `href` | `reference or object` | Link to the resource corresponding to this database service. |
| `changeDescription` | `reference or object` | Change that lead to this version of the entity. |
| `incrementalChangeDescription` | `reference or object` | Change that lead to this version of the entity. |
| `deleted` | `boolean` | When `true` indicates the entity has been soft deleted. |
| `entityStatus` | `reference or object` | Status of the entity. |
| `provider` | `reference or object` |  |
| `followers` | `reference or object` | Followers of this entity. |
| `domains` | `reference or object` | Domains the asset belongs to. When not set, the asset inherits the domain from the parent it belongs to. |
| `ingestionRunner` | `reference or object` | The ingestion agent responsible for executing the ingestion pipeline. |

## Enum fields

### definitions.metadataServiceType

Type of database service such as Amundsen, Atlas...

**Allowed values:**

- `Amundsen`
- `MetadataES`
- `OpenMetadata`
- `Atlas`
- `Alation`
- `AlationSink`
- `Collibra`
