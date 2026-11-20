# Page

This schema defines the type of Page.

**Source schema:** `schemas/entity/data/page.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of the Knowledge Page. |
| `name` | `reference or object` | Name of Knowledge Page belongs to |
| `fullyQualifiedName` | `reference or object` | Fully qualified name of a Knowledge Page. |
| `displayName` | `string` | Display Name that identifies this Knowledge Page. It could be title or label. |
| `description` | `reference or object` | Description of a Knowledge Page. |
| `version` | `reference or object` | Metadata version of the entity. |
| `updatedAt` | `reference or object` | Last update time corresponding to the new version of the entity in Unix epoch time milliseconds. |
| `updatedBy` | `string` | User who updated the Knowledge Page. |
| `href` | `reference or object` | Link to this Knowledge Page resource. |
| `changeDescription` | `reference or object` | Change that lead to this version of the entity. |
| `incrementalChangeDescription` | `reference or object` | Change that lead to this version of the entity. |
| `owners` | `reference or object` | Owners of this Knowledge Page. |
| `reviewers` | `reference or object` | User references of the reviewers for this tag. |
| `entityStatus` | `reference or object` | Status of the tag. |
| `followers` | `reference or object` | Followers of this Knowledge Page. |
| `votes` | `reference or object` | Votes for this Knowledge Page. |
| `tags` | `array` | Tags for this SQL query. |
| `pageType` | `reference or object` | Type of the Knowledge Page. |
| `page` | `reference or object` | Knowledge Page Schema |
| `relatedEntities` | `reference or object` | Related Entities for the Knowledge Page |
| `editors` | `reference or object` | List of users who are updating the entity |
| `parent` | `reference or object` | Parent of this Knowledege Center. |
| `children` | `reference or object` | Children of this Knowledge Center. |
| `childrenCount` | `integer` | Count of immediate children glossary terms. |
| `domains` | `reference or object` | Fully qualified name of the domains the Knowledge Page belongs to. |
| `dataProducts` | `reference or object` | List of data products this entity is part of. |
| `attachments` | `array` | Attachments for the Knowledge Page |
| `processingStatus` | `reference or object` | Status of the most recent knowledge-pill extraction run on this article's body. |
| `processingError` | `string` | Error message from the most recent failed knowledge-pill extraction run, if any. |
| `extractionStats` | `reference or object` | Statistics from the most recent knowledge-pill extraction run on this page's body. |
| `memoryCount` | `integer` | Number of knowledge pills (context memories) extracted from this page. |

## Enum fields

### definitions.pageType

Type of the Knowledge Page.

**Allowed values:**

- `Article`
- `QuickLink`

### definitions.pageProcessingStatus

Status of the asynchronous knowledge-pill extraction for an article's body. Distinct from the governance entityStatus.

**Allowed values:**

- `Queued`
- `Processing`
- `Processed`
- `Failed`
