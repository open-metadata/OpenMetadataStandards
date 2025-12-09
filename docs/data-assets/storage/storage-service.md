
# Storage Service

**Object storage and file system services - infrastructure for unstructured data**

---

## Overview

The **StorageService** entity represents object storage systems and distributed file systems that store unstructured and semi-structured data. It serves as the root container for storage buckets, containers, and data lakes across cloud and on-premise infrastructure.

**Hierarchy**:
```mermaid
graph LR
    A[StorageService] --> B[Container]
    B --> C[DataFiles]

    style A fill:#667eea,color:#fff
    style B fill:#4facfe,color:#fff
    style C fill:#00f2fe,color:#333
```

**Supported Storage Systems**:

**Object Storage**:

- **AWS S3** - Amazon Simple Storage Service
- **Azure Blob Storage** - Microsoft Azure blob containers
- **Google Cloud Storage (GCS)** - Google Cloud storage buckets
- **MinIO** - S3-compatible object storage
- **Azure Data Lake Storage (ADLS)** - Gen1 and Gen2
- **Oracle Object Storage**
- **IBM Cloud Object Storage**
- **Alibaba Cloud OSS** - Alibaba Cloud Object Storage Service

**Distributed File Systems**:

- **HDFS** - Hadoop Distributed File System
- **NFS** - Network File System
- **Ceph** - Distributed object, block, and file storage

**Note**: For cloud document management platforms like Google Drive, OneDrive, and SharePoint, see [Drive Service](drive-service.md).

---

## Relationships

StorageService has comprehensive relationships with entities across the metadata platform:

```mermaid
graph TD
    subgraph Service Layer
        A[StorageService<br/>s3_prod]
    end

    subgraph Storage Containers
        A --> B1[Container:<br/>raw-data]
        A --> B2[Container:<br/>processed-data]
        A --> B3[Container:<br/>ml-models]
        A --> B4[Container:<br/>logs]

        B1 --> C1[File:<br/>events_2024.parquet]
        B1 --> C2[File:<br/>users.avro]
        B2 --> C3[File:<br/>sales_agg.parquet]
        B2 --> C4[File:<br/>customer_features.csv]
        B3 --> C5[File:<br/>model_v1.pkl]
        B4 --> C6[File:<br/>app_logs.json]
    end

    subgraph Ownership
        A -.->|owned by| D1[Team:<br/>Data Platform]
        A -.->|owned by| D2[User:<br/>platform.admin]
    end

    subgraph Governance
        A -.->|in domain| E[Domain:<br/>Data Lake]
        A -.->|has tags| F1[Tag:<br/>Production]
        A -.->|has tags| F2[Tag:<br/>Tier.Gold]
        A -.->|has tags| F3[Tag:<br/>Sensitive]
    end

    subgraph External Tables
        B1 -.->|referenced by| G1[External Table:<br/>raw_events]
        B2 -.->|referenced by| G2[External Table:<br/>sales_aggregated]
        B2 -.->|referenced by| G3[External Table:<br/>customer_features]
    end

    subgraph Pipeline Integration
        H1[Pipeline:<br/>data_ingestion] -.->|writes to| B1
        H2[Pipeline:<br/>data_processing] -.->|reads from| B1
        H2 -.->|writes to| B2

        I1[Pipeline:<br/>ml_training] -.->|reads from| B2
        I1 -.->|writes models to| B3

        J1[Pipeline:<br/>log_collection] -.->|writes to| B4
    end

    subgraph Data Quality
        B2 -.->|quality tests| K1[TestSuite:<br/>data_quality_checks]
        K1 -.->|validates| C3
        K1 -.->|validates| C4
    end

    subgraph Data Formats
        C1 -.->|format| L1[Parquet]
        C2 -.->|format| L2[Avro]
        C3 -.->|format| L1
        C4 -.->|format| L3[CSV]
    end

    style A fill:#667eea,color:#fff,stroke:#4c51bf,stroke-width:3px
    style B1 fill:#4facfe,color:#fff
    style B2 fill:#4facfe,color:#fff
    style B3 fill:#4facfe,color:#fff
    style B4 fill:#4facfe,color:#fff
    style C1 fill:#00f2fe,color:#333
    style C2 fill:#00f2fe,color:#333
    style C3 fill:#00f2fe,color:#333
    style C4 fill:#00f2fe,color:#333
    style C5 fill:#00f2fe,color:#333
    style C6 fill:#00f2fe,color:#333
    style D1 fill:#43e97b,color:#fff
    style D2 fill:#43e97b,color:#fff
    style E fill:#fa709a,color:#fff
    style F1 fill:#f093fb,color:#fff
    style F2 fill:#f093fb,color:#fff
    style F3 fill:#f093fb,color:#fff
    style G1 fill:#764ba2,color:#fff
    style G2 fill:#764ba2,color:#fff
    style G3 fill:#764ba2,color:#fff
    style H1 fill:#00ac69,color:#fff
    style H2 fill:#00ac69,color:#fff
    style I1 fill:#00ac69,color:#fff
    style J1 fill:#00ac69,color:#fff
    style K1 fill:#ffd700,color:#333
    style L1 fill:#ff6b6b,color:#fff
    style L2 fill:#ff6b6b,color:#fff
    style L3 fill:#ff6b6b,color:#fff
```

