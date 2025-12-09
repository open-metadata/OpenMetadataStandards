
# ML Model Service

**MLOps platforms and model registries - managing machine learning models at scale**

---

## Overview

The **ML Model Service** entity represents MLOps platforms and model registries that track, manage, and serve machine learning models. It is the top-level container for ML models and connects to platforms like MLflow, SageMaker, Vertex AI, and other ML lifecycle management tools.

**Hierarchy**:
```mermaid
graph LR
    A[MLModelService] --> B[MLModel]
    B --> C[Features]

    style A fill:#667eea,color:#fff
    style B fill:#4facfe,color:#fff
    style C fill:#00f2fe,color:#333
```

---

## Relationships

MLModelService has comprehensive relationships with entities across the metadata platform:

```mermaid
graph TD
    subgraph Service Layer
        A[MLModelService<br/>mlflow_prod]
    end

    subgraph ML Models
        A --> B1[MLModel:<br/>churn_predictor]
        A --> B2[MLModel:<br/>fraud_detection]
        A --> B3[MLModel:<br/>recommendation_engine]

        B1 --> C1[Feature:<br/>recency]
        B1 --> C2[Feature:<br/>frequency]
        B1 --> C3[Feature:<br/>monetary]

        B2 --> C4[Feature:<br/>transaction_amount]
        B2 --> C5[Feature:<br/>merchant_category]

        B3 --> C6[Feature:<br/>user_preferences]
        B3 --> C7[Feature:<br/>product_similarity]
    end

    subgraph Ownership
        A -.->|owned by| D1[Team:<br/>Data Science]
        A -.->|owned by| D2[User:<br/>ml.engineer]
    end

    subgraph Governance
        A -.->|in domain| E[Domain:<br/>ML Platform]
        A -.->|has tags| F1[Tag:<br/>Production]
        A -.->|has tags| F2[Tag:<br/>Tier.Gold]
        A -.->|has tags| F3[Tag:<br/>Sensitive]
    end

    subgraph Training Data Lineage
        G1[Table:<br/>customer_features] -.->|trains| B1
        G2[Table:<br/>transaction_history] -.->|trains| B2
        G3[Table:<br/>user_interactions] -.->|trains| B3

        B1 -.->|predictions to| H1[Table:<br/>churn_scores]
        B2 -.->|predictions to| H2[Table:<br/>fraud_scores]
        B3 -.->|predictions to| H3[Table:<br/>recommendations]
    end

    subgraph ML Pipelines
        I1[Pipeline:<br/>feature_engineering] -.->|creates features for| B1
        I2[Pipeline:<br/>model_training] -.->|trains| B1
        I3[Pipeline:<br/>batch_inference] -.->|runs predictions| B1

        J1[Pipeline:<br/>fraud_feature_pipeline] -.->|creates features for| B2
        J2[Pipeline:<br/>fraud_training_pipeline] -.->|trains| B2
    end

    subgraph Model Versions & Metrics
        B1 -.->|has metrics| K1[Accuracy: 92%<br/>AUC: 0.93]
        B2 -.->|has metrics| K2[Precision: 0.85<br/>Recall: 0.88]
        B3 -.->|has metrics| K3[NDCG: 0.78<br/>MAP: 0.72]
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
    style H1 fill:#f5576c,color:#fff
    style H2 fill:#f5576c,color:#fff
    style H3 fill:#f5576c,color:#fff
    style I1 fill:#00ac69,color:#fff
    style I2 fill:#00ac69,color:#fff
    style I3 fill:#00ac69,color:#fff
    style J1 fill:#00ac69,color:#fff
    style J2 fill:#00ac69,color:#fff
    style K1 fill:#ffd700,color:#333
    style K2 fill:#ffd700,color:#333
    style K3 fill:#ffd700,color:#333
```

**Relationship Types**:

- **Solid lines (→)**: Hierarchical containment (Service manages Models, Models have Features)
- **Dashed lines (-.->)**: References and associations (ownership, governance, lineage, training, inference)

---

### Child Entities
- **MlModel**: ML models managed by this service

### Associated Entities
- **Owner**: User or team owning this service
- **Domain**: Business domain assignment
- **Tag**: Classification tags
- **Table**: Tables for training data and predictions (via lineage)
- **Pipeline**: Feature engineering, training, and inference pipelines

---

## Schema Specifications

