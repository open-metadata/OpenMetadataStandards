
# Glossary

**Business vocabulary containers - organizing and standardizing business terminology**

---

## Overview

The **Glossary** entity represents a container for organizing business terms and definitions. It provides a structured way to manage business vocabulary, ensuring consistent understanding of terms across the organization.

## Relationship Diagram

```mermaid
graph TD
    %% Main entity
    GLOSS[Glossary<br/>BusinessGlossary]

    %% Hierarchical relationships
    GLOSS -->|contains| GT1[GlossaryTerm<br/>Customer]
    GLOSS -->|contains| GT2[GlossaryTerm<br/>Revenue]
    GLOSS -->|contains| GT3[GlossaryTerm<br/>Product]

    %% Nested term hierarchy
    GT1 -->|has child| GT1A[GlossaryTerm<br/>EnterpriseCustomer]
    GT1 -->|has child| GT1B[GlossaryTerm<br/>IndividualCustomer]

    %% Governance relationships
    USR[User/Team<br/>DataGovernance] -.->|owns| GLOSS
    REV1[User<br/>Jane Doe] -.->|reviews| GLOSS
    REV2[User<br/>John Smith] -.->|reviews| GLOSS
    DOM1[Domain<br/>Enterprise] -.->|contains| GLOSS
    DP1[DataProduct<br/>Customer360] -.->|includes| GLOSS

    %% Classification relationships
    TAG1[Tag<br/>Governance.Approved] -.->|classifies| GLOSS

    %% Applied to assets
    GT1 -.->|describes| TBL1[Table<br/>customers]
    GT1 -.->|describes| COL1[Column<br/>customer_type]
    GT2 -.->|describes| TBL2[Table<br/>sales]
    GT3 -.->|describes| DASH[Dashboard<br/>Product Analytics]

    %% Styling
    classDef glossary fill:#8B5CF6,stroke:#7C3AED,color:#fff
    classDef term fill:#A78BFA,stroke:#8B5CF6,color:#fff
    classDef governance fill:#059669,stroke:#047857,color:#fff
    classDef data fill:#2563EB,stroke:#1E40AF,color:#fff

    class GLOSS glossary
    class GT1,GT2,GT3,GT1A,GT1B term
    class USR,REV1,REV2,DOM1,TAG1,DP1 governance
    class TBL1,TBL2,COL1,DASH data
```

---

## Schema Specifications