**Relationship Types**:

- **Solid lines (→)**: Hierarchical containment (Service contains Containers, Containers contain Files)
- **Dashed lines (-.->)**: References and associations (ownership, governance, external tables, pipelines, quality)

---

### Child Entities
- **Container**: Storage buckets/containers within this service (separate entity type, not a direct property)

### Associated Entities
- **Owners**: Users or teams owning this service
- **Domains**: Business domains this service belongs to
- **Tags**: Classification tags
- **Pipelines**: Ingestion pipelines deployed for this storage service
- **Followers**: Users following this service
- **Data Products**: Data products this service is part of
- **Ingestion Runner**: Agent responsible for executing ingestion pipelines
- **Table**: External tables pointing to storage (indirect relationship)
- **TestSuite**: Data quality tests for stored files (indirect relationship)

---

## Schema Specifications

View the complete StorageService schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/services/storageService.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "Storage Service",
      "description": "This schema defines the Storage Service entity, such as S3, GCS or AZURE.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.services.StorageService",
      "javaInterfaces": [
        "org.openmetadata.schema.EntityInterface",
        "org.openmetadata.schema.ServiceEntityInterface"
      ],

      "definitions": {
        "storageServiceType": {
          "description": "Type of storage service such as S3, GFS, AZURE...",
          "javaInterfaces": [
            "org.openmetadata.schema.EnumInterface"
          ],
          "type": "string",
          "enum": [
            "S3",
            "ADLS",
            "GCS",
            "CustomStorage"
          ],
          "javaEnums": [
            { "name": "S3" },
            { "name": "ADLS" },
            { "name": "GCS" },
            { "name": "CustomStorage" }
          ]
        },
        "storageConnection": {
          "type": "object",
          "javaType": "org.openmetadata.schema.type.StorageConnection",
          "description": "Storage Connection.",
          "javaInterfaces": [
            "org.openmetadata.schema.ServiceConnectionEntityInterface"
          ],
          "properties": {
            "config": {
              "mask": true,
              "oneOf": [
                { "$ref": "connections/storage/s3Connection.json" },
                { "$ref": "connections/storage/adlsConnection.json" },
                { "$ref": "connections/storage/gcsConnection.json" },
                { "$ref": "connections/storage/customStorageConnection.json" }
              ]
            }
          },
          "additionalProperties": false
        }
      },

      "properties": {
        "id": {
          "description": "Unique identifier of this storage service instance.",
          "$ref": "../../type/basic.json#/definitions/uuid"
        },
        "name": {
          "description": "Name that identifies this storage service.",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "FullyQualifiedName same as `name`.",
          "$ref": "../../type/basic.json#/definitions/fullyQualifiedEntityName"
        },
        "displayName": {
          "description": "Display Name that identifies this storage service.",
          "type": "string"
        },
        "serviceType": {
          "description": "Type of storage service such as S3, GCS, AZURE...",
          "$ref": "#/definitions/storageServiceType"
        },
        "description": {
          "description": "Description of a storage service instance.",
          "$ref": "../../type/basic.json#/definitions/markdown"
        },
        "connection": {
          "$ref": "#/definitions/storageConnection"
        },
        "pipelines": {
          "description": "References to pipelines deployed for this storage service to extract metadata, usage, lineage etc..",
          "$ref": "../../type/entityReferenceList.json"
        },
        "testConnectionResult": {
          "description": "Last test connection results for this service",
          "$ref": "connections/testConnectionResult.json"
        },
        "tags": {
          "description": "Tags for this storage Service.",
          "type": "array",
          "items": {
            "$ref": "../../type/tagLabel.json"
          },
          "default": []
        },
        "version": {
          "description": "Metadata version of the entity.",
          "$ref": "../../type/entityHistory.json#/definitions/entityVersion"
        },
        "updatedAt": {
          "description": "Last update time corresponding to the new version of the entity in Unix epoch time milliseconds.",
          "$ref": "../../type/basic.json#/definitions/timestamp"
        },
        "updatedBy": {
          "description": "User who made the update.",
          "type": "string"
        },
        "impersonatedBy": {
          "description": "Bot user that performed the action on behalf of the actual user.",
          "$ref": "../../type/basic.json#/definitions/impersonatedBy"
        },
        "href": {
          "description": "Link to the resource corresponding to this storage service.",
          "$ref": "../../type/basic.json#/definitions/href"
        },
        "owners": {
          "description": "Owners of this storage service.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "changeDescription": {
          "description": "Change that lead to this version of the entity.",
          "$ref": "../../type/entityHistory.json#/definitions/changeDescription"
        },
        "incrementalChangeDescription": {
          "description": "Change that lead to this version of the entity.",
          "$ref": "../../type/entityHistory.json#/definitions/changeDescription"
        },
        "deleted": {
          "description": "When `true` indicates the entity has been soft deleted.",
          "type": "boolean",
          "default": false
        },
        "dataProducts": {
          "description": "List of data products this entity is part of.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "followers": {
          "description": "Followers of this entity.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "domains": {
          "description": "Domains the Storage service belongs to.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "ingestionRunner": {
          "description": "The ingestion agent responsible for executing the ingestion pipeline.",
          "$ref": "../../type/entityReference.json"
        }
      },

      "required": ["id", "name", "serviceType"],
      "additionalProperties": false
    }
    ```

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/services/storageService.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2002/07/owl#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # StorageService Class Definition
    om:StorageService a owl:Class ;
        rdfs:subClassOf om:Service ;
        rdfs:label "Storage Service" ;
        rdfs:comment "This schema defines the Storage Service entity, such as S3, GCS or AZURE." ;
        om:hierarchyLevel 1 .

    # Datatype Properties
    om:serviceName a owl:DatatypeProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name that identifies this storage service" .

    om:fullyQualifiedName a owl:DatatypeProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range xsd:string ;
        rdfs:label "fullyQualifiedName" ;
        rdfs:comment "FullyQualifiedName same as name" .

    om:displayName a owl:DatatypeProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range xsd:string ;
        rdfs:label "displayName" ;
        rdfs:comment "Display Name that identifies this storage service" .

    om:description a owl:DatatypeProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range xsd:string ;
        rdfs:label "description" ;
        rdfs:comment "Description of a storage service instance" .

    om:serviceType a owl:DatatypeProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:StorageServiceType ;
        rdfs:label "serviceType" ;
        rdfs:comment "Type of storage service such as S3, GCS, AZURE..." .

    om:deleted a owl:DatatypeProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range xsd:boolean ;
        rdfs:label "deleted" ;
        rdfs:comment "When true indicates the entity has been soft deleted" .

    # Object Properties
    om:connection a owl:ObjectProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:StorageConnection ;
        rdfs:label "connection" ;
        rdfs:comment "Storage connection configuration" .

    om:hasPipeline a owl:ObjectProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:Pipeline ;
        rdfs:label "pipelines" ;
        rdfs:comment "References to pipelines deployed for this storage service to extract metadata, usage, lineage etc." .

    om:hasTestConnectionResult a owl:ObjectProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:TestConnectionResult ;
        rdfs:label "testConnectionResult" ;
        rdfs:comment "Last test connection results for this service" .

    om:hasOwner a owl:ObjectProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:Owner ;
        rdfs:label "owners" ;
        rdfs:comment "Owners of this storage service" .

    om:serviceHasTag a owl:ObjectProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:Tag ;
        rdfs:label "tags" ;
        rdfs:comment "Tags for this storage Service" .

    om:inDomain a owl:ObjectProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:Domain ;
        rdfs:label "domains" ;
        rdfs:comment "Domains the Storage service belongs to" .

    om:hasFollower a owl:ObjectProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:User ;
        rdfs:label "followers" ;
        rdfs:comment "Followers of this entity" .

    om:partOfDataProduct a owl:ObjectProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:DataProduct ;
        rdfs:label "dataProducts" ;
        rdfs:comment "List of data products this entity is part of" .

    om:hasIngestionRunner a owl:ObjectProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:IngestionRunner ;
        rdfs:label "ingestionRunner" ;
        rdfs:comment "The ingestion agent responsible for executing the ingestion pipeline" .

    # Storage Service Type Enumeration
    om:StorageServiceType a owl:Class ;
        owl:oneOf (
            om:S3StorageService
            om:ADLSStorageService
            om:GCSStorageService
            om:CustomStorageService
        ) .

    # Example Instance
    ex:s3ProductionService a om:StorageService ;
        om:serviceName "s3_prod" ;
        om:fullyQualifiedName "s3_prod" ;
        om:displayName "Production S3 Storage" ;
        om:description "Primary S3 storage for production data lake" ;
        om:serviceType om:S3StorageService ;
        om:hasOwner ex:dataEngTeam ;
        om:serviceHasTag ex:tierGold ;
        om:inDomain ex:dataPlatformDomain ;
        om:deleted false .
    ```

    **[View Full RDF Ontology →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/ontology/openmetadata.ttl)**

