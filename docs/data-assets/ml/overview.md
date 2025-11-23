
# ML Model Assets

**Machine learning models and AI systems**

ML Model assets represent machine learning models, training datasets, features, and experiments. OpenMetadata models ML assets with a two-level hierarchy for MLOps platforms.

---

## Hierarchy Overview

```mermaid
graph TD
    A[MLModelService<br/>MLflow, SageMaker, Vertex AI] --> B1[MLModel:<br/>customer_churn_predictor]
    A --> B2[MLModel:<br/>fraud_detection]
    A --> B3[MLModel:<br/>product_recommendation]

    B1 --> C1[Features]
    B1 --> C2[Hyperparameters]
    B1 --> C3[Metrics]

    C1 --> D1[Feature: recency<br/>Source: customers.last_purchase_date]
    C1 --> D2[Feature: frequency<br/>Source: orders.count_30d]
    C1 --> D3[Feature: monetary<br/>Source: orders.total_amount_30d]

    C2 --> E1[learning_rate: 0.01]
    C2 --> E2[max_depth: 6]
    C2 --> E3[n_estimators: 100]

    C3 --> F1[Accuracy: 92%]
    C3 --> F2[Precision: 0.85]
    C3 --> F3[Recall: 0.88]
    C3 --> F4[AUC: 0.93]

    B1 -.->|trained on| G1[Snowflake<br/>customer_features]
    B1 -.->|predictions to| G2[Snowflake<br/>churn_scores]
    B2 -.->|monitors| G3[Dashboard]

    style A fill:#667eea,color:#fff
    style B1 fill:#4facfe,color:#fff
    style B2 fill:#4facfe,color:#fff
    style B3 fill:#4facfe,color:#fff
    style C1 fill:#00f2fe,color:#fff
    style C2 fill:#00f2fe,color:#fff
    style C3 fill:#00f2fe,color:#fff
    style D1 fill:#43e97b,color:#fff
    style D2 fill:#43e97b,color:#fff
    style D3 fill:#43e97b,color:#fff
    style E1 fill:#fa709a,color:#fff
    style E2 fill:#fa709a,color:#fff
    style E3 fill:#fa709a,color:#fff
    style F1 fill:#f093fb,color:#fff
    style F2 fill:#f093fb,color:#fff
    style F3 fill:#f093fb,color:#fff
    style F4 fill:#f093fb,color:#fff
    style G1 fill:#764ba2,color:#fff
    style G2 fill:#764ba2,color:#fff
    style G3 fill:#764ba2,color:#fff
```

---

## Why This Hierarchy?

### ML Model Service
**Purpose**: Represents the ML platform or model registry

An ML Model Service is the platform that tracks and serves ML models. It contains configuration for connecting to the MLOps tool and discovering models.

**Examples**:

- `mlflow-prod` - Production MLflow instance
- `sagemaker-models` - AWS SageMaker model registry
- `vertex-ai` - Google Cloud Vertex AI
- `databricks-ml` - Databricks ML workspace

**Why needed**: Organizations use different ML platforms for different teams and use cases (MLflow for experimentation, SageMaker for production, Vertex AI for Google Cloud). The service level organizes models by platform.

**Supported Platforms**: MLflow, AWS SageMaker, Azure ML, Google Vertex AI, Databricks ML, Kubeflow, Weights & Biases, Neptune, H2O

[**View ML Model Service Specification →**](mlmodel-service.md){ .md-button }

---

### ML Model
**Purpose**: Represents a trained machine learning model

An ML Model is a trained algorithm that makes predictions. It has features, training data, performance metrics, versions, and deployment information.

**Examples**:

- `customer_churn_predictor` - Predicts customer churn risk
- `product_recommendation` - Recommends products to users
- `fraud_detection` - Identifies fraudulent transactions
- `demand_forecasting` - Forecasts product demand

**Key Metadata**:

