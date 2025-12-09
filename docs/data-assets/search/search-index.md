
# SearchIndex

**Search indices - structured data for full-text search and analytics**

---

## Overview

The **SearchIndex** entity represents search indices in search engines like Elasticsearch and OpenSearch. It captures index mappings, field definitions, analyzers, settings, and the relationships between indexed data and source systems.

**Hierarchy**:
```
Search Service → Search Index → Fields
```

---

## Schema Specifications

View the complete SearchIndex schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/data/SearchIndex.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "SearchIndex",
      "description": "A `SearchIndex` is a index mapping definition in ElasticSearch or OpenSearch",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.data.SearchIndex",

      "definitions": {
        "searchIndexField": {
          "type": "object",
          "javaType": "org.openmetadata.schema.type.SearchIndexField",
          "description": "This schema defines the type for a field in a searchIndex.",
          "properties": {
            "name": {
              "type": "string",
              "description": "Local name (not fully qualified name) of the field.",
              "minLength": 1,
              "maxLength": 256,
              "pattern": "^((?!::).)*$"
            },
            "displayName": {
              "type": "string",
              "description": "Display Name that identifies this searchIndexField name."
            },
            "dataType": {
              "type": "string",
              "description": "Data type of the searchIndex (int, date etc.).",
              "enum": [
                "NUMBER", "TEXT", "BINARY", "TIMESTAMP", "TIMESTAMPZ",
                "TIME", "DATE", "DATETIME", "KEYWORD", "ARRAY", "OBJECT",
                "FLATTENED", "NESTED", "JOIN", "RANGE", "IP", "VERSION",
                "MURMUR3", "AGGREGATE_METRIC_DOUBLE", "HISTOGRAM",
                "ANNOTATED-TEXT", "COMPLETION", "SEARCH_AS_YOU_TYPE",
                "DENSE_VECTOR", "RANK_FEATURE", "RANK_FEATURES",
                "GEO_POINT", "GEO_SHAPE", "POINT", "SHAPE", "PERCOLATOR",
                "BOOLEAN", "CONSTANT_KEYWORD", "WILDCARD", "LONG",
                "INTEGER", "SHORT", "BYTE", "DOUBLE", "FLOAT",
                "HALF_FLOAT", "SCALED_FLOAT", "UNSIGNED_LONG", "UNKNOWN"
              ]
            },
            "dataTypeDisplay": {
              "type": "string",
              "description": "Display name used for dataType."
            },
            "description": {
              "type": "string",
              "description": "Description of the field.",
              "$ref": "../../type/basic.json#/definitions/markdown"
            },
            "fullyQualifiedName": {
              "$ref": "../../type/basic.json#/definitions/fullyQualifiedEntityName"
            },
            "tags": {
              "description": "Tags associated with the column.",
              "type": "array",
              "items": {
                "$ref": "../../type/tagLabel.json"
              }
            },
            "children": {
              "description": "Child columns if dataType has properties.",
              "type": "array",
              "items": {
                "$ref": "#/definitions/searchIndexField"
              }
            }
          },
          "required": ["name", "dataType"]
        },
        "searchIndexSettings": {
          "javaType": "org.openmetadata.schema.type.searchindex.SearchIndexSettings",
          "description": "Contains key/value pair of SearchIndex Settings.",
          "type": "object",
          "additionalProperties": {
            "type": "string"
          }
        },
        "searchIndexSampleData": {
          "type": "object",
          "javaType": "org.openmetadata.schema.type.searchindex.SearchIndexSampleData",
          "description": "This schema defines the type to capture sample data for a SearchIndex.",
          "properties": {
            "messages": {
              "description": "List of local sample messages for a SearchIndex.",
              "type": "array",
              "items": {
                "type": "string"
              }
            }
          }
        },
        "indexType": {
          "description": "Whether the entity is index or index template.",
          "type": "string",
          "enum": ["Index", "IndexTemplate"],
          "default": "Index"
        }
      },

      "properties": {
        "id": {
          "description": "Unique identifier that identifies this SearchIndex instance.",
          "$ref": "../../type/basic.json#/definitions/uuid"
        },
        "name": {
          "description": "Name that identifies the SearchIndex.",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "Name that uniquely identifies a SearchIndex in the format 'searchServiceName.searchIndexName'.",
          "$ref": "../../type/basic.json#/definitions/fullyQualifiedEntityName"
        },
        "displayName": {
          "description": "Display Name that identifies this SearchIndex. It could be title or label from the source services.",
          "type": "string"
        },
        "description": {
          "description": "Description of the SearchIndex instance.",
          "$ref": "../../type/basic.json#/definitions/markdown"
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
        "service": {
          "description": "Link to the search cluster/service where this SearchIndex is hosted in.",
          "$ref": "../../type/entityReference.json"
        },
        "serviceType": {
          "description": "Service type where this SearchIndex is hosted in.",
          "$ref": "../services/searchService.json#/definitions/searchServiceType"
        },
        "fields": {
          "description": "Fields in this SearchIndex.",
          "type": "array",
          "items": {
            "$ref": "#/definitions/searchIndexField"
          }
        },
        "searchIndexSettings": {
          "description": "Contains key/value pair of searchIndex settings.",
          "$ref": "#/definitions/searchIndexSettings"
        },
        "indexType": {
          "description": "Whether the entity is index or index template.",
          "$ref": "#/definitions/indexType",
          "default": "Index"
        },
        "sampleData": {
          "description": "Sample data for a searchIndex.",
          "$ref": "#/definitions/searchIndexSampleData"
        },
        "owners": {
          "description": "Owners of this searchIndex.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "followers": {
          "description": "Followers of this searchIndex.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "tags": {
          "description": "Tags for this searchIndex.",
          "type": "array",
          "items": {
            "$ref": "../../type/tagLabel.json"
          }
        },
        "href": {
          "description": "Link to the resource corresponding to this entity.",
          "$ref": "../../type/basic.json#/definitions/href"
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
        "extension": {
          "description": "Entity extension data with custom attributes added to the entity.",
          "$ref": "../../type/basic.json#/definitions/entityExtension"
        },
        "domains": {
          "description": "Domains the SearchIndex belongs to. When not set, the SearchIndex inherits the domain from the messaging service it belongs to.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "dataProducts": {
          "description": "List of data products this entity is part of.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "votes": {
          "description": "Votes on the entity.",
          "$ref": "../../type/votes.json"
        },
        "lifeCycle": {
          "description": "Life Cycle of the entity",
          "$ref": "../../type/lifeCycle.json"
        },
        "certification": {
          "$ref": "../../type/assetCertification.json"
        },
        "sourceHash": {
          "description": "Source hash of the entity",
          "type": "string",
          "minLength": 1,
          "maxLength": 32
        },
        "entityStatus": {
          "description": "Status of the SearchIndex.",
          "$ref": "../../type/status.json"
        }
      },

      "required": ["id", "name", "service", "fields"]
    }
    ```

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/searchIndex.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2001/XMLSchema#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # SearchIndex Class Definition
    om:SearchIndex a owl:Class ;
        rdfs:subClassOf om:DataAsset ;
        rdfs:label "SearchIndex" ;
        rdfs:comment "A search index containing structured data for full-text search and analytics" ;
        om:hierarchyLevel 2 .

    # Properties
    om:indexName a owl:DatatypeProperty ;
        rdfs:domain om:SearchIndex ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name of the search index" .

    om:fullyQualifiedName a owl:DatatypeProperty ;
        rdfs:domain om:SearchIndex ;
        rdfs:range xsd:string ;
        rdfs:label "fullyQualifiedName" ;
        rdfs:comment "Complete hierarchical name: service.index" .

    om:hasField a owl:ObjectProperty ;
        rdfs:domain om:SearchIndex ;
        rdfs:range om:SearchIndexField ;
        rdfs:label "hasField" ;
        rdfs:comment "Fields in this search index" .

    om:hasSettings a owl:ObjectProperty ;
        rdfs:domain om:SearchIndex ;
        rdfs:range om:IndexSettings ;
        rdfs:label "hasSettings" ;
        rdfs:comment "Index settings (shards, replicas, etc.)" .

    om:belongsToService a owl:ObjectProperty ;
        rdfs:domain om:SearchIndex ;
        rdfs:range om:SearchService ;
        rdfs:label "belongsToService" ;
        rdfs:comment "Parent search service" .

    om:ownedBy a owl:ObjectProperty ;
        rdfs:domain om:SearchIndex ;
        rdfs:range om:Owner ;
        rdfs:label "owners" ;
        rdfs:comment "Users or teams that own this index" .

    om:hasTag a owl:ObjectProperty ;
        rdfs:domain om:SearchIndex ;
        rdfs:range om:Tag ;
        rdfs:label "hasTag" ;
        rdfs:comment "Classification tags applied to index" .

    om:linkedToGlossaryTerm a owl:ObjectProperty ;
        rdfs:domain om:SearchIndex ;
        rdfs:range om:GlossaryTerm ;
        rdfs:label "linkedToGlossaryTerm" ;
        rdfs:comment "Business glossary terms" .

    # SearchIndexField Class
    om:SearchIndexField a owl:Class ;
        rdfs:label "SearchIndexField" ;
        rdfs:comment "A field in a search index with its mapping and analyzer configuration" .

    om:fieldDataType a owl:DatatypeProperty ;
        rdfs:domain om:SearchIndexField ;
        rdfs:range xsd:string ;
        rdfs:label "dataType" ;
        rdfs:comment "Data type: text, keyword, long, date, etc." .

    om:analyzer a owl:DatatypeProperty ;
        rdfs:domain om:SearchIndexField ;
        rdfs:range xsd:string ;
        rdfs:label "analyzer" ;
        rdfs:comment "Analyzer used for indexing" .

    # Example Instance
    ex:productsIndex a om:SearchIndex ;
        om:indexName "products" ;
        om:fullyQualifiedName "elasticsearch_prod.products" ;
        om:displayName "Product Catalog Index" ;
        om:belongsToService ex:elasticsearchProd ;
        om:ownedBy ex:searchTeam ;
        om:hasTag ex:tierGold ;
        om:hasField ex:productIdField ;
        om:hasField ex:productNameField ;
        om:hasField ex:descriptionField .
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

        "SearchIndex": "om:SearchIndex",
        "name": {
          "@id": "om:indexName",
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
        "fields": {
          "@id": "om:hasField",
          "@type": "@id",
          "@container": "@list"
        },
        "settings": {
          "@id": "om:hasSettings",
          "@type": "@id"
        },
        "service": {
          "@id": "om:belongsToService",
          "@type": "@id"
        },
        "owners": {
          "@id": "om:ownedBy",
          "@type": "@id",
          "@container": "@set"
        },
        "followers": {
          "@id": "om:followedBy",
          "@type": "@id",
          "@container": "@set"
        },
        "domains": {
          "@id": "om:inDomain",
          "@type": "@id",
          "@container": "@set"
        },
        "dataProducts": {
          "@id": "om:partOfDataProduct",
          "@type": "@id",
          "@container": "@set"
        },
        "tags": {
          "@id": "om:hasTag",
          "@type": "@id",
          "@container": "@set"
        }
      }
    }
    ```

    **Example JSON-LD Instance**:

    ```json
    {
      "@context": "https://open-metadata.org/context/searchIndex.jsonld",
      "@type": "SearchIndex",
      "@id": "https://example.com/search/elasticsearch_prod/products",

      "name": "products",
      "fullyQualifiedName": "elasticsearch_prod.products",
      "displayName": "Product Catalog Index",
      "description": "Full-text search index for the product catalog with advanced filtering",

      "service": {
        "@id": "https://example.com/services/elasticsearch_prod",
        "@type": "SearchService",
        "name": "elasticsearch_prod"
      },

      "searchIndexSettings": {
        "@type": "SearchIndexSettings",
        "numberOfShards": "5",
        "numberOfReplicas": "2",
        "refreshInterval": "1s"
      },

      "owners": [
        {
          "@id": "https://example.com/teams/search-team",
          "@type": "Team",
          "name": "search-team",
          "displayName": "Search Team"
        }
      ],

      "tags": [
        {
          "@id": "https://open-metadata.org/tags/Tier/Gold",
          "tagFQN": "Tier.Gold"
        }
      ],

      "fields": [
        {
          "@type": "SearchIndexField",
          "name": "product_id",
          "dataType": "KEYWORD",
          "description": "Unique product identifier"
        },
        {
          "@type": "SearchIndexField",
          "name": "product_name",
          "dataType": "TEXT",
          "dataTypeDisplay": "text",
          "children": [
            {
              "name": "keyword",
              "dataType": "KEYWORD"
            }
          ]
        }
      ]
    }
    ```

    **[View Full JSON-LD Context →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/contexts/searchIndex.jsonld)**

---

## Use Cases

- Catalog all search indices across Elasticsearch and OpenSearch
- Document index mappings, field definitions, and analyzers
- Track ownership and responsibility for search indices
- Apply governance tags to search data
- Capture lineage from source tables to search indices
- Monitor index performance and storage
- Define data quality rules for indexed data
- Document search use cases and query patterns

---

## JSON Schema Specification

### Core Properties

#### `id` (uuid)
**Type**: `string` (UUID format)
**Required**: Yes (system-generated)
**Description**: Unique identifier for this search index instance

```json
{
  "id": "b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e"
}
```

---

#### `name` (entityName)
**Type**: `string`
**Required**: Yes
**Pattern**: `^[^.]*$` (no dots allowed)
**Min Length**: 1
**Max Length**: 256
**Description**: Name of the search index (unqualified)

```json
{
  "name": "products"
}
```

---

#### `fullyQualifiedName` (fullyQualifiedEntityName)
**Type**: `string`
**Required**: Yes (system-generated)
**Pattern**: `^((?!::).)*$`
**Description**: Fully qualified name in the format `service.index`

```json
{
  "fullyQualifiedName": "elasticsearch_prod.products"
}
```

---

#### `displayName`
**Type**: `string`
**Required**: No
**Description**: Human-readable display name

```json
{
  "displayName": "Product Catalog Search Index"
}
```

---

#### `description` (markdown)
**Type**: `string` (Markdown format)
**Required**: No
**Description**: Rich text description of the index's purpose and usage

```json
{
  "description": "# Product Catalog Search Index\n\nFull-text search index for the product catalog with:\n- Advanced text analysis for product names and descriptions\n- Faceted search by category, brand, price\n- Autocomplete suggestions\n\n## Data Source\nIndexed from `postgres_prod.ecommerce.products` table\n\n## Update Frequency\nReal-time updates via Change Data Capture"
}
```

---

### Structure Properties

#### `fields[]` (SearchIndexField[])
**Type**: `array` of SearchIndexField objects
**Required**: Yes
**Description**: List of fields in the search index

**SearchIndexField Object Properties**:

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `name` | string | Yes | Field name (local name, not fully qualified) |
| `displayName` | string | No | Display name for the field |
| `dataType` | DataType enum | Yes | Field data type |
| `dataTypeDisplay` | string | No | Display name used for dataType |
| `description` | markdown | No | Field description |
| `fullyQualifiedName` | string | No | Fully qualified field name |
| `tags` | TagLabel[] | No | Tags associated with the column |
| `children` | SearchIndexField[] | No | Child columns if dataType has properties |

**Data Types** (Elasticsearch/OpenSearch):
- Text types: `TEXT`, `KEYWORD`, `ANNOTATED-TEXT`, `COMPLETION`, `SEARCH_AS_YOU_TYPE`, `WILDCARD`, `CONSTANT_KEYWORD`
- Numeric types: `NUMBER`, `LONG`, `INTEGER`, `SHORT`, `BYTE`, `DOUBLE`, `FLOAT`, `HALF_FLOAT`, `SCALED_FLOAT`, `UNSIGNED_LONG`
- Date/Time types: `DATE`, `TIME`, `DATETIME`, `TIMESTAMP`, `TIMESTAMPZ`
- Boolean type: `BOOLEAN`
- Binary type: `BINARY`
- Range types: `RANGE`
- Complex types: `OBJECT`, `NESTED`, `FLATTENED`, `ARRAY`
- Geo types: `GEO_POINT`, `GEO_SHAPE`, `POINT`, `SHAPE`
- Specialized types: `IP`, `VERSION`, `MURMUR3`, `AGGREGATE_METRIC_DOUBLE`, `HISTOGRAM`, `DENSE_VECTOR`, `RANK_FEATURE`, `RANK_FEATURES`, `JOIN`, `PERCOLATOR`, `UNKNOWN`

**Example**:

```json
{
  "fields": [
    {
      "name": "product_id",
      "dataType": "KEYWORD",
      "dataTypeDisplay": "keyword",
      "description": "Unique product identifier"
    },
    {
      "name": "product_name",
      "dataType": "TEXT",
      "dataTypeDisplay": "text",
      "description": "Product name with full-text search",
      "children": [
        {
          "name": "keyword",
          "dataType": "KEYWORD",
          "description": "Exact match field"
        },
        {
          "name": "suggest",
          "dataType": "COMPLETION",
          "description": "Autocomplete suggestions"
        }
      ]
    },
    {
      "name": "description",
      "dataType": "TEXT",
      "dataTypeDisplay": "text",
      "description": "Product description with English language analysis"
    },
    {
      "name": "price",
      "dataType": "SCALED_FLOAT",
      "dataTypeDisplay": "scaled_float",
      "description": "Product price"
    },
    {
      "name": "categories",
      "dataType": "KEYWORD",
      "description": "Product categories (array)"
    },
    {
      "name": "created_at",
      "dataType": "DATE",
      "dataTypeDisplay": "date",
      "description": "Product creation timestamp"
    },
    {
      "name": "location",
      "dataType": "GEO_POINT",
      "description": "Geographic location of product availability"
    },
    {
      "name": "attributes",
      "dataType": "NESTED",
      "description": "Product attributes as nested objects",
      "children": [
        {
          "name": "name",
          "dataType": "KEYWORD"
        },
        {
          "name": "value",
          "dataType": "TEXT"
        }
      ]
    }
  ]
}
```

---

#### `searchIndexSettings` (SearchIndexSettings)
**Type**: `object`
**Required**: No
**Description**: Contains key/value pair of searchIndex settings

**SearchIndexSettings Properties**:

SearchIndexSettings is an object with string key/value pairs for any index-specific settings such as:

| Property | Type | Description |
|----------|------|-------------|
| `numberOfShards` | string | Number of primary shards |
| `numberOfReplicas` | string | Number of replica shards |
| `refreshInterval` | string | How often the index is refreshed (e.g., "1s") |
| `maxResultWindow` | string | Maximum pagination depth |
| Any custom setting | string | Additional custom settings as key/value pairs |

**Example**:

```json
{
  "searchIndexSettings": {
    "numberOfShards": "5",
    "numberOfReplicas": "2",
    "refreshInterval": "1s",
    "maxResultWindow": "10000",
    "analysis.analyzer.custom_english.type": "custom",
    "analysis.analyzer.custom_english.tokenizer": "standard"
  }
}
```

---

#### `indexType` (IndexType enum)
**Type**: `string`
**Required**: No
**Default**: `Index`
**Description**: Whether the entity is index or index template

**Allowed Values**:
- `Index`: Regular search index
- `IndexTemplate`: Index template

**Example**:

```json
{
  "indexType": "Index"
}
```

---

#### `sampleData` (SearchIndexSampleData)
**Type**: `object`
**Required**: No
**Description**: Sample data for a searchIndex

**SearchIndexSampleData Properties**:

| Property | Type | Description |
|----------|------|-------------|
| `messages` | array of strings | List of local sample messages for a SearchIndex |

**Example**:

```json
{
  "sampleData": {
    "messages": [
      "{\"product_id\":\"P001\",\"product_name\":\"Widget\",\"price\":29.99}",
      "{\"product_id\":\"P002\",\"product_name\":\"Gadget\",\"price\":49.99}"
    ]
  }
}
```

---

### Location Properties

#### `service` (EntityReference)
**Type**: `object`
**Required**: Yes
**Description**: Link to the search cluster/service where this SearchIndex is hosted in

```json
{
  "service": {
    "id": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d",
    "type": "searchService",
    "name": "elasticsearch_prod",
    "fullyQualifiedName": "elasticsearch_prod"
  }
}
```

---

#### `serviceType` (SearchServiceType)
**Type**: `string` (enum)
**Required**: No
**Description**: Service type where this SearchIndex is hosted in

**Allowed Values**: `ElasticSearch`, `OpenSearch`, `CustomSearch`

```json
{
  "serviceType": "ElasticSearch"
}
```

---

### Governance Properties

#### `owners` (EntityReferenceList)
**Type**: `array` of EntityReference
**Required**: No
**Description**: Owners of this searchIndex

```json
{
  "owners": [
    {
      "id": "d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a",
      "type": "team",
      "name": "search-team",
      "displayName": "Search Team"
    }
  ]
}
```

---

#### `followers` (EntityReferenceList)
**Type**: `array` of EntityReference
**Required**: No
**Description**: Followers of this searchIndex

```json
{
  "followers": [
    {
      "id": "user-uuid-1",
      "type": "user",
      "name": "john.doe"
    }
  ]
}
```

---

#### `domains` (EntityReferenceList)
**Type**: `array` of EntityReference
**Required**: No
**Description**: Domains the SearchIndex belongs to. When not set, the SearchIndex inherits the domain from the messaging service it belongs to

```json
{
  "domains": [
    {
      "id": "e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b",
      "type": "domain",
      "name": "Product",
      "fullyQualifiedName": "Product"
    }
  ]
}
```

---

#### `dataProducts` (EntityReferenceList)
**Type**: `array` of EntityReference
**Required**: No
**Description**: List of data products this entity is part of

```json
{
  "dataProducts": [
    {
      "id": "dataproduct-uuid",
      "type": "dataProduct",
      "name": "ProductCatalog",
      "fullyQualifiedName": "ProductCatalog"
    }
  ]
}
```

---

#### `tags[]` (TagLabel[])
**Type**: `array`
**Required**: No
**Description**: Tags for this searchIndex

```json
{
  "tags": [
    {
      "tagFQN": "Tier.Gold",
      "description": "Critical search index",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    },
    {
      "tagFQN": "PII.Sensitive",
      "source": "Classification",
      "labelType": "Automated",
      "state": "Confirmed"
    }
  ]
}
```

---

#### `votes` (Votes)
**Type**: `object`
**Required**: No
**Description**: Votes on the entity

```json
{
  "votes": {
    "upVotes": 10,
    "downVotes": 2,
    "upVoters": ["user1", "user2"],
    "downVoters": ["user3"]
  }
}
```

---

#### `lifeCycle` (LifeCycle)
**Type**: `object`
**Required**: No
**Description**: Life Cycle of the entity

```json
{
  "lifeCycle": {
    "stage": "Production",
    "created": {
      "timestamp": 1704240000000,
      "user": "admin"
    }
  }
}
```

---

#### `certification` (AssetCertification)
**Type**: `object`
**Required**: No
**Description**: Asset certification information

```json
{
  "certification": {
    "tagLabel": {
      "tagFQN": "Certification.Gold"
    },
    "certifiedBy": "data-governance-team",
    "certifiedAt": 1704240000000
  }
}
```

---

### System Properties

#### `href` (href)
**Type**: `string` (URL)
**Required**: No (system-managed)
**Description**: Link to the resource corresponding to this entity

```json
{
  "href": "https://openmetadata.org/api/v1/searchIndexes/b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e"
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

#### `extension` (EntityExtension)
**Type**: `object`
**Required**: No
**Description**: Entity extension data with custom attributes added to the entity

```json
{
  "extension": {
    "customField1": "value1",
    "customField2": "value2"
  }
}
```

---

#### `sourceHash` (string)
**Type**: `string`
**Required**: No
**Min Length**: 1
**Max Length**: 32
**Description**: Source hash of the entity

```json
{
  "sourceHash": "abc123def456"
}
```

---

#### `entityStatus` (Status)
**Type**: `object`
**Required**: No
**Description**: Status of the SearchIndex

```json
{
  "entityStatus": {
    "status": "Active"
  }
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
    "fieldsAdded": [{"name": "newField", "newValue": "value"}],
    "fieldsUpdated": [],
    "fieldsDeleted": [],
    "previousVersion": 1.0
  }
}
```

---

#### `incrementalChangeDescription` (ChangeDescription)
**Type**: `object`
**Required**: No (system-managed)
**Description**: Change that lead to this version of the entity

---

#### `impersonatedBy` (ImpersonatedBy)
**Type**: `string`
**Required**: No
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
  "version": 1.5
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
  "updatedBy": "search.admin"
}
```