=== "JSON-LD"

    **JSON-LD Context and Example**

    ```json
    {
      "@context": {
        "@vocab": "https://open-metadata.org/schema/",
        "om": "https://open-metadata.org/schema/",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "xsd": "http://www.w3.org/2001/XMLSchema#",

        "StorageService": "om:StorageService",
        "name": {
          "@id": "om:serviceName",
          "@type": "xsd:string"
        },
        "fullyQualifiedName": {
          "@id": "om:fullyQualifiedName",
          "@type": "xsd:string"
        },
        "displayName": {
          "@id": "om:displayName",
          "@type": "xsd:string"
        },
        "description": {
          "@id": "om:description",
          "@type": "xsd:string"
        },
        "serviceType": {
          "@id": "om:serviceType",
          "@type": "@vocab"
        },
        "connection": {
          "@id": "om:connection",
          "@type": "@id"
        },
        "pipelines": {
          "@id": "om:hasPipeline",
          "@type": "@id",
          "@container": "@set"
        },
        "testConnectionResult": {
          "@id": "om:hasTestConnectionResult",
          "@type": "@id"
        },
        "owners": {
          "@id": "om:hasOwner",
          "@type": "@id",
          "@container": "@set"
        },
        "domains": {
          "@id": "om:inDomain",
          "@type": "@id",
          "@container": "@set"
        },
        "tags": {
          "@id": "om:serviceHasTag",
          "@type": "@id",
          "@container": "@set"
        },
        "followers": {
          "@id": "om:hasFollower",
          "@type": "@id",
          "@container": "@set"
        },
        "dataProducts": {
          "@id": "om:partOfDataProduct",
          "@type": "@id",
          "@container": "@set"
        },
        "ingestionRunner": {
          "@id": "om:hasIngestionRunner",
          "@type": "@id"
        },
        "deleted": {
          "@id": "om:deleted",
          "@type": "xsd:boolean"
        }
      }
    }
    ```

    **Example JSON-LD Instance**:

    ```json
    {
      "@context": "https://open-metadata.org/context/storageService.jsonld",
      "@type": "StorageService",
      "@id": "https://example.com/services/s3_prod",

      "name": "s3_prod",
      "fullyQualifiedName": "s3_prod",
      "displayName": "Production S3 Storage",
      "description": "Primary S3 storage for production data lake",
      "serviceType": "S3",

      "connection": {
        "@type": "StorageConnection",
        "config": {
          "@type": "S3Connection",
          "awsRegion": "us-east-1"
        }
      },

      "owners": [
        {
          "@id": "https://example.com/teams/data-engineering",
          "@type": "Team",
          "name": "data-engineering",
          "displayName": "Data Engineering Team"
        }
      ],

      "domains": [
        {
          "@id": "https://example.com/domains/DataPlatform",
          "@type": "Domain",
          "name": "DataPlatform"
        }
      ],

      "tags": [
        {
          "@id": "https://open-metadata.org/tags/Tier/Gold",
          "tagFQN": "Tier.Gold"
        },
        {
          "@id": "https://open-metadata.org/tags/Environment/Production",
          "tagFQN": "Environment.Production"
        }
      ],

      "pipelines": [
        {
          "@id": "https://example.com/pipelines/storage-metadata-ingestion",
          "@type": "Pipeline",
          "name": "storage-metadata-ingestion"
        }
      ],

      "followers": [
        {
          "@id": "https://example.com/users/john.doe",
          "@type": "User",
          "name": "john.doe"
        }
      ],

      "deleted": false
    }
    ```

    **[View Full JSON-LD Context →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/contexts/storageService.jsonld)**