View the complete ML Model Service schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/services/mlmodelService.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "MlModelService",
      "description": "MlModel Service Entity, such as MlFlow.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.services.MlModelService",
      "javaInterfaces": [
        "org.openmetadata.schema.EntityInterface",
        "org.openmetadata.schema.ServiceEntityInterface"
      ],

      "definitions": {
        "mlModelServiceType": {
          "description": "Type of MlModel service",
          "type": "string",
          "javaInterfaces": ["org.openmetadata.schema.EnumInterface"],
          "enum": ["Mlflow", "Sklearn", "CustomMlModel", "SageMaker", "VertexAI"],
          "javaEnums": [
            {"name": "Mlflow"},
            {"name": "Sklearn"},
            {"name": "CustomMlModel"},
            {"name": "SageMaker"},
            {"name": "VertexAI"}
          ]
        },
        "mlModelConnection": {
          "type": "object",
          "javaType": "org.openmetadata.schema.type.MlModelConnection",
          "description": "MlModel Connection.",
          "javaInterfaces": [
            "org.openmetadata.schema.ServiceConnectionEntityInterface"
          ],
          "properties": {
            "config": {
              "mask": true,
              "oneOf": [
                {"$ref": "./connections/mlmodel/mlflowConnection.json"},
                {"$ref": "./connections/mlmodel/sklearnConnection.json"},
                {"$ref": "./connections/mlmodel/customMlModelConnection.json"},
                {"$ref": "./connections/mlmodel/sageMakerConnection.json"},
                {"$ref": "./connections/mlmodel/vertexaiConnection.json"}
              ]
            }
          },
          "additionalProperties": false
        }
      },

      "properties": {
        "id": {
          "description": "Unique identifier of this pipeline service instance.",
          "$ref": "../../type/basic.json#/definitions/uuid"
        },
        "name": {
          "description": "Name that identifies this pipeline service.",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "FullyQualifiedName same as `name`.",
          "$ref": "../../type/basic.json#/definitions/fullyQualifiedEntityName"
        },
        "serviceType": {
          "description": "Type of pipeline service such as Airflow or Prefect...",
          "$ref": "#/definitions/mlModelServiceType"
        },
        "description": {
          "description": "Description of a pipeline service instance.",
          "type": "string"
        },
        "displayName": {
          "description": "Display Name that identifies this pipeline service. It could be title or label from the source services.",
          "type": "string"
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
        "pipelines": {
          "description": "References to pipelines deployed for this pipeline service to extract metadata",
          "$ref": "../../type/entityReferenceList.json"
        },
        "connection": {
          "$ref": "#/definitions/mlModelConnection"
        },
        "testConnectionResult": {
          "description": "Last test connection results for this service",
          "$ref": "connections/testConnectionResult.json"
        },
        "tags": {
          "description": "Tags for this MlModel Service.",
          "type": "array",
          "items": {
            "$ref": "../../type/tagLabel.json"
          },
          "default": []
        },
        "owners": {
          "description": "Owners of this pipeline service.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "href": {
          "description": "Link to the resource corresponding to this pipeline service.",
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
        "dataProducts": {
          "description": "List of data products this entity is part of.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "followers": {
          "description": "Followers of this entity.",
          "$ref": "../../type/entityReferenceList.json"
        },
        "domains": {
          "description": "Domains the MLModel service belongs to.",
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

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/services/mlmodelService.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2002/07/owl#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # MLModelService Class Definition
    om:MlModelService a owl:Class ;
        rdfs:subClassOf om:Service ;
        rdfs:label "ML Model Service" ;
        rdfs:comment "MlModel Service Entity, such as MlFlow." ;
        om:hierarchyLevel 1 .

    # Properties
    om:serviceName a owl:DatatypeProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name that identifies this pipeline service." .

    om:serviceType a owl:DatatypeProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range om:MlModelServiceType ;
        rdfs:label "serviceType" ;
        rdfs:comment "Type of MlModel service" .

    om:description a owl:DatatypeProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range xsd:string ;
        rdfs:label "description" ;
        rdfs:comment "Description of a pipeline service instance." .

    om:displayName a owl:DatatypeProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range xsd:string ;
        rdfs:label "displayName" ;
        rdfs:comment "Display Name that identifies this pipeline service." .

    om:hasMlModel a owl:ObjectProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range om:MlModel ;
        rdfs:label "hasMlModel" ;
        rdfs:comment "Models managed by this service" .

    om:owners a owl:ObjectProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range om:EntityReferenceList ;
        rdfs:label "owners" ;
        rdfs:comment "Owners of this pipeline service." .

    om:domains a owl:ObjectProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range om:EntityReferenceList ;
        rdfs:label "domains" ;
        rdfs:comment "Domains the MLModel service belongs to." .

    om:tags a owl:ObjectProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range om:TagLabel ;
        rdfs:label "tags" ;
        rdfs:comment "Tags for this MlModel Service." .

    om:followers a owl:ObjectProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range om:EntityReferenceList ;
        rdfs:label "followers" ;
        rdfs:comment "Followers of this entity." .

    om:dataProducts a owl:ObjectProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range om:EntityReferenceList ;
        rdfs:label "dataProducts" ;
        rdfs:comment "List of data products this entity is part of." .

    om:connection a owl:ObjectProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range om:MlModelConnection ;
        rdfs:label "connection" ;
        rdfs:comment "MlModel Connection." .

    om:pipelines a owl:ObjectProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range om:EntityReferenceList ;
        rdfs:label "pipelines" ;
        rdfs:comment "References to pipelines deployed for this pipeline service to extract metadata" .

    om:ingestionRunner a owl:ObjectProperty ;
        rdfs:domain om:MlModelService ;
        rdfs:range om:EntityReference ;
        rdfs:label "ingestionRunner" ;
        rdfs:comment "The ingestion agent responsible for executing the ingestion pipeline." .

    # Service Type Enumeration
    om:MlModelServiceType a owl:Class ;
        owl:oneOf (
            om:Mlflow
            om:Sklearn
            om:CustomMlModel
            om:SageMaker
            om:VertexAI
        ) .

    # Example Instance
    ex:mlflowProduction a om:MlModelService ;
        om:serviceName "mlflow_prod" ;
        om:fullyQualifiedName "mlflow_prod" ;
        om:displayName "MLflow Production" ;
        om:serviceType om:Mlflow ;
        om:owners ex:dataScienceTeam ;
        om:tags ex:tierProduction ;
        om:domains ex:mlPlatformDomain ;
        om:hasMlModel ex:churnPredictor ;
        om:hasMlModel ex:fraudDetection .
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

        "MlModelService": "om:MlModelService",
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
        "owners": {
          "@id": "om:owners",
          "@type": "@id",
          "@container": "@set"
        },
        "domains": {
          "@id": "om:domains",
          "@type": "@id",
          "@container": "@set"
        },
        "tags": {
          "@id": "om:tags",
          "@type": "@id",
          "@container": "@set"
        },
        "followers": {
          "@id": "om:followers",
          "@type": "@id",
          "@container": "@set"
        },
        "dataProducts": {
          "@id": "om:dataProducts",
          "@type": "@id",
          "@container": "@set"
        },
        "pipelines": {
          "@id": "om:pipelines",
          "@type": "@id",
          "@container": "@set"
        },
        "ingestionRunner": {
          "@id": "om:ingestionRunner",
          "@type": "@id"
        }
      }
    }
    ```

    **Example JSON-LD Instance**:

    ```json
    {
      "@context": "https://open-metadata.org/context/mlmodelService.jsonld",
      "@type": "MlModelService",
      "@id": "https://example.com/services/mlflow_prod",

      "name": "mlflow_prod",
      "fullyQualifiedName": "mlflow_prod",
      "displayName": "MLflow Production",
      "description": "Production MLflow instance for model tracking and registry",
      "serviceType": "Mlflow",

      "connection": {
        "config": {
          "type": "Mlflow",
          "trackingUri": "https://mlflow.company.com",
          "registryUri": "https://mlflow.company.com"
        }
      },

      "owners": [
        {
          "@id": "https://example.com/teams/data-science",
          "@type": "Team",
          "name": "data-science",
          "displayName": "Data Science Team"
        }
      ],

      "domains": [
        {
          "@id": "https://example.com/domains/AI-ML",
          "@type": "Domain",
          "name": "AI-ML"
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

      "followers": [],
      "dataProducts": []
    }
    ```

    **[View Full JSON-LD Context →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/contexts/mlmodelService.jsonld)**

---

## Use Cases

- Connect to MLflow, SageMaker, Vertex AI, and other ML platforms
- Discover and catalog ML models across different registries
- Track model ownership and governance by ML platform
- Apply environment tags (production, staging, development)
- Organize models by team and domain
- Monitor model deployment across platforms
- Ensure compliance for AI/ML systems
- Enable cross-platform model lineage

---

## JSON Schema Specification

### Core Properties

#### `id` (uuid)
**Type**: `string` (UUID format)
**Required**: Yes (system-generated)
**Description**: Unique identifier for this ML model service instance

```json
{
  "id": "7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d"
}
```

---

#### `name` (entityName)
**Type**: `string`
**Required**: Yes
**Pattern**: `^[^.]*$` (no dots allowed)
**Min Length**: 1
**Max Length**: 256
**Description**: Name of the ML model service

```json
{
  "name": "mlflow_prod"
}
```

---

#### `fullyQualifiedName` (fullyQualifiedEntityName)
**Type**: `string`
**Required**: Yes (system-generated)
**Description**: For services, this is the same as `name`

```json
{
  "fullyQualifiedName": "mlflow_prod"
}
```

---

#### `displayName`
**Type**: `string`
**Required**: No
**Description**: Human-readable display name

```json
{
  "displayName": "MLflow Production Environment"
}
```

---

#### `description` (markdown)
**Type**: `string` (Markdown format)
**Required**: No
**Description**: Rich text description of the service's purpose and usage

```json
{
  "description": "# MLflow Production\n\nProduction MLflow instance for tracking experiments, registering models, and serving predictions.\n\n## Usage\n- All production models must be registered here\n- Experiment tracking for data science team\n- Model deployment via SageMaker integration"
}
```

---

### Service Configuration

#### `serviceType` (mlModelServiceType enum)
**Type**: `string` enum
**Required**: Yes
**Allowed Values**:

- `Mlflow` - Open-source ML lifecycle management
- `Sklearn` - Scikit-learn models
- `CustomMlModel` - Custom ML platform
- `SageMaker` - AWS SageMaker model registry
- `VertexAI` - Google Cloud Vertex AI

```json
{
  "serviceType": "Mlflow"
}
```

---

#### `connection` (MLModelConnection)
**Type**: `object`
**Required**: Yes
**Description**: Connection configuration specific to the service type

**MLflow Connection**:

```json
{
  "connection": {
    "config": {
      "type": "MLflow",
      "trackingUri": "https://mlflow.company.com",
      "registryUri": "https://mlflow.company.com",
      "supportsMetadataExtraction": true
    }
  }
}
```

**AWS SageMaker Connection**:

```json
{
  "connection": {
    "config": {
      "type": "SageMaker",
      "awsRegion": "us-west-2",
      "awsAccessKeyId": "${AWS_ACCESS_KEY_ID}",
      "awsSecretAccessKey": "${AWS_SECRET_ACCESS_KEY}",
      "awsSessionToken": "${AWS_SESSION_TOKEN}",
      "endpointURL": "https://api.sagemaker.us-west-2.amazonaws.com"
    }
  }
}
```

**Google Vertex AI Connection**:

```json
{
  "connection": {
    "config": {
      "type": "VertexAI",
      "gcpProjectId": "my-ml-project",
      "gcpRegion": "us-central1",
      "credentials": {
        "gcpConfig": {
          "type": "service_account",
          "projectId": "my-ml-project",
          "privateKeyId": "key-id",
          "privateKey": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n",
          "clientEmail": "ml-service@my-ml-project.iam.gserviceaccount.com"
        }
      }
    }
  }
}
```

**Azure ML Connection**:

```json
{
  "connection": {
    "config": {
      "type": "AzureML",
      "subscriptionId": "azure-subscription-id",
      "resourceGroup": "ml-resource-group",
      "workspaceName": "ml-workspace",
      "tenantId": "azure-tenant-id",
      "clientId": "azure-client-id",
      "clientSecret": "${AZURE_CLIENT_SECRET}"
    }
  }
}
```

---

### Governance Properties

#### `owners` (EntityReferenceList)
**Type**: `array` (EntityReferenceList)
**Required**: No
**Description**: Owners of this pipeline service

```json
{
  "owners": [
    {
      "id": "9d8e7f6a-5b4c-3d2e-1f0a-9b8c7d6e5f4a",
      "type": "team",
      "name": "data-science",
      "displayName": "Data Science Team"
    }
  ]
}
```

---

#### `domains` (EntityReferenceList)
**Type**: `array` (EntityReferenceList)
**Required**: No
**Description**: Domains the MLModel service belongs to

```json
{
  "domains": [
    {
      "id": "a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d",
      "type": "domain",
      "name": "AI-ML",
      "fullyQualifiedName": "AI-ML"
    }
  ]
}
```

---

#### `tags[]` (TagLabel[])
**Type**: `array`
**Required**: No
**Default**: `[]`
**Description**: Tags for this MlModel Service

```json
{
  "tags": [
    {
      "tagFQN": "Tier.Production",
      "description": "Production ML infrastructure",
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

#### `followers` (EntityReferenceList)
**Type**: `array` (EntityReferenceList)
**Required**: No
**Description**: Followers of this entity

```json
{
  "followers": [
    {
      "id": "1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d",
      "type": "user",
      "name": "john.doe",
      "displayName": "John Doe"
    }
  ]
}
```

---

#### `dataProducts` (EntityReferenceList)
**Type**: `array` (EntityReferenceList)
**Required**: No
**Description**: List of data products this entity is part of

```json
{
  "dataProducts": [
    {
      "id": "2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e",
      "type": "dataProduct",
      "name": "ml-insights",
      "fullyQualifiedName": "ml-insights"
    }
  ]
}
```

---

#### `pipelines` (EntityReferenceList)
**Type**: `array` (EntityReferenceList)
**Required**: No
**Description**: References to pipelines deployed for this pipeline service to extract metadata

```json
{
  "pipelines": [
    {
      "id": "3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f",
      "type": "pipeline",
      "name": "mlflow_ingestion",
      "fullyQualifiedName": "mlflow_prod.mlflow_ingestion"
    }
  ]
}
```

---

#### `ingestionRunner` (EntityReference)
**Type**: `object` (EntityReference)
**Required**: No
**Description**: The ingestion agent responsible for executing the ingestion pipeline

```json
{
  "ingestionRunner": {
    "id": "4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a",
    "type": "ingestionPipeline",
    "name": "openmetadata-agent"
  }
}
```

---

#### `href` (href)
**Type**: `string` (URI)
**Required**: No
**Description**: Link to the resource corresponding to this pipeline service

```json
{
  "href": "http://localhost:8585/api/v1/services/mlmodelServices/7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d"
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

#### `changeDescription` (ChangeDescription)
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
        "newValue": [{"tagFQN": "Tier.Production"}]
      }
    ],
    "fieldsDeleted": [],
    "previousVersion": 1.0
  }
}
```

---

#### `incrementalChangeDescription` (ChangeDescription)
**Type**: `object`
**Required**: No
**Description**: Change that lead to this version of the entity

```json
{
  "incrementalChangeDescription": {
    "fieldsAdded": [],
    "fieldsUpdated": [],
    "fieldsDeleted": [],
    "previousVersion": 1.1
  }
}
```

---

#### `impersonatedBy` (impersonatedBy)
**Type**: `string`
**Required**: No
**Description**: Bot user that performed the action on behalf of the actual user

```json
{
  "impersonatedBy": "ingestion-bot"
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

### MLflow Production Service

```json
{
  "id": "7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d",
  "name": "mlflow_prod",
  "fullyQualifiedName": "mlflow_prod",
  "displayName": "MLflow Production",
  "description": "Production MLflow tracking server and model registry for tracking experiments, registering models, and serving predictions.",
  "serviceType": "Mlflow",
  "connection": {
    "config": {
      "type": "Mlflow",
      "trackingUri": "https://mlflow.company.com",
      "registryUri": "https://mlflow.company.com"
    }
  },
  "owners": [
    {
      "id": "9d8e7f6a-5b4c-3d2e-1f0a-9b8c7d6e5f4a",
      "type": "team",
      "name": "data-science",
      "displayName": "Data Science Team"
    }
  ],
  "domains": [
    {
      "id": "a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d",
      "type": "domain",
      "name": "AI-ML"
    }
  ],
  "tags": [
    {"tagFQN": "Tier.Production"},
    {"tagFQN": "Environment.Prod"}
  ],
  "followers": [],
  "dataProducts": [],
  "deleted": false,
  "version": 1.0,
  "updatedAt": 1704240000000,
  "updatedBy": "admin"
}
```

### SageMaker Service

```json
{
  "id": "2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e",
  "name": "sagemaker_models",
  "fullyQualifiedName": "sagemaker_models",
  "displayName": "AWS SageMaker Production",
  "description": "Production SageMaker instance for model deployment and serving",
  "serviceType": "SageMaker",
  "connection": {
    "config": {
      "type": "SageMaker",
      "awsRegion": "us-west-2",
      "awsAccessKeyId": "${AWS_ACCESS_KEY_ID}",
      "awsSecretAccessKey": "${AWS_SECRET_ACCESS_KEY}"
    }
  },
  "owners": [
    {
      "id": "9d8e7f6a-5b4c-3d2e-1f0a-9b8c7d6e5f4a",
      "type": "team",
      "name": "ml-ops",
      "displayName": "ML Operations Team"
    }
  ],
  "tags": [
    {"tagFQN": "Tier.Production"},
    {"tagFQN": "Cloud.AWS"}
  ],
  "deleted": false,
  "version": 1.0,
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
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

om:MlModelService a owl:Class ;
    rdfs:subClassOf om:Service ;
    rdfs:label "ML Model Service" ;
    rdfs:comment "MlModel Service Entity, such as MlFlow." ;
    om:hasProperties [
        om:name "string" ;
        om:serviceType "MlModelServiceType" ;
        om:connection "MlModelConnection" ;
        om:owners "EntityReferenceList" ;
        om:domains "EntityReferenceList" ;
        om:tags "TagLabel[]" ;
    ] .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://example.com/services/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

ex:mlflow_prod a om:MlModelService ;
    om:serviceName "mlflow_prod" ;
    om:fullyQualifiedName "mlflow_prod" ;
    om:displayName "MLflow Production" ;
    om:serviceType om:Mlflow ;
    om:owners ex:data_science_team ;
    om:domains ex:ai_ml_domain ;
    om:tags ex:tier_production ;
    om:tags ex:environment_prod ;
    om:hasMlModel ex:churn_predictor ;
    om:hasMlModel ex:fraud_detection ;
    om:deleted "false"^^xsd:boolean .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "om": "https://open-metadata.org/schema/",
    "MlModelService": "om:MlModelService",
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
    "owners": {
      "@id": "om:owners",
      "@type": "@id",
      "@container": "@set"
    },
    "domains": {
      "@id": "om:domains",
      "@type": "@id",
      "@container": "@set"
    },
    "tags": {
      "@id": "om:tags",
      "@type": "@id",
      "@container": "@set"
    },
    "followers": {
      "@id": "om:followers",
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
  "@context": "https://open-metadata.org/context/mlmodelService.jsonld",
  "@type": "MlModelService",
  "@id": "https://example.com/services/mlflow_prod",
  "name": "mlflow_prod",
  "displayName": "MLflow Production",
  "description": "Production MLflow tracking server and model registry",
  "serviceType": "Mlflow",
  "owners": [
    {
      "@id": "https://example.com/teams/data-science",
      "@type": "Team",
      "name": "data-science"
    }
  ],
  "domains": [
    {
      "@id": "https://example.com/domains/AI-ML",
      "@type": "Domain",
      "name": "AI-ML"
    }
  ],
  "tags": [
    {"@id": "https://open-metadata.org/tags/Tier/Production"}
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

### Create ML Model Service

```http
POST /api/v1/services/mlmodelServices
Content-Type: application/json

{
  "name": "mlflow_prod",
  "serviceType": "MLflow",
  "connection": {
    "config": {
      "type": "MLflow",
      "trackingUri": "https://mlflow.company.com"
    }
  }
}
```

### Get ML Model Service

```http
GET /api/v1/services/mlmodelServices/name/mlflow_prod?fields=owner,tags,domain
```

### Update ML Model Service

```http
PATCH /api/v1/services/mlmodelServices/{id}
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
POST /api/v1/services/mlmodelServices/testConnection
Content-Type: application/json

{
  "serviceType": "MLflow",
  "connection": {
    "config": {
      "type": "MLflow",
      "trackingUri": "https://mlflow.company.com"
    }
  }
}
```

### List Models in Service

```http
GET /api/v1/mlmodels?service=mlflow_prod&fields=algorithm,owner
```

---

## Related Documentation

- **[ML Model](mlmodel.md)** - ML model specification
- **[ML Overview](overview.md)** - ML assets overview
- **[Services](../../schemas/entity/services.md)** - Service entity patterns
- **[Lineage](../../lineage/overview.md)** - Model lineage tracking
