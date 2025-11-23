
# API Endpoint

**Individual API endpoints - the building blocks of REST APIs**

---

## Overview

The **ApiEndpoint** entity represents a single API endpoint with its HTTP method, path, request/response schemas, authentication requirements, and OpenAPI specification. It is the most granular API asset in OpenMetadata.

**Hierarchy**:

```mermaid
graph LR
    SVC[API Service] --> COLL[API Collection]
    COLL --> EP[API Endpoint]
    EP --> SCHEMA[Request/Response Schema]

    style SVC fill:#667eea,color:#fff
    style COLL fill:#4facfe,color:#fff
    style EP fill:#00f2fe,color:#333,stroke:#4c51bf,stroke-width:3px
    style SCHEMA fill:#e0f2fe,color:#333
```

---

## Relationships

ApiEndpoint has comprehensive relationships with entities across the metadata platform:

```mermaid
graph TD
    subgraph Hierarchy
        SVC[ApiService<br/>customer_api_v2]
        COLL[ApiCollection<br/>customers]
        SVC --> COLL
        COLL --> EP[ApiEndpoint<br/>GET /customers/:id]
    end

    subgraph Request/Response
        EP --> REQ[RequestSchema<br/>PathParams + QueryParams]
        EP --> RES[ResponseSchema<br/>200: Customer Object]
        REQ --> F1[Field<br/>id: string]
        REQ --> F2[Field<br/>include: string array]
        RES --> F3[Field<br/>customer_id: string]
        RES --> F4[Field<br/>email: string]
        RES --> F5[Field<br/>name: string]
    end

    subgraph Backend Data
        EP -.->|queries| TBL1[Table<br/>customers]
        EP -.->|joins| TBL2[Table<br/>addresses]
        EP -.->|joins| TBL3[Table<br/>orders]
    end

    subgraph Ownership
        EP -.->|owned by| TEAM[Team<br/>API Platform]
        EP -.->|owned by| USER[User<br/>api.dev]
    end

    subgraph Governance
        EP -.->|in domain| DOM[Domain<br/>Customer Platform]
        EP -.->|tagged| TAG1[Tag<br/>Public API]
        EP -.->|tagged| TAG2[Tag<br/>PII.Sensitive]
        EP -.->|linked to| GT[GlossaryTerm<br/>Customer Retrieval]
    end

    subgraph Policies
        POL1[Policy<br/>Rate Limiting] -.->|applies to| EP
        POL2[Policy<br/>Authentication] -.->|requires| EP
        POL3[Policy<br/>Authorization] -.->|enforces| EP
    end

    subgraph Quality
        TC1[TestCase<br/>response_time_sla] -.->|monitors| EP
        TC2[TestCase<br/>schema_compliance] -.->|validates| RES
        TC3[TestCase<br/>error_rate] -.->|tracks| EP
    end

    subgraph Consumers
        APP1[Application<br/>web_app] -.->|calls| EP
        APP2[Application<br/>mobile_app] -.->|calls| EP
        APP3[Service<br/>notification_service] -.->|calls| EP
    end

    subgraph Documentation
        DOC[Documentation<br/>OpenAPI Spec] -.->|describes| EP
        DASH[Dashboard<br/>API Performance] -.->|monitors| EP
    end

    style SVC fill:#667eea,color:#fff
    style COLL fill:#4facfe,color:#fff
    style EP fill:#00f2fe,color:#333,stroke:#4c51bf,stroke-width:3px
    style REQ fill:#00f2fe,color:#333
    style RES fill:#00f2fe,color:#333
    style F1 fill:#00f2fe,color:#333
    style F2 fill:#00f2fe,color:#333
    style F3 fill:#00f2fe,color:#333
    style F4 fill:#00f2fe,color:#333
    style F5 fill:#00f2fe,color:#333
    style TBL1 fill:#764ba2,color:#fff
    style TBL2 fill:#764ba2,color:#fff
    style TBL3 fill:#764ba2,color:#fff
    style TEAM fill:#43e97b,color:#fff
    style USER fill:#43e97b,color:#fff
    style DOM fill:#fa709a,color:#fff
    style TAG1 fill:#f093fb,color:#fff
    style TAG2 fill:#f093fb,color:#fff
    style GT fill:#ffd700,color:#333
    style POL1 fill:#ff6b6b,color:#fff
    style POL2 fill:#ff6b6b,color:#fff
    style POL3 fill:#ff6b6b,color:#fff
    style TC1 fill:#9b59b6,color:#fff
    style TC2 fill:#9b59b6,color:#fff
    style TC3 fill:#9b59b6,color:#fff
    style APP1 fill:#00ac69,color:#fff
    style APP2 fill:#00ac69,color:#fff
    style APP3 fill:#00ac69,color:#fff
    style DOC fill:#f5576c,color:#fff
    style DASH fill:#f5576c,color:#fff
```

**Relationship Types**:

- **Solid lines (→)**: Hierarchical containment (Service → Collection → Endpoint → Schemas)
- **Dashed lines (-.->)**: References and associations (ownership, governance, lineage, policies)

### Parent Entities
- **ApiService**: The API service hosting this endpoint
- **ApiCollection**: The collection grouping this endpoint

### Child Entities
- **RequestSchema**: Request parameters and body schema
- **ResponseSchema**: Response body schema for various status codes

### Associated Entities
- **Owner**: User or team owning this endpoint
- **Domain**: Business domain assignment
- **Tag**: Classification tags
- **GlossaryTerm**: Business terminology
- **Table**: Backend database tables accessed by this endpoint
- **Policy**: Rate limiting, authentication, authorization policies
- **Application**: Consumer applications calling this endpoint
- **TestCase**: Performance SLA, schema validation, error rate monitoring
- **Dashboard**: API performance monitoring dashboards

---

## Schema Specifications

View the complete ApiEndpoint schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/data/apiEndpoint.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "ApiEndpoint",
      "description": "An `ApiEndpoint` represents a single API endpoint with request/response schemas and OpenAPI specification.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.data.ApiEndpoint",

      "definitions": {
        "httpMethod": {
          "description": "HTTP method for the endpoint",
          "type": "string",
          "enum": ["GET", "POST", "PUT", "PATCH", "DELETE", "HEAD", "OPTIONS"]
        },
        "requestSchema": {
          "type": "object",
          "properties": {
            "schemaType": {
              "type": "string",
              "enum": ["JSON", "XML", "FormData", "Protobuf", "Avro"]
            },
            "schemaDefinition": {
              "type": "object"
            },
            "contentType": {
              "type": "string"
            },
            "parameters": {
              "type": "array",
              "items": {
                "$ref": "#/definitions/parameter"
              }
            }
          }
        },
        "responseSchema": {
          "type": "object",
          "properties": {
            "statusCode": {
              "type": "integer"
            },
            "description": {
              "type": "string"
            },
            "schemaType": {
              "type": "string",
              "enum": ["JSON", "XML", "Protobuf", "Avro"]
            },
            "schemaDefinition": {
              "type": "object"
            },
            "contentType": {
              "type": "string"
            }
          }
        },
        "parameter": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string"
            },
            "in": {
              "type": "string",
              "enum": ["query", "header", "path", "cookie"]
            },
            "required": {
              "type": "boolean"
            },
            "schema": {
              "type": "object"
            },
            "description": {
              "type": "string"
            }
          }
        },
        "authentication": {
          "type": "object",
          "properties": {
            "required": {
              "type": "boolean"
            },
            "type": {
              "type": "string",
              "enum": ["None", "Basic", "Bearer", "OAuth2", "APIKey", "JWT"]
            },
            "scopes": {
              "type": "array",
              "items": {"type": "string"}
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
          "description": "Endpoint name",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "Fully qualified name: service.collection.endpoint",
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
        "endpointURL": {
          "description": "Full endpoint URL path",
          "type": "string"
        },
        "httpMethod": {
          "$ref": "#/definitions/httpMethod"
        },
        "requestSchema": {
          "$ref": "#/definitions/requestSchema"
        },
        "responseSchemas": {
          "description": "Response schemas by status code",
          "type": "array",
          "items": {
            "$ref": "#/definitions/responseSchema"
          }
        },
        "authentication": {
          "$ref": "#/definitions/authentication"
        },
        "apiCollection": {
          "description": "Parent API collection",
          "$ref": "../../type/entityReference.json"
        },
        "service": {
          "description": "API service",
          "$ref": "../../type/entityReference.json"
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
        "glossaryTerms": {
          "description": "Business glossary terms",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "version": {
          "description": "Metadata version",
          "$ref": "../../type/entityHistory.json#/definitions/entityVersion"
        }
      },

      "required": ["id", "name", "endpointURL", "httpMethod", "apiCollection"]
    }
    ```

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/apiEndpoint.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2001/XMLSchema#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # ApiEndpoint Class Definition
    om:ApiEndpoint a owl:Class ;
        rdfs:subClassOf om:DataAsset ;
        rdfs:label "ApiEndpoint" ;
        rdfs:comment "A single API endpoint with HTTP method, path, and request/response schemas" ;
        om:hierarchyLevel 3 .

    # Properties
    om:endpointName a owl:DatatypeProperty ;
        rdfs:domain om:ApiEndpoint ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name of the API endpoint" .

    om:fullyQualifiedName a owl:DatatypeProperty ;
        rdfs:domain om:ApiEndpoint ;
        rdfs:range xsd:string ;
        rdfs:label "fullyQualifiedName" ;
        rdfs:comment "Complete hierarchical name: service.collection.endpoint" .

    om:endpointURL a owl:DatatypeProperty ;
        rdfs:domain om:ApiEndpoint ;
        rdfs:range xsd:string ;
        rdfs:label "endpointURL" ;
        rdfs:comment "URL path for the endpoint" .

    om:httpMethod a owl:DatatypeProperty ;
        rdfs:domain om:ApiEndpoint ;
        rdfs:range om:HttpMethod ;
        rdfs:label "httpMethod" ;
        rdfs:comment "HTTP method: GET, POST, PUT, DELETE, etc." .

    om:hasRequestSchema a owl:ObjectProperty ;
        rdfs:domain om:ApiEndpoint ;
        rdfs:range om:RequestSchema ;
        rdfs:label "hasRequestSchema" ;
        rdfs:comment "Request schema definition" .

    om:hasResponseSchema a owl:ObjectProperty ;
        rdfs:domain om:ApiEndpoint ;
        rdfs:range om:ResponseSchema ;
        rdfs:label "hasResponseSchema" ;
        rdfs:comment "Response schema definitions" .

    om:belongsToCollection a owl:ObjectProperty ;
        rdfs:domain om:ApiEndpoint ;
        rdfs:range om:ApiCollection ;
        rdfs:label "belongsToCollection" ;
        rdfs:comment "Parent API collection" .

    om:requiresAuthentication a owl:ObjectProperty ;
        rdfs:domain om:ApiEndpoint ;
        rdfs:range om:Authentication ;
        rdfs:label "requiresAuthentication" ;
        rdfs:comment "Authentication requirements" .

    om:ownedBy a owl:ObjectProperty ;
        rdfs:domain om:ApiEndpoint ;
        rdfs:range om:Owner ;
        rdfs:label "ownedBy" ;
        rdfs:comment "User or team that owns this endpoint" .

    om:hasTag a owl:ObjectProperty ;
        rdfs:domain om:ApiEndpoint ;
        rdfs:range om:Tag ;
        rdfs:label "hasTag" ;
        rdfs:comment "Classification tags applied to endpoint" .

    om:linkedToGlossaryTerm a owl:ObjectProperty ;
        rdfs:domain om:ApiEndpoint ;
        rdfs:range om:GlossaryTerm ;
        rdfs:label "linkedToGlossaryTerm" ;
        rdfs:comment "Business glossary terms" .

    # HTTP Method Enumeration
    om:HttpMethod a owl:Class ;
        owl:oneOf (
            om:GET
            om:POST
            om:PUT
            om:PATCH
            om:DELETE
        ) .

    # Example Instance
    ex:createPaymentEndpoint a om:ApiEndpoint ;
        om:endpointName "createPayment" ;
        om:fullyQualifiedName "production_api_gateway.payments_api.createPayment" ;
        om:displayName "Create Payment" ;
        om:endpointURL "/api/v2/payments" ;
        om:httpMethod om:POST ;
        om:belongsToCollection ex:paymentsAPI ;
        om:ownedBy ex:paymentsTeam ;
        om:hasTag ex:tierGold ;
        om:requiresAuthentication ex:oauth2Auth ;
        om:hasRequestSchema ex:createPaymentRequest ;
        om:hasResponseSchema ex:createPaymentResponse200 .
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

        "ApiEndpoint": "om:ApiEndpoint",
        "name": {
          "@id": "om:endpointName",
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
        "endpointURL": {
          "@id": "om:endpointURL",
          "@type": "xsd:string"
        },
        "httpMethod": {
          "@id": "om:httpMethod",
          "@type": "@vocab"
        },
        "requestSchema": {
          "@id": "om:hasRequestSchema",
          "@type": "@id"
        },
        "responseSchemas": {
          "@id": "om:hasResponseSchema",
          "@type": "@id",
          "@container": "@set"
        },
        "apiCollection": {
          "@id": "om:belongsToCollection",
          "@type": "@id"
        },
        "service": {
          "@id": "om:belongsToService",
          "@type": "@id"
        },
        "authentication": {
          "@id": "om:requiresAuthentication",
          "@type": "@id"
        },
        "owner": {
          "@id": "om:ownedBy",
          "@type": "@id"
        },
        "domain": {
          "@id": "om:inDomain",
          "@type": "@id"
        },
        "tags": {
          "@id": "om:hasTag",
          "@type": "@id",
          "@container": "@set"
        },
        "glossaryTerms": {
          "@id": "om:linkedToGlossaryTerm",
          "@type": "@id",
          "@container": "@set"
        }
      }
    }
    ```

    **Example JSON-LD Instance**:

    ```json
    {
      "@context": "https://open-metadata.org/context/apiEndpoint.jsonld",
      "@type": "ApiEndpoint",
      "@id": "https://example.com/api/endpoints/create_payment",

      "name": "createPayment",
      "fullyQualifiedName": "production_api_gateway.payments_api.createPayment",
      "displayName": "Create Payment",
      "description": "Creates a new payment transaction",
      "endpointURL": "/api/v2/payments",
      "httpMethod": "POST",

      "requestSchema": {
        "schemaType": "JSON",
        "contentType": "application/json",
        "schemaDefinition": {
          "type": "object",
          "properties": {
            "amount": {"type": "number"},
            "currency": {"type": "string"},
            "customerId": {"type": "string"}
          },
          "required": ["amount", "currency", "customerId"]
        }
      },

      "responseSchemas": [
        {
          "statusCode": 200,
          "description": "Payment created successfully",
          "schemaType": "JSON",
          "contentType": "application/json",
          "schemaDefinition": {
            "type": "object",
            "properties": {
              "paymentId": {"type": "string"},
              "status": {"type": "string"},
              "amount": {"type": "number"}
            }
          }
        },
        {
          "statusCode": 400,
          "description": "Invalid request",
          "schemaType": "JSON",
          "schemaDefinition": {
            "type": "object",
            "properties": {
              "error": {"type": "string"},
              "message": {"type": "string"}
            }
          }
        }
      ],

      "authentication": {
        "required": true,
        "type": "OAuth2",
        "scopes": ["payments.write"]
      },

      "apiCollection": {
        "@id": "https://example.com/api/collections/payments",
        "@type": "ApiCollection",
        "name": "payments_api"
      },

      "service": {
        "@id": "https://example.com/services/production_api_gateway",
        "@type": "ApiService",
        "name": "production_api_gateway"
      },

      "owner": {
        "@id": "https://example.com/teams/payments",
        "@type": "Team",
        "name": "payments",
        "displayName": "Payments Team"
      },

      "tags": [
        {
          "@id": "https://open-metadata.org/tags/Tier/Gold",
          "tagFQN": "Tier.Gold"
        },
        {
          "@id": "https://open-metadata.org/tags/Compliance/PCI-DSS",
          "tagFQN": "Compliance.PCI-DSS"
        }
      ]
    }
    ```

    **[View Full JSON-LD Context →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/contexts/apiEndpoint.jsonld)**

---

## Use Cases

- Document REST API endpoints with OpenAPI specifications
- Catalog GraphQL queries and mutations
- Track gRPC service methods
- Define request/response schemas and validation rules
- Apply authentication and authorization requirements
- Monitor endpoint performance and error rates
- Track endpoint ownership by development teams
- Apply governance tags (Security, Compliance, SLA)
- Generate API documentation automatically
- Version API endpoints and manage deprecation

---

## JSON Schema Specification

### Core Properties

#### `id` (uuid)
**Type**: `string` (UUID format)
**Required**: Yes (system-generated)
**Description**: Unique identifier for this API endpoint instance

```json
{
  "id": "3c4d5e6f-7a8b-4c9d-0e1f-2a3b4c5d6e7f"
}
```

---

#### `name` (entityName)
**Type**: `string`
**Required**: Yes
**Pattern**: `^[^.]*$` (no dots allowed)
**Min Length**: 1
**Max Length**: 256
**Description**: Name of the API endpoint (unqualified)

```json
{
  "name": "createPayment"
}
```

---

#### `fullyQualifiedName` (fullyQualifiedEntityName)
**Type**: `string`
**Required**: Yes (system-generated)
**Pattern**: `^((?!::).)*$`
**Description**: Fully qualified name in the format `service.collection.endpoint`

```json
{
  "fullyQualifiedName": "production_api_gateway.payments_api.createPayment"
}
```

---

#### `displayName`
**Type**: `string`
**Required**: No
**Description**: Human-readable display name

```json
{
  "displayName": "Create Payment"
}
```

---

#### `description` (markdown)
**Type**: `string` (Markdown format)
**Required**: No
**Description**: Rich text description of the endpoint's purpose

```json
{
  "description": "# Create Payment Endpoint\n\nCreates a new payment transaction.\n\n## Authentication\nRequires OAuth2 with `payments.write` scope.\n\n## Rate Limits\n- 100 requests per minute per user\n- 10,000 requests per hour per organization"
}
```

---

### Endpoint Properties

#### `endpointURL`
**Type**: `string`
**Required**: Yes
**Description**: URL path for this endpoint (can include path parameters)

```json
{
  "endpointURL": "/api/v2/payments/{paymentId}"
}
```

---

#### `httpMethod` (HttpMethod enum)
**Type**: `string` enum
**Required**: Yes
**Allowed Values**:

- `GET` - Retrieve resource
- `POST` - Create resource
- `PUT` - Replace resource
- `PATCH` - Update resource
- `DELETE` - Delete resource
- `HEAD` - Get headers only
- `OPTIONS` - Get allowed methods

```json
{
  "httpMethod": "POST"
}
```

---

### Schema Properties

#### `requestSchema` (RequestSchema)
**Type**: `object`
**Required**: No
**Description**: Request body and parameter schema

**RequestSchema Properties**:

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `schemaType` | SchemaType enum | Yes | JSON, XML, FormData, Protobuf, Avro |
| `contentType` | string | Yes | MIME type (application/json, etc.) |
| `schemaDefinition` | object | No | JSON Schema or schema definition |
| `parameters` | Parameter[] | No | Query, path, header parameters |

**Example**:

```json
{
  "requestSchema": {
    "schemaType": "JSON",
    "contentType": "application/json",
    "schemaDefinition": {
      "type": "object",
      "properties": {
        "amount": {
          "type": "number",
          "minimum": 0.01,
          "description": "Payment amount"
        },
        "currency": {
          "type": "string",
          "pattern": "^[A-Z]{3}$",
          "description": "ISO 4217 currency code"
        },
        "customerId": {
          "type": "string",
          "format": "uuid",
          "description": "Customer UUID"
        },
        "paymentMethod": {
          "type": "string",
          "enum": ["card", "bank_transfer", "wallet"]
        }
      },
      "required": ["amount", "currency", "customerId"]
    },
    "parameters": [
      {
        "name": "idempotencyKey",
        "in": "header",
        "required": true,
        "schema": {
          "type": "string",
          "format": "uuid"
        },
        "description": "Idempotency key to prevent duplicate requests"
      },
      {
        "name": "async",
        "in": "query",
        "required": false,
        "schema": {
          "type": "boolean",
          "default": false
        },
        "description": "Process payment asynchronously"
      }
    ]
  }
}
```

---

#### `responseSchemas[]` (ResponseSchema[])
**Type**: `array`
**Required**: No
**Description**: Response schemas for different HTTP status codes

**ResponseSchema Properties**:

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `statusCode` | integer | Yes | HTTP status code (200, 400, etc.) |
| `description` | string | No | Response description |
| `schemaType` | SchemaType enum | Yes | JSON, XML, Protobuf, Avro |
| `contentType` | string | Yes | MIME type |
| `schemaDefinition` | object | No | JSON Schema or schema definition |

**Example**:

```json
{
  "responseSchemas": [
    {
      "statusCode": 200,
      "description": "Payment created successfully",
      "schemaType": "JSON",
      "contentType": "application/json",
      "schemaDefinition": {
        "type": "object",
        "properties": {
          "paymentId": {
            "type": "string",
            "format": "uuid"
          },
          "status": {
            "type": "string",
            "enum": ["pending", "processing", "completed", "failed"]
          },
          "amount": {
            "type": "number"
          },
          "currency": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          }
        }
      }
    },
    {
      "statusCode": 400,
      "description": "Invalid request",
      "schemaType": "JSON",
      "contentType": "application/json",
      "schemaDefinition": {
        "type": "object",
        "properties": {
          "error": {
            "type": "string",
            "enum": ["invalid_amount", "invalid_currency", "invalid_customer"]
          },
          "message": {
            "type": "string"
          },
          "details": {
            "type": "object"
          }
        }
      }
    },
    {
      "statusCode": 401,
      "description": "Unauthorized - missing or invalid authentication",
      "schemaType": "JSON",
      "contentType": "application/json"
    },
    {
      "statusCode": 429,
      "description": "Rate limit exceeded",
      "schemaType": "JSON",
      "contentType": "application/json",
      "schemaDefinition": {
        "type": "object",
        "properties": {
          "error": {
            "type": "string",
            "const": "rate_limit_exceeded"
          },
          "retryAfter": {
            "type": "integer",
            "description": "Seconds until retry is allowed"
          }
        }
      }
    }
  ]
}
```

---

### Authentication Properties

#### `authentication` (Authentication)
**Type**: `object`
**Required**: No
**Description**: Authentication requirements for this endpoint

```json
{
  "authentication": {
    "required": true,
    "type": "OAuth2",
    "scopes": ["payments.write", "customers.read"],
    "description": "Requires OAuth2 authentication with payment write permissions"
  }
}
```

**Authentication Types**:

- `None` - No authentication required
- `Basic` - HTTP Basic authentication
- `Bearer` - Bearer token authentication
- `OAuth2` - OAuth 2.0 authentication
- `APIKey` - API key authentication
- `JWT` - JSON Web Token authentication

---

### Location Properties

#### `apiCollection` (EntityReference)
**Type**: `object`
**Required**: Yes
**Description**: Reference to parent API collection

```json
{
  "apiCollection": {
    "id": "collection-uuid",
    "type": "apiCollection",
    "name": "payments_api",
    "fullyQualifiedName": "production_api_gateway.payments_api"
  }
}
```

---

#### `service` (EntityReference)
**Type**: `object`
**Required**: Yes
**Description**: Reference to API service

```json
{
  "service": {
    "id": "service-uuid",
    "type": "apiService",
    "name": "production_api_gateway",
    "fullyQualifiedName": "production_api_gateway"
  }
}
```

---

### Governance Properties

#### `owner` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: User or team that owns this endpoint

```json
{
  "owner": {
    "id": "team-uuid",
    "type": "team",
    "name": "payments",
    "displayName": "Payments Team"
  }
}
```

---

#### `domain` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: Data domain this endpoint belongs to

```json
{
  "domain": {
    "id": "domain-uuid",
    "type": "domain",
    "name": "Finance",
    "fullyQualifiedName": "Finance"
  }
}
```

---

#### `tags[]` (TagLabel[])
**Type**: `array`
**Required**: No
**Description**: Classification tags applied to the endpoint

```json
{
  "tags": [
    {
      "tagFQN": "Tier.Gold",
      "description": "Critical business endpoint",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    },
    {
      "tagFQN": "Compliance.PCI-DSS",
      "source": "Classification",
      "labelType": "Automated",
      "state": "Confirmed"
    },
    {
      "tagFQN": "Security.Sensitive",
      "source": "Classification"
    }
  ]
}
```

---

#### `glossaryTerms[]` (GlossaryTerm[])
**Type**: `array`
**Required**: No
**Description**: Business glossary terms linked to this endpoint

```json
{
  "glossaryTerms": [
    {
      "fullyQualifiedName": "BusinessGlossary.Payment"
    },
    {
      "fullyQualifiedName": "BusinessGlossary.Transaction"
    }
  ]
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
  "version": 4.2
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
  "updatedBy": "jane.developer"
}
```

---

## Complete Example

### OpenAPI-Compliant REST Endpoint

```json
{
  "id": "3c4d5e6f-7a8b-4c9d-0e1f-2a3b4c5d6e7f",
  "name": "createPayment",
  "fullyQualifiedName": "production_api_gateway.payments_api.createPayment",
  "displayName": "Create Payment",
  "description": "# Create Payment Endpoint\n\nCreates a new payment transaction.",
  "endpointURL": "/api/v2/payments",
  "httpMethod": "POST",
  "requestSchema": {
    "schemaType": "JSON",
    "contentType": "application/json",
    "schemaDefinition": {
      "type": "object",
      "properties": {
        "amount": {
          "type": "number",
          "minimum": 0.01
        },
        "currency": {
          "type": "string",
          "pattern": "^[A-Z]{3}$"
        },
        "customerId": {
          "type": "string",
          "format": "uuid"
        },
        "paymentMethod": {
          "type": "string",
          "enum": ["card", "bank_transfer", "wallet"]
        }
      },
      "required": ["amount", "currency", "customerId"]
    },
    "parameters": [
      {
        "name": "idempotencyKey",
        "in": "header",
        "required": true,
        "schema": {
          "type": "string",
          "format": "uuid"
        }
      }
    ]
  },
  "responseSchemas": [
    {
      "statusCode": 200,
      "description": "Payment created successfully",
      "schemaType": "JSON",
      "contentType": "application/json",
      "schemaDefinition": {
        "type": "object",
        "properties": {
          "paymentId": {"type": "string", "format": "uuid"},
          "status": {"type": "string"},
          "amount": {"type": "number"}
        }
      }
    },
    {
      "statusCode": 400,
      "description": "Invalid request",
      "schemaType": "JSON",
      "contentType": "application/json"
    }
  ],
  "authentication": {
    "required": true,
    "type": "OAuth2",
    "scopes": ["payments.write"]
  },
  "apiCollection": {
    "id": "collection-uuid",
    "type": "apiCollection",
    "name": "payments_api"
  },
  "service": {
    "id": "service-uuid",
    "type": "apiService",
    "name": "production_api_gateway"
  },
  "owner": {
    "id": "team-uuid",
    "type": "team",
    "name": "payments"
  },
  "domain": {
    "id": "domain-uuid",
    "type": "domain",
    "name": "Finance"
  },
  "tags": [
    {"tagFQN": "Tier.Gold"},
    {"tagFQN": "Compliance.PCI-DSS"}
  ],
  "version": 4.2,
  "updatedAt": 1704240000000,
  "updatedBy": "jane.developer"
}
```

---

## RDF Representation

### Ontology Class

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl: <http://www.w3.org/2001/XMLSchema#> .

om:ApiEndpoint a owl:Class ;
    rdfs:subClassOf om:DataAsset ;
    rdfs:label "ApiEndpoint" ;
    rdfs:comment "A single API endpoint with request/response schemas" ;
    om:hasProperties [
        om:name "string" ;
        om:endpointURL "string" ;
        om:httpMethod "HttpMethod" ;
        om:requestSchema "RequestSchema" ;
        om:responseSchemas "ResponseSchema[]" ;
        om:authentication "Authentication" ;
        om:apiCollection "ApiCollection" ;
        om:owner "Owner" ;
        om:tags "Tag[]" ;
    ] .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://example.com/> .

ex:createPayment a om:ApiEndpoint ;
    om:endpointName "createPayment" ;
    om:fullyQualifiedName "production_api_gateway.payments_api.createPayment" ;
    om:displayName "Create Payment" ;
    om:endpointURL "/api/v2/payments" ;
    om:httpMethod om:POST ;
    om:belongsToCollection ex:paymentsAPI ;
    om:ownedBy ex:paymentsTeam ;
    om:hasTag ex:tierGold ;
    om:requiresAuthentication ex:oauth2Auth .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "om": "https://open-metadata.org/schema/",
    "ApiEndpoint": "om:ApiEndpoint",
    "name": "om:name",
    "endpointURL": "om:endpointURL",
    "httpMethod": "om:httpMethod",
    "requestSchema": {
      "@id": "om:hasRequestSchema",
      "@type": "@id"
    },
    "responseSchemas": {
      "@id": "om:hasResponseSchema",
      "@type": "@id",
      "@container": "@set"
    },
    "apiCollection": {
      "@id": "om:belongsToCollection",
      "@type": "@id"
    },
    "owner": {
      "@id": "om:ownedBy",
      "@type": "@id"
    }
  }
}
```

### JSON-LD Example

```json
{
  "@context": "https://open-metadata.org/context/apiEndpoint.jsonld",
  "@type": "ApiEndpoint",
  "@id": "https://example.com/api/endpoints/create_payment",
  "name": "createPayment",
  "endpointURL": "/api/v2/payments",
  "httpMethod": "POST",
  "apiCollection": {
    "@id": "https://example.com/api/payments",
    "@type": "ApiCollection"
  }
}
```

---

## Relationships

### Parent Entities
- **ApiCollection**: The collection this endpoint belongs to
- **ApiService**: The API service hosting this endpoint

### Child Entities
- None (leaf entity in hierarchy)

### Associated Entities
- **Owner**: User or team owning this endpoint
- **Domain**: Business domain assignment
- **Tag**: Classification tags
- **GlossaryTerm**: Business terminology
- **Schema**: Request and response schemas
- **Table**: Database tables accessed by endpoint (via lineage)

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

**Stay informed about API endpoint changes**

Followers allow users to "follow" API endpoints and receive notifications when they change. This is critical for:

- **API Consumers**: Monitor endpoints your applications depend on
- **Backend Engineers**: Track endpoints you own or maintain
- **Integration Teams**: Stay informed about contract changes
- **API Product Managers**: Monitor endpoint usage and evolution

**Key Benefits**:
- Receive notifications about breaking changes to request/response schemas
- Track deprecation notices and versioning changes
- Monitor authentication or rate limiting updates
- Get alerts for SLA or performance threshold changes

**Common Use Cases**:
- Frontend developers follow endpoints their apps consume
- Backend engineers follow production endpoints they maintain
- DevOps teams follow critical API endpoints for monitoring
- Product teams follow public API endpoints for customer impact

!!! tip "Learn More"
    See the complete **[Followers Guide](../../core-concepts/followers.md)** for detailed information about configuring notifications, best practices, and integration with webhooks.

---

## API Operations

### List API Endpoints

```http
GET /v1/apiEndpoints
Query Parameters:
  - fields: Fields to include (owners, followers, tags, extension, domains, dataProducts, sourceHash)
  - service: Filter by API service name (e.g., "OpenMetadata API Service")
  - apiCollection: Filter by API collection name (e.g., "UsersAPI")
  - limit: Number of results (1-1000000, default 10)
  - before: Cursor for previous page
  - after: Cursor for next page
  - include: all | deleted | non-deleted (default: non-deleted)

Response: APIEndpointList
```

**Example Request**:

```http
GET /v1/apiEndpoints?apiCollection=payments_api&fields=requestSchema,responseSchemas,tags&limit=50
```

---

### Create API Endpoint

```http
POST /v1/apiEndpoints
Content-Type: application/json

{
  "name": "createPayment",
  "apiCollection": "production_api_gateway.payments_api",
  "displayName": "Create Payment",
  "description": "Creates a new payment transaction",
  "endpointURL": "/api/v2/payments",
  "httpMethod": "POST",
  "requestSchema": {
    "schemaType": "JSON",
    "contentType": "application/json",
    "schemaDefinition": {
      "type": "object",
      "properties": {
        "amount": {
          "type": "number",
          "minimum": 0.01,
          "description": "Payment amount"
        },
        "currency": {
          "type": "string",
          "pattern": "^[A-Z]{3}$",
          "description": "ISO 4217 currency code"
        },
        "customerId": {
          "type": "string",
          "format": "uuid",
          "description": "Customer UUID"
        },
        "paymentMethod": {
          "type": "string",
          "enum": ["card", "bank_transfer", "wallet"]
        }
      },
      "required": ["amount", "currency", "customerId"]
    },
    "parameters": [
      {
        "name": "idempotencyKey",
        "in": "header",
        "required": true,
        "schema": {
          "type": "string",
          "format": "uuid"
        },
        "description": "Idempotency key to prevent duplicate requests"
      }
    ]
  },
  "responseSchemas": [
    {
      "statusCode": 200,
      "description": "Payment created successfully",
      "schemaType": "JSON",
      "contentType": "application/json",
      "schemaDefinition": {
        "type": "object",
        "properties": {
          "paymentId": {"type": "string", "format": "uuid"},
          "status": {"type": "string", "enum": ["pending", "processing", "completed"]},
          "amount": {"type": "number"}
        }
      }
    },
    {
      "statusCode": 400,
      "description": "Invalid request",
      "schemaType": "JSON",
      "contentType": "application/json"
    }
  ],
  "authentication": {
    "required": true,
    "type": "OAuth2",
    "scopes": ["payments.write"]
  },
  "owner": {
    "id": "team-uuid",
    "type": "team"
  },
  "tags": [
    {"tagFQN": "Tier.Gold"},
    {"tagFQN": "Compliance.PCI-DSS"}
  ]
}

Response: APIEndpoint
```

---

### Get API Endpoint by Name

```http
GET /v1/apiEndpoints/name/{fqn}
Query Parameters:
  - fields: Fields to include (requestSchema, responseSchemas, owners, followers, tags, extension)
  - include: all | deleted | non-deleted (default: non-deleted)

Response: APIEndpoint
```

**Example Request**:

```http
GET /v1/apiEndpoints/name/production_api_gateway.payments_api.createPayment?fields=requestSchema,responseSchemas,owner,tags
```

---

### Get API Endpoint by ID

```http
GET /v1/apiEndpoints/{id}
Query Parameters:
  - fields: Fields to include
  - include: all | deleted | non-deleted (default: non-deleted)

Response: APIEndpoint
```

---

### Update API Endpoint (Partial)

```http
PATCH /v1/apiEndpoints/{id}
Content-Type: application/json-patch+json

[
  {
    "op": "add",
    "path": "/tags/-",
    "value": {"tagFQN": "Tier.Gold"}
  },
  {
    "op": "replace",
    "path": "/description",
    "value": "Updated endpoint description with new details"
  },
  {
    "op": "replace",
    "path": "/authentication/scopes",
    "value": ["payments.write", "payments.refund"]
  }
]

Response: APIEndpoint
```

---

### Create or Update API Endpoint

```http
PUT /v1/apiEndpoints
Content-Type: application/json

{
  "name": "getPayment",
  "apiCollection": "production_api_gateway.payments_api",
  "endpointURL": "/api/v2/payments/{id}",
  "httpMethod": "GET",
  "requestSchema": {
    "schemaType": "JSON",
    "contentType": "application/json",
    "parameters": [
      {
        "name": "id",
        "in": "path",
        "required": true,
        "schema": {"type": "string", "format": "uuid"}
      }
    ]
  }
}

Response: APIEndpoint
```

---

### Delete API Endpoint

```http
DELETE /v1/apiEndpoints/{id}
Query Parameters:
  - hardDelete: true | false (default: false - soft delete)
  - recursive: true | false (default: false)

Response: APIEndpoint
```

---

### Delete API Endpoint (Async)

```http
DELETE /v1/apiEndpoints/async/{id}
Query Parameters:
  - hardDelete: true | false (default: false)
  - recursive: true | false (default: false)

Response: Async deletion job details
```

---

### Get Followers

```http
GET /v1/apiEndpoints/{id}/followers

Response: List of followers (users following this endpoint)
```

---

### Add Follower

```http
PUT /v1/apiEndpoints/{id}/followers/{userId}

Response: ChangeEvent
```

---

### Get API Endpoint Version

```http
GET /v1/apiEndpoints/{id}/versions/{version}

Response: APIEndpoint (specific version)
```

---

### Get API Endpoint Versions

```http
GET /v1/apiEndpoints/{id}/versions

Response: EntityHistory (all versions)
```

---

### Restore API Endpoint

```http
PUT /v1/apiEndpoints/restore
Content-Type: application/json

{
  "id": "endpoint-uuid"
}

Response: APIEndpoint (restored)
```

---

### Vote on API Endpoint

```http
PUT /v1/apiEndpoints/{id}/vote
Content-Type: application/json

{
  "vote": "upvote"
}

Response: ChangeEvent
```

---

### Bulk Create or Update API Endpoints

```http
PUT /v1/apiEndpoints/bulk
Content-Type: application/json

{
  "entities": [
    {
      "name": "getCustomer",
      "apiCollection": "production_api_gateway.customers_api",
      "endpointURL": "/api/v2/customers/{id}",
      "httpMethod": "GET"
    },
    {
      "name": "listCustomers",
      "apiCollection": "production_api_gateway.customers_api",
      "endpointURL": "/api/v2/customers",
      "httpMethod": "GET"
    }
  ]
}

Response: BulkOperationResult
```

---

## Related Documentation

- **[API Service](api-service.md)** - Parent service configuration
- **[API Collection](api-collection.md)** - Parent collection specification
- **[OpenAPI Specification](../../specifications/openapi.md)** - OpenAPI/Swagger standards
- **[Authentication](../../security/authentication.md)** - API authentication methods
- **[Schema Registry](../../schemas/overview.md)** - Schema management