---

## Use Cases

- Catalog cloud storage services (AWS S3, Azure Blob, GCS)
- Document on-premise file systems (HDFS)
- Track storage service ownership and governance
- Apply security and compliance tags
- Monitor storage costs and usage
- Manage access controls and permissions
- Track data lifecycle policies
- Document data lake architectures
- Support multi-cloud storage strategies

---

## JSON Schema Specification

### Core Properties

#### `id` (uuid)
**Type**: `string` (UUID format)
**Required**: Yes (system-generated)
**Description**: Unique identifier for this storage service instance

```json
{
  "id": "1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d"
}
```

---

#### `name` (entityName)
**Type**: `string`
**Required**: Yes
**Pattern**: `^[^.]*$` (no dots allowed)
**Min Length**: 1
**Max Length**: 256
**Description**: Name of the storage service (unqualified)

```json
{
  "name": "s3_prod"
}
```

---

#### `fullyQualifiedName` (fullyQualifiedEntityName)
**Type**: `string`
**Required**: Yes (system-generated)
**Pattern**: `^((?!::).)*$`
**Description**: Fully qualified name (same as name for services)

```json
{
  "fullyQualifiedName": "s3_prod"
}
```

---

#### `displayName`
**Type**: `string`
**Required**: No
**Description**: Human-readable display name

