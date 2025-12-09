
# SearchService

**Search engine services - powering full-text search and analytics**

---

## Overview

The **SearchService** entity represents search engine services like Elasticsearch, OpenSearch, Solr, and other search platforms. It is the root container for search indices and their configurations, providing full-text search capabilities, analytics, and real-time data exploration.

**Hierarchy**:
```mermaid
graph LR
    A[SearchService] --> B[SearchIndex]
    B --> C[Fields]

    style A fill:#667eea,color:#fff
    style B fill:#4facfe,color:#fff
    style C fill:#00f2fe,color:#333
```

---

## Relationships

SearchService has comprehensive relationships with entities across the metadata platform:

```mermaid
graph TD
    subgraph Service Layer
        A[SearchService<br/>elasticsearch_prod]
    end

    subgraph Search Indices
        A --> B1[SearchIndex:<br/>products_idx]
        A --> B2[SearchIndex:<br/>customers_idx]
        A --> B3[SearchIndex:<br/>documents_idx]

        B1 --> C1[Field:<br/>product_name<br/>type: text, analyzed]
        B1 --> C2[Field:<br/>category<br/>type: keyword]
        B1 --> C3[Field:<br/>price<br/>type: float]

        B2 --> C4[Field:<br/>customer_name<br/>type: text]
        B2 --> C5[Field:<br/>email<br/>type: keyword]

        B3 --> C6[Field:<br/>content<br/>type: text]
        B3 --> C7[Field:<br/>tags<br/>type: keyword]
    end

    subgraph Ownership
        A -.->|owned by| D1[Team:<br/>Search Platform]
        A -.->|owned by| D2[User:<br/>search.admin]
    end

    subgraph Governance
        A -.->|in domain| E[Domain:<br/>Search Infrastructure]
        A -.->|has tags| F1[Tag:<br/>Production]
        A -.->|has tags| F2[Tag:<br/>Tier.Gold]
        A -.->|has tags| F3[Tag:<br/>Performance]
    end

    subgraph Source Data
        G1[Table:<br/>products] -.->|indexed into| B1
        G2[Table:<br/>customers] -.->|indexed into| B2
        G3[Table:<br/>documents] -.->|indexed into| B3

        H1[Pipeline:<br/>product_indexer] -.->|populates| B1
        H2[Pipeline:<br/>customer_indexer] -.->|populates| B2
        H3[Pipeline:<br/>document_indexer] -.->|populates| B3
    end

    subgraph Query Consumers
        I1[ApiEndpoint:<br/>GET /search/products] -.->|queries| B1
        I2[Dashboard:<br/>Search Analytics] -.->|monitors| A
        I3[Application:<br/>E-commerce Site] -.->|searches via| B1
        I4[Application:<br/>Customer Portal] -.->|searches via| B2
    end

    subgraph Index Configuration
        B1 -.->|settings| J1[Replicas: 2<br/>Shards: 5]
        B2 -.->|settings| J2[Replicas: 1<br/>Shards: 3]
        B3 -.->|settings| J3[Replicas: 2<br/>Shards: 5]
    end

    subgraph Data Quality
        K1[TestCase:<br/>index_freshness_check] -.->|validates| B1
        K2[TestCase:<br/>document_count_check] -.->|validates| B2
    end

    style A fill:#667eea,color:#fff,stroke:#4c51bf,stroke-width:3px
    style B1 fill:#4facfe,color:#fff
    style B2 fill:#4facfe,color:#fff
    style B3 fill:#4facfe,color:#fff
    style C1 fill:#00f2fe,color:#333
    style C2 fill:#00f2fe,color:#333
    style C3 fill:#00f2fe,color:#333
    style C4 fill:#00f2fe,color:#333
    style C5 fill:#00f2fe,color:#333
    style C6 fill:#00f2fe,color:#333
    style C7 fill:#00f2fe,color:#333
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
    style H3 fill:#00ac69,color:#fff
    style I1 fill:#ff6b6b,color:#fff
    style I2 fill:#ff6b6b,color:#fff
    style I3 fill:#ff6b6b,color:#fff
    style I4 fill:#ff6b6b,color:#fff
    style J1 fill:#ffd700,color:#333
    style J2 fill:#ffd700,color:#333
    style J3 fill:#ffd700,color:#333
    style K1 fill:#f5576c,color:#fff
    style K2 fill:#f5576c,color:#fff
```

