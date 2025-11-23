
# Dashboard Assets

**Business intelligence and data visualization**

Dashboard assets represent business intelligence reports, visualizations, and analytics that help users understand and explore data. OpenMetadata models dashboards with a three-level hierarchy for BI platforms.

---

## Hierarchy Overview

```mermaid
graph TD
    A[DashboardService<br/>Tableau, Looker, PowerBI] --> B1[Dashboard:<br/>Sales Performance]
    A --> B2[Dashboard:<br/>Customer Analytics]

    B1 --> C1[Chart:<br/>Revenue Trend]
    B1 --> C2[Chart:<br/>Regional Sales Map]
    B1 --> C3[Chart:<br/>Top Products]

    B2 --> C4[Chart:<br/>Customer Cohorts]
    B2 --> C5[Chart:<br/>Retention Rate]
    B2 --> C6[Chart:<br/>LTV Distribution]

    C1 -.->|queries| D1[Snowflake<br/>fact_orders]
    C2 -.->|queries| D2[Snowflake<br/>dim_geography]
    C4 -.->|queries| D3[Snowflake<br/>dim_customers]
    C5 -.->|queries| D4[Snowflake<br/>customer_metrics]

    B1 -.->|owned by| E1[Sales Team]
    B2 -.->|owned by| E2[Analytics Team]

    style A fill:#667eea,color:#fff
    style B1 fill:#f5576c,color:#fff
    style B2 fill:#f5576c,color:#fff
    style C1 fill:#fa709a,color:#fff
    style C2 fill:#fa709a,color:#fff
    style C3 fill:#fa709a,color:#fff
    style C4 fill:#fa709a,color:#fff
    style C5 fill:#fa709a,color:#fff
    style C6 fill:#fa709a,color:#fff
    style D1 fill:#4facfe,color:#fff
    style D2 fill:#4facfe,color:#fff
    style D3 fill:#4facfe,color:#fff
    style D4 fill:#4facfe,color:#fff
    style E1 fill:#00f2fe,color:#fff
    style E2 fill:#00f2fe,color:#fff
```

---

## Why This Hierarchy?

### Dashboard Service
**Purpose**: Represents the BI or analytics platform

A Dashboard Service is the platform that hosts dashboards and visualizations. It contains configuration for connecting to the BI tool and discovering reports.

**Examples**:

- `tableau-prod` - Production Tableau Server
- `looker-analytics` - Looker instance
- `powerbi-sales` - Power BI workspace
- `superset-internal` - Apache Superset for internal analytics

**Why needed**: Organizations use multiple BI platforms for different teams and use cases (Tableau for executive dashboards, Looker for self-service analytics, Superset for engineering). The service level organizes dashboards by platform.

**Supported Platforms**: Tableau, Looker, Power BI, Apache Superset, Metabase, Mode, Redash, QuickSight, Sisense, Google Data Studio

[**View Dashboard Service Specification →**](dashboard-service.md){ .md-button }

---

### Dashboard
**Purpose**: Represents a complete BI report or dashboard

A Dashboard is a collection of charts and visualizations that tell a story about the data. It has owners, tags, lineage to source tables, and contains multiple charts.

**Examples**:

- `Sales Performance Dashboard` - Executive sales metrics
- `Customer Analytics` - Customer behavior and segmentation
- `Operations KPIs` - Operational metrics and health
- `Marketing Attribution` - Marketing channel effectiveness

**Key Metadata**:

- **Charts**: Individual visualizations within the dashboard
- **Data Sources**: Tables and queries used
- **Lineage**: Source tables → Dashboard
- **Owners**: Team or users responsible
- **Tags**: Department, sensitivity, business domain
- **URL**: Link to live dashboard
- **Refresh Schedule**: How often data updates

**Why needed**: Dashboards are the consumption layer of analytics. Tracking them enables:
- Understanding which data powers which business decisions
- Impact analysis (which dashboards break if table changes?)
- Governance (who has access to sensitive dashboards?)
- Discoverability (find relevant dashboards for your team)

[**View Dashboard Specification →**](dashboard.md){ .md-button }

---

### Chart
**Purpose**: Individual visualization within a dashboard

A Chart is a single visualization - bar chart, line chart, pie chart, table, etc. Charts have queries, data sources, and visual configurations.

**Examples**:

- `Monthly Revenue Trend` - Line chart of revenue over time
- `Top 10 Products` - Bar chart of product sales
- `Customer Segmentation` - Pie chart of customer types
- `Orders Table` - Tabular view of recent orders

**Chart Types**:

- **Bar/Column**: Compare categories
- **Line**: Show trends over time
- **Pie/Donut**: Show composition
- **Table**: Display raw data
- **Map**: Geographic visualization
- **Scatter**: Show correlations
- **Heatmap**: Show intensity across dimensions

**Why needed**: Charts provide granular lineage. You can see exactly which columns from which tables feed each visualization, enabling precise impact analysis.

[**View Chart Specification →**](chart.md){ .md-button }

---

## Common Patterns

### Pattern 1: Tableau Executive Dashboard
```
Tableau Service → Sales Performance Dashboard → Revenue Trend Chart
                                              → Regional Sales Map
                                              → Top Products Table
```

Executive dashboard with multiple visualizations from a single data source.