```json
{
  "displayName": "Production S3 Storage"
}
```

---

#### `description` (markdown)
**Type**: `string` (Markdown format)
**Required**: No
**Description**: Rich text description of the storage service

```json
{
  "description": "# Production S3 Storage\n\nPrimary S3 storage for production data lake.\n\n## Key Buckets\n- `raw-data` - Ingested raw files\n- `processed-data` - Transformed data\n- `archive` - Historical archives\n\n## Access\n- Production workloads only\n- Cross-account access via IAM roles"
}
```

---

### Service Configuration

#### `serviceType` (StorageServiceType enum)
**Type**: `string` enum
**Required**: Yes
**Allowed Values**:

- `S3` - Amazon S3
- `ADLS` - Azure Data Lake Storage
- `GCS` - Google Cloud Storage
- `CustomStorage` - Custom storage service

```json
{
  "serviceType": "S3"
}
```

---

#### `connection` (StorageConnection)
**Type**: `object`
**Required**: No
**Description**: Storage connection configuration (credentials, endpoints)

**S3 Connection Example**:

```json
{
  "connection": {
    "config": {
      "type": "S3",
      "awsAccessKeyId": "AKIAIOSFODNN7EXAMPLE",
      "awsSecretAccessKey": "***encrypted***",
      "awsRegion": "us-east-1",
      "endpointURL": "https://s3.amazonaws.com"
    }
  }
}
```

**GCS Connection Example**:

```json
{
  "connection": {
    "config": {
      "type": "GCS",
      "projectId": "my-gcp-project",
      "credentials": "***encrypted-service-account-json***"
    }
  }
}
```

**ADLS Connection Example**:

```json
{
  "connection": {
    "config": {
      "type": "ADLS",
      "accountName": "mystorageaccount",
      "accountKey": "***encrypted***"
    }
  }
}
```

**Custom Storage Connection Example**:

```json
{
  "connection": {
    "config": {
      "type": "CustomStorage",
      "connectionOptions": {
        "endpoint": "https://custom-storage.example.com",
        "apiKey": "***encrypted***"
      }
    }
  }
}
```

---

### Relationship Properties

#### `pipelines` (EntityReferenceList)
**Type**: `array` of Pipeline references
**Required**: No
**Description**: References to pipelines deployed for this storage service to extract metadata, usage, lineage etc.

```json
{
  "pipelines": [
    {
      "id": "2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e",
      "type": "pipeline",
      "name": "storage-metadata-ingestion",
      "fullyQualifiedName": "airflow.storage-metadata-ingestion"
    }
  ]
}
```

---

#### `testConnectionResult` (TestConnectionResult)
**Type**: `object`
**Required**: No
**Description**: Last test connection results for this service

