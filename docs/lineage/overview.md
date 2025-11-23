
# Data Lineage

**End-to-end tracking of data flow, transformations, and dependencies**

Data lineage in OpenMetadata provides comprehensive tracking of how data moves and transforms across your entire data ecosystem. Built on W3C PROV-O (Provenance Ontology) standards, OpenMetadata's lineage captures table-level, column-level, and cross-system data flows to enable impact analysis, root cause debugging, and regulatory compliance.

---

## Lineage Overview

OpenMetadata captures three levels of lineage:

```mermaid
graph LR
    subgraph "Source Systems"
        S1[PostgreSQL<br/>customers]
        S2[MongoDB<br/>events]
        S3[API<br/>products]
    end

    subgraph "Transformation Layer"
        P1[Airflow Pipeline<br/>customer_etl]
        P2[dbt Model<br/>enrich_customers]
        P3[Spark Job<br/>aggregate_events]
    end

    subgraph "Analytics Layer"
        W1[Snowflake<br/>dim_customers]
        W2[Snowflake<br/>fact_events]
        W3[Snowflake<br/>customer_metrics]
    end

    subgraph "Consumption Layer"
        D1[Tableau<br/>Customer Dashboard]
        D2[Looker<br/>Events Report]
    end

    S1 -->|extract| P1
    S2 -->|extract| P3
    S3 -->|extract| P2

    P1 -->|load| W1
    P2 -->|transform| W1
    P3 -->|load| W2

    W1 -->|join| P2
    W1 -->|aggregate| W3
    W2 -->|aggregate| W3

    W1 -->|query| D1
    W3 -->|query| D1
    W2 -->|query| D2

    style S1 fill:#0061f2,color:#fff
    style S2 fill:#0061f2,color:#fff
    style S3 fill:#0061f2,color:#fff
    style P1 fill:#f5576c,color:#fff
    style P2 fill:#f5576c,color:#fff
    style P3 fill:#f5576c,color:#fff
    style W1 fill:#00ac69,color:#fff
    style W2 fill:#00ac69,color:#fff
    style W3 fill:#00ac69,color:#fff
    style D1 fill:#6900c7,color:#fff
    style D2 fill:#6900c7,color:#fff
```

---

## Why Lineage Matters

### Impact Analysis
**Question**: "If I change this source table, what breaks?"

Lineage shows all downstream dependencies:
- Which pipelines read from this table
- What analytics tables depend on it
- Which dashboards will be affected
- What ML models consume this data

### Root Cause Analysis
**Question**: "Why is this dashboard showing wrong data?"

Trace backwards through lineage:
- Which pipeline produced this data
- What source tables were used
- When did the data last refresh
- What transformations were applied

### Compliance and Auditing
**Question**: "Where does this customer PII flow?"

Track sensitive data movement:
- All systems that store customer data
- Transformations that process PII
- Who has access at each stage
- Retention and deletion compliance

### Data Discovery
**Question**: "What can I learn from this data?"

Explore relationships:
- Related datasets and metrics
- Similar transformations elsewhere
- Trusted data sources
- Expert owners and documentation

---

## Lineage Types

### 1. Table-Level Lineage

**Tracks relationships between entire tables/datasets**

```mermaid
graph LR
    A[orders<br/>PostgreSQL] -->|Pipeline| B[stg_orders<br/>Snowflake]
    B -->|dbt| C[fact_orders<br/>Snowflake]
    D[products<br/>PostgreSQL] -->|Pipeline| E[stg_products<br/>Snowflake]
    E -->|dbt| C
    C -->|Aggregation| F[daily_revenue<br/>Snowflake]

    style A fill:#0061f2,color:#fff
    style D fill:#0061f2,color:#fff
    style B fill:#4facfe,color:#fff
    style E fill:#4facfe,color:#fff
    style C fill:#00ac69,color:#fff
    style F fill:#00ac69,color:#fff
```

**Use Cases**:

- Understand pipeline dependencies
- Identify data freshness bottlenecks
- Plan schema changes and migrations
- Visualize data architecture

---