- **Algorithm**: Model type (RandomForest, XGBoost, Neural Network, etc.)
- **Features**: Input variables used for predictions
- **Training Data**: Tables/datasets used for training
- **Performance Metrics**: Accuracy, precision, recall, AUC, etc.
- **Versions**: Model iterations with performance tracking
- **Deployment**: Where and how the model is served
- **Lineage**: Training data → Model → Predictions table
- **Owner**: Data science team or individual

**Why needed**: ML models are critical data assets. Tracking them enables:
- Understanding which data trains which models
- Impact analysis (what breaks if training data changes?)
- Model governance (bias detection, compliance)
- Performance monitoring and model drift detection
- Reproducibility and experiment tracking

[**View ML Model Specification →**](mlmodel.md){ .md-button }

---

## ML Model Lifecycle

```mermaid
graph LR
    A[Training Data] -->|Train| B[Experiment]
    B -->|Best Model| C[Registered Model]
    C -->|Deploy| D[Production Model]
    D -->|Predictions| E[Predictions Table]

    A -.->|Version 1.0| A1[customers_features v1]
    C -.->|Version 2.0| C1[Model v2 - 92% accuracy]
    C -.->|Version 1.0| C2[Model v1 - 88% accuracy]

    style A fill:#0061f2,color:#fff
    style B fill:#6900c7,color:#fff
    style C fill:#4facfe,color:#fff
    style D fill:#00ac69,color:#fff
    style E fill:#f5576c,color:#fff
```

**Stages**:
1. **Experimentation**: Train models on different datasets and hyperparameters
2. **Registration**: Register best-performing models in model registry
3. **Deployment**: Deploy models to production (API, batch scoring, edge)
4. **Monitoring**: Track predictions and model performance

---

## Common Patterns

### Pattern 1: MLflow Churn Prediction
```
MLflow Service → customer_churn_predictor Model → Algorithm: XGBoost
                                                 → Features: [recency, frequency, monetary]
                                                 → Training Data: customer_features table
                                                 → Metrics: AUC 0.85, Precision 0.78
```

Classification model predicting customer churn.

### Pattern 2: SageMaker Recommendation Engine
```
SageMaker Service → product_recommendation Model → Algorithm: Collaborative Filtering
                                                  → Features: [user_id, product_views, purchases]
                                                  → Training Data: user_product_interactions
                                                  → Deployment: Real-time endpoint
```

Recommendation model served via API.

### Pattern 3: Vertex AI Demand Forecasting
```
Vertex AI Service → demand_forecasting Model → Algorithm: LSTM Neural Network
                                              → Features: [historical_sales, seasonality, promotions]
                                              → Training Data: sales_history table
                                              → Predictions: future_demand table
```

Time series forecasting model for inventory planning.

---

## Real-World Example

Here's how a data science team builds a fraud detection model:

```mermaid
graph LR
    A[Snowflake<br/>transactions] --> P1[Feature Pipeline]
    B[Snowflake<br/>customers] --> P1

    P1 --> C[fraud_features<br/>Table]
    C -->|Train| D[MLflow<br/>fraud_detection Model]

    D -->|Deploy| E[SageMaker<br/>Production Endpoint]
    E -->|Predictions| F[fraud_scores<br/>Table]

    F -->|Alert| G[Fraud Alert System]

    D -.->|Algorithm| H[Random Forest]
    D -.->|Metrics| I[AUC: 0.93, Precision: 0.85]
    D -.->|Owner| J[Data Science Team]

    style A fill:#0061f2,color:#fff
    style B fill:#0061f2,color:#fff
    style C fill:#00ac69,color:#fff
    style D fill:#4facfe,color:#fff
    style E fill:#f5576c,color:#fff
    style F fill:#6900c7,color:#fff
```

**Flow**:
1. **Feature Engineering**: Pipeline creates features from transactions and customer data
2. **Training**: Model trained on fraud_features table
3. **Registration**: Model registered in MLflow with metrics
4. **Deployment**: Model deployed to SageMaker endpoint
5. **Scoring**: Real-time predictions written to fraud_scores table
6. **Action**: Alerts trigger for high fraud scores