```json
{
  "testConnectionResult": {
    "status": "Successful",
    "lastUpdatedAt": 1704240000000
  }
}
```

---

### Governance Properties

#### `owners` (EntityReferenceList)
**Type**: `array` of entity references
**Required**: No
**Description**: Owners of this storage service

```json
{
  "owners": [
    {
      "id": "4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a",
      "type": "team",
      "name": "data-engineering",
      "displayName": "Data Engineering Team"
    }
  ]
}
```

---

#### `domains` (EntityReferenceList)
**Type**: `array` of domain references
**Required**: No
**Description**: Domains the Storage service belongs to

```json
{
  "domains": [
    {
      "id": "5e6f7a8b-9c0d-1e2f-3a4b-5c6d7e8f9a0b",
      "type": "domain",
      "name": "DataPlatform",
      "fullyQualifiedName": "DataPlatform"
    }
  ]
}
```

---

#### `tags[]` (TagLabel[])
**Type**: `array`
**Required**: No
**Description**: Classification tags applied to the storage service

```json
{
  "tags": [
    {
      "tagFQN": "Tier.Gold",
      "description": "Production-critical storage",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    },
    {
      "tagFQN": "Environment.Production",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    },
    {
      "tagFQN": "Compliance.SOC2",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    }
  ]
}
```

---

#### `followers` (EntityReferenceList)
**Type**: `array` of user references
**Required**: No
**Description**: Followers of this entity

```json
{
  "followers": [
    {
      "id": "6f7a8b9c-0d1e-2f3a-4b5c-6d7e8f9a0b1c",
      "type": "user",
      "name": "john.doe",
      "displayName": "John Doe"
    }
  ]
}
```

---

#### `dataProducts` (EntityReferenceList)
**Type**: `array` of data product references
**Required**: No
**Description**: List of data products this entity is part of

```json
{
  "dataProducts": [
    {
      "id": "7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d",
      "type": "dataProduct",
      "name": "customer-analytics",
      "fullyQualifiedName": "customer-analytics"
    }
  ]
}
```

---

#### `ingestionRunner` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: The ingestion agent responsible for executing the ingestion pipeline

```json
{
  "ingestionRunner": {
    "id": "8b9c0d1e-2f3a-4b5c-6d7e-8f9a0b1c2d3e",
    "type": "ingestionPipeline",
    "name": "metadata-ingestion-runner"
  }
}
```

---

### Versioning Properties

#### `version` (entityVersion)
**Type**: `number`
**Required**: Yes (system-managed)
**Description**: Metadata version of the entity

```json
{
  "version": 1.2
}
```

---

#### `updatedAt` (timestamp)
**Type**: `integer` (Unix epoch milliseconds)
**Required**: No (system-managed)
**Description**: Last update time corresponding to the new version of the entity in Unix epoch time milliseconds

```json
{
  "updatedAt": 1704240000000
}
```

---

#### `updatedBy` (string)
**Type**: `string`
**Required**: No (system-managed)
**Description**: User who made the update

```json
{
  "updatedBy": "admin"
}
```

---

#### `impersonatedBy` (impersonatedBy)
**Type**: `object`
**Required**: No
**Description**: Bot user that performed the action on behalf of the actual user

```json
{
  "impersonatedBy": {
    "id": "9c0d1e2f-3a4b-5c6d-7e8f-9a0b1c2d3e4f",
    "type": "bot",
    "name": "ingestion-bot"
  }
}
```

---

#### `href` (href)
**Type**: `string` (URI)
**Required**: No (system-generated)
**Description**: Link to the resource corresponding to this storage service

```json
{
  "href": "https://openmetadata.example.com/api/v1/services/storageServices/1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d"
}
```

---

#### `changeDescription` (changeDescription)
**Type**: `object`
**Required**: No
**Description**: Change that lead to this version of the entity

```json
{
  "changeDescription": {
    "fieldsAdded": [],
    "fieldsUpdated": [
      {
        "name": "tags",
        "oldValue": [],
        "newValue": [{"tagFQN": "Tier.Gold"}]
      }
    ],
    "fieldsDeleted": [],
    "previousVersion": 1.1
  }
}
```

---

#### `incrementalChangeDescription` (changeDescription)
**Type**: `object`
**Required**: No
**Description**: Incremental change that lead to this version of the entity