### 2. Column-Level Lineage

**Tracks how specific columns flow and transform**

```mermaid
graph LR
    A[orders.customer_id] -->|Copy| B[stg_orders.customer_id]
    C[orders.amount] -->|Copy| D[stg_orders.order_amount]

    B -->|Join Key| E[fact_orders.customer_key]
    D -->|Rename| F[fact_orders.revenue]

    E -->|Group By| G[daily_revenue.customer_id]
    F -->|SUM| H[daily_revenue.total_revenue]

    style A fill:#0061f2,color:#fff
    style C fill:#0061f2,color:#fff
    style B fill:#4facfe,color:#fff
    style D fill:#4facfe,color:#fff
    style E fill:#00ac69,color:#fff
    style F fill:#00ac69,color:#fff
    style G fill:#fa709a,color:#fff
    style H fill:#fa709a,color:#fff
```

**Use Cases**:

- Trace PII and sensitive data flows
- Debug incorrect column values
- Understand metric calculations
- Validate transformations

**Transformation Types**:

- **Identity**: Column copied unchanged
- **Derived**: Column transformed (UPPER, CONCAT, etc.)
- **Aggregate**: Column aggregated (SUM, COUNT, AVG)
- **Join**: Column used in join conditions

---

### 3. End-to-End Lineage

**Complete data journey from source to consumption**

```mermaid
graph TB
    subgraph "Source"
        S1[SalesForce API<br/>accounts]
    end

    subgraph "Ingestion"
        I1[Fivetran<br/>salesforce_sync]
    end

    subgraph "Staging"
        ST1[Snowflake<br/>raw.accounts]
    end

    subgraph "Transformation"
        T1[dbt<br/>stg_accounts]
        T2[dbt<br/>dim_customers]
    end

    subgraph "Metrics"
        M1[dbt<br/>customer_metrics]
    end

    subgraph "Consumption"
        C1[Tableau<br/>Sales Dashboard]
        C2[ML Model<br/>Churn Prediction]
    end

    S1 -->|Extract| I1
    I1 -->|Load| ST1
    ST1 -->|Clean| T1
    T1 -->|Enrich| T2
    T2 -->|Aggregate| M1
    M1 -->|Visualize| C1
    M1 -->|Train| C2

    style S1 fill:#0061f2,color:#fff
    style I1 fill:#667eea,color:#fff
    style ST1 fill:#4facfe,color:#fff
    style T1 fill:#f5576c,color:#fff
    style T2 fill:#f5576c,color:#fff
    style M1 fill:#00ac69,color:#fff
    style C1 fill:#6900c7,color:#fff
    style C2 fill:#fa709a,color:#fff
```

**Use Cases**:

- Understand complete data journey
- Identify bottlenecks and inefficiencies
- Plan optimization strategies
- Document data architecture for compliance

---

## PROV-O Foundation

OpenMetadata lineage is based on W3C PROV-O (Provenance Ontology), providing standardized semantics for data provenance.

### Core PROV-O Concepts

```mermaid
graph TB
    E1[Entity<br/>Data Asset] -->|wasGeneratedBy| A1[Activity<br/>Pipeline/Query]
    A1 -->|used| E2[Entity<br/>Source Data]

    A1 -->|wasAssociatedWith| AG1[Agent<br/>Pipeline Service]
    E1 -->|wasAttributedTo| AG2[Agent<br/>Owner]

    E1 -->|wasDerivedFrom| E2

    style E1 fill:#00ac69,color:#fff
    style E2 fill:#0061f2,color:#fff
    style A1 fill:#f5576c,color:#fff
    style AG1 fill:#667eea,color:#fff
    style AG2 fill:#667eea,color:#fff
```

**PROV-O Mapping**:

| PROV-O Concept | OpenMetadata Entity | Example |
|----------------|---------------------|---------|
| **Entity** | Tables, Columns, Datasets | `dim_customers` table |
| **Activity** | Pipelines, Queries, Jobs | `customer_etl` pipeline |
| **Agent** | Users, Services, Teams | `airflow-prod` service |
| **wasGeneratedBy** | Pipeline output | Table created by pipeline |
| **used** | Pipeline input | Pipeline reads from table |
| **wasDerivedFrom** | Direct lineage | Table derived from source |
| **wasAttributedTo** | Ownership | Table owned by Data Team |