View the complete Glossary schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/data/glossary.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "Glossary",
      "description": "This schema defines the Glossary entity. A Glossary is collection of hierarchical GlossaryTerms.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.data.Glossary",
      "javaInterfaces": ["org.openmetadata.schema.EntityInterface"],

      "properties": {
        "id": {
          "description": "Unique identifier of a glossary instance.",
          "$ref": "../../type/basic.json#/definitions/uuid"
        },
        "name": {
          "description": "Name of the glossary",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "FullyQualifiedName same as name.",
          "$ref": "../../type/basic.json#/definitions/fullyQualifiedEntityName"
        },
        "displayName": {
          "description": "Display Name that identifies this glossary.",
          "type": "string"
        },
        "description": {
          "description": "Description of the glossary.",
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
        "href": {
          "description": "Link to the resource corresponding to this entity.",
          "$ref": "../../type/basic.json#/definitions/href"
        },
        "reviewers": {
          "description": "User references of the reviewers for this glossary.",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "owners": {
          "description": "Owners of this glossary.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "usageCount": {
          "description": "Count of how many times terms from this glossary are used.",
          "type": "integer"
        },
        "tags": {
          "description": "Tags for this glossary.",
          "type": "array",
          "items": {
            "$ref": "../../type/tagLabel.json"
          },
          "default": []
        },
        "termCount": {
          "description": "Total number of terms in the glossary. This includes all the children in the hierarchy.",
          "type": "integer",
          "minimum": 0
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
        "provider": {
          "$ref": "../../type/basic.json#/definitions/providerType"
        },
        "disabled": {
          "description": "System glossary can't be deleted. Use this flag to disable them.",
          "type": "boolean"
        },
        "mutuallyExclusive": {
          "description": "Glossary terms that are direct children in this glossary are mutually exclusive. When mutually exclusive is `true` only one term can be used to label an entity. When mutually exclusive is `false`, multiple terms from this group can be used to label an entity.",
          "type": "boolean",
          "default": "false"
        },
        "domains": {
          "description": "Domains the Glossary belongs to.",
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
        "extension": {
          "description": "Entity extension data with custom attributes added to the entity.",
          "$ref": "../../type/basic.json#/definitions/entityExtension"
        },
        "entityStatus": {
          "description": "Status of the Glossary.",
          "$ref": "../../type/status.json"
        }
      },

      "required": ["id", "name", "description"],
      "additionalProperties": false
    }
    ```

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/glossary.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2002/07/owl#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # Glossary Class Definition
    om:Glossary a owl:Class ;
        rdfs:subClassOf om:GovernanceAsset ;
        rdfs:label "Glossary" ;
        rdfs:comment "This schema defines the Glossary entity. A Glossary is collection of hierarchical GlossaryTerms." ;
        om:hierarchyLevel 1 .

    # Datatype Properties
    om:glossaryName a owl:DatatypeProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name of the glossary" .

    om:fullyQualifiedName a owl:DatatypeProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range xsd:string ;
        rdfs:label "fullyQualifiedName" ;
        rdfs:comment "FullyQualifiedName same as name" .

    om:displayName a owl:DatatypeProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range xsd:string ;
        rdfs:label "displayName" ;
        rdfs:comment "Display Name that identifies this glossary" .

    om:description a owl:DatatypeProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range xsd:string ;
        rdfs:label "description" ;
        rdfs:comment "Description of the glossary" .

    om:mutuallyExclusive a owl:DatatypeProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range xsd:boolean ;
        rdfs:label "mutuallyExclusive" ;
        rdfs:comment "Glossary terms that are direct children in this glossary are mutually exclusive" .

    om:usageCount a owl:DatatypeProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range xsd:integer ;
        rdfs:label "usageCount" ;
        rdfs:comment "Count of how many times terms from this glossary are used" .

    om:termCount a owl:DatatypeProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range xsd:integer ;
        rdfs:label "termCount" ;
        rdfs:comment "Total number of terms in the glossary" .

    om:disabled a owl:DatatypeProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range xsd:boolean ;
        rdfs:label "disabled" ;
        rdfs:comment "System glossary can't be deleted. Use this flag to disable them" .

    om:deleted a owl:DatatypeProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range xsd:boolean ;
        rdfs:label "deleted" ;
        rdfs:comment "When true indicates the entity has been soft deleted" .

    # Object Properties
    om:hasOwner a owl:ObjectProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range om:Owner ;
        rdfs:label "owners" ;
        rdfs:comment "Owners of this glossary" .

    om:hasReviewer a owl:ObjectProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range om:User ;
        rdfs:label "reviewers" ;
        rdfs:comment "User references of the reviewers for this glossary" .

    om:inDomain a owl:ObjectProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range om:Domain ;
        rdfs:label "domains" ;
        rdfs:comment "Domains the Glossary belongs to" .

    om:hasTag a owl:ObjectProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range om:TagLabel ;
        rdfs:label "tags" ;
        rdfs:comment "Tags for this glossary" .

    om:hasDataProduct a owl:ObjectProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range om:DataProduct ;
        rdfs:label "dataProducts" ;
        rdfs:comment "List of data products this entity is part of" .

    om:hasVotes a owl:ObjectProperty ;
        rdfs:domain om:Glossary ;
        rdfs:range om:Votes ;
        rdfs:label "votes" ;
        rdfs:comment "Votes on the entity" .

    # Example Instance
    ex:businessGlossary a om:Glossary ;
        om:glossaryName "BusinessGlossary" ;
        om:fullyQualifiedName "BusinessGlossary" ;
        om:displayName "Business Glossary" ;
        om:description "Standard business terminology for the organization" ;
        om:mutuallyExclusive false ;
        om:usageCount 42 ;
        om:termCount 15 ;
        om:hasOwner ex:dataGovernanceTeam ;
        om:hasReviewer ex:janeDoe ;
        om:inDomain ex:enterpriseDomain ;
        om:hasTag ex:governanceApproved .
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

        "Glossary": "om:Glossary",
        "name": {
          "@id": "om:glossaryName",
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
        "mutuallyExclusive": {
          "@id": "om:mutuallyExclusive",
          "@type": "xsd:boolean"
        },
        "usageCount": {
          "@id": "om:usageCount",
          "@type": "xsd:integer"
        },
        "termCount": {
          "@id": "om:termCount",
          "@type": "xsd:integer"
        },
        "disabled": {
          "@id": "om:disabled",
          "@type": "xsd:boolean"
        },
        "deleted": {
          "@id": "om:deleted",
          "@type": "xsd:boolean"
        },
        "owners": {
          "@id": "om:hasOwner",
          "@type": "@id",
          "@container": "@set"
        },
        "reviewers": {
          "@id": "om:hasReviewer",
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
        "dataProducts": {
          "@id": "om:hasDataProduct",
          "@type": "@id",
          "@container": "@set"
        },
        "votes": {
          "@id": "om:hasVotes",
          "@type": "@id"
        }
      }
    }
    ```

    **Example JSON-LD Instance**:

    ```json
    {
      "@context": "https://open-metadata.org/context/glossary.jsonld",
      "@type": "Glossary",
      "@id": "https://example.com/glossary/business",

      "name": "BusinessGlossary",
      "fullyQualifiedName": "BusinessGlossary",
      "displayName": "Business Glossary",
      "description": "# Business Glossary\n\nStandard business terminology and definitions for the organization.\n\n## Purpose\n- Ensure consistent understanding of business terms\n- Document business concepts and relationships\n- Support data governance initiatives",
      "mutuallyExclusive": false,
      "usageCount": 42,
      "termCount": 15,

      "owners": [
        {
          "@id": "https://example.com/teams/data-governance",
          "@type": "Team",
          "name": "DataGovernance",
          "displayName": "Data Governance Team"
        }
      ],

      "reviewers": [
        {
          "@id": "https://example.com/users/jane.doe",
          "@type": "User",
          "name": "jane.doe",
          "displayName": "Jane Doe"
        },
        {
          "@id": "https://example.com/users/john.smith",
          "@type": "User",
          "name": "john.smith",
          "displayName": "John Smith"
        }
      ],

      "domains": [
        {
          "@id": "https://example.com/domains/enterprise",
          "@type": "Domain",
          "name": "Enterprise"
        }
      ],

      "tags": [
        {
          "@id": "https://open-metadata.org/tags/Governance/Approved",
          "tagFQN": "Governance.Approved"
        }
      ],

      "dataProducts": [
        {
          "@id": "https://example.com/dataproducts/customer-360",
          "@type": "DataProduct",
          "name": "Customer360"
        }
      ],

      "votes": {
        "@id": "https://example.com/glossary/business/votes",
        "upVotes": 10,
        "downVotes": 2
      }
    }
    ```

    **[View Full JSON-LD Context →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/contexts/glossary.jsonld)**

---

## Use Cases

- Create domain-specific glossaries (Sales, Finance, Marketing, etc.)
- Establish organization-wide business terminology standards
- Document regulatory and compliance terminology
- Support data governance programs
- Enable self-service data discovery through business context
- Facilitate cross-team communication with shared vocabulary
- Maintain hierarchical term relationships

---

## JSON Schema Specification

### Core Properties

#### `id` (uuid)
**Type**: `string` (UUID format)
**Required**: Yes (system-generated)
**Description**: Unique identifier for this glossary instance

```json
{
  "id": "1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d"
}
```

---

#### `name` (entityName)
**Type**: `string`
**Required**: Yes
**Pattern**: `^[^.]*$` (no dots allowed)
**Min Length**: 1
**Max Length**: 256
**Description**: Name of the glossary

```json
{
  "name": "BusinessGlossary"
}
```

---

#### `fullyQualifiedName` (fullyQualifiedEntityName)
**Type**: `string`
**Required**: Yes (system-generated)
**Pattern**: `^((?!::).)*$`
**Description**: Fully qualified name of the glossary

```json
{
  "fullyQualifiedName": "BusinessGlossary"
}
```

---

#### `displayName`
**Type**: `string`
**Required**: No
**Description**: Human-readable display name

```json
{
  "displayName": "Business Glossary"
}
```

---

#### `description` (markdown)
**Type**: `string` (Markdown format)
**Required**: Yes
**Description**: Description of the glossary

```json
{
  "description": "# Business Glossary\n\nStandard business terminology and definitions for the organization.\n\n## Purpose\n- Ensure consistent understanding of business terms\n- Document business concepts and relationships\n- Support data governance initiatives"
}
```

---

### Structure Properties

#### `mutuallyExclusive` (boolean)
**Type**: `boolean`
**Required**: No (default: false)
**Description**: Glossary terms that are direct children in this glossary are mutually exclusive. When mutually exclusive is `true` only one term can be used to label an entity. When mutually exclusive is `false`, multiple terms from this group can be used to label an entity.

```json
{
  "mutuallyExclusive": false
}
```

---

#### `termCount` (integer)
**Type**: `integer`
**Required**: No
**Description**: Total number of terms in the glossary. This includes all the children in the hierarchy.

```json
{
  "termCount": 15
}
```

---

#### `usageCount` (integer)
**Type**: `integer`
**Required**: No
**Description**: Count of how many times terms from this glossary are used.

```json
{
  "usageCount": 42
}
```

---

#### `disabled` (boolean)
**Type**: `boolean`
**Required**: No
**Description**: System glossary can't be deleted. Use this flag to disable them.

```json
{
  "disabled": false
}
```

---

### Governance Properties

#### `owners` (EntityReferenceList)
**Type**: `object` (EntityReferenceList)
**Required**: No
**Description**: Owners of this glossary

```json
{
  "owners": [
    {
      "id": "owner-uuid",
      "type": "team",
      "name": "DataGovernance",
      "displayName": "Data Governance Team"
    }
  ]
}
```

---

#### `reviewers[]` (EntityReference[])
**Type**: `array` of User or Team references
**Required**: No
**Description**: User references of the reviewers for this glossary

```json
{
  "reviewers": [
    {
      "id": "reviewer-uuid-1",
      "type": "user",
      "name": "jane.doe",
      "displayName": "Jane Doe"
    },
    {
      "id": "reviewer-uuid-2",
      "type": "user",
      "name": "john.smith",
      "displayName": "John Smith"
    }
  ]
}
```

---

#### `domains` (EntityReferenceList)
**Type**: `object` (EntityReferenceList)
**Required**: No
**Description**: Domains the Glossary belongs to

```json
{
  "domains": [
    {
      "id": "domain-uuid",
      "type": "domain",
      "name": "Enterprise",
      "fullyQualifiedName": "Enterprise"
    }
  ]
}
```

---

#### `tags[]` (TagLabel[])
**Type**: `array`
**Required**: No (default: [])
**Description**: Tags for this glossary

```json
{
  "tags": [
    {
      "tagFQN": "Governance.Approved",
      "description": "Approved by governance team",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    }
  ]
}
```

---

#### `dataProducts` (EntityReferenceList)
**Type**: `object` (EntityReferenceList)
**Required**: No
**Description**: List of data products this entity is part of

```json
{
  "dataProducts": [
    {
      "id": "dataproduct-uuid",
      "type": "dataProduct",
      "name": "Customer360",
      "fullyQualifiedName": "Customer360"
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
    "upVoters": ["user-uuid-1", "user-uuid-2"],
    "downVoters": ["user-uuid-3"]
  }
}
```

---

### Versioning Properties

#### `version` (entityVersion)
**Type**: `number`
**Required**: No (system-managed)
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
  "updatedBy": "jane.doe"
}
```

---

#### `impersonatedBy` (impersonatedBy)
**Type**: `object`
**Required**: No (system-managed)
**Description**: Bot user that performed the action on behalf of the actual user

```json
{
  "impersonatedBy": {
    "id": "bot-uuid",
    "type": "bot",
    "name": "ingestion-bot"
  }
}
```

---

#### `href` (href)
**Type**: `string` (URI)
**Required**: No (system-managed)
**Description**: Link to the resource corresponding to this entity

```json
{
  "href": "https://example.com/api/v1/glossaries/1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d"
}
```

---

#### `changeDescription` (changeDescription)
**Type**: `object`
**Required**: No (system-managed)
**Description**: Change that lead to this version of the entity

```json
{
  "changeDescription": {
    "fieldsAdded": [],
    "fieldsUpdated": [
      {
        "name": "description",
        "oldValue": "Old description",
        "newValue": "Updated description"
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
**Required**: No (system-managed)
**Description**: Change that lead to this version of the entity

```json
{
  "incrementalChangeDescription": {
    "fieldsAdded": [
      {
        "name": "tags",
        "newValue": "[{\"tagFQN\":\"Governance.Approved\"}]"
      }
    ],
    "fieldsUpdated": [],
    "fieldsDeleted": []
  }
}
```

---

#### `deleted` (boolean)
**Type**: `boolean`
**Required**: No (default: false)
**Description**: When `true` indicates the entity has been soft deleted

```json
{
  "deleted": false
}
```

---

#### `provider` (providerType)
**Type**: `string`
**Required**: No
**Description**: Provider type for the glossary

```json
{
  "provider": "system"
}
```

---

#### `entityStatus` (status)
**Type**: `object`
**Required**: No
**Description**: Status of the Glossary

```json
{
  "entityStatus": {
    "status": "Approved",
    "message": "Glossary has been reviewed and approved"
  }
}
```

---

#### `extension` (entityExtension)
**Type**: `object`
**Required**: No
**Description**: Entity extension data with custom attributes added to the entity

```json
{
  "extension": {
    "customProperty1": "value1",
    "customProperty2": "value2"
  }
}
```

---

## Complete Example

```json
{
  "id": "1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d",
  "name": "BusinessGlossary",
  "fullyQualifiedName": "BusinessGlossary",
  "displayName": "Business Glossary",
  "description": "# Business Glossary\n\nStandard business terminology and definitions for the organization.",
  "mutuallyExclusive": false,
  "usageCount": 42,
  "termCount": 15,
  "disabled": false,
  "deleted": false,
  "href": "https://example.com/api/v1/glossaries/1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d",
  "owners": [
    {
      "id": "owner-uuid",
      "type": "team",
      "name": "DataGovernance",
      "displayName": "Data Governance Team"
    }
  ],
  "reviewers": [
    {
      "id": "reviewer-uuid-1",
      "type": "user",
      "name": "jane.doe",
      "displayName": "Jane Doe"
    }
  ],
  "domains": [
    {
      "id": "domain-uuid",
      "type": "domain",
      "name": "Enterprise",
      "fullyQualifiedName": "Enterprise"
    }
  ],
  "tags": [
    {
      "tagFQN": "Governance.Approved",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    }
  ],
  "dataProducts": [
    {
      "id": "dataproduct-uuid",
      "type": "dataProduct",
      "name": "Customer360",
      "fullyQualifiedName": "Customer360"
    }
  ],
  "votes": {
    "upVotes": 10,
    "downVotes": 2,
    "upVoters": ["user-uuid-1", "user-uuid-2"],
    "downVoters": ["user-uuid-3"]
  },
  "provider": "user",
  "entityStatus": {
    "status": "Approved",
    "message": "Glossary has been reviewed and approved"
  },
  "extension": {
    "customProperty1": "value1"
  },
  "version": 1.2,
  "updatedAt": 1704240000000,
  "updatedBy": "jane.doe"
}
```

---

## RDF Representation

### Ontology Class

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .

om:Glossary a owl:Class ;
    rdfs:subClassOf om:GovernanceAsset ;
    rdfs:label "Glossary" ;
    rdfs:comment "This schema defines the Glossary entity. A Glossary is collection of hierarchical GlossaryTerms." .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://example.com/glossary/> .

ex:businessGlossary a om:Glossary ;
    om:name "BusinessGlossary" ;
    om:fullyQualifiedName "BusinessGlossary" ;
    om:displayName "Business Glossary" ;
    om:description "Standard business terminology for the organization" ;
    om:mutuallyExclusive false ;
    om:usageCount 42 ;
    om:termCount 15 ;
    om:disabled false ;
    om:deleted false ;
    om:hasOwner ex:dataGovernanceTeam ;
    om:hasReviewer ex:janeDoe ;
    om:hasReviewer ex:johnSmith ;
    om:inDomain ex:enterpriseDomain ;
    om:hasTag ex:governanceApproved ;
    om:hasDataProduct ex:customer360 ;
    om:hasVotes ex:businessGlossaryVotes .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "om": "https://open-metadata.org/schema/",
    "xsd": "http://www.w3.org/2001/XMLSchema#",
    "Glossary": "om:Glossary",
    "name": {
      "@id": "om:name",
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
    "mutuallyExclusive": {
      "@id": "om:mutuallyExclusive",
      "@type": "xsd:boolean"
    },
    "usageCount": {
      "@id": "om:usageCount",
      "@type": "xsd:integer"
    },
    "termCount": {
      "@id": "om:termCount",
      "@type": "xsd:integer"
    },
    "disabled": {
      "@id": "om:disabled",
      "@type": "xsd:boolean"
    },
    "deleted": {
      "@id": "om:deleted",
      "@type": "xsd:boolean"
    },
    "owners": {
      "@id": "om:hasOwner",
      "@type": "@id",
      "@container": "@set"
    },
    "reviewers": {
      "@id": "om:hasReviewer",
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
    "dataProducts": {
      "@id": "om:hasDataProduct",
      "@type": "@id",
      "@container": "@set"
    },
    "votes": {
      "@id": "om:hasVotes",
      "@type": "@id"
    }
  }
}
```

### JSON-LD Example

```json
{
  "@context": "https://open-metadata.org/context/glossary.jsonld",
  "@type": "Glossary",
  "@id": "https://example.com/glossary/business",
  "name": "BusinessGlossary",
  "fullyQualifiedName": "BusinessGlossary",
  "displayName": "Business Glossary",
  "description": "Standard business terminology for the organization",
  "mutuallyExclusive": false,
  "usageCount": 42,
  "termCount": 15,
  "owners": [
    {
      "@id": "https://example.com/teams/data-governance",
      "@type": "Team"
    }
  ],
  "reviewers": [
    {
      "@id": "https://example.com/users/jane.doe",
      "@type": "User"
    }
  ],
  "domains": [
    {
      "@id": "https://example.com/domains/enterprise",
      "@type": "Domain"
    }
  ],
  "dataProducts": [
    {
      "@id": "https://example.com/dataproducts/customer-360",
      "@type": "DataProduct"
    }
  ]
}
```

---

## Relationships

### Associated Entities
- **Owners**: Users or teams owning this glossary
- **Reviewers**: Users or teams that can review terms
- **Domains**: Business domain assignments
- **Tags**: Classification tags
- **DataProducts**: Data products this glossary is part of
- **Votes**: Community voting on the glossary

---

## Custom Properties

This entity supports custom properties through the `extension` field.
Common custom properties include:

- **Data Classification**: Sensitivity level
- **Cost Center**: Billing allocation
- **Retention Period**: Data retention requirements
- **Application Owner**: Owning application/team

See [Custom Properties](../metadata-specifications/custom-properties.md)
for details on defining and using custom properties.

---

## API Operations

### List Glossaries

```http
GET /v1/glossaries
Query Parameters:
  - fields: Fields to include (owners, tags, reviewers, usageCount, termCount, domains, extension)
  - limit: Number of results (1-1000000, default 10)
  - before: Cursor for previous page
  - after: Cursor for next page
  - include: all | deleted | non-deleted (default: non-deleted)

Response: GlossaryList
```

**Example Request**:

```http
GET /v1/glossaries?fields=owners,termCount,reviewers&limit=20
```

---

### Create Glossary

```http
POST /v1/glossaries
Content-Type: application/json

{
  "name": "BusinessGlossary",
  "displayName": "Business Glossary",
  "description": "# Business Glossary\n\nStandard business terminology and definitions for enterprise-wide consistency.",
  "owner": {
    "id": "team-uuid",
    "type": "team"
  },
  "reviewers": [
    {
      "id": "user-uuid-1",
      "type": "user"
    },
    {
      "id": "user-uuid-2",
      "type": "user"
    }
  ],
  "tags": [
    {"tagFQN": "Governance.Approved"},
    {"tagFQN": "BusinessCritical"}
  ],
  "domain": {
    "id": "domain-uuid",
    "type": "domain"
  },
  "mutuallyExclusive": false
}

Response: Glossary
```

---

### Get Glossary by Name

```http
GET /v1/glossaries/name/{name}
Query Parameters:
  - fields: Fields to include (owners, tags, reviewers, usageCount, termCount, domains)
  - include: all | deleted | non-deleted (default: non-deleted)

Response: Glossary
```

**Example Request**:

```http
GET /v1/glossaries/name/BusinessGlossary?fields=owners,termCount,reviewers
```

---

### Get Glossary by FQN

```http
GET /v1/glossaries/name/{fqn}
Query Parameters:
  - fields: Fields to include
  - include: all | deleted | non-deleted (default: non-deleted)

Response: Glossary
```

---

### Get Glossary by ID

```http
GET /v1/glossaries/{id}
Query Parameters:
  - fields: Fields to include
  - include: all | deleted | non-deleted (default: non-deleted)

Response: Glossary
```

---

### Update Glossary (Partial)

```http
PATCH /v1/glossaries/{id}
Content-Type: application/json-patch+json

[
  {
    "op": "add",
    "path": "/reviewers/-",
    "value": {
      "id": "new-reviewer-uuid",
      "type": "user"
    }
  },
  {
    "op": "replace",
    "path": "/description",
    "value": "Updated glossary description"
  },
  {
    "op": "add",
    "path": "/tags/-",
    "value": {"tagFQN": "Governance.Published"}
  }
]

Response: Glossary
```

---

### Create or Update Glossary

```http
PUT /v1/glossaries
Content-Type: application/json

{
  "name": "BusinessGlossary",
  "displayName": "Business Glossary",
  "description": "Standard business terminology",
  "owner": {
    "id": "team-uuid",
    "type": "team"
  }
}

Response: Glossary
```

---

### Delete Glossary

```http
DELETE /v1/glossaries/{id}
Query Parameters:
  - hardDelete: true | false (default: false - soft delete)
  - recursive: true | false (default: false)

Response: Glossary
```

---

### Delete Glossary (Async)

```http
DELETE /v1/glossaries/async/{id}
Query Parameters:
  - hardDelete: true | false (default: false)
  - recursive: true | false (default: false)

Response: Async deletion job details
```

---

### Export Glossary

```http
GET /v1/glossaries/name/{name}/export

Response: CSV file with glossary terms
```

---

### Export Glossary (Async)

```http
GET /v1/glossaries/name/{name}/exportAsync

Response: Async export job details
```

---

### Get CSV Documentation

```http
GET /v1/glossaries/documentation/csv

Response: CSV template documentation
```

---

### Import Glossary

```http
PUT /v1/glossaries/name/{name}/import
Content-Type: multipart/form-data

file: [CSV file with glossary terms]
dryRun: false

Response: Import result
```

---

### Import Glossary (Async)

```http
PUT /v1/glossaries/name/{name}/importAsync
Content-Type: multipart/form-data

file: [CSV file with glossary terms]
dryRun: false

Response: Async import job details
```

---

### Get Glossary Version

```http
GET /v1/glossaries/{id}/versions/{version}

Response: Glossary (specific version)
```

---

### Get Glossary Versions

```http
GET /v1/glossaries/{id}/versions

Response: EntityHistory (all versions)
```

---

### Restore Glossary

```http
PUT /v1/glossaries/restore
Content-Type: application/json

{
  "id": "glossary-uuid"
}

Response: Glossary (restored)
```

---

### Vote on Glossary

```http
PUT /v1/glossaries/{id}/vote
Content-Type: application/json

{
  "vote": "upvote"
}

Response: ChangeEvent
```

---

## Related Documentation

- **[GlossaryTerm](glossary-term.md)** - Individual business terms
- **[Classification](classification.md)** - Tag hierarchies
- **[Domain](../domains/domain.md)** - Business domains
- **[Governance](overview.md)** - Governance framework
