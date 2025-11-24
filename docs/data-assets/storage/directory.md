# Directory

**Folders in cloud drive services - organizing collaborative files and documents**

---

## Overview

The **Directory** (or Folder) entity represents a folder or directory within a Drive Service (Google Drive, OneDrive, SharePoint, Dropbox). Directories organize files hierarchically and provide namespace organization for collaborative documents, spreadsheets, presentations, and other files.

**Hierarchy**:

```mermaid
graph LR
    DS[Drive Service] --> DIR[Directory]
    DIR --> SUBDIR[Sub-Directory]
    DIR --> FILE[Files]
    DIR --> SHEET[Spreadsheet]
    DIR --> DOC[Document]

    style DS fill:#667eea,color:#fff
    style DIR fill:#4facfe,color:#fff,stroke:#4c51bf,stroke-width:3px
    style SUBDIR fill:#00f2fe,color:#333
    style FILE fill:#e0f2fe,color:#333
    style SHEET fill:#e0f2fe,color:#333
    style DOC fill:#e0f2fe,color:#333
```

---

## Schema Specifications

View the complete Directory schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/data/directory.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "Directory",
      "description": "A folder or directory in a cloud drive service.",
      "type": "object",

      "properties": {
        "id": {
          "description": "Unique identifier",
          "$ref": "../../type/basic.json#/definitions/uuid"
        },
        "name": {
          "description": "Directory name",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "Fully qualified path: driveService.parentDir.dirName",
          "$ref": "../../type/basic.json#/definitions/fullyQualifiedEntityName"
        },
        "displayName": {
          "description": "Display name",
          "type": "string"
        },
        "description": {
          "description": "Markdown description",
          "$ref": "../../type/basic.json#/definitions/markdown"
        },
        "driveService": {
          "description": "Reference to parent drive service",
          "$ref": "../../type/entityReference.json"
        },
        "parentDirectory": {
          "description": "Parent directory (null if root)",
          "$ref": "../../type/entityReference.json"
        },
        "path": {
          "description": "Full path from root",
          "type": "string",
          "example": "/Marketing/Campaigns/Q4 2024"
        },
        "directoryType": {
          "description": "Type of directory",
          "type": "string",
          "enum": ["Folder", "SharedDrive", "DocumentLibrary", "TeamFolder"]
        },
        "files": {
          "description": "Files in this directory",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "subdirectories": {
          "description": "Child directories",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "spreadsheets": {
          "description": "Spreadsheet files in directory",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "sharing": {
          "description": "Sharing settings",
          "type": "object",
          "properties": {
            "sharedWith": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "email": {"type": "string"},
                  "permission": {
                    "type": "string",
                    "enum": ["viewer", "commenter", "editor", "owner"]
                  }
                }
              }
            },
            "linkSharing": {
              "type": "string",
              "enum": ["private", "anyone_with_link", "public"]
            }
          }
        },
        "size": {
          "description": "Total size in bytes",
          "type": "integer"
        },
        "fileCount": {
          "description": "Number of files",
          "type": "integer"
        },
        "owner": {
          "description": "Owner of this directory",
          "$ref": "../../type/entityReference.json"
        },
        "domain": {
          "description": "Domain this directory belongs to",
          "$ref": "../../type/entityReference.json"
        },
        "tags": {
          "description": "Tags for this directory",
          "type": "array",
          "items": {
            "$ref": "../../type/tagLabel.json"
          }
        },
        "extension": {
          "description": "Custom properties",
          "$ref": "../../type/basic.json#/definitions/entityExtension"
        }
      },
      "required": ["id", "name", "driveService"],
      "additionalProperties": false
    }
    ```

=== "RDF (Turtle)"

    **RDF/OWL Ontology Representation**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix om-dir: <https://open-metadata.org/schema/entity/data/> .
    @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2002/07/owl#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # Directory Class
    om-dir:Directory a owl:Class ;
        rdfs:label "Directory" ;
        rdfs:comment "Folder or directory in cloud drive service" ;
        rdfs:isDefinedBy om: .

    # Properties
    om-dir:path a owl:DatatypeProperty ;
        rdfs:label "path" ;
        rdfs:comment "Full path from root directory" ;
        rdfs:domain om-dir:Directory ;
        rdfs:range xsd:string .

    om-dir:parentDirectory a owl:ObjectProperty ;
        rdfs:label "parent directory" ;
        rdfs:comment "Parent directory reference" ;
        rdfs:domain om-dir:Directory ;
        rdfs:range om-dir:Directory .

    om-dir:hasFile a owl:ObjectProperty ;
        rdfs:label "has file" ;
        rdfs:comment "Files contained in this directory" ;
        rdfs:domain om-dir:Directory ;
        rdfs:range om:File .

    om-dir:hasSpreadsheet a owl:ObjectProperty ;
        rdfs:label "has spreadsheet" ;
        rdfs:comment "Spreadsheets in this directory" ;
        rdfs:domain om-dir:Directory ;
        rdfs:range om:Spreadsheet .
    ```

=== "JSON-LD Context"

    **JSON-LD Context for Semantic Interoperability**

    ```json
    {
      "@context": {
        "@vocab": "https://open-metadata.org/schema/entity/data/",
        "om": "https://open-metadata.org/schema/",
        "xsd": "http://www.w3.org/2001/XMLSchema#",

        "Directory": {
          "@id": "om:Directory",
          "@type": "@id"
        },
        "path": {
          "@id": "om:path",
          "@type": "xsd:string"
        },
        "parentDirectory": {
          "@id": "om:parentDirectory",
          "@type": "@id"
        },
        "files": {
          "@id": "om:hasFile",
          "@type": "@id",
          "@container": "@set"
        },
        "spreadsheets": {
          "@id": "om:hasSpreadsheet",
          "@type": "@id",
          "@container": "@set"
        }
      }
    }
    ```