---

## Real-World Example: E-Commerce Analytics

Complete lineage for customer analytics:

```mermaid
graph TB
    subgraph "Operational Systems"
        OP1[MySQL<br/>ecommerce.customers]
        OP2[MySQL<br/>ecommerce.orders]
        OP3[Stripe API<br/>payments]
    end

    subgraph "Ingestion Layer"
        P1[Fivetran<br/>mysql_sync]
        P2[Airbyte<br/>stripe_sync]
    end

    subgraph "Raw Data Warehouse"
        R1[Snowflake<br/>raw.customers]
        R2[Snowflake<br/>raw.orders]
        R3[Snowflake<br/>raw.payments]
    end

    subgraph "Staging Layer"
        S1[dbt<br/>stg_customers]
        S2[dbt<br/>stg_orders]
        S3[dbt<br/>stg_payments]
    end

    subgraph "Core Models"
        C1[dbt<br/>dim_customers]
        C2[dbt<br/>fact_orders]
    end

    subgraph "Metrics Layer"
        M1[dbt<br/>customer_lifetime_value]
        M2[dbt<br/>daily_revenue]
    end

    subgraph "Analytics"
        A1[Tableau<br/>Executive Dashboard]
        A2[Looker<br/>Sales Analytics]
        A3[Python Notebook<br/>Churn Analysis]
    end

    OP1 -->|Extract| P1
    OP2 -->|Extract| P1
    OP3 -->|Extract| P2

    P1 -->|Load| R1
    P1 -->|Load| R2
    P2 -->|Load| R3

    R1 -->|Transform| S1
    R2 -->|Transform| S2
    R3 -->|Transform| S3

    S1 -->|Enrich| C1
    S2 -->|Join| C2
    S3 -->|Join| C2
    C1 -->|Join| C2

    C1 -->|Aggregate| M1
    C2 -->|Aggregate| M1
    C2 -->|Aggregate| M2

    M1 -->|Visualize| A1
    M2 -->|Visualize| A1
    M2 -->|Visualize| A2
    M1 -->|Analyze| A3

    style OP1 fill:#0061f2,color:#fff
    style OP2 fill:#0061f2,color:#fff
    style OP3 fill:#0061f2,color:#fff
    style P1 fill:#667eea,color:#fff
    style P2 fill:#667eea,color:#fff
    style R1 fill:#4facfe,color:#fff
    style R2 fill:#4facfe,color:#fff
    style R3 fill:#4facfe,color:#fff
    style S1 fill:#f5576c,color:#fff
    style S2 fill:#f5576c,color:#fff
    style S3 fill:#f5576c,color:#fff
    style C1 fill:#00ac69,color:#fff
    style C2 fill:#00ac69,color:#fff
    style M1 fill:#fa709a,color:#fff
    style M2 fill:#fa709a,color:#fff
    style A1 fill:#6900c7,color:#fff
    style A2 fill:#6900c7,color:#fff
    style A3 fill:#6900c7,color:#fff
```

**Lineage Insights**:

1. **Source-to-Target Flow**:
   - Operational data → Ingestion → Raw → Staging → Core → Metrics → Analytics
   - 7-layer architecture with clear separation of concerns

2. **Impact Analysis**:
   - Change to `ecommerce.customers` affects:
     - 3 downstream pipelines
     - 4 analytics tables
     - 3 dashboards/reports

3. **Root Cause Debugging**:
   - If Executive Dashboard shows wrong CLV:
     - Trace back through `customer_lifetime_value` → `fact_orders` → `stg_orders` → `raw.orders`
     - Identify which pipeline or transformation introduced the issue

4. **Data Governance**:
   - PII in `customers.email` flows through lineage
   - Automatically tag all downstream uses
   - Ensure masking policies apply everywhere

---

## Column-Level Lineage Example