```json
{
  "incrementalChangeDescription": {
    "fieldsAdded": [],
    "fieldsUpdated": [
      {
        "name": "description",
        "oldValue": "",
        "newValue": "Updated description"
      }
    ],
    "fieldsDeleted": [],
    "previousVersion": 1.1
  }
}
```

---

#### `deleted` (boolean)
**Type**: `boolean`
**Required**: No
**Default**: `false`
**Description**: When `true` indicates the entity has been soft deleted

```json
{
  "deleted": false
}
```

---

## Complete Example

### AWS S3 Storage Service

```json
{
  "id": "1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d",
  "name": "s3_prod",
  "fullyQualifiedName": "s3_prod",
  "displayName": "Production S3 Storage",
  "description": "# Production S3 Storage\n\nPrimary S3 storage for production data lake",
  "serviceType": "S3",
  "connection": {
    "config": {
      "type": "S3",
      "awsAccessKeyId": "AKIAIOSFODNN7EXAMPLE",
      "awsSecretAccessKey": "***encrypted***",
      "awsRegion": "us-east-1",
      "endpointURL": "https://s3.amazonaws.com"
    }
  },
  "pipelines": [
    {
      "id": "2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e",
      "type": "pipeline",
      "name": "storage-metadata-ingestion",
      "fullyQualifiedName": "airflow.storage-metadata-ingestion"
    }
  ],
  "owners": [
    {
      "id": "4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a",
      "type": "team",
      "name": "data-engineering"
    }
  ],
  "domains": [
    {
      "id": "5e6f7a8b-9c0d-1e2f-3a4b-5c6d7e8f9a0b",
      "type": "domain",
      "name": "DataPlatform"
    }
  ],
  "tags": [
    {"tagFQN": "Tier.Gold"},
    {"tagFQN": "Environment.Production"}
  ],
  "version": 1.2,
  "updatedAt": 1704240000000,
  "updatedBy": "admin",
  "deleted": false
}
```

### Google Cloud Storage Service

```json
{
  "id": "6f7a8b9c-0d1e-2f3a-4b5c-6d7e8f9a0b1c",
  "name": "gcs_datalake",
  "fullyQualifiedName": "gcs_datalake",
  "displayName": "GCS Data Lake",
  "description": "Google Cloud Storage data lake for analytics",
  "serviceType": "GCS",
  "connection": {
    "config": {
      "type": "GCS",
      "projectId": "my-analytics-project",
      "credentials": "***encrypted-service-account-json***"
    }
  },
  "owners": [
    {
      "type": "team",
      "name": "analytics-team"
    }
  ],
  "tags": [
    {"tagFQN": "Tier.Silver"}
  ],
  "version": 1.0,
  "updatedAt": 1704240000000,
  "updatedBy": "admin",
  "deleted": false
}
```

### Azure Data Lake Storage Service

```json
{
  "id": "7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d",
  "name": "adls_analytics",
  "fullyQualifiedName": "adls_analytics",
  "displayName": "ADLS Analytics Storage",
  "description": "Azure Data Lake Storage for analytics workloads",
  "serviceType": "ADLS",
  "connection": {
    "config": {
      "type": "ADLS",
      "accountName": "myanalyticsaccount",
      "accountKey": "***encrypted***"
    }
  },
  "owners": [
    {
      "type": "team",
      "name": "azure-platform"
    }
  ],
  "tags": [
    {"tagFQN": "Tier.Gold"},
    {"tagFQN": "Environment.Production"}
  ],
  "version": 2.1,
  "updatedAt": 1704240000000,
  "updatedBy": "admin",
  "deleted": false
}
```

---

## RDF Representation

### Ontology Class

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

om:StorageService a owl:Class ;
    rdfs:subClassOf om:Service ;
    rdfs:label "Storage Service" ;
    rdfs:comment "This schema defines the Storage Service entity, such as S3, GCS or AZURE." ;
    om:hasProperties [
        om:name "string" ;
        om:serviceType "StorageServiceType" ;
        om:connection "StorageConnection" ;
        om:pipelines "Pipeline[]" ;
        om:owners "Owner[]" ;
        om:domains "Domain[]" ;
        om:tags "Tag[]" ;
        om:followers "User[]" ;
        om:dataProducts "DataProduct[]" ;
        om:deleted "boolean" ;
    ] .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://example.com/services/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