---

## Use Cases

### Team Collaboration

Organize team files:

```json
{
  "name": "Marketing Campaigns",
  "driveService": "google_drive_marketing",
  "path": "/Marketing/Campaigns",
  "directoryType": "Folder",
  "subdirectories": [
    "Q1 2024",
    "Q2 2024",
    "Q3 2024",
    "Q4 2024"
  ],
  "files": ["Campaign_Template.docx", "Brand_Guidelines.pdf"],
  "spreadsheets": ["Campaign_Metrics.gsheet"],
  "owner": "marketing-team",
  "tags": ["Marketing", "Campaigns"]
}
```

### Data Analytics

Track data source folders:

```json
{
  "name": "Sales Data",
  "driveService": "google_drive_analytics",
  "path": "/Data/Sales",
  "spreadsheets": [
    "Monthly_Sales_2024.gsheet",
    "Customer_Segments.gsheet",
    "Revenue_Forecast.xlsx"
  ],
  "lineage": {
    "downstream": ["pipeline.sales_etl", "table.sales_summary"]
  }
}
```

---

## Custom Properties

This entity supports custom properties through the `extension` field.
Common custom properties include:

- **Data Classification**: Sensitivity level
- **Cost Center**: Billing allocation
- **Retention Period**: Data retention requirements
- **Application Owner**: Owning application/team

See [Custom Properties](../../metadata-specifications/custom-properties.md)
for details on defining and using custom properties.

---

## Followers

Users can follow directories to receive notifications about new files, permission changes, and organizational structure updates. See **[Followers](../../metadata-specifications/followers.md)** for details.

---

## API Operations

All Directory operations are available under the `/v1/drives/directories` endpoint.

### List Directories

Get a list of directories, optionally filtered by service or parent directory.

```http
GET /v1/drives/directories
Query Parameters:
  - fields: Fields to include (owners, children, parent, tags, etc.)
  - service: Filter by drive service name (e.g., googleDrive)
  - parent: Filter by parent directory FQN
  - root: Include only root directories (boolean)
  - limit: Number of results (1-1000000, default 10)
  - before/after: Cursor-based pagination
  - include: all | deleted | non-deleted (default: non-deleted)

Response: DirectoryList
```

### Create Directory

Create a new directory under a drive service or parent directory.

```http
POST /v1/drives/directories
Content-Type: application/json

{
  "name": "Marketing",
  "driveService": "google_drive_workspace",
  "parent": "google_drive_workspace.Shared",
  "description": "Marketing team folder"
}

Response: Directory
```

### Get Directory by Name

Get a directory by its fully qualified name.

```http
GET /v1/drives/directories/name/{fqn}
Query Parameters:
  - fields: Fields to include
  - include: all | deleted | non-deleted

Example:
GET /v1/drives/directories/name/googleDrive.Marketing.Campaigns?fields=files,spreadsheets,owner

Response: Directory
```

### Get Directory by ID

Get a directory by its unique identifier.

```http
GET /v1/drives/directories/{id}
Query Parameters:
  - fields: Fields to include
  - include: all | deleted | non-deleted

Response: Directory
```

### Update Directory

Update a directory using JSON Patch.

```http
PATCH /v1/drives/directories/name/{fqn}
Content-Type: application/json-patch+json

[
  {"op": "add", "path": "/tags", "value": [{"tagFQN": "Tier.Gold"}]},
  {"op": "replace", "path": "/description", "value": "Updated description"}
]

Response: Directory
```

### Create or Update Directory

Create a new directory or update if it exists.

```http
PUT /v1/drives/directories
Content-Type: application/json

{
  "name": "Analytics",
  "driveService": "google_drive_workspace",
  "description": "Analytics team folder",
  "owner": "data-team"
}

Response: Directory
```

### Delete Directory

Delete a directory by fully qualified name.

```http
DELETE /v1/drives/directories/name/{fqn}
Query Parameters:
  - recursive: Delete children recursively (default: false)
  - hardDelete: Permanently delete (default: false)

Response: 200 OK
```

### Get Directory Versions

Get all versions of a directory.

```http
GET /v1/drives/directories/{id}/versions

Response: EntityHistory
```

### Get Specific Version

Get a specific version of a directory.

```http
GET /v1/drives/directories/{id}/versions/{version}

Response: Directory
```

### Follow Directory

Add a follower to a directory.

```http
PUT /v1/drives/directories/{id}/followers/{userId}

Response: ChangeEvent
```

### Get Followers

Get all followers of a directory.

```http
GET /v1/drives/directories/{id}/followers

Response: EntityReference[]
```

### Bulk Operations

Create or update multiple directories.

```http
PUT /v1/drives/directories/bulk
Content-Type: application/json

{
  "entities": [...]
}

Response: BulkOperationResult
```

---

## Related Documentation

- **[Drive Service](drive-service.md)** - Parent drive service
- **[Spreadsheet](spreadsheet.md)** - Spreadsheet files
- **[Worksheet](worksheet.md)** - Worksheets in spreadsheets
- **[File](file.md)** - Other files
- **[Pipeline](../pipelines/pipeline.md)** - Pipelines consuming drive files