---

## Complete Example

```json
{
  "id": "b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e",
  "name": "products",
  "fullyQualifiedName": "elasticsearch_prod.products",
  "displayName": "Product Catalog Search Index",
  "description": "# Product Catalog Search Index\n\nFull-text search index for the product catalog.",
  "service": {
    "id": "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d",
    "type": "searchService",
    "name": "elasticsearch_prod",
    "fullyQualifiedName": "elasticsearch_prod"
  },
  "serviceType": "ElasticSearch",
  "fields": [
    {
      "name": "product_id",
      "dataType": "KEYWORD",
      "dataTypeDisplay": "keyword",
      "description": "Unique product identifier"
    },
    {
      "name": "product_name",
      "dataType": "TEXT",
      "dataTypeDisplay": "text",
      "description": "Product name with full-text search",
      "children": [
        {
          "name": "keyword",
          "dataType": "KEYWORD"
        },
        {
          "name": "suggest",
          "dataType": "COMPLETION"
        }
      ]
    },
    {
      "name": "description",
      "dataType": "TEXT",
      "dataTypeDisplay": "text",
      "description": "Product description"
    },
    {
      "name": "price",
      "dataType": "SCALED_FLOAT",
      "dataTypeDisplay": "scaled_float"
    },
    {
      "name": "categories",
      "dataType": "KEYWORD",
      "description": "Product categories"
    },
    {
      "name": "created_at",
      "dataType": "DATE",
      "dataTypeDisplay": "date"
    }
  ],
  "searchIndexSettings": {
    "numberOfShards": "5",
    "numberOfReplicas": "2",
    "refreshInterval": "1s",
    "maxResultWindow": "10000"
  },
  "indexType": "Index",
  "sampleData": {
    "messages": [
      "{\"product_id\":\"P001\",\"product_name\":\"Widget\",\"price\":29.99}"
    ]
  },
  "owners": [
    {
      "id": "d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a",
      "type": "team",
      "name": "search-team",
      "displayName": "Search Team"
    }
  ],
  "followers": [
    {
      "id": "user-uuid-1",
      "type": "user",
      "name": "john.doe"
    }
  ],
  "domains": [
    {
      "id": "e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b",
      "type": "domain",
      "name": "Product",
      "fullyQualifiedName": "Product"
    }
  ],
  "dataProducts": [
    {
      "id": "dataproduct-uuid",
      "type": "dataProduct",
      "name": "ProductCatalog",
      "fullyQualifiedName": "ProductCatalog"
    }
  ],
  "tags": [
    {
      "tagFQN": "Tier.Gold",
      "labelType": "Manual",
      "state": "Confirmed"
    }
  ],
  "votes": {
    "upVotes": 10,
    "downVotes": 2
  },
  "lifeCycle": {
    "stage": "Production"
  },
  "certification": {
    "tagLabel": {
      "tagFQN": "Certification.Gold"
    }
  },
  "version": 1.5,
  "updatedAt": 1704240000000,
  "updatedBy": "search.admin",
  "href": "https://openmetadata.org/api/v1/searchIndexes/b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e",
  "deleted": false
}
```

