
# Team

**Groups of users with hierarchy and ownership of data assets**

---

## Overview

The **Team** entity represents groups of users organized in a hierarchical structure. Teams can own data assets, have assigned roles, and establish organizational structure for data governance and collaboration.

---

## Relationship Diagram

```mermaid
graph TB
    subgraph "Team Hierarchy"
        ORG[Organization<br/>Acme Corp<br/><i>Type: Organization</i>]
        PARENT[Parent Team<br/>Engineering<br/><i>Type: Division</i>]
        TEAM[Team<br/>Data Engineering<br/><i>Type: Department</i>]
        CHILD1[Child Team<br/>Data Platform<br/><i>Type: Group</i>]
        CHILD2[Child Team<br/>Analytics<br/><i>Type: Group</i>]

        ORG -->|contains| PARENT
        PARENT -->|has sub-team| TEAM
        TEAM -->|has sub-team| CHILD1
        TEAM -->|has sub-team| CHILD2
    end

    subgraph "Team Members"
        USR1[User<br/>jane.doe<br/><i>Data Engineer</i>]
        USR2[User<br/>john.smith<br/><i>Senior Engineer</i>]
        USR3[User<br/>alice.wilson<br/><i>Team Lead</i>]

        TEAM -->|has member| USR1
        TEAM -->|has member| USR2
        TEAM -->|has member| USR3
        TEAM -->|owner| USR3
    end

    subgraph "Roles & Access Control"
        ROLE1[Role<br/>DataEngineer<br/><i>Default Role</i>]
        ROLE2[Role<br/>DataSteward<br/><i>Additional Role</i>]
        POL1[Policy<br/>DatabaseAccess<br/><i>Team Policy</i>]
        POL2[Policy<br/>PipelineManagement<br/><i>Team Policy</i>]

        TEAM -->|default role| ROLE1
        TEAM -->|default role| ROLE2
        TEAM -->|has policy| POL1
        TEAM -->|has policy| POL2
    end

    subgraph "Owned Data Assets"
        TBL1[Table<br/>customers<br/><i>postgres_prod.public</i>]
        TBL2[Table<br/>orders<br/><i>postgres_prod.public</i>]
        PIPE1[Pipeline<br/>customer_etl<br/><i>Daily ETL</i>]
        PIPE2[Pipeline<br/>analytics_sync<br/><i>Real-time</i>]
        DASH1[Dashboard<br/>Data Quality<br/><i>Tableau</i>]
        DASH2[Dashboard<br/>Team Metrics<br/><i>Tableau</i>]

        TEAM -.->|owns| TBL1
        TEAM -.->|owns| TBL2
        TEAM -.->|owns| PIPE1
        TEAM -.->|owns| PIPE2
        TEAM -.->|owns| DASH1
        TEAM -.->|owns| DASH2
    end

    subgraph "Governance"
        DOM[Domain<br/>Customer Data<br/><i>Business Domain</i>]
        GT1[GlossaryTerm<br/>Customer<br/><i>Owned Term</i>]
        GT2[GlossaryTerm<br/>Order<br/><i>Owned Term</i>]

        TEAM -.->|manages| DOM
        TEAM -.->|owns| GT1
        TEAM -.->|owns| GT2
    end

    subgraph "Additional Assets"
        ML1[MLModel<br/>churn_predictor<br/><i>Production</i>]
        TOPIC1[Topic<br/>user_events<br/><i>Kafka</i>]
        CONT1[Container<br/>raw_data<br/><i>S3 Bucket</i>]

        TEAM -.->|owns| ML1
        TEAM -.->|owns| TOPIC1
        TEAM -.->|owns| CONT1
    end

    %% Styling
    classDef orgStyle fill:#7C3AED,stroke:#5B21B6,color:#fff,stroke-width:3px
    classDef teamStyle fill:#8B5CF6,stroke:#7C3AED,color:#fff,stroke-width:3px
    classDef childStyle fill:#A78BFA,stroke:#8B5CF6,color:#000,stroke-width:2px
    classDef userStyle fill:#059669,stroke:#047857,color:#fff,stroke-width:2px
    classDef roleStyle fill:#10B981,stroke:#059669,color:#fff,stroke-width:2px
    classDef policyStyle fill:#34D399,stroke:#10B981,color:#000,stroke-width:2px
    classDef dataStyle fill:#2563EB,stroke:#1E40AF,color:#fff,stroke-width:2px
    classDef governanceStyle fill:#F59E0B,stroke:#D97706,color:#000,stroke-width:2px
    classDef additionalStyle fill:#06B6D4,stroke:#0891B2,color:#fff,stroke-width:2px

    class ORG orgStyle
    class PARENT,TEAM teamStyle
    class CHILD1,CHILD2 childStyle
    class USR1,USR2,USR3 userStyle
    class ROLE1,ROLE2 roleStyle
    class POL1,POL2 policyStyle
    class TBL1,TBL2,PIPE1,PIPE2,DASH1,DASH2 dataStyle
    class DOM,GT1,GT2 governanceStyle
    class ML1,TOPIC1,CONT1 additionalStyle
```

