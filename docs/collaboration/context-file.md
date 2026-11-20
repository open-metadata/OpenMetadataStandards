# ContextFile

An uploaded file (PDF, spreadsheet, document) stored in the Context Center Drive.

**Source schema:** `schemas/entity/data/contextFile.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `id` | `reference or object` | Unique identifier of the file. |
| `name` | `reference or object` | Name of the file. |
| `fullyQualifiedName` | `reference or object` | Fully qualified name of the file. |
| `displayName` | `string` | Display name (original filename or user-provided title). |
| `description` | `reference or object` | Description of the file. |
| `fileType` | `reference or object` | Type of file (PDF, Spreadsheet, etc.). |
| `fileSize` | `integer` | File size in bytes. |
| `contentType` | `string` | MIME type of the file. |
| `fileExtension` | `string` | File extension (e.g., pdf, xlsx). |
| `assetId` | `string` | Legacy reference to the current Asset entity storing the file blob. Prefer headContentId for new flows. |
| `headContentId` | `string` | Identifier of the current ContextFileContent snapshot for this file. |
| `processingStatus` | `reference or object` | Current processing state after upload. |
| `processingError` | `string` | Reason the most recent processing attempt failed. Cleared when a new attempt starts. |
| `extractionStats` | `reference or object` | Statistics from the most recent knowledge-pill extraction run. |
| `extractedText` | `string` | Full text extracted from the file for search and AI context. |
| `pageCount` | `integer` | Number of pages (PDF) or sheets (spreadsheet). |
| `memoryCount` | `integer` | Number of knowledge pills (context memories) extracted from this file. |
| `sourceType` | `reference or object` | How this file was added. |
| `sourceId` | `string` | ID of the file in the external source system. |
| `sourceUrl` | `string` | URL to view the file in the external source system. |
| `folder` | `reference or object` | Parent folder containing this file. |
| `owners` | `reference or object` | Owners of this file. |
| `tags` | `array` | Tags associated with this file. |
| `version` | `reference or object` | Metadata version of the entity. |
| `updatedAt` | `reference or object` | Last update time in Unix epoch time milliseconds. |
| `updatedBy` | `string` | User who made the update. |
| `href` | `reference or object` | Link to this resource. |
| `changeDescription` | `reference or object` | Change that led to this version. |
| `incrementalChangeDescription` | `reference or object` | Incremental change that led to this version. |
| `deleted` | `boolean` | When true indicates the entity has been soft deleted. |
| `domains` | `reference or object` | Domains this file belongs to. |
| `followers` | `reference or object` | Followers of this file. |
| `votes` | `reference or object` | Votes on this file. |

## Enum fields

### definitions.fileType

Type of file based on content.

**Allowed values:**

- `PDF`
- `Spreadsheet`
- `Presentation`
- `Image`
- `Document`
- `CSV`
- `Text`
- `Archive`
- `Other`

### definitions.processingStatus

Processing state of the file after upload.

**Default:** `Uploaded`

**Allowed values:**

- `Uploaded`
- `Analyzing`
- `ExtractingContext`
- `Processed`
- `Failed`
- `Unsupported`

### definitions.sourceType

How this file was added to the drive.

**Default:** `Upload`

**Allowed values:**

- `Upload`
- `DriveSync`
- `Confluence`
- `Notion`