---

## RDF Representation

### Ontology Class

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl: <http://www.w3.org/2001/XMLSchema#> .

om:SearchIndex a owl:Class ;
    rdfs:subClassOf om:DataAsset ;
    rdfs:label "SearchIndex" ;
    rdfs:comment "A search index mapping definition in ElasticSearch or OpenSearch" ;
    om:hasProperties [
        om:name "string" ;
        om:fields "SearchIndexField[]" ;
        om:searchIndexSettings "SearchIndexSettings" ;
        om:indexType "IndexType" ;
        om:service "SearchService" ;
        om:owners "Owner[]" ;
        om:followers "User[]" ;
        om:domains "Domain[]" ;
        om:dataProducts "DataProduct[]" ;
        om:tags "Tag[]" ;
        om:votes "Votes" ;
        om:lifeCycle "LifeCycle" ;
        om:certification "AssetCertification" ;
    ] .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://example.com/> .

ex:products_index a om:SearchIndex ;
    om:name "products" ;
    om:fullyQualifiedName "elasticsearch_prod.products" ;
    om:displayName "Product Catalog Search Index" ;
    om:description "Full-text search index for products" ;
    om:belongsToService ex:elasticsearch_prod ;
    om:serviceType "ElasticSearch" ;
    om:indexType "Index" ;
    om:ownedBy ex:search_team ;
    om:followedBy ex:user1 ;
    om:inDomain ex:product_domain ;
    om:partOfDataProduct ex:product_catalog ;
    om:hasTag ex:tier_gold ;
    om:hasField ex:product_id_field ;
    om:hasField ex:product_name_field ;
    om:hasField ex:description_field .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "om": "https://open-metadata.org/schema/",
    "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
    "SearchIndex": "om:SearchIndex",
    "name": "om:name",
    "fullyQualifiedName": "om:fullyQualifiedName",
    "displayName": "om:displayName",
    "description": "om:description",
    "fields": {
      "@id": "om:hasField",
      "@type": "@id",
      "@container": "@list"
    },
    "searchIndexSettings": {
      "@id": "om:hasSettings",
      "@type": "@id"
    },
    "indexType": "om:indexType",
    "sampleData": {
      "@id": "om:hasSampleData",
      "@type": "@id"
    },
    "service": {
      "@id": "om:belongsToService",
      "@type": "@id"
    },
    "serviceType": "om:serviceType",
    "owners": {
      "@id": "om:ownedBy",
      "@type": "@id",
      "@container": "@set"
    },
    "followers": {
      "@id": "om:followedBy",
      "@type": "@id",
      "@container": "@set"
    },
    "domains": {
      "@id": "om:inDomain",
      "@type": "@id",
      "@container": "@set"
    },
    "dataProducts": {
      "@id": "om:partOfDataProduct",
      "@type": "@id",
      "@container": "@set"
    },
    "tags": {
      "@id": "om:hasTag",
      "@type": "@id",
      "@container": "@set"
    },
    "votes": {
      "@id": "om:hasVotes",
      "@type": "@id"
    },
    "lifeCycle": {
      "@id": "om:hasLifeCycle",
      "@type": "@id"
    },
    "certification": {
      "@id": "om:hasCertification",
      "@type": "@id"
    }
  }
}
```

### JSON-LD Example

```json
{
  "@context": "https://open-metadata.org/context/searchIndex.jsonld",
  "@type": "SearchIndex",
  "@id": "https://example.com/search/elasticsearch_prod/products",
  "name": "products",
  "fullyQualifiedName": "elasticsearch_prod.products",
  "displayName": "Product Catalog Search Index",
  "service": {
    "@id": "https://example.com/services/elasticsearch_prod",
    "@type": "SearchService"
  },
  "serviceType": "ElasticSearch",
  "indexType": "Index",
  "owners": [
    {
      "@id": "https://example.com/teams/search-team",
      "@type": "Team"
    }
  ],
  "followers": [
    {
      "@id": "https://example.com/users/john.doe",
      "@type": "User"
    }
  ],
  "domains": [
    {
      "@id": "https://example.com/domains/Product",
      "@type": "Domain"
    }
  ],
  "tags": [
    {"@id": "https://open-metadata.org/tags/Tier/Gold"}
  ],
  "fields": [
    {
      "@type": "SearchIndexField",
      "name": "product_id",
      "dataType": "KEYWORD"
    },
    {
      "@type": "SearchIndexField",
      "name": "product_name",
      "dataType": "TEXT",
      "children": [
        {
          "name": "keyword",
          "dataType": "KEYWORD"
        }
      ]
    }
  ]
}
```

---

## Relationships

SearchIndex has comprehensive relationships with entities across the metadata platform:

```mermaid
graph TD
    subgraph Hierarchy
        SVC[SearchService<br/>elasticsearch_prod]
        SVC --> IDX[SearchIndex<br/>products]
    end

    subgraph Fields
        IDX --> F1[Field<br/>product_id: keyword]
        IDX --> F2[Field<br/>product_name: text]
        IDX --> F3[Field<br/>description: text]
        IDX --> F4[Field<br/>price: scaled_float]
        IDX --> F5[Field<br/>categories: keyword]
        IDX --> F6[Field<br/>location: geo_point]
    end

    subgraph Source Data
        TBL1[Table<br/>products] -.->|indexed from| IDX
        TBL2[Table<br/>product_details] -.->|enriches| IDX
        TBL3[Table<br/>product_inventory] -.->|supplements| IDX
    end

    subgraph Pipelines
        PIPE1[Pipeline<br/>product_indexing] -.->|feeds| IDX
        PIPE2[Pipeline<br/>realtime_sync] -.->|updates| IDX
        CDC[Pipeline<br/>cdc_connector] -.->|streams to| IDX
    end

    subgraph Query Consumers
        APP1[Application<br/>search_ui] -.->|queries| IDX
        APP2[Application<br/>recommendation_engine] -.->|queries| IDX
        API[ApiEndpoint<br/>product_search] -.->|queries| IDX
    end

    subgraph Ownership
        IDX -.->|owned by| TEAM[Team<br/>Search Team]
        IDX -.->|owned by| USER[User<br/>search.admin]
    end

    subgraph Governance
        IDX -.->|in domains| DOM[Domain<br/>Product Catalog]
        IDX -.->|part of| DP[DataProduct<br/>ProductCatalog]
        IDX -.->|tagged| TAG1[Tag<br/>Tier.Gold]
        IDX -.->|tagged| TAG2[Tag<br/>Production]
        IDX -.->|tagged| TAG3[Tag<br/>PII.Sensitive]
        IDX -.->|has votes| VOTES[Votes<br/>10 up, 2 down]
        IDX -.->|certified| CERT[Certification<br/>Gold]
    end

    subgraph Quality
        TC1[TestCase<br/>index_freshness] -.->|monitors| IDX
        TC2[TestCase<br/>query_performance] -.->|tracks| IDX
        TC3[TestCase<br/>schema_validation] -.->|validates| F2
    end

    subgraph Monitoring
        DASH[Dashboard<br/>Search Metrics] -.->|monitors| IDX
        ALERT[Alert<br/>index_lag_alert] -.->|watches| IDX
    end

    style SVC fill:#667eea,color:#fff
    style IDX fill:#4facfe,color:#fff,stroke:#4c51bf,stroke-width:3px
    style F1 fill:#00f2fe,color:#333
    style F2 fill:#00f2fe,color:#333
    style F3 fill:#00f2fe,color:#333
    style F4 fill:#00f2fe,color:#333
    style F5 fill:#00f2fe,color:#333
    style F6 fill:#00f2fe,color:#333
    style TBL1 fill:#764ba2,color:#fff
    style TBL2 fill:#764ba2,color:#fff
    style TBL3 fill:#764ba2,color:#fff
    style PIPE1 fill:#f5576c,color:#fff
    style PIPE2 fill:#f5576c,color:#fff
    style CDC fill:#f5576c,color:#fff
    style APP1 fill:#00ac69,color:#fff
    style APP2 fill:#00ac69,color:#fff
    style API fill:#00ac69,color:#fff
    style TEAM fill:#43e97b,color:#fff
    style USER fill:#43e97b,color:#fff
    style DOM fill:#fa709a,color:#fff
    style DP fill:#fa709a,color:#fff
    style TAG1 fill:#f093fb,color:#fff
    style TAG2 fill:#f093fb,color:#fff
    style TAG3 fill:#f093fb,color:#fff
    style VOTES fill:#ffd700,color:#333
    style CERT fill:#ffd700,color:#333
    style TC1 fill:#9b59b6,color:#fff
    style TC2 fill:#9b59b6,color:#fff
    style TC3 fill:#9b59b6,color:#fff
    style DASH fill:#ff6b6b,color:#fff
    style ALERT fill:#ff6b6b,color:#fff