Detailed column transformations for revenue calculation:

```mermaid
graph TB
    subgraph "Source: MySQL orders"
        S1[order_id]
        S2[customer_id]
        S3[amount]
        S4[discount]
        S5[created_at]
    end

    subgraph "Transform: dbt stg_orders"
        T1[order_key]
        T2[customer_key]
        T3[gross_amount]
        T4[discount_amount]
        T5[net_amount]
        T6[order_date]
    end

    subgraph "Aggregate: dbt daily_revenue"
        A1[revenue_date]
        A2[total_gross]
        A3[total_discount]
        A4[total_net]
        A5[order_count]
    end

    S1 -->|CAST as INT| T1
    S2 -->|CAST as INT| T2
    S3 -->|No transform| T3
    S4 -->|No transform| T4
    S3 -->|amount - discount| T5
    S4 -->|amount - discount| T5
    S5 -->|DATE_TRUNC| T6

    T6 -->|GROUP BY| A1
    T3 -->|SUM| A2
    T4 -->|SUM| A3
    T5 -->|SUM| A4
    T1 -->|COUNT| A5

    style S1 fill:#0061f2,color:#fff
    style S2 fill:#0061f2,color:#fff
    style S3 fill:#0061f2,color:#fff
    style S4 fill:#0061f2,color:#fff
    style S5 fill:#0061f2,color:#fff
    style T1 fill:#f5576c,color:#fff
    style T2 fill:#f5576c,color:#fff
    style T3 fill:#f5576c,color:#fff
    style T4 fill:#f5576c,color:#fff
    style T5 fill:#f5576c,color:#fff
    style T6 fill:#f5576c,color:#fff
    style A1 fill:#00ac69,color:#fff
    style A2 fill:#00ac69,color:#fff
    style A3 fill:#00ac69,color:#fff
    style A4 fill:#00ac69,color:#fff
    style A5 fill:#00ac69,color:#fff
```

**Transformation Details**:

| Source Column | Transformation | Target Column | SQL Logic |
|---------------|----------------|---------------|-----------|
| `amount` | Identity | `gross_amount` | `amount` |
| `discount` | Identity | `discount_amount` | `discount` |
| `amount`, `discount` | Derived | `net_amount` | `amount - discount` |
| `created_at` | Derived | `order_date` | `DATE_TRUNC('day', created_at)` |
| `gross_amount` | Aggregate | `total_gross` | `SUM(gross_amount)` |
| `net_amount` | Aggregate | `total_net` | `SUM(net_amount)` |

---

## Lineage Capture Methods

OpenMetadata captures lineage from multiple sources:

### 1. SQL Parsing
**Automatic lineage from SQL queries**

```sql
-- SQL Query in dbt model
SELECT
    c.customer_id,
    c.email,
    COUNT(o.order_id) as order_count,
    SUM(o.amount) as total_spent
FROM raw.customers c
LEFT JOIN raw.orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.email
```

**Captured Lineage**:

- `raw.customers.customer_id` → `customer_metrics.customer_id` (identity)
- `raw.customers.email` → `customer_metrics.email` (identity)
- `raw.orders.order_id` → `customer_metrics.order_count` (aggregate)
- `raw.orders.amount` → `customer_metrics.total_spent` (aggregate)

### 2. API Integration
**Lineage from orchestration platforms**

```python
# Airflow DAG lineage
from openmetadata.api import OpenMetadata

client = OpenMetadata(...)

# Report lineage from pipeline task
client.add_lineage(
    source="mysql.ecommerce.customers",
    target="snowflake.analytics.dim_customers",
    pipeline="customer_etl",
    pipeline_service="airflow-prod"
)
```

### 3. Query Log Analysis
**Automatic lineage from database query logs**

OpenMetadata analyzes query logs from:
- Snowflake query history
- BigQuery audit logs
- Redshift system tables
- PostgreSQL pg_stat_statements

### 4. Metadata Extraction
**Lineage from transformation tools**

- **dbt**: Parses `manifest.json` for model dependencies
- **Databricks**: Reads notebook lineage
- **Spark**: Analyzes execution plans
- **Tableau**: Extracts data source relationships

