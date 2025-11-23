
# Tag

**Individual classification labels - enabling precise data governance and discovery**

---

## Overview

The **Tag** entity represents an individual classification label within a hierarchical taxonomy. Tags are organized under Classifications and can have parent-child relationships, enabling precise categorization of data assets for governance, compliance, and discovery.

## Relationship Diagram

```mermaid
graph TD
    %% Parent classification
    CLASS[Classification<br/>PII]

    %% Main tag entity
    CLASS -->|contains| TAG[Tag<br/>Sensitive]

    %% Parent tag relationship
    TAG_PARENT[Tag<br/>PersonalData] -.->|broader than| TAG

    %% Child tags
    TAG -->|has child| CHILD1[Tag<br/>Email]
    TAG -->|has child| CHILD2[Tag<br/>SSN]
    TAG -->|has child| CHILD3[Tag<br/>CreditCard]
    TAG -->|has child| CHILD4[Tag<br/>BankAccount]

    %% Grandchild tags
    CHILD1 -->|has child| GRAND1[Tag<br/>WorkEmail]
    CHILD1 -->|has child| GRAND2[Tag<br/>PersonalEmail]

    %% Sibling tags
    CLASS -->|contains| SIBLING1[Tag<br/>NonSensitive]
    SIBLING1 -->|has child| SIB_CHILD1[Tag<br/>Name]
    SIBLING1 -->|has child| SIB_CHILD2[Tag<br/>Address]

    %% Applied to columns
    TAG -.->|classifies| COL1[Column<br/>customer_email]
    CHILD1 -.->|classifies| COL2[Column<br/>user_email]
    CHILD1 -.->|classifies| COL3[Column<br/>contact_email]
    CHILD2 -.->|classifies| COL4[Column<br/>ssn]
    CHILD3 -.->|classifies| COL5[Column<br/>card_number]

    %% Applied to tables
    TAG -.->|classifies| TBL1[Table<br/>customer_pii]
    TAG -.->|classifies| TBL2[Table<br/>employee_data]

    %% Applied to other assets
    TAG -.->|classifies| DASH[Dashboard<br/>PII Report]
    TAG -.->|classifies| ML[MLModel<br/>pii_detector]
    TAG -.->|classifies| PIPE[Pipeline<br/>anonymization_job]

    %% Visual styling properties
    STYLE[Style Properties] -.->|color: #FF0000| TAG
    STYLE -.->|icon| TAG

    %% State indicators
    STATE1[Status<br/>Active] -.->|state| TAG

    %% Governance
    OWNER[User/Team] -.->|owns| TAG

    %% Styling
    classDef classification fill:#8B5CF6,stroke:#7C3AED,color:#fff
    classDef tag fill:#A78BFA,stroke:#8B5CF6,color:#fff
    classDef childTag fill:#DDD6FE,stroke:#A78BFA,color:#000
    classDef governance fill:#059669,stroke:#047857,color:#fff
    classDef data fill:#2563EB,stroke:#1E40AF,color:#fff
    classDef metadata fill:#F59E0B,stroke:#D97706,color:#fff

    class CLASS classification
    class TAG,SIBLING1,TAG_PARENT tag
    class CHILD1,CHILD2,CHILD3,CHILD4,GRAND1,GRAND2,SIB_CHILD1,SIB_CHILD2 childTag
    class OWNER,STATE1 governance
    class COL1,COL2,COL3,COL4,COL5,TBL1,TBL2,DASH,ML,PIPE data
    class STYLE metadata
```

---

## Schema Specifications

