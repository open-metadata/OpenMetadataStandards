
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
- **Container**: Storage buckets/containers within this service

### Associated Entities
- **Owner**: User or team owning this service
- **Domain**: Business domain assignment
- **Tag**: Classification tags
- **Pipeline**: Pipelines reading/writing to this storage
- **Table**: External tables pointing to storage
- **TestSuite**: Data quality tests for stored files

---

## Schema Specifications

View the complete StorageService schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/services/storageService.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "StorageService",
      "description": "A `StorageService` entity represents an object storage or file system service.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.services.StorageService",

      "definitions": {
        "storageServiceType": {
          "description": "Type of storage service",
          "type": "string",
          "enum": [
            "S3", "ABFS", "GCS", "HDFS", "MinIO",
            "ADLS", "OracleObjectStorage", "IBMCloudObjectStorage"
          ]
        },
        "s3Connection": {
          "type": "object",
          "properties": {
            "awsAccessKeyId": {
              "type": "string",
              "description": "AWS Access Key ID"
            },
            "awsSecretAccessKey": {
              "type": "string",
              "description": "AWS Secret Access Key (encrypted)"
            },
            "awsRegion": {
              "type": "string",
              "description": "AWS Region"
            },
            "awsSessionToken": {
              "type": "string",
              "description": "AWS Session Token for temporary credentials"
            },
            "endpointURL": {
              "type": "string",
              "description": "Custom endpoint URL (for S3-compatible services)"
            }
          }
        },
        "gcsConnection": {
          "type": "object",
          "properties": {
            "credentials": {
              "type": "string",
              "description": "GCS service account JSON credentials"
            },
            "projectId": {
              "type": "string",
              "description": "GCP Project ID"
            }
          }
        },
        "azureConnection": {
          "type": "object",
          "properties": {
            "accountName": {
              "type": "string",
              "description": "Azure Storage Account Name"
            },
            "accountKey": {
              "type": "string",
              "description": "Azure Storage Account Key (encrypted)"
            },
            "connectionString": {
              "type": "string",
              "description": "Azure connection string"
            }
          }
        }
      },

      "properties": {
        "id": {
          "description": "Unique identifier",
          "$ref": "../../type/basic.json#/definitions/uuid"
        },
        "name": {
          "description": "Service name",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "Fully qualified name",
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
        "serviceType": {
          "$ref": "#/definitions/storageServiceType"
        },
        "connection": {
          "description": "Service connection configuration",
          "oneOf": [
            {"$ref": "#/definitions/s3Connection"},
            {"$ref": "#/definitions/gcsConnection"},
            {"$ref": "#/definitions/azureConnection"}
          ]
        },
        "containers": {
          "description": "Storage containers/buckets in this service",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "owner": {
          "description": "Owner (user or team)",
          "$ref": "../../type/entityReference.json"
        },
        "domain": {
          "description": "Data domain",
          "$ref": "../../type/entityReference.json"
        },
        "tags": {
          "description": "Classification tags",
          "type": "array",
          "items": {
            "$ref": "../../type/tagLabel.json"
          }
        },
        "version": {
          "description": "Metadata version",
          "$ref": "../../type/entityHistory.json#/definitions/entityVersion"
        }
      },

      "required": ["id", "name", "serviceType"]
    }
    ```

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/services/storageService.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2001/XMLSchema#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # StorageService Class Definition
    om:StorageService a owl:Class ;
        rdfs:subClassOf om:Service ;
        rdfs:label "StorageService" ;
        rdfs:comment "Object storage or file system service for unstructured data" ;
        om:hierarchyLevel 1 .

    # Properties
    om:serviceName a owl:DatatypeProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name of the storage service" .

    om:serviceType a owl:DatatypeProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:StorageServiceType ;
        rdfs:label "serviceType" ;
        rdfs:comment "Type of storage service (S3, GCS, Azure, HDFS, etc.)" .

    om:hasContainer a owl:ObjectProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:Container ;
        rdfs:label "hasContainer" ;
        rdfs:comment "Storage containers/buckets in this service" .

    om:serviceOwnedBy a owl:ObjectProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:Owner ;
        rdfs:label "ownedBy" ;
        rdfs:comment "User or team that owns this service" .

    om:serviceHasTag a owl:ObjectProperty ;
        rdfs:domain om:StorageService ;
        rdfs:range om:Tag ;
        rdfs:label "hasTag" ;
        rdfs:comment "Classification tags applied to service" .

    # Storage Service Type Enumeration
    om:StorageServiceType a owl:Class ;
        owl:oneOf (
            om:S3StorageService
            om:GCSStorageService
            om:AzureBlobStorageService
            om:HDFSStorageService
            om:MinIOStorageService
            om:ADLSStorageService
        ) .

    # Example Instance
    ex:s3ProductionService a om:StorageService ;
        om:serviceName "s3_prod" ;
        om:fullyQualifiedName "s3_prod" ;
        om:serviceType om:S3StorageService ;
        om:serviceOwnedBy ex:dataEngTeam ;
        om:serviceHasTag ex:tierGold ;
        om:hasContainer ex:rawDataBucket ;
        om:hasContainer ex:processedDataBucket .
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
        "containers": {
          "@id": "om:hasContainer",
          "@type": "@id",
          "@container": "@set"
        },
        "owner": {
          "@id": "om:serviceOwnedBy",
          "@type": "@id"
        },
        "domain": {
          "@id": "om:inDomain",
          "@type": "@id"
        },
        "tags": {
          "@id": "om:serviceHasTag",
          "@type": "@id",
          "@container": "@set"
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
        "awsRegion": "us-east-1",
        "endpointURL": "https://s3.amazonaws.com"
      },

      "owner": {
        "@id": "https://example.com/teams/data-engineering",
        "@type": "Team",
        "name": "data-engineering",
        "displayName": "Data Engineering Team"
      },

      "domain": {
        "@id": "https://example.com/domains/DataPlatform",
        "@type": "Domain",
        "name": "DataPlatform"
      },

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

      "containers": [
        {
          "@id": "https://example.com/storage/s3_prod/raw-data",
          "@type": "Container",
          "name": "raw-data"
        },
        {
          "@id": "https://example.com/storage/s3_prod/processed-data",
          "@type": "Container",
          "name": "processed-data"
        }
      ]
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
- `ABFS` - Azure Blob File System
- `GCS` - Google Cloud Storage
- `HDFS` - Hadoop Distributed File System
- `MinIO` - MinIO object storage
- `ADLS` - Azure Data Lake Storage
- `OracleObjectStorage` - Oracle Cloud Object Storage
- `IBMCloudObjectStorage` - IBM Cloud Object Storage

```json
{
  "serviceType": "S3"
}
```

---

#### `connection` (Connection)
**Type**: `object`
**Required**: Yes
**Description**: Service connection configuration (credentials, endpoints)

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

**Azure Blob Connection Example**:

```json
{
  "connection": {
    "config": {
      "type": "ABFS",
      "accountName": "mystorageaccount",
      "accountKey": "***encrypted***",
      "connectionString": "DefaultEndpointsProtocol=https;AccountName=..."
    }
  }
}
```

**HDFS Connection Example**:

```json
{
  "connection": {
    "config": {
      "type": "HDFS",
      "nameNodeHost": "hdfs-namenode.example.com",
      "nameNodePort": 9000,
      "kerberosEnabled": true,
      "kerberosPrincipal": "hdfs/namenode@EXAMPLE.COM"
    }
  }
}
```

---

### Relationship Properties

#### `containers[]` (Container[])
**Type**: `array` of Container references
**Required**: No
**Description**: Storage containers/buckets in this service

```json
{
  "containers": [
    {
      "id": "2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e",
      "type": "container",
      "name": "raw-data",
      "fullyQualifiedName": "s3_prod.raw-data"
    },
    {
      "id": "3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f",
      "type": "container",
      "name": "processed-data",
      "fullyQualifiedName": "s3_prod.processed-data"
    }
  ]
}
```

---

### Governance Properties

#### `owner` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: User or team that owns this storage service

```json
{
  "owner": {
    "id": "4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a",
    "type": "team",
    "name": "data-engineering",
    "displayName": "Data Engineering Team"
  }
}
```

---

#### `domain` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: Data domain this service belongs to

```json
{
  "domain": {
    "id": "5e6f7a8b-9c0d-1e2f-3a4b-5c6d7e8f9a0b",
    "type": "domain",
    "name": "DataPlatform",
    "fullyQualifiedName": "DataPlatform"
  }
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

### Versioning Properties

#### `version` (entityVersion)
**Type**: `number`
**Required**: Yes (system-managed)
**Description**: Metadata version number

```json
{
  "version": 1.2
}
```

---

#### `updatedAt` (timestamp)
**Type**: `integer` (Unix epoch milliseconds)
**Required**: Yes (system-managed)
**Description**: Last update timestamp

```json
{
  "updatedAt": 1704240000000
}
```

---

#### `updatedBy` (string)
**Type**: `string`
**Required**: Yes (system-managed)
**Description**: User who made the update

```json
{
  "updatedBy": "admin"
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
  "containers": [
    {
      "id": "2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e",
      "type": "container",
      "name": "raw-data",
      "fullyQualifiedName": "s3_prod.raw-data"
    },
    {
      "id": "3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f",
      "type": "container",
      "name": "processed-data",
      "fullyQualifiedName": "s3_prod.processed-data"
    }
  ],
  "owner": {
    "id": "4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a",
    "type": "team",
    "name": "data-engineering"
  },
  "domain": {
    "id": "5e6f7a8b-9c0d-1e2f-3a4b-5c6d7e8f9a0b",
    "type": "domain",
    "name": "DataPlatform"
  },
  "tags": [
    {"tagFQN": "Tier.Gold"},
    {"tagFQN": "Environment.Production"}
  ],
  "version": 1.2,
  "updatedAt": 1704240000000,
  "updatedBy": "admin"
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
  "owner": {
    "type": "team",
    "name": "analytics-team"
  },
  "tags": [
    {"tagFQN": "Tier.Silver"}
  ],
  "version": 1.0,
  "updatedAt": 1704240000000,
  "updatedBy": "admin"
}
```

### HDFS Service

```json
{
  "id": "7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d",
  "name": "hdfs_cluster",
  "fullyQualifiedName": "hdfs_cluster",
  "displayName": "Production HDFS Cluster",
  "description": "On-premise Hadoop HDFS cluster",
  "serviceType": "HDFS",
  "connection": {
    "config": {
      "type": "HDFS",
      "nameNodeHost": "hdfs-namenode.example.com",
      "nameNodePort": 9000,
      "kerberosEnabled": true
    }
  },
  "owner": {
    "type": "team",
    "name": "hadoop-ops"
  },
  "tags": [
    {"tagFQN": "Tier.Gold"},
    {"tagFQN": "Environment.OnPremise"}
  ],
  "version": 2.1,
  "updatedAt": 1704240000000,
  "updatedBy": "admin"
}
```

---

## RDF Representation

### Ontology Class

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl: <http://www.w3.org/2001/XMLSchema#> .

om:StorageService a owl:Class ;
    rdfs:subClassOf om:Service ;
    rdfs:label "StorageService" ;
    rdfs:comment "Object storage or file system service" ;
    om:hasProperties [
        om:name "string" ;
        om:serviceType "StorageServiceType" ;
        om:connection "Connection" ;
        om:containers "Container[]" ;
        om:owner "Owner" ;
        om:tags "Tag[]" ;
    ] .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://example.com/services/> .

ex:s3_prod a om:StorageService ;
    om:serviceName "s3_prod" ;
    om:fullyQualifiedName "s3_prod" ;
    om:displayName "Production S3 Storage" ;
    om:description "Primary S3 storage for production data lake" ;
    om:serviceType om:S3StorageService ;
    om:serviceOwnedBy ex:dataEngTeam ;
    om:serviceHasTag ex:tier_gold ;
    om:serviceHasTag ex:env_production ;
    om:hasContainer ex:rawDataBucket ;
    om:hasContainer ex:processedDataBucket .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "om": "https://open-metadata.org/schema/",
    "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
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
    "containers": {
      "@id": "om:hasContainer",
      "@type": "@id",
      "@container": "@set"
    },
    "owner": {
      "@id": "om:serviceOwnedBy",
      "@type": "@id"
    },
    "tags": {
      "@id": "om:serviceHasTag",
      "@type": "@id",
      "@container": "@set"
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
  "owner": {
    "@id": "https://example.com/teams/data-engineering",
    "@type": "Team"
  },
  "tags": [
    {"@id": "https://open-metadata.org/tags/Tier/Gold"},
    {"@id": "https://open-metadata.org/tags/Environment/Production"}
  ],
  "containers": [
    {
      "@id": "https://example.com/storage/s3_prod/raw-data",
      "@type": "Container",
      "name": "raw-data"
    }
  ]
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