**Key Relationships:**

- **Hierarchical Structure**: Teams organize into parent-child relationships (Organization → Division → Department → Group)
- **Team Members**: Users belong to teams and inherit default roles
- **Access Control**: Teams have default roles and policies that apply to all members
- **Asset Ownership**: Teams own tables, dashboards, pipelines, ML models, topics, and other data assets
- **Domain Management**: Teams manage specific data domains for governance
- **Governance**: Teams own glossary terms and establish data standards

---

## Schema Specifications

View the complete Team schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/teams/team.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "Team",
      "description": "A `Team` represents a group of users organized in a hierarchical structure for collaboration and ownership.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.teams.Team",

      "definitions": {
        "teamType": {
          "description": "Type of team",
          "type": "string",
          "enum": [
            "Organization",
            "BusinessUnit",
            "Division",
            "Department",
            "Group"
          ]
        },
        "teamProfile": {
          "type": "object",
          "properties": {
            "description": {
              "type": "string",
              "description": "Team description"
            },
            "email": {
              "type": "string",
              "format": "email",
              "description": "Team email for notifications"
            },
            "teamSize": {
              "type": "integer",
              "description": "Number of members"
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
          "description": "Team name",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "Fully qualified name: organization.department.team",
          "$ref": "../../type/basic.json#/definitions/fullyQualifiedEntityName"
        },
        "displayName": {
          "description": "Display name",
          "type": "string"
        },
        "description": {
          "description": "Team description",
          "$ref": "../../type/basic.json#/definitions/markdown"
        },
        "teamType": {
          "$ref": "#/definitions/teamType"
        },
        "email": {
          "description": "Team email address",
          "type": "string",
          "format": "email"
        },
        "profile": {
          "$ref": "#/definitions/teamProfile"
        },
        "parents": {
          "description": "Parent teams",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "children": {
          "description": "Child teams",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "users": {
          "description": "Users in this team",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "defaultRoles": {
          "description": "Default roles for team members",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "policies": {
          "description": "Policies applied to this team",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "owns": {
          "description": "Data assets owned by this team",
          "type": "array",
          "items": {
            "$ref": "../../type/entityReference.json"
          }
        },
        "domain": {
          "description": "Data domain this team manages",
          "$ref": "../../type/entityReference.json"
        },
        "isJoinable": {
          "description": "Can users join without approval",
          "type": "boolean",
          "default": false
        },
        "version": {
          "description": "Metadata version",
          "$ref": "../../type/entityHistory.json#/definitions/entityVersion"
        }
      },

      "required": ["id", "name", "teamType"]
    }
    ```

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/teams/team.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2001/XMLSchema#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # Team Class Definition
    om:Team a owl:Class ;
        rdfs:subClassOf om:Entity ;
        rdfs:label "Team" ;
        rdfs:comment "A group of users organized in a hierarchical structure" .

    # Properties
    om:teamName a owl:DatatypeProperty ;
        rdfs:domain om:Team ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name of the team" .

    om:teamEmail a owl:DatatypeProperty ;
        rdfs:domain om:Team ;
        rdfs:range xsd:string ;
        rdfs:label "email" ;
        rdfs:comment "Team email address" .

    om:teamType a owl:DatatypeProperty ;
        rdfs:domain om:Team ;
        rdfs:range om:TeamType ;
        rdfs:label "teamType" ;
        rdfs:comment "Type of team: Organization, Department, Group" .

    om:isJoinable a owl:DatatypeProperty ;
        rdfs:domain om:Team ;
        rdfs:range xsd:boolean ;
        rdfs:label "isJoinable" ;
        rdfs:comment "Whether users can join without approval" .

    om:hasParent a owl:ObjectProperty ;
        rdfs:domain om:Team ;
        rdfs:range om:Team ;
        rdfs:label "hasParent" ;
        rdfs:comment "Parent team in hierarchy" .

    om:hasChild a owl:ObjectProperty ;
        rdfs:domain om:Team ;
        rdfs:range om:Team ;
        rdfs:label "hasChild" ;
        rdfs:comment "Child teams" .

    om:hasMember a owl:ObjectProperty ;
        rdfs:domain om:Team ;
        rdfs:range om:User ;
        rdfs:label "hasMember" ;
        rdfs:comment "Users in this team" .

    om:hasDefaultRole a owl:ObjectProperty ;
        rdfs:domain om:Team ;
        rdfs:range om:Role ;
        rdfs:label "hasDefaultRole" ;
        rdfs:comment "Default roles for team members" .

    om:hasPolicy a owl:ObjectProperty ;
        rdfs:domain om:Team ;
        rdfs:range om:Policy ;
        rdfs:label "hasPolicy" ;
        rdfs:comment "Policies applied to this team" .

    om:teamOwns a owl:ObjectProperty ;
        rdfs:domain om:Team ;
        rdfs:range om:DataAsset ;
        rdfs:label "teamOwns" ;
        rdfs:comment "Data assets owned by this team" .

    om:managesDomain a owl:ObjectProperty ;
        rdfs:domain om:Team ;
        rdfs:range om:Domain ;
        rdfs:label "managesDomain" ;
        rdfs:comment "Data domain managed by this team" .

    # Team Type Enumeration
    om:TeamType a owl:Class ;
        owl:oneOf (
            om:OrganizationType
            om:BusinessUnitType
            om:DivisionType
            om:DepartmentType
            om:GroupType
        ) .

    # Example Instance
    ex:dataEngineeringTeam a om:Team ;
        om:teamName "Data Engineering" ;
        om:teamEmail "data-eng@example.com" ;
        om:teamType om:DepartmentType ;
        om:hasParent ex:engineeringTeam ;
        om:hasMember ex:janeDoe ;
        om:hasMember ex:johnSmith ;
        om:hasDefaultRole ex:dataEngineerRole ;
        om:teamOwns ex:customersTable ;
        om:isJoinable false .
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

        "Team": "om:Team",
        "name": {
          "@id": "om:teamName",
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
        "email": {
          "@id": "om:teamEmail",
          "@type": "xsd:string"
        },
        "description": {
          "@id": "om:description",
          "@type": "xsd:string"
        },
        "teamType": {
          "@id": "om:teamType",
          "@type": "@vocab"
        },
        "isJoinable": {
          "@id": "om:isJoinable",
          "@type": "xsd:boolean"
        },
        "parents": {
          "@id": "om:hasParent",
          "@type": "@id",
          "@container": "@set"
        },
        "children": {
          "@id": "om:hasChild",
          "@type": "@id",
          "@container": "@set"
        },
        "users": {
          "@id": "om:hasMember",
          "@type": "@id",
          "@container": "@set"
        },
        "defaultRoles": {
          "@id": "om:hasDefaultRole",
          "@type": "@id",
          "@container": "@set"
        },
        "policies": {
          "@id": "om:hasPolicy",
          "@type": "@id",
          "@container": "@set"
        },
        "owns": {
          "@id": "om:teamOwns",
          "@type": "@id",
          "@container": "@set"
        },
        "domain": {
          "@id": "om:managesDomain",
          "@type": "@id"
        }
      }
    }
    ```

    **Example JSON-LD Instance**:

    ```json
    {
      "@context": "https://open-metadata.org/context/team.jsonld",
      "@type": "Team",
      "@id": "https://example.com/teams/data-engineering",

      "name": "DataEngineering",
      "fullyQualifiedName": "example_org.Engineering.DataEngineering",
      "displayName": "Data Engineering",
      "email": "data-eng@example.com",
      "description": "Team responsible for building and maintaining data infrastructure",
      "teamType": "Department",
      "isJoinable": false,

      "parents": [
        {
          "@id": "https://example.com/teams/engineering",
          "@type": "Team",
          "name": "Engineering"
        }
      ],

      "users": [
        {
          "@id": "https://example.com/users/jane.doe",
          "@type": "User",
          "name": "jane.doe"
        },
        {
          "@id": "https://example.com/users/john.smith",
          "@type": "User",
          "name": "john.smith"
        }
      ],

      "defaultRoles": [
        {
          "@id": "https://example.com/roles/data-engineer",
          "@type": "Role",
          "name": "DataEngineer"
        }
      ],

      "owns": [
        {
          "@id": "https://example.com/tables/customers",
          "@type": "Table",
          "fullyQualifiedName": "postgres_prod.ecommerce.public.customers"
        }
      ],

      "domain": {
        "@id": "https://example.com/domains/data-platform",
        "@type": "Domain",
        "name": "DataPlatform"
      }
    }
    ```

    **[View Full JSON-LD Context →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/contexts/team.jsonld)**

---

## Use Cases

- Organize users into hierarchical team structures
- Assign ownership of data assets to teams
- Define default roles and permissions for team members
- Manage team-based access control policies
- Track team ownership across data domains
- Enable team-based collaboration on data assets
- Support organizational structure modeling
- Facilitate team notifications and communications

---

## JSON Schema Specification

### Core Properties

#### `id` (uuid)
**Type**: `string` (UUID format)
**Required**: Yes (system-generated)
**Description**: Unique identifier for this team instance

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
**Max Length**: 128
**Description**: Team name (unique within parent)

```json
{
  "name": "DataEngineering"
}
```

---

#### `fullyQualifiedName` (fullyQualifiedEntityName)
**Type**: `string`
**Required**: Yes (system-generated)
**Description**: Fully qualified name showing hierarchy: `organization.division.team`

```json
{
  "fullyQualifiedName": "example_org.Engineering.DataEngineering"
}
```

---

#### `displayName`
**Type**: `string`
**Required**: No
**Description**: Human-readable display name

```json
{
  "displayName": "Data Engineering Team"
}
```

---

#### `description` (markdown)
**Type**: `string` (Markdown format)
**Required**: No
**Description**: Team description and purpose

```json
{
  "description": "# Data Engineering Team\n\nResponsible for building and maintaining data infrastructure, pipelines, and platforms."
}
```

---

### Team Type Properties

#### `teamType` (TeamType enum)
**Type**: `string` enum
**Required**: Yes
**Allowed Values**:

- `Organization` - Top-level organization
- `BusinessUnit` - Business unit within organization
- `Division` - Division within business unit
- `Department` - Department within division
- `Group` - Working group or project team

```json
{
  "teamType": "Department"
}
```

---

#### `email`
**Type**: `string` (email format)
**Required**: No
**Description**: Team email address for notifications

```json
{
  "email": "data-eng@example.com"
}
```

---

### Hierarchy Properties

#### `parents[]` (EntityReference[])
**Type**: `array` of Team references
**Required**: No
**Description**: Parent teams in the organizational hierarchy

```json
{
  "parents": [
    {
      "id": "parent-team-uuid",
      "type": "team",
      "name": "Engineering",
      "fullyQualifiedName": "example_org.Engineering"
    }
  ]
}
```

---

#### `children[]` (EntityReference[])
**Type**: `array` of Team references
**Required**: No
**Description**: Child teams reporting to this team

```json
{
  "children": [
    {
      "id": "child-team-uuid-1",
      "type": "team",
      "name": "DataPlatform",
      "fullyQualifiedName": "example_org.Engineering.DataEngineering.DataPlatform"
    },
    {
      "id": "child-team-uuid-2",
      "type": "team",
      "name": "Analytics",
      "fullyQualifiedName": "example_org.Engineering.DataEngineering.Analytics"
    }
  ]
}
```

---

### Membership Properties

#### `users[]` (EntityReference[])
**Type**: `array` of User references
**Required**: No
**Description**: Users who are members of this team

```json
{
  "users": [
    {
      "id": "user-uuid-1",
      "type": "user",
      "name": "jane.doe",
      "displayName": "Jane Doe"
    },
    {
      "id": "user-uuid-2",
      "type": "user",
      "name": "john.smith",
      "displayName": "John Smith"
    }
  ]
}
```

---

#### `isJoinable`
**Type**: `boolean`
**Required**: No (default: false)
**Description**: Whether users can join this team without approval

```json
{
  "isJoinable": false
}
```

---

### Role and Policy Properties

#### `defaultRoles[]` (EntityReference[])
**Type**: `array` of Role references
**Required**: No
**Description**: Default roles automatically assigned to team members

```json
{
  "defaultRoles": [
    {
      "id": "role-uuid",
      "type": "role",
      "name": "DataEngineer",
      "fullyQualifiedName": "DataEngineer"
    }
  ]
}
```

---

#### `policies[]` (EntityReference[])
**Type**: `array` of Policy references
**Required**: No
**Description**: Access control policies applied to this team

```json
{
  "policies": [
    {
      "id": "policy-uuid-1",
      "type": "policy",
      "name": "TeamDataAccess",
      "fullyQualifiedName": "TeamDataAccess"
    },
    {
      "id": "policy-uuid-2",
      "type": "policy",
      "name": "TeamAdministration",
      "fullyQualifiedName": "TeamAdministration"
    }
  ]
}
```

---

### Ownership Properties

#### `owns[]` (EntityReference[])
**Type**: `array`
**Required**: No
**Description**: Data assets owned by this team

```json
{
  "owns": [
    {
      "id": "table-uuid-1",
      "type": "table",
      "name": "customers",
      "fullyQualifiedName": "postgres_prod.ecommerce.public.customers"
    },
    {
      "id": "dashboard-uuid-1",
      "type": "dashboard",
      "name": "Team Dashboard"
    },
    {
      "id": "pipeline-uuid-1",
      "type": "pipeline",
      "name": "daily_etl"
    }
  ]
}
```

---

#### `domain` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: Data domain this team manages

```json
{
  "domain": {
    "id": "domain-uuid",
    "type": "domain",
    "name": "DataPlatform",
    "fullyQualifiedName": "DataPlatform"
  }
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
  "version": 2.1
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
  "name": "DataEngineering",
  "fullyQualifiedName": "example_org.Engineering.DataEngineering",
  "displayName": "Data Engineering Team",
  "description": "# Data Engineering Team\n\nResponsible for building and maintaining data infrastructure, pipelines, and platforms.",
  "teamType": "Department",
  "email": "data-eng@example.com",
  "isJoinable": false,
  "parents": [
    {
      "id": "parent-uuid",
      "type": "team",
      "name": "Engineering",
      "fullyQualifiedName": "example_org.Engineering"
    }
  ],
  "children": [
    {
      "id": "child-uuid-1",
      "type": "team",
      "name": "DataPlatform"
    },
    {
      "id": "child-uuid-2",
      "type": "team",
      "name": "Analytics"
    }
  ],
  "users": [
    {
      "id": "user-uuid-1",
      "type": "user",
      "name": "jane.doe",
      "displayName": "Jane Doe"
    },
    {
      "id": "user-uuid-2",
      "type": "user",
      "name": "john.smith",
      "displayName": "John Smith"
    }
  ],
  "defaultRoles": [
    {
      "id": "role-uuid",
      "type": "role",
      "name": "DataEngineer"
    }
  ],
  "policies": [
    {
      "id": "policy-uuid",
      "type": "policy",
      "name": "TeamDataAccess"
    }
  ],
  "owns": [
    {
      "type": "table",
      "name": "customers",
      "fullyQualifiedName": "postgres_prod.ecommerce.public.customers"
    },
    {
      "type": "pipeline",
      "name": "daily_etl"
    }
  ],
  "domain": {
    "id": "domain-uuid",
    "type": "domain",
    "name": "DataPlatform"
  },
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

om:Team a owl:Class ;
    rdfs:subClassOf om:Entity ;
    rdfs:label "Team" ;
    rdfs:comment "A group of users in hierarchical structure" ;
    om:hasProperties [
        om:name "string" ;
        om:teamType "TeamType" ;
        om:parents "Team[]" ;
        om:children "Team[]" ;
        om:users "User[]" ;
        om:defaultRoles "Role[]" ;
        om:owns "DataAsset[]" ;
    ] .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://example.com/> .

ex:dataEngineeringTeam a om:Team ;
    om:teamName "DataEngineering" ;
    om:displayName "Data Engineering Team" ;
    om:teamType om:DepartmentType ;
    om:teamEmail "data-eng@example.com" ;
    om:hasParent ex:engineeringTeam ;
    om:hasChild ex:dataPlatformTeam ;
    om:hasChild ex:analyticsTeam ;
    om:hasMember ex:janeDoe ;
    om:hasMember ex:johnSmith ;
    om:hasDefaultRole ex:dataEngineerRole ;
    om:teamOwns ex:customersTable ;
    om:managesDomain ex:dataPlatformDomain ;
    om:isJoinable false .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "Team": "om:Team",
    "name": "om:teamName",
    "email": "om:teamEmail",
    "teamType": {
      "@id": "om:teamType",
      "@type": "@vocab"
    },
    "parents": {
      "@id": "om:hasParent",
      "@type": "@id",
      "@container": "@set"
    },
    "children": {
      "@id": "om:hasChild",
      "@type": "@id",
      "@container": "@set"
    },
    "users": {
      "@id": "om:hasMember",
      "@type": "@id",
      "@container": "@set"
    },
    "owns": {
      "@id": "om:teamOwns",
      "@type": "@id",
      "@container": "@set"
    }
  }
}
```

### JSON-LD Example

```json
{
  "@context": "https://open-metadata.org/context/team.jsonld",
  "@type": "Team",
  "@id": "https://example.com/teams/data-engineering",
  "name": "DataEngineering",
  "displayName": "Data Engineering Team",
  "teamType": "Department",
  "parents": [
    {
      "@id": "https://example.com/teams/engineering",
      "@type": "Team"
    }
  ],
  "users": [
    {
      "@id": "https://example.com/users/jane.doe",
      "@type": "User"
    }
  ],
  "owns": [
    {
      "@id": "https://example.com/tables/customers",
      "@type": "Table"
    }
  ]
}
```

---

## Relationships

### Parent Entities
- **Organization**: Root organization
- **Team**: Parent teams in hierarchy

### Child Entities
- **Team**: Sub-teams within this team
- **User**: Team members

### Associated Entities
- **Role**: Default roles for members
- **Policy**: Access control policies
- **Domain**: Managed data domain
- **DataAsset**: Owned assets

### Relationship Diagram

```mermaid
graph TD
    %% Hierarchical relationships (parent-child)
    ORG[Organization<br/>Acme Corp] -->|contains| TEAM1[Team<br/>Engineering]
    TEAM1 -->|has sub-team| TEAM2[Team<br/>Data Engineering]
    TEAM1 -->|has sub-team| TEAM3[Team<br/>ML Engineering]

    %% Team members
    TEAM2 -->|has member| USR1[User<br/>jane.doe]
    TEAM2 -->|has member| USR2[User<br/>john.smith]
    TEAM2 -->|has owner| USR1

    %% Cross-entity relationships - Roles & Policies
    ROLE[Role<br/>DataEngineer] -.->|assigned to| TEAM2
    POL[Policy<br/>DatabaseAccess] -.->|applies to| TEAM2

    %% Cross-entity relationships - Domains
    TEAM2 -.->|manages| DOM[Domain<br/>CustomerData]

    %% Cross-entity relationships - Owned Assets
    TEAM2 -.->|owns| TBL[Table<br/>customers]
    TEAM2 -.->|owns| PIPE[Pipeline<br/>customer_etl]
    TEAM2 -.->|owns| DASH[Dashboard<br/>Data Quality]

    %% Styling
    classDef org fill:#8B5CF6,stroke:#7C3AED,color:#fff
    classDef team fill:#A78BFA,stroke:#8B5CF6,color:#fff
    classDef user fill:#C4B5FD,stroke:#A78BFA,color:#000
    classDef access fill:#059669,stroke:#047857,color:#fff
    classDef data fill:#2563EB,stroke:#1E40AF,color:#fff

    class ORG org
    class TEAM1,TEAM2,TEAM3 team
    class USR1,USR2 user
    class ROLE,POL,DOM access
    class TBL,PIPE,DASH data
```

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

### Create Team

```http
POST /api/v1/teams
Content-Type: application/json

{
  "name": "DataEngineering",
  "displayName": "Data Engineering Team",
  "teamType": "Department",
  "email": "data-eng@example.com",
  "parents": ["Engineering"]
}
```

### Get Team

```http
GET /api/v1/teams/name/DataEngineering?fields=users,owns,children,defaultRoles
```

### Update Team

```http
PATCH /api/v1/teams/{id}
Content-Type: application/json-patch+json

[
  {
    "op": "add",
    "path": "/users/-",
    "value": {"id": "user-uuid", "type": "user"}
  }
]
```

### Add User to Team

```http
PUT /api/v1/teams/{id}/users/{userId}
```

### Set Team as Owner

```http
PUT /api/v1/tables/{tableId}/owner
Content-Type: application/json

{
  "owner": {
    "id": "team-uuid",
    "type": "team"
  }
}
```

### Assign Default Roles

```http
PUT /api/v1/teams/{id}/defaultRoles
Content-Type: application/json

{
  "defaultRoles": [
    {"id": "role-uuid", "type": "role"}
  ]
}
```

---

## Related Documentation

- **[User](user.md)** - User entity
- **[Role](role.md)** - Role entity
- **[Domain](../../governance/domain.md)** - Data domain
- **[Policy](../../security/policies.md)** - Access policies
- **[Organization](../../core-concepts/organization.md)** - Organization structure
- **[Ownership](../../governance/ownership.md)** - Asset ownership