View the complete Tag schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/classification/tag.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "Tag",
      "description": "A `Tag` is a label within a `Classification` hierarchy used to categorize data assets.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.classification.Tag",

      "definitions": {
        "tagStyle": {
          "type": "object",
          "properties": {
            "color": {
              "type": "string",
              "description": "Hex color code for the tag"
            },
            "iconURL": {
              "type": "string",
              "format": "uri",
              "description": "Icon URL for the tag"
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
          "description": "Tag name",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "Fully qualified name: classification.tag or classification.parent.child",
          "$ref": "../../type/basic.json#/definitions/fullyQualifiedEntityName"
        },
        "displayName": {
          "description": "Display name",
          "type": "string"
        },
        "description": {
          "description": "Markdown description of the tag",
          "$ref": "../../type/basic.json#/definitions/markdown"
        },
        "classification": {
          "description": "Parent classification",
          "$ref": "../../type/entityReference.json"
        },
        "parent": {
          "description": "Parent tag (for nested tags)",
          "$ref": "../../type/entityReference.json"
        },
        "children": {
          "description": "Child tags",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "style": {
          "description": "Visual styling for the tag",
          "$ref": "#/definitions/tagStyle"
        },
        "disabled": {
          "description": "Whether this tag is disabled",
          "type": "boolean",
          "default": false
        },
        "deprecated": {
          "description": "Whether this tag is deprecated",
          "type": "boolean",
          "default": false
        },
        "usageCount": {
          "description": "Number of data assets using this tag",
          "type": "integer"
        },
        "version": {
          "description": "Metadata version",
          "$ref": "../../type/entityHistory.json#/definitions/entityVersion"
        }
      },

      "required": ["id", "name", "classification"]
    }
    ```

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/classification/tag.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2001/XMLSchema#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
    @prefix skos: <http://www.w3.org/2004/02/skos/core#> .

    # Tag Class Definition
    om:Tag a owl:Class ;
        rdfs:subClassOf om:GovernanceAsset, skos:Concept ;
        rdfs:label "Tag" ;
        rdfs:comment "A classification label used to categorize data assets" ;
        om:hierarchyLevel 2 .

    # Properties
    om:tagName a owl:DatatypeProperty ;
        rdfs:domain om:Tag ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name of the tag" ;
        owl:equivalentProperty skos:prefLabel .

    om:fullyQualifiedName a owl:DatatypeProperty ;
        rdfs:domain om:Tag ;
        rdfs:range xsd:string ;
        rdfs:label "fullyQualifiedName" ;
        rdfs:comment "Complete hierarchical name: classification.tag.child" ;
        owl:equivalentProperty skos:notation .

    om:tagDescription a owl:DatatypeProperty ;
        rdfs:domain om:Tag ;
        rdfs:range xsd:string ;
        rdfs:label "description" ;
        rdfs:comment "Description of the tag" ;
        owl:equivalentProperty skos:definition .

    om:tagColor a owl:DatatypeProperty ;
        rdfs:domain om:Tag ;
        rdfs:range xsd:string ;
        rdfs:label "color" ;
        rdfs:comment "Hex color code for visual representation" .

    om:isDisabled a owl:DatatypeProperty ;
        rdfs:domain om:Tag ;
        rdfs:range xsd:boolean ;
        rdfs:label "disabled" ;
        rdfs:comment "Whether this tag is disabled" .

    om:isDeprecated a owl:DatatypeProperty ;
        rdfs:domain om:Tag ;
        rdfs:range xsd:boolean ;
        rdfs:label "deprecated" ;
        rdfs:comment "Whether this tag is deprecated" .

    om:belongsToClassification a owl:ObjectProperty ;
        rdfs:domain om:Tag ;
        rdfs:range om:Classification ;
        rdfs:label "belongsToClassification" ;
        rdfs:comment "Parent classification" ;
        owl:equivalentProperty skos:inScheme .

    om:hasParentTag a owl:ObjectProperty ;
        rdfs:domain om:Tag ;
        rdfs:range om:Tag ;
        rdfs:label "hasParentTag" ;
        rdfs:comment "Parent tag in hierarchy" ;
        owl:equivalentProperty skos:broader .

    om:hasChildTag a owl:ObjectProperty ;
        rdfs:domain om:Tag ;
        rdfs:range om:Tag ;
        rdfs:label "hasChildTag" ;
        rdfs:comment "Child tag in hierarchy" ;
        owl:equivalentProperty skos:narrower .

    om:appliedTo a owl:ObjectProperty ;
        rdfs:domain om:Tag ;
        rdfs:range om:DataAsset ;
        rdfs:label "appliedTo" ;
        rdfs:comment "Data assets tagged with this tag" .

    # Example Instances
    ex:sensitiveTag a om:Tag, skos:Concept ;
        skos:prefLabel "Sensitive" ;
        om:fullyQualifiedName "PII.Sensitive" ;
        skos:definition "Highly sensitive personal information" ;
        skos:inScheme ex:piiClassification ;
        om:tagColor "#FF0000" ;
        om:isDisabled false ;
        om:isDeprecated false ;
        skos:narrower ex:emailTag ;
        skos:narrower ex:ssnTag .

    ex:emailTag a om:Tag, skos:Concept ;
        skos:prefLabel "Email" ;
        om:fullyQualifiedName "PII.Sensitive.Email" ;
        skos:definition "Email addresses" ;
        skos:inScheme ex:piiClassification ;
        skos:broader ex:sensitiveTag ;
        om:tagColor "#FF6600" ;
        om:appliedTo ex:emailColumn .
    ```

    **[View Full RDF Ontology →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/ontology/openmetadata.ttl)**

=== "JSON-LD"

    **JSON-LD Context and Example**

    ```json
    {
      "@context": {
        "@vocab": "https://open-metadata.org/schema/",
        "om": "https://open-metadata.org/schema/",
        "skos": "http://www.w3.org/2004/02/skos/core#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "xsd": "http://www.w3.org/2001/XMLSchema#",

        "Tag": "om:Tag",
        "Concept": "skos:Concept",
        "name": {
          "@id": "skos:prefLabel",
          "@type": "xsd:string"
        },
        "fullyQualifiedName": {
          "@id": "skos:notation",
          "@type": "xsd:string"
        },
        "displayName": {
          "@id": "om:displayName",
          "@type": "xsd:string"
        },
        "description": {
          "@id": "skos:definition",
          "@type": "xsd:string"
        },
        "classification": {
          "@id": "skos:inScheme",
          "@type": "@id"
        },
        "parent": {
          "@id": "skos:broader",
          "@type": "@id"
        },
        "children": {
          "@id": "skos:narrower",
          "@type": "@id",
          "@container": "@set"
        },
        "disabled": {
          "@id": "om:isDisabled",
          "@type": "xsd:boolean"
        },
        "deprecated": {
          "@id": "om:isDeprecated",
          "@type": "xsd:boolean"
        }
      }
    }
    ```

    **Example JSON-LD Instance**:

    ```json
    {
      "@context": "https://open-metadata.org/context/tag.jsonld",
      "@type": ["Tag", "Concept"],
      "@id": "https://open-metadata.org/tags/PII/Sensitive/Email",

      "name": "Email",
      "fullyQualifiedName": "PII.Sensitive.Email",
      "displayName": "Email Address",
      "description": "# Email Address Tag\n\nIdentifies data containing email addresses.\n\n## Usage\n- Applied to columns storing email addresses\n- Triggers privacy protection measures\n- Subject to GDPR right to erasure",

      "classification": {
        "@id": "https://open-metadata.org/classifications/PII",
        "@type": "Classification",
        "name": "PII"
      },

      "parent": {
        "@id": "https://open-metadata.org/tags/PII/Sensitive",
        "@type": "Tag",
        "name": "Sensitive",
        "fullyQualifiedName": "PII.Sensitive"
      },

      "style": {
        "color": "#FF6600",
        "iconURL": "https://example.com/icons/email.svg"
      },

      "disabled": false,
      "deprecated": false,
      "usageCount": 127
    }
    ```

    **[View Full JSON-LD Context →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/contexts/tag.jsonld)**

---

## Use Cases

- Tag tables and columns with governance classifications (PII, PHI, etc.)
- Apply data tier labels (Gold, Silver, Bronze)
- Mark data quality levels
- Label compliance requirements (GDPR, HIPAA, PCI-DSS)
- Enable faceted search and filtering
- Automate data policies based on tags
- Track tag usage across data assets
- Deprecate tags while maintaining history
- Create custom domain-specific taxonomies
- Support automated tag propagation (column → table)

---

## JSON Schema Specification

### Core Properties

#### `id` (uuid)
**Type**: `string` (UUID format)
**Required**: Yes (system-generated)
**Description**: Unique identifier for this tag

```json
{
  "id": "4d5e6f7a-8b9c-4d0e-1f2a-3b4c5d6e7f8a"
}
```

---

#### `name` (entityName)
**Type**: `string`
**Required**: Yes
**Pattern**: `^[^.]*$` (no dots allowed)
**Min Length**: 1
**Max Length**: 256
**Description**: Name of the tag (unqualified)

```json
{
  "name": "Email"
}
```

---

#### `fullyQualifiedName` (fullyQualifiedEntityName)
**Type**: `string`
**Required**: Yes (system-generated)
**Pattern**: `^((?!::).)*$`
**Description**: Fully qualified name showing complete hierarchy

**Format**: `classification.tag` or `classification.parent.child.grandchild`

```json
{
  "fullyQualifiedName": "PII.Sensitive.Email"
}
```

---

#### `displayName`
**Type**: `string`
**Required**: No
**Description**: Human-readable display name

```json
{
  "displayName": "Email Address"
}
```

---

#### `description` (markdown)
**Type**: `string` (Markdown format)
**Required**: No
**Description**: Rich text description of the tag's purpose and usage

```json
{
  "description": "# Email Address Tag\n\nIdentifies data containing email addresses.\n\n## Usage Guidelines\n- Applied to columns storing email addresses\n- Triggers privacy protection measures\n- Subject to GDPR right to erasure\n\n## Examples\n- user_email\n- contact_email\n- billing_email"
}
```

---

### Relationship Properties

#### `classification` (EntityReference)
**Type**: `object`
**Required**: Yes
**Description**: Reference to parent classification

```json
{
  "classification": {
    "id": "classification-uuid",
    "type": "classification",
    "name": "PII",
    "fullyQualifiedName": "PII"
  }
}
```

---

#### `parent` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: Parent tag in hierarchy (if this is a nested tag)

```json
{
  "parent": {
    "id": "parent-tag-uuid",
    "type": "tag",
    "name": "Sensitive",
    "fullyQualifiedName": "PII.Sensitive"
  }
}
```

---

#### `children[]` (Tag[])
**Type**: `array` of Tag references
**Required**: No
**Description**: Child tags in the hierarchy

```json
{
  "children": [
    {
      "id": "child-tag-uuid-1",
      "type": "tag",
      "name": "WorkEmail",
      "fullyQualifiedName": "PII.Sensitive.Email.WorkEmail"
    },
    {
      "id": "child-tag-uuid-2",
      "type": "tag",
      "name": "PersonalEmail",
      "fullyQualifiedName": "PII.Sensitive.Email.PersonalEmail"
    }
  ]
}
```

---

### Visual Properties

#### `style` (TagStyle)
**Type**: `object`
**Required**: No
**Description**: Visual styling for displaying the tag

**TagStyle Object**:

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `color` | string | No | Hex color code (e.g., "#FF6600") |
| `iconURL` | uri | No | URL to tag icon image |

```json
{
  "style": {
    "color": "#FF6600",
    "iconURL": "https://example.com/icons/email.svg"
  }
}
```

**Common Color Schemes**:

- **Red (#FF0000)**: High sensitivity, critical
- **Orange (#FF6600)**: Medium sensitivity
- **Yellow (#FFCC00)**: Low sensitivity
- **Green (#00CC00)**: Public, non-sensitive
- **Blue (#0066FF)**: Informational
- **Purple (#9933FF)**: Compliance-related

---

### State Properties

#### `disabled` (boolean)
**Type**: `boolean`
**Required**: No (default: false)
**Description**: Whether this tag is disabled and hidden from users

```json
{
  "disabled": false
}
```

---

#### `deprecated` (boolean)
**Type**: `boolean`
**Required**: No (default: false)
**Description**: Whether this tag is deprecated (visible but not recommended for new use)

```json
{
  "deprecated": false
}
```

---

### Usage Properties

#### `usageCount` (integer)
**Type**: `integer`
**Required**: No (system-generated)
**Description**: Number of data assets tagged with this tag

```json
{
  "usageCount": 127
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
  "version": 1.3
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

### Primary Tag with Children

```json
{
  "id": "4d5e6f7a-8b9c-4d0e-1f2a-3b4c5d6e7f8a",
  "name": "Sensitive",
  "fullyQualifiedName": "PII.Sensitive",
  "displayName": "Sensitive PII",
  "description": "# Sensitive Personal Information\n\nHighly sensitive personal information requiring strict access controls and encryption.",
  "classification": {
    "id": "classification-uuid",
    "type": "classification",
    "name": "PII",
    "fullyQualifiedName": "PII"
  },
  "parent": null,
  "children": [
    {
      "id": "child-uuid-1",
      "type": "tag",
      "name": "Email",
      "fullyQualifiedName": "PII.Sensitive.Email"
    },
    {
      "id": "child-uuid-2",
      "type": "tag",
      "name": "SSN",
      "fullyQualifiedName": "PII.Sensitive.SSN"
    },
    {
      "id": "child-uuid-3",
      "type": "tag",
      "name": "CreditCard",
      "fullyQualifiedName": "PII.Sensitive.CreditCard"
    }
  ],
  "style": {
    "color": "#FF0000",
    "iconURL": "https://example.com/icons/sensitive.svg"
  },
  "disabled": false,
  "deprecated": false,
  "usageCount": 342,
  "version": 1.3,
  "updatedAt": 1704240000000,
  "updatedBy": "admin"
}
```

### Nested Child Tag

```json
{
  "id": "5e6f7a8b-9c0d-4e1f-2a3b-4c5d6e7f8a9b",
  "name": "Email",
  "fullyQualifiedName": "PII.Sensitive.Email",
  "displayName": "Email Address",
  "description": "Email addresses requiring privacy protection",
  "classification": {
    "id": "classification-uuid",
    "type": "classification",
    "name": "PII",
    "fullyQualifiedName": "PII"
  },
  "parent": {
    "id": "parent-uuid",
    "type": "tag",
    "name": "Sensitive",
    "fullyQualifiedName": "PII.Sensitive"
  },
  "children": [],
  "style": {
    "color": "#FF6600"
  },
  "disabled": false,
  "deprecated": false,
  "usageCount": 127,
  "version": 1.1,
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
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .

om:Tag a owl:Class ;
    rdfs:subClassOf om:GovernanceAsset, skos:Concept ;
    rdfs:label "Tag" ;
    rdfs:comment "A classification label for categorizing data assets" ;
    om:hasProperties [
        om:name "string" ;
        om:description "string" ;
        om:classification "Classification" ;
        om:parent "Tag" ;
        om:children "Tag[]" ;
        om:color "string" ;
        om:disabled "boolean" ;
    ] .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://open-metadata.org/tags/> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .

ex:PII_Sensitive a om:Tag, skos:Concept ;
    skos:prefLabel "Sensitive" ;
    skos:notation "PII.Sensitive" ;
    skos:definition "Highly sensitive personal information" ;
    skos:inScheme ex:PII ;
    om:tagColor "#FF0000" ;
    om:isDisabled false ;
    om:isDeprecated false ;
    skos:narrower ex:PII_Sensitive_Email ;
    skos:narrower ex:PII_Sensitive_SSN .

ex:PII_Sensitive_Email a om:Tag, skos:Concept ;
    skos:prefLabel "Email" ;
    skos:notation "PII.Sensitive.Email" ;
    skos:definition "Email addresses" ;
    skos:inScheme ex:PII ;
    skos:broader ex:PII_Sensitive ;
    om:tagColor "#FF6600" .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "om": "https://open-metadata.org/schema/",
    "skos": "http://www.w3.org/2004/02/skos/core#",
    "Tag": "om:Tag",
    "Concept": "skos:Concept",
    "name": "skos:prefLabel",
    "fullyQualifiedName": "skos:notation",
    "description": "skos:definition",
    "classification": "skos:inScheme",
    "parent": "skos:broader",
    "children": "skos:narrower"
  }
}
```

### JSON-LD Example

```json
{
  "@context": "https://open-metadata.org/context/tag.jsonld",
  "@type": ["Tag", "Concept"],
  "@id": "https://open-metadata.org/tags/PII/Sensitive/Email",
  "name": "Email",
  "fullyQualifiedName": "PII.Sensitive.Email",
  "description": "Email addresses",
  "classification": {
    "@id": "https://open-metadata.org/classifications/PII",
    "@type": "Classification"
  },
  "parent": {
    "@id": "https://open-metadata.org/tags/PII/Sensitive",
    "@type": "Tag"
  },
  "style": {
    "color": "#FF6600"
  }
}
```

---

## Tag Hierarchies

### PII Classification Example

```
PII
├── Sensitive
│   ├── Email
│   ├── SSN
│   ├── CreditCard
│   ├── BankAccount
│   └── Biometric
└── NonSensitive
    ├── Name
    ├── PhoneNumber
    ├── Address
    └── DateOfBirth
```

### Tier Classification Example (Mutually Exclusive)

```
Tier
├── Gold
├── Silver
└── Bronze
```

### Compliance Classification Example

```
Compliance
├── GDPR
│   ├── PersonalData
│   ├── SensitiveData
│   └── RightToErasure
├── HIPAA
│   ├── PHI
│   └── ePHI
└── PCI-DSS
    ├── CardholderData
    └── SensitiveAuthenticationData
```

---

## Relationships

### Parent Entities
- **Classification**: The classification this tag belongs to
- **Tag**: Parent tag (for nested tags)

### Child Entities
- **Tag**: Child tags in hierarchy

### Associated Entities
- **DataAsset**: Tables, columns, dashboards, etc. tagged with this tag
- **Column**: Table columns with this tag
- **Table**: Tables with this tag
- **Dashboard**: Dashboards with this tag

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

### Create Tag

```http
POST /api/v1/classifications/{classificationId}/tags
Content-Type: application/json

{
  "name": "Email",
  "displayName": "Email Address",
  "description": "Email addresses requiring privacy protection",
  "parent": "PII.Sensitive",
  "style": {
    "color": "#FF6600"
  }
}
```

### Get Tag

```http
GET /api/v1/tags/name/PII.Sensitive.Email?fields=parent,children,usageCount
```

### Update Tag

```http
PATCH /api/v1/tags/{id}
Content-Type: application/json-patch+json

[
  {
    "op": "replace",
    "path": "/description",
    "value": "Updated description for email tag"
  },
  {
    "op": "replace",
    "path": "/style/color",
    "value": "#FF9900"
  }
]
```

### Deprecate Tag

```http
PATCH /api/v1/tags/{id}
Content-Type: application/json-patch+json

[
  {
    "op": "replace",
    "path": "/deprecated",
    "value": true
  }
]
```

### Apply Tag to Table

```http
PUT /api/v1/tables/{tableId}/tags
Content-Type: application/json

{
  "tags": [
    {
      "tagFQN": "PII.Sensitive.Email",
      "source": "Classification",
      "labelType": "Manual"
    }
  ]
}
```

### Apply Tag to Column

```http
PUT /api/v1/tables/{tableId}/columns/{columnName}/tags
Content-Type: application/json

{
  "tags": [
    {
      "tagFQN": "PII.Sensitive.Email",
      "source": "Classification",
      "labelType": "Manual"
    }
  ]
}
```

### List Tags by Classification

```http
GET /api/v1/classifications/{classificationId}/tags?fields=parent,children,usageCount
```

### Get Tag Usage

```http
GET /api/v1/tags/name/PII.Sensitive.Email/usage
```

---

## TagLabel Application

When a tag is applied to a data asset, it creates a **TagLabel** with additional metadata:

```json
{
  "tagFQN": "PII.Sensitive.Email",
  "description": "Email addresses",
  "source": "Classification",
  "labelType": "Manual",
  "state": "Confirmed"
}
```

**TagLabel Properties**:

| Property | Type | Description |
|----------|------|-------------|
| `tagFQN` | string | Fully qualified tag name |
| `description` | string | Tag description (inherited) |
| `source` | enum | Source: `Classification`, `Glossary` |
| `labelType` | enum | Type: `Manual`, `Propagated`, `Automated`, `Derived` |
| `state` | enum | State: `Suggested`, `Confirmed` |

---

## Related Documentation

- **[Classification](classification.md)** - Parent classification hierarchies
- **[GlossaryTerm](glossary-term.md)** - Business terminology
- **[Table](../data-assets/databases/table.md)** - Applying tags to tables
- **[Column](../data-assets/databases/column.md)** - Applying tags to columns
- **[SKOS Standard](https://www.w3.org/TR/skos-reference/)** - W3C Simple Knowledge Organization System
- **[Data Governance](overview.md)** - Governance framework