**Benefits**:

- **Lineage**: Trace predictions back to training data
- **Impact Analysis**: Know which models break if transactions table changes
- **Governance**: Track model performance and bias metrics
- **Reproducibility**: Know exact data and code used for training

---

## ML Model Lineage

ML models create complex lineage across the data platform:

```mermaid
graph TD
    A[Raw Events] --> B[Feature Pipeline]
    B --> C[Features Table]
    C --> D[ML Model Training]

    D --> E[Registered Model v1.0]
    D --> F[Registered Model v2.0]

    F --> G[Production Model]
    G --> H[Predictions API]
    H --> I[Predictions Table]

    I --> J[Dashboard]
    I --> K[Alerting System]

    style D fill:#6900c7,color:#fff
    style E fill:#4facfe,color:#fff
    style F fill:#4facfe,color:#fff
    style G fill:#00ac69,color:#fff
```

**Data → Features → Model → Predictions → Decisions**

---

## Model Features

Features are the input variables for ML models. OpenMetadata tracks features and their sources:

```json
{
  "modelName": "customer_churn_predictor",
  "features": [
    {
      "name": "recency",
      "dataType": "integer",
      "source": "customers.last_purchase_date",
      "description": "Days since last purchase"
    },
    {
      "name": "frequency",
      "dataType": "integer",
      "source": "orders.count_30d",
      "description": "Number of orders in last 30 days"
    },
    {
      "name": "monetary",
      "dataType": "float",
      "source": "orders.total_amount_30d",
      "description": "Total spend in last 30 days"
    }
  ]
}
```

**Feature Lineage**: Track which table columns become which model features.

---

## Model Versions

ML models evolve over time. OpenMetadata tracks versions:

| Version | Algorithm | Training Data | Accuracy | Deployed | Date |
|---------|-----------|---------------|----------|----------|------|
| v1.0 | Logistic Regression | customers_2024_01 | 82% | No | 2024-01-15 |
| v2.0 | Random Forest | customers_2024_03 | 88% | No | 2024-03-10 |
| v3.0 | XGBoost | customers_2024_06 | 92% | Yes | 2024-06-20 |

**Version Metadata**: Each version has its own metrics, training data, and deployment status.

---

## Model Governance

Track important governance metadata:

- **Fairness Metrics**: Bias detection across demographic groups
- **Explainability**: SHAP values, feature importance
- **Compliance**: GDPR, model cards, audit logs
- **Data Lineage**: Ensure training data quality and provenance
- **Performance Monitoring**: Drift detection, accuracy over time

---

## Entity Specifications

| Entity | Description | Specification |
|--------|-------------|---------------|
| **ML Model Service** | MLOps platform | [View Spec](mlmodel-service.md) |
| **ML Model** | Trained model | [View Spec](mlmodel.md) |

Each specification includes:
- Complete field reference
- JSON Schema definition
- RDF/OWL ontology representation
- JSON-LD context and examples
- Integration with ML platforms

---

## Supported ML Platforms

OpenMetadata supports metadata extraction from:

- **MLflow** - Open-source ML lifecycle platform
- **AWS SageMaker** - Fully managed ML service
- **Azure Machine Learning** - Enterprise ML platform
- **Google Vertex AI** - Unified ML platform
- **Databricks ML** - ML on lakehouse platform
- **Kubeflow** - ML toolkit for Kubernetes
- **Weights & Biases** - ML experiment tracking
- **Neptune.ai** - ML metadata store
- **H2O.ai** - AutoML platform
- **Hugging Face** - Model hub for transformers

---

## Next Steps

1. **Explore specifications** - Click through ML Model entities above
2. **See ML lineage** - Check out [feature lineage to predictions](../../lineage/overview.md)
3. **ML governance** - Learn about model fairness and compliance
