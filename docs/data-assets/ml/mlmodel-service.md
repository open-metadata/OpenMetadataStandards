
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
      "title": "MLModelService",
      "description": "An `MLModelService` represents an MLOps platform or model registry that manages machine learning models.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.services.MlModelService",

      "definitions": {
        "mlModelServiceType": {
          "description": "Type of ML Model service",
          "type": "string",
          "enum": [
            "MLflow", "SageMaker", "VertexAI", "AzureML",
            "Databricks", "Kubeflow", "CustomML", "WandB",
            "Neptune", "H2O", "HuggingFace"
          ]
        },
        "mlModelConnection": {
          "type": "object",
          "properties": {
            "config": {
              "oneOf": [
                {"$ref": "#/definitions/mlflowConnection"},
                {"$ref": "#/definitions/sagemakerConnection"},
                {"$ref": "#/definitions/vertexAIConnection"}
              ]
            }
          }
        },
        "mlflowConnection": {
          "type": "object",
          "properties": {
            "type": {"const": "MLflow"},
            "trackingUri": {
              "type": "string",
              "description": "MLflow tracking server URI"
            },
            "registryUri": {
              "type": "string",
              "description": "MLflow model registry URI"
            }
          },
          "required": ["type", "trackingUri"]
        },
        "sagemakerConnection": {
          "type": "object",
          "properties": {
            "type": {"const": "SageMaker"},
            "awsRegion": {
              "type": "string",
              "description": "AWS region"
            },
            "awsAccessKeyId": {
              "type": "string",
              "description": "AWS access key"
            },
            "awsSecretAccessKey": {
              "type": "string",
              "description": "AWS secret key"
            }
          },
          "required": ["type", "awsRegion"]
        },
        "vertexAIConnection": {
          "type": "object",
          "properties": {
            "type": {"const": "VertexAI"},
            "gcpProjectId": {
              "type": "string",
              "description": "GCP project ID"
            },
            "gcpRegion": {
              "type": "string",
              "description": "GCP region"
            }
          },
          "required": ["type", "gcpProjectId"]
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
          "description": "Fully qualified name (same as name for services)",
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
          "$ref": "#/definitions/mlModelServiceType"
        },
        "connection": {
          "description": "Connection configuration",
          "$ref": "#/definitions/mlModelConnection"
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

      "required": ["id", "name", "serviceType", "connection"]
    }
    ```

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/services/mlmodelService.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2001/XMLSchema#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # MLModelService Class Definition
    om:MLModelService a owl:Class ;
        rdfs:subClassOf om:Service ;
        rdfs:label "ML Model Service" ;
        rdfs:comment "An MLOps platform or model registry managing machine learning models" ;
        om:hierarchyLevel 1 .

    # Properties
    om:serviceName a owl:DatatypeProperty ;
        rdfs:domain om:MLModelService ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name of the ML model service" .

    om:serviceType a owl:DatatypeProperty ;
        rdfs:domain om:MLModelService ;
        rdfs:range om:MLModelServiceType ;
        rdfs:label "serviceType" ;
        rdfs:comment "Type of ML model service (MLflow, SageMaker, etc.)" .

    om:trackingUri a owl:DatatypeProperty ;
        rdfs:domain om:MLModelService ;
        rdfs:range xsd:anyURI ;
        rdfs:label "trackingUri" ;
        rdfs:comment "URI for the ML tracking server" .

    om:hasMlModel a owl:ObjectProperty ;
        rdfs:domain om:MLModelService ;
        rdfs:range om:MlModel ;
        rdfs:label "hasMlModel" ;
        rdfs:comment "Models managed by this service" .

    om:ownedBy a owl:ObjectProperty ;
        rdfs:domain om:MLModelService ;
        rdfs:range om:Owner ;
        rdfs:label "ownedBy" ;
        rdfs:comment "User or team that owns this service" .

    om:hasTag a owl:ObjectProperty ;
        rdfs:domain om:MLModelService ;
        rdfs:range om:Tag ;
        rdfs:label "hasTag" ;
        rdfs:comment "Classification tags applied to service" .

    # Service Type Enumeration
    om:MLModelServiceType a owl:Class ;
        owl:oneOf (
            om:MLflowService
            om:SageMakerService
            om:VertexAIService
            om:AzureMLService
            om:DatabricksMLService
        ) .

    # Example Instance
    ex:mlflowProduction a om:MLModelService ;
        om:serviceName "mlflow_prod" ;
        om:fullyQualifiedName "mlflow_prod" ;
        om:serviceType om:MLflowService ;
        om:trackingUri "https://mlflow.company.com" ;
        om:ownedBy ex:dataScience ;
        om:hasTag ex:tierProduction ;
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

        "MLModelService": "om:MLModelService",
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
        }
      }
    }
    ```

    **Example JSON-LD Instance**:

    ```json
    {
      "@context": "https://open-metadata.org/context/mlmodelService.jsonld",
      "@type": "MLModelService",
      "@id": "https://example.com/services/mlflow_prod",

      "name": "mlflow_prod",
      "fullyQualifiedName": "mlflow_prod",
      "displayName": "MLflow Production",
      "description": "Production MLflow instance for model tracking and registry",
      "serviceType": "MLflow",

      "connection": {
        "config": {
          "type": "MLflow",
          "trackingUri": "https://mlflow.company.com",
          "registryUri": "https://mlflow.company.com"
        }
      },

      "owner": {
        "@id": "https://example.com/teams/data-science",
        "@type": "Team",
        "name": "data-science",
        "displayName": "Data Science Team"
      },

      "domain": {
        "@id": "https://example.com/domains/AI-ML",
        "@type": "Domain",
        "name": "AI-ML"
      },

      "tags": [
        {
          "@id": "https://open-metadata.org/tags/Tier/Production",
          "tagFQN": "Tier.Production"
        },
        {
          "@id": "https://open-metadata.org/tags/Environment/Prod",
          "tagFQN": "Environment.Prod"
        }
      ]
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

#### `serviceType` (MLModelServiceType enum)
**Type**: `string` enum
**Required**: Yes
**Allowed Values**:

- `MLflow` - Open-source ML lifecycle management
- `SageMaker` - AWS SageMaker model registry
- `VertexAI` - Google Cloud Vertex AI
- `AzureML` - Azure Machine Learning
- `Databricks` - Databricks ML
- `Kubeflow` - Kubeflow on Kubernetes
- `CustomML` - Custom ML platform
- `WandB` - Weights & Biases
- `Neptune` - Neptune.ai experiment tracking
- `H2O` - H2O.ai AutoML
- `HuggingFace` - Hugging Face model hub

```json
{
  "serviceType": "MLflow"
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

#### `owner` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: User or team that owns this service

```json
{
  "owner": {
    "id": "9d8e7f6a-5b4c-3d2e-1f0a-9b8c7d6e5f4a",
    "type": "team",
    "name": "data-science",
    "displayName": "Data Science Team"
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
    "id": "a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d",
    "type": "domain",
    "name": "AI-ML",
    "fullyQualifiedName": "AI-ML"
  }
}
```

---

#### `tags[]` (TagLabel[])
**Type**: `array`
**Required**: No
**Description**: Classification tags applied to the service

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
  "description": "# MLflow Production\n\nProduction MLflow tracking server and model registry.\n\n## Purpose\n- Track experiments for all production models\n- Register validated models\n- Serve model versions via API",
  "serviceType": "MLflow",
  "connection": {
    "config": {
      "type": "MLflow",
      "trackingUri": "https://mlflow.company.com",
      "registryUri": "https://mlflow.company.com",
      "supportsMetadataExtraction": true
    }
  },
  "owner": {
    "id": "9d8e7f6a-5b4c-3d2e-1f0a-9b8c7d6e5f4a",
    "type": "team",
    "name": "data-science",
    "displayName": "Data Science Team"
  },
  "domain": {
    "id": "a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d",
    "type": "domain",
    "name": "AI-ML"
  },
  "tags": [
    {"tagFQN": "Tier.Production"},
    {"tagFQN": "Environment.Prod"}
  ],
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
  "owner": {
    "id": "9d8e7f6a-5b4c-3d2e-1f0a-9b8c7d6e5f4a",
    "type": "team",
    "name": "ml-ops"
  },
  "tags": [
    {"tagFQN": "Tier.Production"},
    {"tagFQN": "Cloud.AWS"}
  ],
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
@prefix owl: <http://www.w3.org/2001/XMLSchema#> .

om:MLModelService a owl:Class ;
    rdfs:subClassOf om:Service ;
    rdfs:label "ML Model Service" ;
    rdfs:comment "An MLOps platform or model registry" ;
    om:hasProperties [
        om:name "string" ;
        om:serviceType "MLModelServiceType" ;
        om:connection "MLModelConnection" ;
        om:owner "Owner" ;
        om:tags "Tag[]" ;
    ] .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://example.com/services/> .

ex:mlflow_prod a om:MLModelService ;
    om:serviceName "mlflow_prod" ;
    om:fullyQualifiedName "mlflow_prod" ;
    om:displayName "MLflow Production" ;
    om:serviceType "MLflow" ;
    om:trackingUri "https://mlflow.company.com"^^xsd:anyURI ;
    om:ownedBy ex:data_science_team ;
    om:hasTag ex:tier_production ;
    om:hasTag ex:environment_prod ;
    om:hasMlModel ex:churn_predictor ;
    om:hasMlModel ex:fraud_detection .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "om": "https://open-metadata.org/schema/",
    "MLModelService": "om:MLModelService",
    "name": "om:serviceName",
    "fullyQualifiedName": "om:fullyQualifiedName",
    "displayName": "om:displayName",
    "serviceType": {
      "@id": "om:serviceType",
      "@type": "@vocab"
    },
    "connection": {
      "@id": "om:hasConnection",
      "@type": "@id"
    },
    "owner": {
      "@id": "om:ownedBy",
      "@type": "@id"
    },
    "tags": {
      "@id": "om:hasTag",
      "@type": "@id",
      "@container": "@set"
    }
  }
}
```

### JSON-LD Example

```json
{
  "@context": "https://open-metadata.org/context/mlmodelService.jsonld",
  "@type": "MLModelService",
  "@id": "https://example.com/services/mlflow_prod",
  "name": "mlflow_prod",
  "displayName": "MLflow Production",
  "serviceType": "MLflow",
  "owner": {
    "@id": "https://example.com/teams/data-science",
    "@type": "Team"
  },
  "tags": [
    {"@id": "https://open-metadata.org/tags/Tier/Production"}
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