ex:s3_prod a om:StorageService ;
    om:serviceName "s3_prod" ;
    om:fullyQualifiedName "s3_prod" ;
    om:displayName "Production S3 Storage" ;
    om:description "Primary S3 storage for production data lake" ;
    om:serviceType om:S3StorageService ;
    om:hasOwner ex:dataEngTeam ;
    om:serviceHasTag ex:tier_gold ;
    om:serviceHasTag ex:env_production ;
    om:inDomain ex:dataPlatformDomain ;
    om:hasPipeline ex:storageMetadataIngestion ;
    om:deleted "false"^^xsd:boolean .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "om": "https://open-metadata.org/schema/",
    "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
    "xsd": "http://www.w3.org/2001/XMLSchema#",
    "StorageService": "om:StorageService",
    "name": "om:serviceName",
    "fullyQualifiedName": "om:fullyQualifiedName",
    "displayName": "om:displayName",
    "description": "om:description",
    "serviceType": {
      "@id": "om:serviceType",
      "@type": "@vocab"
    },
    "connection": {
      "@id": "om:connection",
      "@type": "@id"
    },
    "pipelines": {
      "@id": "om:hasPipeline",
      "@type": "@id",
      "@container": "@set"
    },
    "owners": {
      "@id": "om:hasOwner",
      "@type": "@id",
      "@container": "@set"
    },
    "domains": {
      "@id": "om:inDomain",
      "@type": "@id",
      "@container": "@set"
    },
    "tags": {
      "@id": "om:serviceHasTag",
      "@type": "@id",
      "@container": "@set"
    },
    "followers": {
      "@id": "om:hasFollower",
      "@type": "@id",
      "@container": "@set"
    },
    "dataProducts": {
      "@id": "om:partOfDataProduct",
      "@type": "@id",
      "@container": "@set"
    },
    "deleted": {
      "@id": "om:deleted",
      "@type": "xsd:boolean"
    }
  }
}
```

### JSON-LD Example

```json
{
  "@context": "https://open-metadata.org/context/storageService.jsonld",
  "@type": "StorageService",
  "@id": "https://example.com/services/s3_prod",
  "name": "s3_prod",
  "fullyQualifiedName": "s3_prod",
  "displayName": "Production S3 Storage",
  "serviceType": "S3",
  "owners": [
    {
      "@id": "https://example.com/teams/data-engineering",
      "@type": "Team"
    }
  ],
  "domains": [
    {
      "@id": "https://example.com/domains/DataPlatform",
      "@type": "Domain"
    }
  ],
  "tags": [
    {"@id": "https://open-metadata.org/tags/Tier/Gold"},
    {"@id": "https://open-metadata.org/tags/Environment/Production"}
  ],
  "pipelines": [
    {
      "@id": "https://example.com/pipelines/storage-metadata-ingestion",
      "@type": "Pipeline"
    }
  ],
  "deleted": false
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

## API Operations

### Create Storage Service

```http
POST /api/v1/services/storageServices
Content-Type: application/json

{
  "name": "s3_prod",
  "serviceType": "S3",
  "connection": {
    "config": {
      "awsAccessKeyId": "AKIAIOSFODNN7EXAMPLE",
      "awsSecretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
      "awsRegion": "us-east-1"
    }
  }
}
```

### Get Storage Service

```http
GET /api/v1/services/storageServices/name/s3_prod?fields=owner,tags,containers
```

### Update Storage Service

```http
PATCH /api/v1/services/storageServices/{id}
Content-Type: application/json-patch+json

[
  {
    "op": "add",
    "path": "/tags/-",
    "value": {"tagFQN": "Tier.Gold"}
  }
]
```

### Test Connection

```http
POST /api/v1/services/storageServices/testConnection
Content-Type: application/json

{
  "connection": {
    "config": {
      "type": "S3",
      "awsAccessKeyId": "AKIAIOSFODNN7EXAMPLE",
      "awsSecretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
      "awsRegion": "us-east-1"
    }
  }
}
```

### Delete Storage Service

```http
DELETE /api/v1/services/storageServices/{id}?hardDelete=true&recursive=false
```

---

## Related Documentation

- **[Container](container.md)** - Storage container/bucket specification
- **[Pipeline](../pipelines/pipeline.md)** - Pipelines using storage
- **[External Tables](../databases/table.md)** - Tables on object storage
- **[Data Lake Architecture](../../guides/data-lake.md)** - Building data lakes
- **[Security](../../security/overview.md)** - Access control and encryption