```

**Relationship Types**:

- **Solid lines (→)**: Hierarchical containment (Service contains SearchIndex, SearchIndex contains Fields)
- **Dashed lines (-.->)**: References and associations (ownership, governance, lineage)

### Parent Entities
- **SearchService**: The search service hosting this index

### Child Entities
- **SearchIndexField**: Individual fields within the index

### Associated Entities
- **Owner**: Users or teams owning this index (owners is plural)
- **Follower**: Users following this index
- **Domain**: Business domain assignments (domains is plural)
- **DataProduct**: Data products this index is part of
- **Tag**: Classification tags
- **Votes**: Votes on the entity
- **Certification**: Asset certification
- **LifeCycle**: Life cycle information
- **Table**: Source tables that feed this index
- **Pipeline**: ETL pipelines, real-time sync, CDC connectors loading data into this index
- **Application**: Applications querying the search index
- **ApiEndpoint**: API endpoints that query this index
- **Dashboard**: Dashboards monitoring search metrics
- **TestCase**: Index freshness, query performance, schema validation tests

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

### Create SearchIndex

```http
POST /api/v1/searchIndexes
Content-Type: application/json

{
  "name": "products",
  "service": "elasticsearch_prod",
  "fields": [
    {
      "name": "product_id",
      "dataType": "keyword"
    },
    {
      "name": "product_name",
      "dataType": "text",
      "analyzer": "standard"
    }
  ],
  "settings": {
    "numberOfShards": 5,
    "numberOfReplicas": 2
  }
}
```

### Get SearchIndex

```http
GET /api/v1/searchIndexes/name/elasticsearch_prod.products?fields=fields,tags,owner,settings
```

### Update SearchIndex

```http
PATCH /api/v1/searchIndexes/{id}
Content-Type: application/json-patch+json

[
  {
    "op": "add",
    "path": "/tags/-",
    "value": {"tagFQN": "Tier.Gold"}
  }
]
```

### Add Field

```http
PUT /api/v1/searchIndexes/{id}/fields
Content-Type: application/json

{
  "fields": [
    {
      "name": "new_field",
      "dataType": "text",
      "analyzer": "standard"
    }
  ]
}
```

### Get Index Mapping

```http
GET /api/v1/searchIndexes/{id}/mapping
```

### Get Index Statistics

```http
GET /api/v1/searchIndexes/{id}/stats
```

---

## Related Documentation

- **[SearchService](search-service.md)** - Search service configuration
- **[Data Lineage](../../lineage/overview.md)** - Tracking data flow to search indices
- **[Analyzers](../../search/analyzers.md)** - Text analysis configuration
- **[API Integration](../../apis/overview.md)** - REST API integration
