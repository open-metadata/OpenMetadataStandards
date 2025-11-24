
# ML Model

**Trained machine learning models - from features to predictions**

---

## Overview

The **MlModel** entity represents a trained machine learning model with its features, training data, hyperparameters, performance metrics, versions, and deployment information. It captures the complete lifecycle of an ML model from experimentation to production deployment.

**Hierarchy**:

```mermaid
graph LR
    SVC[ML Model Service] --> MODEL[ML Model]
    MODEL --> FEAT[Features]
    MODEL --> DATA[Training Data]
    MODEL --> VER[Versions]

    style SVC fill:#667eea,color:#fff
    style MODEL fill:#4facfe,color:#fff,stroke:#4c51bf,stroke-width:3px
    style FEAT fill:#f093fb,color:#333
    style DATA fill:#f093fb,color:#333
    style VER fill:#f093fb,color:#333
```

---

## Relationships

MLModel has comprehensive relationships with entities across the metadata platform:

```mermaid
graph TD
    subgraph Hierarchy
        SVC[MLModelService<br/>sagemaker_prod]
        SVC --> MODEL[MLModel<br/>churn_predictor_v2]
    end

    subgraph Features
        MODEL --> F1[Feature<br/>customer_age]
        MODEL --> F2[Feature<br/>total_purchases]
        MODEL --> F3[Feature<br/>days_since_last_order]
        MODEL --> F4[Feature<br/>avg_order_value]
    end

    subgraph Training Data
        MODEL -.->|trained on| TRAIN1[Table<br/>training_data]
        MODEL -.->|trained on| TRAIN2[Table<br/>customer_features]
    end

    subgraph Prediction Data
        MODEL -.->|predicts on| PRED1[Table<br/>customers_current]
        MODEL -.->|outputs to| PRED2[Table<br/>churn_predictions]
    end

    subgraph Pipelines
        PIPE1[Pipeline<br/>feature_engineering] -.->|prepares| TRAIN1
        PIPE2[Pipeline<br/>model_training] -.->|trains| MODEL
        PIPE3[Pipeline<br/>batch_prediction] -.->|uses| MODEL
    end

    subgraph Ownership
        MODEL -.->|owned by| TEAM[Team<br/>Data Science]
        MODEL -.->|owned by| USER[User<br/>ml.engineer]
    end

    subgraph Governance
        MODEL -.->|in domain| DOM[Domain<br/>Customer Analytics]
        MODEL -.->|tagged| TAG1[Tag<br/>Tier.Gold]
        MODEL -.->|tagged| TAG2[Tag<br/>PII.Sensitive]
        MODEL -.->|linked to| GT[GlossaryTerm<br/>Churn Prediction]
    end

    subgraph Metrics
        MODEL --> M1[Metric<br/>Accuracy: 0.89]
        MODEL --> M2[Metric<br/>Precision: 0.87]
        MODEL --> M3[Metric<br/>Recall: 0.91]
        MODEL --> M4[Metric<br/>F1-Score: 0.89]
    end

    subgraph Quality
        TC1[TestCase<br/>model_accuracy_threshold] -.->|validates| MODEL
        TC2[TestCase<br/>prediction_drift_check] -.->|monitors| PRED2
    end

    subgraph Dashboards
        DASH[Dashboard<br/>Model Performance] -.->|monitors| MODEL
        DASH -.->|visualizes| M1
        DASH -.->|visualizes| M2
    end

    style SVC fill:#667eea,color:#fff
    style MODEL fill:#4facfe,color:#fff,stroke:#4c51bf,stroke-width:3px
    style F1 fill:#00f2fe,color:#333
    style F2 fill:#00f2fe,color:#333
    style F3 fill:#00f2fe,color:#333
    style F4 fill:#00f2fe,color:#333
    style TRAIN1 fill:#764ba2,color:#fff
    style TRAIN2 fill:#764ba2,color:#fff
    style PRED1 fill:#764ba2,color:#fff
    style PRED2 fill:#764ba2,color:#fff
    style PIPE1 fill:#f5576c,color:#fff
    style PIPE2 fill:#f5576c,color:#fff
    style PIPE3 fill:#f5576c,color:#fff
    style TEAM fill:#43e97b,color:#fff
    style USER fill:#43e97b,color:#fff
    style DOM fill:#fa709a,color:#fff
    style TAG1 fill:#f093fb,color:#fff
    style TAG2 fill:#f093fb,color:#fff
    style GT fill:#ffd700,color:#333
    style M1 fill:#00ac69,color:#fff
    style M2 fill:#00ac69,color:#fff
    style M3 fill:#00ac69,color:#fff
    style M4 fill:#00ac69,color:#fff
    style TC1 fill:#9b59b6,color:#fff
    style TC2 fill:#9b59b6,color:#fff
    style DASH fill:#ff6b6b,color:#fff
```

**Relationship Types**:

- **Solid lines (→)**: Hierarchical containment (Service contains MLModel, MLModel contains Features and Metrics)
- **Dashed lines (-.->)**: References and associations (ownership, governance, lineage)

### Parent Entities
- **MLModelService**: The ML platform service hosting this model

### Child Entities
- **Feature**: Input features used by the model
- **Metric**: Model performance metrics (accuracy, precision, recall, etc.)

### Associated Entities
- **Owner**: User or team owning this model
- **Domain**: Business domain assignment
- **Tag**: Classification tags
- **GlossaryTerm**: Business terminology
- **Table**: Training data tables, prediction input/output tables
- **Pipeline**: Feature engineering, training, and prediction pipelines
- **Dashboard**: Dashboards monitoring model performance
- **TestCase**: Model validation and drift monitoring tests

---

## Schema Specifications

View the complete ML Model schema in your preferred format:

=== "JSON Schema"

    **Complete JSON Schema Definition**

    ```json
    {
      "$id": "https://open-metadata.org/schema/entity/data/mlmodel.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "MlModel",
      "description": "An `MlModel` represents a trained machine learning model with features, training data, metrics, and versions.",
      "type": "object",
      "javaType": "org.openmetadata.schema.entity.data.MlModel",

      "definitions": {
        "mlFeature": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string",
              "description": "Feature name"
            },
            "dataType": {
              "type": "string",
              "enum": ["integer", "float", "string", "boolean", "array", "object"],
              "description": "Feature data type"
            },
            "description": {
              "type": "string",
              "description": "Feature description"
            },
            "featureSources": {
              "type": "array",
              "description": "Source columns/tables for this feature",
              "items": {
                "$ref": "../../type/entityReference.json"
              }
            },
            "featureAlgorithm": {
              "type": "string",
              "description": "Algorithm used to create this feature"
            },
            "tags": {
              "type": "array",
              "items": {"$ref": "../../type/tagLabel.json"}
            }
          },
          "required": ["name", "dataType"]
        },
        "mlHyperParameter": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string",
              "description": "Hyperparameter name"
            },
            "value": {
              "type": "string",
              "description": "Hyperparameter value"
            },
            "description": {
              "type": "string",
              "description": "Parameter description"
            }
          },
          "required": ["name", "value"]
        },
        "mlStore": {
          "type": "object",
          "properties": {
            "storage": {
              "type": "string",
              "description": "Storage location (S3, GCS, HDFS, etc.)"
            },
            "imageRepository": {
              "type": "string",
              "description": "Container image repository"
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
          "description": "Model name",
          "$ref": "../../type/basic.json#/definitions/entityName"
        },
        "fullyQualifiedName": {
          "description": "Fully qualified name: service.model",
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
        "algorithm": {
          "description": "ML algorithm used",
          "type": "string"
        },
        "mlFeatures": {
          "description": "Features used by the model",
          "type": "array",
          "items": {
            "$ref": "#/definitions/mlFeature"
          }
        },
        "mlHyperParameters": {
          "description": "Model hyperparameters",
          "type": "array",
          "items": {
            "$ref": "#/definitions/mlHyperParameter"
          }
        },
        "target": {
          "description": "Target variable for supervised learning",
          "type": "string"
        },
        "dashboard": {
          "description": "Dashboard for model metrics",
          "$ref": "../../type/entityReference.json"
        },
        "mlStore": {
          "description": "Model storage information",
          "$ref": "#/definitions/mlStore"
        },
        "server": {
          "description": "Endpoint URL where model is served",
          "type": "string",
          "format": "uri"
        },
        "service": {
          "description": "ML model service",
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

      "required": ["id", "name", "algorithm", "service"]
    }
    ```

    **[View Full JSON Schema →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/entity/data/mlmodel.json)**