---

## Lineage Use Cases

### Use Case 1: PII Compliance

**Scenario**: Track all uses of customer email addresses

```mermaid
graph LR
    S[customers.email<br/>PII.Sensitive]

    S --> T1[stg_customers.email<br/>PII.Sensitive]
    S --> T2[marketing.contacts<br/>PII.Sensitive]

    T1 --> A1[customer_360.email<br/>PII.Sensitive]
    T2 --> A2[campaign_targets.email<br/>PII.Sensitive]

    A1 --> D1[Customer Dashboard<br/>Masked]
    A2 --> D2[Email Campaign Tool<br/>Restricted Access]

    style S fill:#f5576c,color:#fff
    style T1 fill:#f5576c,color:#fff
    style T2 fill:#f5576c,color:#fff
    style A1 fill:#f5576c,color:#fff
    style A2 fill:#f5576c,color:#fff
```

**Benefits**:

- Automatically propagate PII tags through lineage
- Ensure masking policies apply to all downstream uses
- Generate compliance reports showing PII data flow
- Alert on unauthorized PII access

### Use Case 2: Schema Change Impact

**Scenario**: Plan to change `orders.amount` column from INT to DECIMAL

```mermaid
graph TB
    S[orders.amount<br/>Type: INT → DECIMAL]

    S --> P1[Pipeline: daily_etl<br/>⚠️ May break]
    S --> P2[Pipeline: revenue_calc<br/>⚠️ May break]

    P1 --> T1[stg_orders.amount<br/>⚠️ Update needed]
    P2 --> T2[fact_orders.revenue<br/>⚠️ Update needed]

    T1 --> D1[Sales Dashboard<br/>⚠️ Test required]
    T2 --> M1[Revenue ML Model<br/>⚠️ Retrain needed]

    style S fill:#f5576c,color:#fff
```

**Action Plan**:
1. Identify 2 affected pipelines
2. Update 2 downstream tables
3. Test 1 dashboard
4. Retrain 1 ML model

### Use Case 3: Root Cause Analysis

**Scenario**: Dashboard shows revenue dropped to zero

```mermaid
graph BT
    D[Revenue Dashboard<br/>Shows $0]

    D --> M[daily_revenue<br/>All rows NULL]
    M --> F[fact_orders<br/>Last update: 3 days ago]
    F --> P[etl_pipeline<br/>Status: FAILED]
    P --> S[orders table<br/>Connection timeout]

    style D fill:#f5576c,color:#fff
    style M fill:#f5576c,color:#fff
    style F fill:#f5576c,color:#fff
    style P fill:#f5576c,color:#fff
    style S fill:#f5576c,color:#fff
```

**Root Cause**:

- Dashboard → Metric table → Fact table → Pipeline → Source
- Pipeline failed 3 days ago due to connection timeout
- Fix connection and re-run pipeline

---

## Best Practices

### 1. Enable Automatic Lineage Capture
Use SQL parsing and query log analysis for automatic lineage instead of manual documentation.

### 2. Validate Lineage Accuracy
Regularly review lineage graphs to ensure they match actual data flows.

### 3. Tag Source Data
Apply governance tags (PII, Tier, Sensitivity) to source data; let lineage propagate them downstream.

### 4. Document Transformations
Add descriptions to pipeline tasks explaining what transformations occur.

### 5. Monitor Lineage Health
Alert when lineage shows stale data (source updated but downstream hasn't refreshed).

### 6. Use Column Lineage for Critical Data
Enable column-level lineage for PII, financial data, and key business metrics.

### 7. Plan Changes with Lineage
Before schema changes, use lineage to identify all impacted assets and plan updates.

---

## Next Steps

1. **Explore examples** - See [lineage examples](../examples/lineage/index.md)
2. **Learn PROV-O** - Understand [PROV-O ontology](../standards/prov-o.md)
3. **Integration guides** - [Enable lineage capture](../getting-started/lineage.md)
4. **API reference** - [Lineage API documentation](../reference/api/lineage.md)