**Relationship Types**:

- **Solid lines (→)**: Hierarchical containment (Service manages Indices, Indices contain Fields)
- **Dashed lines (-.->)**: References and associations (ownership, governance, data sources, queries, pipelines, quality)

---

### Child Entities
- **SearchIndex**: Search indices managed by this service

### Associated Entities
- **Owner**: User or team owning this service
- **Domain**: Business domain assignment
- **Tag**: Classification tags
- **Pipeline**: ETL pipelines loading data into search indices
- **Table**: Database tables indexed by search
- **ApiEndpoint**: API endpoints querying the search indices
- **Dashboard**: Monitoring dashboards for search analytics
- **TestCase**: Data quality tests for index freshness and completeness

---

## Schema Specifications

View the complete SearchService schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/services/searchService.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "Search Service",
      "description": "This schema defines the Search Service entity, such as ElasticSearch, OpenSearch.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.services.SearchService",
      "javaInterfaces": [
        "org.openmetadata.schema.EntityInterface",
        "org.openmetadata.schema.ServiceEntityInterface"
      ],

      "definitions": {
        "searchServiceType": {
          "description": "Type of search service such as ElasticSearch or OpenSearch.",
          "javaInterfaces": [
            "org.openmetadata.schema.EnumInterface"
          ],
          "type": "string",
          "enum": [
            "ElasticSearch",
            "OpenSearch",
            "CustomSearch"
          ],
          "javaEnums": [
            {
              "name": "ElasticSearch"
            },
            {
              "name": "OpenSearch"
            },
            {
              "name": "CustomSearch"
            }
          ]
        },
        "searchConnection": {
          "type": "object",
          "javaType": "org.openmetadata.schema.type.SearchConnection",
          "description": "search Connection.",
          "javaInterfaces": [
            "org.openmetadata.schema.ServiceConnectionEntityInterface"
          ],
          "properties": {
            "config": {
              "mask": true,
              "oneOf": [
                {
                  "$ref": "connections/search/elasticSearchConnection.json"
                },
                {
                  "$ref": "connections/search/openSearchConnection.json"
                },
                {
                  "$ref": "connections/search/customSearchConnection.json"
                }
              ]
            }
          },
          "additionalProperties": false
        }
      },

      "properties": {
        "id": {
          "description": "Unique identifier of this search service instance.",
          "$ref": "../../type/basic.json#/definitions/uuid"
        },
        "name": {
          "description": "Name that identifies this search service.",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "FullyQualifiedName same as `name`.",
          "$ref": "../../type/basic.json#/definitions/fullyQualifiedEntityName"
        },
        "displayName": {
          "description": "Display Name that identifies this search service.",
          "type": "string"
        },
        "serviceType": {
          "description": "Type of search service such as S3, GCS, AZURE...",
          "$ref": "#/definitions/searchServiceType"
        },
        "description": {
          "description": "Description of a search service instance.",
          "$ref": "../../type/basic.json#/definitions/markdown"
        },
        "connection": {
          "$ref": "#/definitions/searchConnection"
        },
        "pipelines": {
          "description": "References to pipelines deployed for this search service to extract metadata etc..",
          "$ref": "../../type/entityReferenceList.json"
        },
        "testConnectionResult": {
          "description": "Last test connection results for this service",
          "$ref": "connections/testConnectionResult.json"
        },
        "tags": {
          "description": "Tags for this search Service.",
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
          "description": "Link to the resource corresponding to this search service.",
          "$ref": "../../type/basic.json#/definitions/href"
        },
        "owners": {
          "description": "Owners of this search service.",
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
          "description": "Domains the search service belongs to.",
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

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/services/searchService.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2002/07/owl#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # SearchService Class Definition
    om:SearchService a owl:Class ;
        rdfs:subClassOf om:Service ;
        rdfs:label "SearchService" ;
        rdfs:comment "This schema defines the Search Service entity, such as ElasticSearch, OpenSearch." ;
        om:hierarchyLevel 1 .

    # Properties
    om:serviceName a owl:DatatypeProperty ;
        rdfs:domain om:SearchService ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name that identifies this search service" .

    om:fullyQualifiedName a owl:DatatypeProperty ;
        rdfs:domain om:SearchService ;
        rdfs:range xsd:string ;
        rdfs:label "fullyQualifiedName" ;
        rdfs:comment "FullyQualifiedName same as name" .

    om:displayName a owl:DatatypeProperty ;
        rdfs:domain om:SearchService ;
        rdfs:range xsd:string ;
        rdfs:label "displayName" ;
        rdfs:comment "Display Name that identifies this search service" .

    om:serviceType a owl:DatatypeProperty ;
        rdfs:domain om:SearchService ;
        rdfs:range om:SearchServiceType ;
        rdfs:label "serviceType" ;
        rdfs:comment "Type of search service such as ElasticSearch or OpenSearch" .

    om:hasConnection a owl:ObjectProperty ;
        rdfs:domain om:SearchService ;
        rdfs:range om:SearchConnection ;
        rdfs:label "hasConnection" ;
        rdfs:comment "Connection configuration for the search service" .

    om:hasPipeline a owl:ObjectProperty ;
        rdfs:domain om:SearchService ;
        rdfs:range om:Pipeline ;
        rdfs:label "hasPipeline" ;
        rdfs:comment "References to pipelines deployed for this search service to extract metadata" .

    om:hasSearchIndex a owl:ObjectProperty ;
        rdfs:domain om:SearchService ;
        rdfs:range om:SearchIndex ;
        rdfs:label "hasSearchIndex" ;
        rdfs:comment "Search indices in this service" .

    om:ownedBy a owl:ObjectProperty ;
        rdfs:domain om:SearchService ;
        rdfs:range om:Owner ;
        rdfs:label "ownedBy" ;
        rdfs:comment "Owners of this search service" .

    om:hasTag a owl:ObjectProperty ;
        rdfs:domain om:SearchService ;
        rdfs:range om:Tag ;
        rdfs:label "hasTag" ;
        rdfs:comment "Tags for this search Service" .

    om:inDomain a owl:ObjectProperty ;
        rdfs:domain om:SearchService ;
        rdfs:range om:Domain ;
        rdfs:label "inDomain" ;
        rdfs:comment "Domains the search service belongs to" .

    om:hasFollower a owl:ObjectProperty ;
        rdfs:domain om:SearchService ;
        rdfs:range om:User ;
        rdfs:label "hasFollower" ;
        rdfs:comment "Followers of this entity" .

    om:partOfDataProduct a owl:ObjectProperty ;
        rdfs:domain om:SearchService ;
        rdfs:range om:DataProduct ;
        rdfs:label "partOfDataProduct" ;
        rdfs:comment "List of data products this entity is part of" .

    # Service Type Enumeration
    om:SearchServiceType a owl:Class ;
        owl:oneOf (
            om:ElasticSearch
            om:OpenSearch
            om:CustomSearch
        ) .

    # Example Instance
    ex:elasticsearchProd a om:SearchService ;
        om:serviceName "elasticsearch_prod" ;
        om:fullyQualifiedName "elasticsearch_prod" ;
        om:displayName "Production Elasticsearch" ;
        om:serviceType om:ElasticSearch ;
        om:ownedBy ex:dataTeam ;
        om:hasTag ex:tierProduction ;
        om:hasSearchIndex ex:productsIndex ;
        om:hasSearchIndex ex:customersIndex ;
        om:inDomain ex:engineeringDomain .
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

        "SearchService": "om:SearchService",
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
          "@id": "om:hasConnection",
          "@type": "@id"
        },
        "pipelines": {
          "@id": "om:hasPipeline",
          "@type": "@id",
          "@container": "@set"
        },
        "indices": {
          "@id": "om:hasSearchIndex",
          "@type": "@id",
          "@container": "@set"
        },
        "owners": {
          "@id": "om:ownedBy",
          "@type": "@id",
          "@container": "@set"
        },
        "domains": {
          "@id": "om:inDomain",
          "@type": "@id",
          "@container": "@set"
        },
        "tags": {
          "@id": "om:hasTag",
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
        }
      }
    }
    ```

    **Example JSON-LD Instance**:

    ```json
    {
      "@context": "https://open-metadata.org/context/searchService.jsonld",
      "@type": "SearchService",
      "@id": "https://example.com/services/elasticsearch_prod",

      "name": "elasticsearch_prod",
      "fullyQualifiedName": "elasticsearch_prod",
      "displayName": "Production Elasticsearch Cluster",
      "description": "Primary Elasticsearch cluster for product search and analytics",
      "serviceType": "ElasticSearch",

      "connection": {
        "@type": "SearchConnection",
        "config": {
          "@type": "ElasticSearchConnection",
          "hostPort": "elasticsearch.example.com:9200",
          "scheme": "https",
          "username": "search_user"
        }
      },

      "owners": [
        {
          "@id": "https://example.com/teams/data-platform",
          "@type": "Team",
          "name": "data-platform",
          "displayName": "Data Platform Team"
        }
      ],

      "domains": [
        {
          "@id": "https://example.com/domains/Engineering",
          "@type": "Domain",
          "name": "Engineering"
        }
      ],

      "tags": [
        {
          "@id": "https://open-metadata.org/tags/Tier/Production",
          "tagFQN": "Tier.Production"
        },
        {
          "@id": "https://open-metadata.org/tags/Environment/Prod",
          "tagFQN": "Environment.Prod"
        }
      ],

      "pipelines": [
        {
          "@id": "https://example.com/pipelines/elasticsearch_metadata",
          "@type": "Pipeline",
          "name": "elasticsearch_metadata"
        }
      ],

      "indices": [
        {
          "@id": "https://example.com/search/elasticsearch_prod/products",
          "@type": "SearchIndex",
          "name": "products"
        },
        {
          "@id": "https://example.com/search/elasticsearch_prod/customers",
          "@type": "SearchIndex",
          "name": "customers"
        }
      ]
    }
    ```

    **[View Full JSON-LD Context →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/contexts/searchService.jsonld)**

---

## Use Cases

- Catalog search services across the organization (Elasticsearch, OpenSearch, Solr)
- Document search service configurations and connection details
- Track ownership and responsibility for search infrastructure
- Monitor search service health and performance
- Discover and inventory all search indices
- Apply governance policies to search services
- Track data lineage from source systems to search indices
- Manage access control and authentication

---

## JSON Schema Specification

### Core Properties

#### `id` (uuid)
**Type**: `string` (UUID format)
**Required**: Yes (system-generated)
**Description**: Unique identifier for this search service instance

```json
{
  "id": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d"
}
```

---

#### `name` (entityName)
**Type**: `string`
**Required**: Yes
**Pattern**: `^[^.]*$` (no dots allowed)
**Min Length**: 1
**Max Length**: 256
**Description**: Name of the search service (unqualified)

```json
{
  "name": "elasticsearch_prod"
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
  "fullyQualifiedName": "elasticsearch_prod"
}
```

---

#### `displayName`
**Type**: `string`
**Required**: No
**Description**: Human-readable display name

```json
{
  "displayName": "Production Elasticsearch Cluster"
}
```

---

#### `description` (markdown)
**Type**: `string` (Markdown format)
**Required**: No
**Description**: Rich text description of the search service's purpose and usage

```json
{
  "description": "# Production Elasticsearch Cluster\n\nPrimary search infrastructure for:\n- Product catalog search\n- Customer data analytics\n- Log aggregation and analysis\n\n## Configuration\n- **Cluster size**: 12 nodes (3 master, 9 data)\n- **Version**: 8.11.0\n- **Data retention**: 90 days\n- **Replication factor**: 2"
}
```

---

### Service Properties

#### `serviceType` (SearchServiceType enum)
**Type**: `string` enum
**Required**: Yes
**Allowed Values**:

- `ElasticSearch` - Elastic Elasticsearch
- `OpenSearch` - OpenSearch
- `CustomSearch` - Custom search implementation

```json
{
  "serviceType": "ElasticSearch"
}
```

---

#### `connection` (SearchConnection)
**Type**: `object`
**Required**: No
**Description**: Connection configuration for the search service

**SearchConnection Properties**:

The `searchConnection` object contains a `config` property with a `oneOf` constraint that accepts:
- `elasticSearchConnection.json` - Configuration for ElasticSearch
- `openSearchConnection.json` - Configuration for OpenSearch
- `customSearchConnection.json` - Configuration for custom search implementations

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `config` | object (oneOf) | Yes | Connection configuration specific to the service type |

**Example for ElasticSearch**:

```json
{
  "connection": {
    "config": {
      "type": "ElasticSearch",
      "hostPort": "elasticsearch.example.com:9200",
      "scheme": "https",
      "username": "search_user",
      "password": "encrypted_password"
    }
  }
}
```

**Example for OpenSearch**:

```json
{
  "connection": {
    "config": {
      "type": "OpenSearch",
      "hostPort": "opensearch.example.com:9200",
      "scheme": "https",
      "username": "search_user",
      "password": "encrypted_password"
    }
  }
}
```

**Example for CustomSearch**:

```json
{
  "connection": {
    "config": {
      "type": "CustomSearch",
      "connectionOptions": {
        "key": "value"
      }
    }
  }
}
```

---

### Governance Properties

#### `owners` (EntityReferenceList)
**Type**: `array` of EntityReference objects
**Required**: No
**Description**: Owners of this search service

```json
{
  "owners": [
    {
      "id": "d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a",
      "type": "team",
      "name": "data-platform",
      "displayName": "Data Platform Team"
    }
  ]
}
```

---

#### `domains` (EntityReferenceList)
**Type**: `array` of EntityReference objects
**Required**: No
**Description**: Domains the search service belongs to

```json
{
  "domains": [
    {
      "id": "e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b",
      "type": "domain",
      "name": "Engineering",
      "fullyQualifiedName": "Engineering"
    }
  ]
}
```

---

#### `tags[]` (TagLabel[])
**Type**: `array`
**Required**: No
**Description**: Classification tags applied to the search service

```json
{
  "tags": [
    {
      "tagFQN": "Tier.Production",
      "description": "Production-grade service",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    },
    {
      "tagFQN": "Environment.Prod",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    }
  ]
}
```

---

#### `pipelines` (EntityReferenceList)
**Type**: `array` of EntityReference objects
**Required**: No
**Description**: References to pipelines deployed for this search service to extract metadata

```json
{
  "pipelines": [
    {
      "id": "f1e2d3c4-b5a6-4c7d-8e9f-0a1b2c3d4e5f",
      "type": "pipeline",
      "name": "elasticsearch_metadata",
      "fullyQualifiedName": "elasticsearch_prod.elasticsearch_metadata"
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
    "status": "successful",
    "lastTestAt": 1704240000000
  }
}
```

---

#### `followers` (EntityReferenceList)
**Type**: `array` of EntityReference objects
**Required**: No
**Description**: Followers of this entity

```json
{
  "followers": [
    {
      "id": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d",
      "type": "user",
      "name": "john.doe",
      "displayName": "John Doe"
    }
  ]
}
```

---

#### `dataProducts` (EntityReferenceList)
**Type**: `array` of EntityReference objects
**Required**: No
**Description**: List of data products this entity is part of

```json
{
  "dataProducts": [
    {
      "id": "b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e",
      "type": "dataProduct",
      "name": "search-analytics",
      "fullyQualifiedName": "search-analytics"
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
    "id": "c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f",
    "type": "ingestionRunner",
    "name": "default-runner",
    "fullyQualifiedName": "default-runner"
  }
}
```

---

#### `href` (URI)
**Type**: `string` (URI format)
**Required**: No (system-generated)
**Description**: Link to the resource corresponding to this search service

```json
{
  "href": "https://api.example.com/v1/services/searchServices/a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d"
}
```

---

#### `changeDescription` (ChangeDescription)
**Type**: `object`
**Required**: No (system-managed)
**Description**: Change that lead to this version of the entity

```json
{
  "changeDescription": {
    "fieldsAdded": [],
    "fieldsUpdated": [{"name": "description", "oldValue": "...", "newValue": "..."}],
    "fieldsDeleted": [],
    "previousVersion": 1.1
  }
}
```

---

#### `incrementalChangeDescription` (ChangeDescription)
**Type**: `object`
**Required**: No (system-managed)
**Description**: Incremental change that lead to this version of the entity

```json
{
  "incrementalChangeDescription": {
    "fieldsAdded": [],
    "fieldsUpdated": [{"name": "tags", "oldValue": "...", "newValue": "..."}],
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

#### `impersonatedBy` (string)
**Type**: `string`
**Required**: No (system-managed)
**Description**: Bot user that performed the action on behalf of the actual user

```json
{
  "impersonatedBy": "bot-user"
}
```

---

### Versioning Properties

#### `version` (entityVersion)
**Type**: `number`
**Required**: Yes (system-managed)
**Description**: Metadata version number, incremented on changes

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

```json
{
  "id": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d",
  "name": "elasticsearch_prod",
  "fullyQualifiedName": "elasticsearch_prod",
  "displayName": "Production Elasticsearch Cluster",
  "description": "# Production Elasticsearch Cluster\n\nPrimary search infrastructure for product catalog and analytics.",
  "serviceType": "ElasticSearch",
  "connection": {
    "config": {
      "type": "ElasticSearch",
      "hostPort": "elasticsearch.example.com:9200",
      "scheme": "https",
      "username": "search_user",
      "password": "encrypted_password"
    }
  },
  "pipelines": [
    {
      "id": "f1e2d3c4-b5a6-4c7d-8e9f-0a1b2c3d4e5f",
      "type": "pipeline",
      "name": "elasticsearch_metadata",
      "fullyQualifiedName": "elasticsearch_prod.elasticsearch_metadata"
    }
  ],
  "testConnectionResult": {
    "status": "successful",
    "lastTestAt": 1704240000000
  },
  "owners": [
    {
      "id": "d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a",
      "type": "team",
      "name": "data-platform",
      "displayName": "Data Platform Team"
    }
  ],
  "domains": [
    {
      "id": "e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b",
      "type": "domain",
      "name": "Engineering"
    }
  ],
  "tags": [
    {"tagFQN": "Tier.Production"},
    {"tagFQN": "Environment.Prod"}
  ],
  "followers": [
    {
      "id": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d",
      "type": "user",
      "name": "john.doe"
    }
  ],
  "dataProducts": [
    {
      "id": "b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e",
      "type": "dataProduct",
      "name": "search-analytics"
    }
  ],
  "ingestionRunner": {
    "id": "c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f",
    "type": "ingestionRunner",
    "name": "default-runner"
  },
  "href": "https://api.example.com/v1/services/searchServices/a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d",
  "version": 1.2,
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

om:SearchService a owl:Class ;
    rdfs:subClassOf om:Service ;
    rdfs:label "SearchService" ;
    rdfs:comment "This schema defines the Search Service entity, such as ElasticSearch, OpenSearch." ;
    om:hasProperties [
        om:name "string" ;
        om:serviceType "SearchServiceType" ;
        om:connection "SearchConnection" ;
        om:owners "EntityReferenceList" ;
        om:domains "EntityReferenceList" ;
        om:tags "TagLabel[]" ;
        om:pipelines "EntityReferenceList" ;
        om:followers "EntityReferenceList" ;
        om:dataProducts "EntityReferenceList" ;
    ] .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://example.com/> .

ex:elasticsearch_prod a om:SearchService ;
    om:name "elasticsearch_prod" ;
    om:fullyQualifiedName "elasticsearch_prod" ;
    om:displayName "Production Elasticsearch Cluster" ;
    om:description "Primary search infrastructure" ;
    om:serviceType "ElasticSearch" ;
    om:ownedBy ex:data_platform_team ;
    om:inDomain ex:engineering_domain ;
    om:hasTag ex:tier_production ;
    om:hasSearchIndex ex:products_index ;
    om:hasSearchIndex ex:customers_index ;
    om:hasPipeline ex:elasticsearch_metadata_pipeline ;
    om:hasFollower ex:john_doe ;
    om:partOfDataProduct ex:search_analytics .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "om": "https://open-metadata.org/schema/",
    "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
    "SearchService": "om:SearchService",
    "name": "om:name",
    "fullyQualifiedName": "om:fullyQualifiedName",
    "displayName": "om:displayName",
    "description": "om:description",
    "serviceType": "om:serviceType",
    "connection": {
      "@id": "om:hasConnection",
      "@type": "@id"
    },
    "pipelines": {
      "@id": "om:hasPipeline",
      "@type": "@id",
      "@container": "@set"
    },
    "owners": {
      "@id": "om:ownedBy",
      "@type": "@id",
      "@container": "@set"
    },
    "domains": {
      "@id": "om:inDomain",
      "@type": "@id",
      "@container": "@set"
    },
    "tags": {
      "@id": "om:hasTag",
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
    }
  }
}
```

### JSON-LD Example

```json
{
  "@context": "https://open-metadata.org/context/searchService.jsonld",
  "@type": "SearchService",
  "@id": "https://example.com/services/elasticsearch_prod",
  "name": "elasticsearch_prod",
  "fullyQualifiedName": "elasticsearch_prod",
  "displayName": "Production Elasticsearch Cluster",
  "serviceType": "ElasticSearch",
  "connection": {
    "@type": "SearchConnection",
    "config": {
      "@type": "ElasticSearchConnection",
      "hostPort": "elasticsearch.example.com:9200",
      "scheme": "https"
    }
  },
  "owners": [
    {
      "@id": "https://example.com/teams/data-platform",
      "@type": "Team"
    }
  ],
  "domains": [
    {
      "@id": "https://example.com/domains/Engineering",
      "@type": "Domain"
    }
  ],
  "tags": [
    {"@id": "https://open-metadata.org/tags/Tier/Production"}
  ],
  "pipelines": [
    {
      "@id": "https://example.com/pipelines/elasticsearch_metadata",
      "@type": "Pipeline"
    }
  ],
  "followers": [
    {
      "@id": "https://example.com/users/john.doe",
      "@type": "User"
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

### Create SearchService

```http
POST /api/v1/services/searchServices
Content-Type: application/json

{
  "name": "elasticsearch_prod",
  "serviceType": "Elasticsearch",
  "connection": {
    "hostPort": "elasticsearch.example.com:9200",
    "scheme": "https",
    "username": "search_user"
  }
}
```

### Get SearchService

```http
GET /api/v1/services/searchServices/name/elasticsearch_prod?fields=owner,tags,connection
```

### Update SearchService

```http
PATCH /api/v1/services/searchServices/{id}
Content-Type: application/json-patch+json

[
  {
    "op": "add",
    "path": "/tags/-",
    "value": {"tagFQN": "Tier.Production"}
  }
]
```

### Test Connection

```http
POST /api/v1/services/searchServices/testConnection
Content-Type: application/json

{
  "connection": {
    "hostPort": "elasticsearch.example.com:9200",
    "scheme": "https",
    "username": "search_user",
    "password": "test_password"
  },
  "serviceType": "Elasticsearch"
}
```

### List Search Indices

```http
GET /api/v1/services/searchServices/{id}/searchIndices
```

---

## Related Documentation

- **[SearchIndex](search-index.md)** - Search index entity
- **[Data Lineage](../../lineage/overview.md)** - Tracking data flow to search
- **[Service Configuration](../../services/overview.md)** - General service setup
- **[API Integration](../../apis/overview.md)** - REST API integration