=== "RDF"

    **RDF/OWL Ontology Definition**

    ```turtle
    @prefix om: <https://open-metadata.org/schema/> .
    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl: <http://www.w3.org/2001/XMLSchema#> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    # MlModel Class Definition
    om:MlModel a owl:Class ;
        rdfs:subClassOf om:DataAsset ;
        rdfs:label "ML Model" ;
        rdfs:comment "A trained machine learning model with features, metrics, and deployment info" ;
        om:hierarchyLevel 2 .

    # Properties
    om:modelName a owl:DatatypeProperty ;
        rdfs:domain om:MlModel ;
        rdfs:range xsd:string ;
        rdfs:label "name" ;
        rdfs:comment "Name of the ML model" .

    om:fullyQualifiedName a owl:DatatypeProperty ;
        rdfs:domain om:MlModel ;
        rdfs:range xsd:string ;
        rdfs:label "fullyQualifiedName" ;
        rdfs:comment "Complete hierarchical name: service.model" .

    om:algorithm a owl:DatatypeProperty ;
        rdfs:domain om:MlModel ;
        rdfs:range xsd:string ;
        rdfs:label "algorithm" ;
        rdfs:comment "ML algorithm (RandomForest, XGBoost, LSTM, etc.)" .

    om:target a owl:DatatypeProperty ;
        rdfs:domain om:MlModel ;
        rdfs:range xsd:string ;
        rdfs:label "target" ;
        rdfs:comment "Target variable for supervised learning" .

    om:hasFeature a owl:ObjectProperty ;
        rdfs:domain om:MlModel ;
        rdfs:range om:MlFeature ;
        rdfs:label "hasFeature" ;
        rdfs:comment "Features used by this model" .

    om:hasHyperParameter a owl:ObjectProperty ;
        rdfs:domain om:MlModel ;
        rdfs:range om:MlHyperParameter ;
        rdfs:label "hasHyperParameter" ;
        rdfs:comment "Model hyperparameters" .

    om:trainedOn a owl:ObjectProperty ;
        rdfs:domain om:MlModel ;
        rdfs:range om:Table ;
        rdfs:label "trainedOn" ;
        rdfs:comment "Training dataset" .

    om:belongsToService a owl:ObjectProperty ;
        rdfs:domain om:MlModel ;
        rdfs:range om:MLModelService ;
        rdfs:label "belongsToService" ;
        rdfs:comment "Parent ML model service" .

    om:ownedBy a owl:ObjectProperty ;
        rdfs:domain om:MlModel ;
        rdfs:range om:Owner ;
        rdfs:label "ownedBy" ;
        rdfs:comment "User or team that owns this model" .

    om:hasTag a owl:ObjectProperty ;
        rdfs:domain om:MlModel ;
        rdfs:range om:Tag ;
        rdfs:label "hasTag" ;
        rdfs:comment "Classification tags applied to model" .

    # Feature Class
    om:MlFeature a owl:Class ;
        rdfs:label "ML Feature" ;
        rdfs:comment "A feature used by an ML model" .

    om:featureName a owl:DatatypeProperty ;
        rdfs:domain om:MlFeature ;
        rdfs:range xsd:string .

    om:featureDataType a owl:DatatypeProperty ;
        rdfs:domain om:MlFeature ;
        rdfs:range xsd:string .

    om:derivedFrom a owl:ObjectProperty ;
        rdfs:domain om:MlFeature ;
        rdfs:range om:Column ;
        rdfs:label "derivedFrom" ;
        rdfs:comment "Source column for this feature" .

    # Hyperparameter Class
    om:MlHyperParameter a owl:Class ;
        rdfs:label "ML Hyperparameter" ;
        rdfs:comment "A hyperparameter configuration" .

    # Example Instance
    ex:churnPredictor a om:MlModel ;
        om:modelName "customer_churn_predictor" ;
        om:fullyQualifiedName "mlflow_prod.customer_churn_predictor" ;
        om:algorithm "XGBoost" ;
        om:target "churn" ;
        om:belongsToService ex:mlflowProd ;
        om:ownedBy ex:dataScience ;
        om:hasTag ex:tierProduction ;
        om:hasFeature ex:recencyFeature ;
        om:hasFeature ex:frequencyFeature ;
        om:hasFeature ex:monetaryFeature ;
        om:trainedOn ex:customerFeaturesTable .
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

        "MlModel": "om:MlModel",
        "name": {
          "@id": "om:modelName",
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
        "algorithm": {
          "@id": "om:algorithm",
          "@type": "xsd:string"
        },
        "target": {
          "@id": "om:target",
          "@type": "xsd:string"
        },
        "mlFeatures": {
          "@id": "om:hasFeature",
          "@type": "@id",
          "@container": "@list"
        },
        "mlHyperParameters": {
          "@id": "om:hasHyperParameter",
          "@type": "@id",
          "@container": "@list"
        },
        "service": {
          "@id": "om:belongsToService",
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
      "@context": "https://open-metadata.org/context/mlmodel.jsonld",
      "@type": "MlModel",
      "@id": "https://example.com/models/customer_churn_predictor",

      "name": "customer_churn_predictor",
      "fullyQualifiedName": "mlflow_prod.customer_churn_predictor",
      "displayName": "Customer Churn Predictor",
      "description": "Predicts customer churn risk using RFM features and XGBoost",
      "algorithm": "XGBoost",
      "target": "churn",

      "service": {
        "@id": "https://example.com/services/mlflow_prod",
        "@type": "MLModelService",
        "name": "mlflow_prod"
      },

      "mlFeatures": [
        {
          "@type": "MlFeature",
          "name": "recency",
          "dataType": "integer",
          "description": "Days since last purchase",
          "featureSources": [
            {
              "@id": "https://example.com/tables/customers/columns/last_purchase_date",
              "@type": "Column"
            }
          ]
        },
        {
          "@type": "MlFeature",
          "name": "frequency",
          "dataType": "integer",
          "description": "Number of purchases in last 90 days"
        },
        {
          "@type": "MlFeature",
          "name": "monetary",
          "dataType": "float",
          "description": "Total spend in last 90 days"
        }
      ],

      "mlHyperParameters": [
        {"name": "max_depth", "value": "6"},
        {"name": "learning_rate", "value": "0.1"},
        {"name": "n_estimators", "value": "100"}
      ],

      "owner": {
        "@id": "https://example.com/teams/data-science",
        "@type": "Team",
        "name": "data-science"
      },

      "tags": [
        {
          "@id": "https://open-metadata.org/tags/Tier/Production",
          "tagFQN": "Tier.Production"
        },
        {
          "@id": "https://open-metadata.org/tags/ModelType/Classification",
          "tagFQN": "ModelType.Classification"
        }
      ]
    }
    ```

    **[View Full JSON-LD Context →](https://github.com/open-metadata/OpenMetadataStandards/blob/main/rdf/contexts/mlmodel.jsonld)**

---

## Use Cases

- Catalog ML models across MLflow, SageMaker, Vertex AI, etc.
- Document model algorithm, features, and purpose
- Track feature lineage from source tables to model inputs
- Monitor model performance metrics and drift
- Version models with training data snapshots
- Apply governance tags (bias-checked, production-ready, etc.)
- Link models to dashboards showing performance
- Capture model deployment endpoints and serving infrastructure
- Enable impact analysis (what breaks if training data changes?)
- Ensure reproducibility with hyperparameter tracking

---

## JSON Schema Specification

### Core Properties

#### `id` (uuid)
**Type**: `string` (UUID format)
**Required**: Yes (system-generated)
**Description**: Unique identifier for this ML model instance

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
**Description**: Name of the ML model (unqualified)

```json
{
  "name": "customer_churn_predictor"
}
```

---

#### `fullyQualifiedName` (fullyQualifiedEntityName)
**Type**: `string`
**Required**: Yes (system-generated)
**Pattern**: `^((?!::).)*$`
**Description**: Fully qualified name in the format `service.model`

```json
{
  "fullyQualifiedName": "mlflow_prod.customer_churn_predictor"
}
```

---

#### `displayName`
**Type**: `string`
**Required**: No
**Description**: Human-readable display name

```json
{
  "displayName": "Customer Churn Predictor v2"
}
```

---

#### `description` (markdown)
**Type**: `string` (Markdown format)
**Required**: No
**Description**: Rich text description of the model's purpose and usage

```json
{
  "description": "# Customer Churn Predictor\n\nPredicts customer churn risk using RFM (Recency, Frequency, Monetary) features.\n\n## Algorithm\nXGBoost classifier with hyperparameter tuning\n\n## Performance\n- AUC: 0.85\n- Precision: 0.78\n- Recall: 0.72\n\n## Usage\nUsed by Customer Success team to identify at-risk customers"
}
```

---

### Model Configuration

#### `algorithm` (string)
**Type**: `string`
**Required**: Yes
**Description**: ML algorithm or model type

**Common Values**:

- Classification: `LogisticRegression`, `RandomForest`, `XGBoost`, `LightGBM`, `CatBoost`, `NeuralNetwork`
- Regression: `LinearRegression`, `Ridge`, `Lasso`, `ElasticNet`, `GradientBoosting`
- Deep Learning: `CNN`, `RNN`, `LSTM`, `GRU`, `Transformer`, `BERT`, `GPT`
- Clustering: `KMeans`, `DBSCAN`, `HierarchicalClustering`
- Recommendation: `CollaborativeFiltering`, `MatrixFactorization`, `DeepRecommender`

```json
{
  "algorithm": "XGBoost"
}
```

---

#### `target` (string)
**Type**: `string`
**Required**: No (required for supervised learning)
**Description**: Target variable name for supervised learning models

```json
{
  "target": "churn"
}
```

---

### Features

#### `mlFeatures[]` (MlFeature[])
**Type**: `array` of MlFeature objects
**Required**: No
**Description**: List of features (input variables) used by the model

**MlFeature Object Properties**:

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `name` | string | Yes | Feature name |
| `dataType` | enum | Yes | Data type (integer, float, string, boolean, array, object) |
| `description` | string | No | Feature description |
| `featureSources` | EntityReference[] | No | Source columns/tables for this feature |
| `featureAlgorithm` | string | No | Algorithm used to compute feature |
| `tags` | TagLabel[] | No | Tags applied to feature |

**Example**:

```json
{
  "mlFeatures": [
    {
      "name": "recency",
      "dataType": "integer",
      "description": "Days since last purchase",
      "featureSources": [
        {
          "id": "col-uuid-1",
          "type": "column",
          "name": "last_purchase_date",
          "fullyQualifiedName": "postgres_prod.ecommerce.public.customers.last_purchase_date"
        }
      ],
      "featureAlgorithm": "DATEDIFF(CURRENT_DATE, last_purchase_date)",
      "tags": [
        {"tagFQN": "FeatureType.Behavioral"}
      ]
    },
    {
      "name": "frequency",
      "dataType": "integer",
      "description": "Number of orders in last 90 days",
      "featureSources": [
        {
          "id": "table-uuid-1",
          "type": "table",
          "name": "orders",
          "fullyQualifiedName": "postgres_prod.ecommerce.public.orders"
        }
      ],
      "featureAlgorithm": "COUNT(*) WHERE order_date >= CURRENT_DATE - 90",
      "tags": [
        {"tagFQN": "FeatureType.Behavioral"}
      ]
    },
    {
      "name": "monetary",
      "dataType": "float",
      "description": "Total spend in last 90 days",
      "featureSources": [
        {
          "id": "col-uuid-2",
          "type": "column",
          "name": "total_amount",
          "fullyQualifiedName": "postgres_prod.ecommerce.public.orders.total_amount"
        }
      ],
      "featureAlgorithm": "SUM(total_amount) WHERE order_date >= CURRENT_DATE - 90",
      "tags": [
        {"tagFQN": "FeatureType.Monetary"}
      ]
    },
    {
      "name": "customer_segment",
      "dataType": "string",
      "description": "Customer segment (Premium, Standard, Basic)",
      "featureSources": [
        {
          "id": "col-uuid-3",
          "type": "column",
          "name": "segment",
          "fullyQualifiedName": "postgres_prod.ecommerce.public.customers.segment"
        }
      ]
    },
    {
      "name": "avg_order_value",
      "dataType": "float",
      "description": "Average order value",
      "featureAlgorithm": "monetary / frequency"
    }
  ]
}
```

---

### Hyperparameters

#### `mlHyperParameters[]` (MlHyperParameter[])
**Type**: `array` of MlHyperParameter objects
**Required**: No
**Description**: Model hyperparameters used for training

**MlHyperParameter Object**:

```json
{
  "mlHyperParameters": [
    {
      "name": "max_depth",
      "value": "6",
      "description": "Maximum tree depth"
    },
    {
      "name": "learning_rate",
      "value": "0.1",
      "description": "Learning rate for boosting"
    },
    {
      "name": "n_estimators",
      "value": "100",
      "description": "Number of boosting rounds"
    },
    {
      "name": "min_child_weight",
      "value": "1"
    },
    {
      "name": "gamma",
      "value": "0"
    },
    {
      "name": "subsample",
      "value": "0.8"
    },
    {
      "name": "colsample_bytree",
      "value": "0.8"
    },
    {
      "name": "objective",
      "value": "binary:logistic"
    },
    {
      "name": "eval_metric",
      "value": "auc"
    }
  ]
}
```

---

### Deployment Properties

#### `mlStore` (MlStore)
**Type**: `object`
**Required**: No
**Description**: Model storage location and artifacts

```json
{
  "mlStore": {
    "storage": "s3://ml-models/customer_churn_predictor/v2/",
    "imageRepository": "docker.company.com/ml-models/churn-predictor:v2.0"
  }
}
```

---

#### `server` (URI)
**Type**: `string` (URI format)
**Required**: No
**Description**: Endpoint URL where model is served for predictions

```json
{
  "server": "https://api.company.com/ml/churn-predictor/v2/predict"
}
```

---

#### `dashboard` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: Dashboard showing model performance metrics

```json
{
  "dashboard": {
    "id": "dashboard-uuid",
    "type": "dashboard",
    "name": "churn_model_performance",
    "fullyQualifiedName": "tableau.ChurnModelPerformance"
  }
}
```

---

### Location Properties

#### `service` (EntityReference)
**Type**: `object`
**Required**: Yes
**Description**: Reference to parent ML model service

```json
{
  "service": {
    "id": "7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d",
    "type": "mlmodelService",
    "name": "mlflow_prod",
    "fullyQualifiedName": "mlflow_prod"
  }
}
```

---

### Governance Properties

#### `owner` (EntityReference)
**Type**: `object`
**Required**: No
**Description**: User or team that owns this model

```json
{
  "owner": {
    "id": "owner-uuid",
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
**Description**: Data domain this model belongs to

```json
{
  "domain": {
    "id": "domain-uuid",
    "type": "domain",
    "name": "Customer Analytics",
    "fullyQualifiedName": "Customer Analytics"
  }
}
```

---

#### `tags[]` (TagLabel[])
**Type**: `array`
**Required**: No
**Description**: Classification tags applied to the model

```json
{
  "tags": [
    {
      "tagFQN": "Tier.Production",
      "description": "Production model",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    },
    {
      "tagFQN": "ModelType.Classification",
      "source": "Classification",
      "labelType": "Automated",
      "state": "Confirmed"
    },
    {
      "tagFQN": "Compliance.BiasChecked",
      "source": "Classification",
      "labelType": "Manual",
      "state": "Confirmed"
    }
  ]
}
```

---

#### `glossaryTerms[]` (GlossaryTerm[])
**Type**: `array`
**Required**: No
**Description**: Business glossary terms linked to this model

```json
{
  "glossaryTerms": [
    {
      "fullyQualifiedName": "BusinessGlossary.CustomerChurn"
    },
    {
      "fullyQualifiedName": "BusinessGlossary.PredictiveModel"
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
  "version": 3.1
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
  "updatedBy": "jane.smith"
}
```

---

## Complete Example

### Customer Churn Predictor

```json
{
  "id": "1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d",
  "name": "customer_churn_predictor",
  "fullyQualifiedName": "mlflow_prod.customer_churn_predictor",
  "displayName": "Customer Churn Predictor v2",
  "description": "# Customer Churn Predictor\n\nPredicts customer churn risk using RFM features and XGBoost.\n\n## Performance\n- AUC: 0.85\n- Precision: 0.78\n- Recall: 0.72",
  "algorithm": "XGBoost",
  "target": "churn",
  "mlFeatures": [
    {
      "name": "recency",
      "dataType": "integer",
      "description": "Days since last purchase",
      "featureSources": [
        {
          "id": "col-uuid-1",
          "type": "column",
          "name": "last_purchase_date",
          "fullyQualifiedName": "postgres_prod.ecommerce.public.customers.last_purchase_date"
        }
      ],
      "featureAlgorithm": "DATEDIFF(CURRENT_DATE, last_purchase_date)"
    },
    {
      "name": "frequency",
      "dataType": "integer",
      "description": "Number of orders in last 90 days"
    },
    {
      "name": "monetary",
      "dataType": "float",
      "description": "Total spend in last 90 days"
    }
  ],
  "mlHyperParameters": [
    {"name": "max_depth", "value": "6"},
    {"name": "learning_rate", "value": "0.1"},
    {"name": "n_estimators", "value": "100"},
    {"name": "objective", "value": "binary:logistic"}
  ],
  "mlStore": {
    "storage": "s3://ml-models/customer_churn_predictor/v2/",
    "imageRepository": "docker.company.com/ml-models/churn-predictor:v2.0"
  },
  "server": "https://api.company.com/ml/churn-predictor/v2/predict",
  "dashboard": {
    "id": "dashboard-uuid",
    "type": "dashboard",
    "name": "churn_model_performance"
  },
  "service": {
    "id": "7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d",
    "type": "mlmodelService",
    "name": "mlflow_prod"
  },
  "owner": {
    "id": "owner-uuid",
    "type": "team",
    "name": "data-science"
  },
  "domain": {
    "id": "domain-uuid",
    "type": "domain",
    "name": "Customer Analytics"
  },
  "tags": [
    {"tagFQN": "Tier.Production"},
    {"tagFQN": "ModelType.Classification"},
    {"tagFQN": "Compliance.BiasChecked"}
  ],
  "glossaryTerms": [
    {"fullyQualifiedName": "BusinessGlossary.CustomerChurn"}
  ],
  "version": 3.1,
  "updatedAt": 1704240000000,
  "updatedBy": "jane.smith"
}
```

### Product Recommendation Model

```json
{
  "id": "2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e",
  "name": "product_recommendation",
  "fullyQualifiedName": "sagemaker_models.product_recommendation",
  "displayName": "Product Recommendation Engine",
  "description": "Collaborative filtering model for personalized product recommendations",
  "algorithm": "MatrixFactorization",
  "mlFeatures": [
    {
      "name": "user_id",
      "dataType": "integer",
      "description": "User identifier"
    },
    {
      "name": "product_views",
      "dataType": "array",
      "description": "Recently viewed products"
    },
    {
      "name": "purchase_history",
      "dataType": "array",
      "description": "Past purchases"
    },
    {
      "name": "user_segment",
      "dataType": "string",
      "description": "User demographic segment"
    }
  ],
  "mlHyperParameters": [
    {"name": "n_factors", "value": "50"},
    {"name": "n_epochs", "value": "20"},
    {"name": "lr_all", "value": "0.005"},
    {"name": "reg_all", "value": "0.02"}
  ],
  "server": "https://runtime.sagemaker.us-west-2.amazonaws.com/endpoints/product-rec-v3/invocations",
  "service": {
    "type": "mlmodelService",
    "name": "sagemaker_models"
  },
  "owner": {
    "type": "team",
    "name": "ml-ops"
  },
  "tags": [
    {"tagFQN": "Tier.Production"},
    {"tagFQN": "ModelType.Recommendation"}
  ]
}
```

---

## RDF Representation

### Ontology Class

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl: <http://www.w3.org/2001/XMLSchema#> .

om:MlModel a owl:Class ;
    rdfs:subClassOf om:DataAsset ;
    rdfs:label "ML Model" ;
    rdfs:comment "A trained machine learning model" ;
    om:hasProperties [
        om:name "string" ;
        om:algorithm "string" ;
        om:features "MlFeature[]" ;
        om:hyperparameters "MlHyperParameter[]" ;
        om:service "MLModelService" ;
        om:owner "Owner" ;
        om:tags "Tag[]" ;
    ] .
```

### Instance Example

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix ex: <https://example.com/models/> .

ex:churn_predictor a om:MlModel ;
    om:modelName "customer_churn_predictor" ;
    om:fullyQualifiedName "mlflow_prod.customer_churn_predictor" ;
    om:displayName "Customer Churn Predictor" ;
    om:algorithm "XGBoost" ;
    om:target "churn" ;
    om:belongsToService ex:mlflow_prod ;
    om:ownedBy ex:data_science ;
    om:hasTag ex:tier_production ;
    om:hasTag ex:model_type_classification ;
    om:hasFeature ex:recency_feature ;
    om:hasFeature ex:frequency_feature ;
    om:hasFeature ex:monetary_feature ;
    om:trainedOn ex:customer_features_table .
```

---

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "om": "https://open-metadata.org/schema/",
    "MlModel": "om:MlModel",
    "name": "om:modelName",
    "fullyQualifiedName": "om:fullyQualifiedName",
    "algorithm": "om:algorithm",
    "target": "om:target",
    "mlFeatures": {
      "@id": "om:hasFeature",
      "@type": "@id",
      "@container": "@list"
    },
    "mlHyperParameters": {
      "@id": "om:hasHyperParameter",
      "@type": "@id",
      "@container": "@list"
    },
    "service": {
      "@id": "om:belongsToService",
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
  "@context": "https://open-metadata.org/context/mlmodel.jsonld",
  "@type": "MlModel",
  "@id": "https://example.com/models/customer_churn_predictor",
  "name": "customer_churn_predictor",
  "fullyQualifiedName": "mlflow_prod.customer_churn_predictor",
  "displayName": "Customer Churn Predictor",
  "algorithm": "XGBoost",
  "target": "churn",
  "service": {
    "@id": "https://example.com/services/mlflow_prod",
    "@type": "MLModelService"
  },
  "mlFeatures": [
    {
      "@type": "MlFeature",
      "name": "recency",
      "dataType": "integer"
    },
    {
      "@type": "MlFeature",
      "name": "frequency",
      "dataType": "integer"
    }
  ],
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

## Relationships

### Parent Entities
- **MLModelService**: The service hosting this model

### Associated Entities
- **Owner**: User or team owning this model
- **Domain**: Business domain assignment
- **Tag**: Classification tags
- **GlossaryTerm**: Business terminology
- **Table**: Training data tables (via feature lineage)
- **Column**: Source columns for features
- **Dashboard**: Performance monitoring dashboard

### Lineage
- **Upstream**: Training tables, feature tables
- **Downstream**: Predictions tables, dashboards, applications

### Relationship Diagram

```mermaid
graph TD
    %% Hierarchical relationships (parent-child)
    SVC[MLModelService<br/>mlflow_prod] -->|contains| ML[MLModel<br/>churn_predictor]
    ML -->|has| FEAT1[Feature<br/>recency]
    ML -->|has| FEAT2[Feature<br/>frequency]
    ML -->|has| FEAT3[Feature<br/>monetary]

    %% Cross-entity relationships - Governance
    USR[Team<br/>Data Science] -.->|owns| ML
    DOM[Domain<br/>Customer Analytics] -.->|groups| ML
    TAG[Tag<br/>Production] -.->|classifies| ML
    GT[GlossaryTerm<br/>Churn Prediction] -.->|describes| ML

    %% Cross-entity relationships - Lineage (upstream)
    TBL1[Table<br/>customers] -.->|trains| ML
    TBL2[Table<br/>transactions] -.->|trains| ML
    COL1[Column<br/>last_purchase_date] -.->|maps to| FEAT1

    %% Cross-entity relationships - Lineage (downstream)
    ML -.->|predicts to| TBL3[Table<br/>churn_predictions]
    ML -.->|monitored by| DASH[Dashboard<br/>Model Performance]
    ML -.->|serves| APP[Application<br/>Retention Campaign]

    %% Cross-entity relationships - Quality
    TC[TestCase<br/>model_accuracy] -.->|validates| ML

    %% Styling
    classDef service fill:#7C3AED,stroke:#5B21B6,color:#fff
    classDef mlmodel fill:#EC4899,stroke:#DB2777,color:#fff
    classDef feature fill:#F9A8D4,stroke:#EC4899,color:#000
    classDef data fill:#2563EB,stroke:#1E40AF,color:#fff
    classDef governance fill:#059669,stroke:#047857,color:#fff
    classDef quality fill:#DC2626,stroke:#B91C1C,color:#fff

    class SVC service
    class ML mlmodel
    class FEAT1,FEAT2,FEAT3 feature
    class TBL1,TBL2,TBL3,COL1,DASH,APP data
    class USR,DOM,TAG,GT governance
    class TC quality
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

## Followers

Users can follow ML models to receive notifications about version updates, performance metrics, and deployment changes. See **[Followers](../../metadata-specifications/followers.md)** for details.

---

## API Operations

All ML Model operations are available under the `/v1/mlmodels` endpoint.

### List ML Models

Get a list of ML models, optionally filtered by service.

```http
GET /v1/mlmodels
Query Parameters:
  - fields: Fields to include (mlFeatures, mlHyperParameters, owner, tags, etc.)
  - service: Filter by ML model service name
  - limit: Number of results (1-1000000, default 10)
  - before/after: Cursor-based pagination
  - include: all | deleted | non-deleted (default: non-deleted)

Response: MlModelList
```

### Create ML Model

Create a new ML model under an ML model service.

```http
POST /v1/mlmodels
Content-Type: application/json

{
  "name": "customer_churn_predictor",
  "service": "mlflow_prod",
  "displayName": "Customer Churn Predictor",
  "description": "XGBoost model for predicting customer churn",
  "algorithm": "XGBoost",
  "mlFeatures": [
    {
      "name": "recency",
      "dataType": "integer",
      "description": "Days since last purchase",
      "featureSources": [
        {"name": "customer_activity", "dataType": "integer"}
      ]
    },
    {
      "name": "frequency",
      "dataType": "integer",
      "description": "Purchase frequency"
    },
    {
      "name": "monetary",
      "dataType": "numerical",
      "description": "Total spend"
    }
  ],
  "mlHyperParameters": [
    {"name": "max_depth", "value": "6"},
    {"name": "learning_rate", "value": "0.1"},
    {"name": "n_estimators", "value": "100"}
  ],
  "target": "churned",
  "dashboard": {"id": "dashboard-uuid", "type": "dashboard"}
}

Response: MlModel
```

### Get ML Model by Name

Get an ML model by its fully qualified name.

```http
GET /v1/mlmodels/name/{fqn}
Query Parameters:
  - fields: Fields to include (mlFeatures, mlHyperParameters, owner, tags, etc.)
  - include: all | deleted | non-deleted

Example:
GET /v1/mlmodels/name/mlflow_prod.customer_churn_predictor?fields=mlFeatures,mlHyperParameters,owner,tags

Response: MlModel
```

### Get ML Model by ID

Get an ML model by its unique identifier.

```http
GET /v1/mlmodels/{id}
Query Parameters:
  - fields: Fields to include
  - include: all | deleted | non-deleted

Response: MlModel
```

### Update ML Model

Update an ML model using JSON Patch.

```http
PATCH /v1/mlmodels/name/{fqn}
Content-Type: application/json-patch+json

[
  {"op": "add", "path": "/tags/-", "value": {"tagFQN": "Tier.Production"}},
  {"op": "replace", "path": "/algorithm", "value": "LightGBM"},
  {"op": "add", "path": "/mlHyperParameters/-", "value": {"name": "num_leaves", "value": "31"}}
]

Response: MlModel
```

### Create or Update ML Model

Create a new ML model or update if it exists.

```http
PUT /v1/mlmodels
Content-Type: application/json

{
  "name": "fraud_detector",
  "service": "sagemaker_prod",
  "algorithm": "RandomForest",
  "mlFeatures": [...]
}

Response: MlModel
```

### Delete ML Model

Delete an ML model by fully qualified name.

```http
DELETE /v1/mlmodels/name/{fqn}
Query Parameters:
  - hardDelete: Permanently delete (default: false)

Response: 200 OK
```

### Update ML Features

Update the features used by the ML model.

```http
PUT /v1/mlmodels/{id}/features
Content-Type: application/json

{
  "mlFeatures": [
    {
      "name": "customer_lifetime_value",
      "dataType": "numerical",
      "description": "Predicted customer lifetime value"
    }
  ]
}

Response: MlModel
```

### Get ML Model Versions

Get all versions of an ML model.

```http
GET /v1/mlmodels/{id}/versions

Response: EntityHistory
```

### Follow ML Model

Add a follower to an ML model.

```http
PUT /v1/mlmodels/{id}/followers/{userId}

Response: ChangeEvent
```

### Get Followers

Get all followers of an ML model.

```http
GET /v1/mlmodels/{id}/followers

Response: EntityReference[]
```

### Vote on ML Model

Upvote or downvote an ML model.

```http
PUT /v1/mlmodels/{id}/vote
Content-Type: application/json

{
  "vote": "upvote"
}

Response: ChangeEvent
```

### Bulk Operations

Create or update multiple ML models.

```http
PUT /v1/mlmodels/bulk
Content-Type: application/json

{
  "entities": [...]
}

Response: BulkOperationResult
    }
  }
}
```

---

## Related Documentation

- **[ML Model Service](mlmodel-service.md)** - Service configuration
- **[ML Overview](overview.md)** - ML assets hierarchy
- **[Lineage](../../lineage/overview.md)** - Model lineage tracking
- **[Data Quality](../../data-quality/overview.md)** - Model performance monitoring
- **[Governance](../../governance/overview.md)** - ML model governance