### Pattern 2: Looker Self-Service Analytics
```
Looker Service → Customer Analytics Dashboard → Customer Cohorts Chart
                                               → Retention Rate Chart
                                               → LTV Distribution Chart
```

Self-service dashboard with drill-down capabilities.

### Pattern 3: Power BI Operational KPIs
```
Power BI Service → Operations Dashboard → Real-Time Orders Chart
                                        → Inventory Levels Chart
                                        → Fulfillment Rate Chart
```

Real-time operational dashboard with live data connections.

---

## Real-World Example

Here's how a sales team uses dashboards to track performance:

```mermaid
graph LR
    A[Snowflake<br/>fact_orders] --> D1[Tableau<br/>Sales Dashboard]
    B[Snowflake<br/>dim_customers] --> D1
    C[Snowflake<br/>dim_products] --> D1

    D1 --> E1[Revenue Trend<br/>Chart]
    D1 --> E2[Regional Sales<br/>Chart]
    D1 --> E3[Top Products<br/>Chart]

    D1 -.->|Owner| F[Sales Team]
    D1 -.->|Tags| G[Sales, Executive]
    D1 -.->|Refresh| H[Every 1 hour]

    style A fill:#0061f2,color:#fff
    style B fill:#0061f2,color:#fff
    style C fill:#0061f2,color:#fff
    style D1 fill:#f5576c,color:#fff
    style E1 fill:#fa709a,color:#fff
    style E2 fill:#fa709a,color:#fff
    style E3 fill:#fa709a,color:#fff
```

**Flow**:
1. **Data Sources**: Three Snowflake tables (fact and dimension tables)
2. **Dashboard**: Tableau Sales Dashboard combining all three sources
3. **Charts**:
   - Revenue trend over time (from fact_orders)
   - Regional breakdown (from fact_orders + dim_customers)
   - Top products (from fact_orders + dim_products)
4. **Metadata**: Owned by Sales Team, tagged for executives, refreshes hourly

**Benefits**:

- **Lineage**: See which tables power which charts
- **Impact Analysis**: Know which dashboards break if fact_orders schema changes
- **Ownership**: Know who to contact for dashboard questions
- **Discoverability**: Sales team can find all sales-related dashboards

---

## Dashboard Lineage

Dashboards create lineage from data tables to business insights:

```mermaid
graph LR
    A[MySQL orders] --> P1[ETL Pipeline]
    P1 --> B[Snowflake fact_orders]

    B --> D1[Sales Dashboard]
    B --> D2[Executive Dashboard]
    C[Snowflake dim_products] --> D1
    C --> D2

    D1 --> R1[Revenue Chart]
    D1 --> R2[Products Chart]

    style P1 fill:#f5576c,color:#fff
    style D1 fill:#6900c7,color:#fff
    style D2 fill:#6900c7,color:#fff
    style R1 fill:#fa709a,color:#fff
    style R2 fill:#fa709a,color:#fff
```

**Column-Level Lineage**: Track which specific columns are used in which charts (e.g., `orders.total_amount` → Revenue Chart Y-axis).

---

## Dashboard Data Models

Some BI tools have intermediate data models:

### Looker LookML Models
```
Looker Service → E-commerce Model → Orders View
                                  → Customers View
               → Sales Dashboard → Uses Orders View & Customers View
```

Looker's semantic layer (LookML) defines reusable data models.

### Power BI Datasets
```
Power BI Service → Sales Dataset → fact_sales Table
                                 → dim_date Table
                 → Sales Dashboard → Uses Sales Dataset
```

Power BI datasets are reusable data models shared across dashboards.

---

## Embedded Analytics

Track dashboards embedded in applications:

```
Tableau Service → Customer Portal Dashboard → Embedded in: app.company.com/portal
                                             → Public Access: Yes
                                             → Row-Level Security: customer_id
```

Embedded dashboards require special security and access controls.

---

## Entity Specifications

| Entity | Description | Specification |
|--------|-------------|---------------|
| **Dashboard Service** | BI platform | [View Spec](dashboard-service.md) |
| **Dashboard** | Report or dashboard | [View Spec](dashboard.md) |
| **Chart** | Individual visualization | [View Spec](chart.md) |

Each specification includes:
- Complete field reference
- JSON Schema definition
- RDF/OWL ontology representation
- JSON-LD context and examples
- Platform-specific integrations

---

## Supported BI Platforms

OpenMetadata supports metadata extraction from:

- **Tableau** - Enterprise BI and visualization
- **Looker** - Modern BI with semantic modeling
- **Power BI** - Microsoft's BI platform
- **Apache Superset** - Open-source data exploration
- **Metabase** - Simple BI for everyone
- **Mode** - Collaborative analytics
- **Redash** - SQL-based dashboards
- **Amazon QuickSight** - Cloud-native BI
- **Google Data Studio** - Free BI from Google
- **Sisense** - Embedded analytics platform
- **Qlik** - Associative analytics
- **MicroStrategy** - Enterprise analytics

---

## Next Steps

1. **Explore specifications** - Click through each entity above
2. **See lineage examples** - Check out [lineage from tables to dashboards](../../lineage/overview.md)
3. **BI integration** - Learn how to connect your BI platform
