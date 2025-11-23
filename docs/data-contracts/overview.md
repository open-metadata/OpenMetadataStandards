
# Data Contracts

**Formal agreements ensuring data quality, schema stability, and SLA compliance**

Data Contracts in OpenMetadata establish formal agreements between data producers and consumers, defining expectations for schema, quality, freshness, and availability. Contracts enable proactive data governance by preventing breaking changes, ensuring quality standards, and guaranteeing SLAs for critical data assets.

---

## Overview

Data Contracts provide a framework for:

- **Schema Contracts**: Guarantees about data structure and types
- **Quality Contracts**: SLAs for data quality dimensions
- **Freshness Contracts**: Guarantees about data update frequency
- **Availability Contracts**: SLAs for data availability and uptime

```mermaid
graph TB
    subgraph "Data Producer"
        P1[Data Engineering Team]
        P2[customer_etl Pipeline]
    end

    subgraph "Data Contract"
        DC[Contract: dim_customers]

        DC --> SC[Schema Contract<br/>- 15 required columns<br/>- No breaking changes]
        DC --> QC[Quality Contract<br/>- 99% completeness<br/>- 100% uniqueness<br/>- Valid email format]
        DC --> FC[Freshness Contract<br/>- Updated daily by 6 AM<br/>- Max age: 24 hours]
        DC --> AC[Availability Contract<br/>- 99.9% uptime<br/>- < 1 sec query latency]
    end

    subgraph "Data Consumers"
        C1[Analytics Team<br/>Customer Dashboard]
        C2[ML Team<br/>Churn Model]
        C3[Marketing Team<br/>Campaign Targeting]
    end

    P1 --> P2
    P2 --> DC
    DC --> C1
    DC --> C2
    DC --> C3

    style P1 fill:#667eea,color:#fff
    style P2 fill:#f5576c,color:#fff
    style DC fill:#0061f2,color:#fff
    style SC fill:#00ac69,color:#fff
    style QC fill:#00ac69,color:#fff
    style FC fill:#00ac69,color:#fff
    style AC fill:#00ac69,color:#fff
    style C1 fill:#6900c7,color:#fff
    style C2 fill:#6900c7,color:#fff
    style C3 fill:#6900c7,color:#fff
```

---

## Why Data Contracts?

### Problem: Implicit Expectations

Without contracts, data consumers make assumptions:
- "This column will always have values"
- "Email addresses will be valid"
- "Data refreshes daily before 8 AM"
- "The schema won't change without notice"

**When these assumptions break, downstream systems fail.**

### Solution: Explicit Contracts

Data contracts make expectations explicit and enforceable:

```mermaid
graph LR
    subgraph "Without Contracts"
        NC1[Implicit Assumptions] --> NC2[Silent Failures] --> NC3[Production Incidents]
    end

    subgraph "With Contracts"
        WC1[Explicit Contract] --> WC2[Automated Validation] --> WC3[Proactive Alerts]
    end

    style NC1 fill:#f5576c,color:#fff
    style NC2 fill:#f5576c,color:#fff
    style NC3 fill:#f5576c,color:#fff
    style WC1 fill:#00ac69,color:#fff
    style WC2 fill:#00ac69,color:#fff
    style WC3 fill:#00ac69,color:#fff
```

**Benefits**:

- **Prevent Breaking Changes**: Schema changes require consumer approval
- **Guarantee Quality**: SLAs for completeness, accuracy, validity
- **Ensure Timeliness**: Freshness guarantees for time-sensitive use cases
- **Enforce Accountability**: Clear ownership and responsibilities
- **Enable Trust**: Consumers can rely on contracted data

---

## Contract Types

### 1. Schema Contracts

**Guarantees about data structure, types, and constraints**

```yaml
schemaContract:
  entity: dim_customers
  version: 2.1.0

  guarantees:
    - type: COLUMN_PRESENCE
      columns:
        - customer_id (required, primary key)
        - email (required, unique)
        - name (required)
        - created_at (required)
        - segment (optional)

    - type: DATA_TYPE_STABILITY
      columns:
        - customer_id: INTEGER (no changes allowed)
        - email: STRING (no changes allowed)
        - created_at: TIMESTAMP (no changes allowed)

    - type: NO_BREAKING_CHANGES
      policy: REQUIRE_APPROVAL
      approvers:
        - analytics-team
        - ml-team

    - type: BACKWARD_COMPATIBILITY
      rules:
        - New columns can be added
        - Optional columns can be removed
        - Required columns cannot be removed
        - Data types cannot change
```

**Schema Contract Checks**:

- ✅ Required columns exist
- ✅ Data types match specification
- ✅ Primary keys are unique and not null
- ✅ Foreign key relationships valid
- ✅ No breaking changes without approval

---

### 2. Quality Contracts

**SLAs for data quality dimensions**

```yaml
qualityContract:
  entity: dim_customers

  completeness:
    - column: customer_id
      threshold: 100%
      description: "Every row must have customer_id"

    - column: email
      threshold: 100%
      description: "Every row must have email"

    - column: name
      threshold: 95%
      description: "At least 95% of rows have name"

  uniqueness:
    - column: customer_id
      threshold: 100%
      description: "No duplicate customer_ids"

    - column: email
      threshold: 99%
      description: "Less than 1% duplicate emails"

  validity:
    - column: email
      rule: REGEX_MATCH
      pattern: "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
      threshold: 99%
      description: "Valid email format"

    - column: segment
      rule: IN_SET
      values: ["enterprise", "smb", "individual"]
      threshold: 100%
      description: "Valid segment values"

  accuracy:
    - column: created_at
      rule: DATE_RANGE
      min: "2020-01-01"
      max: "NOW()"
      threshold: 100%
      description: "Created date is realistic"

  consistency:
    - rule: REFERENTIAL_INTEGRITY
      foreign_key: customer_id
      references: fact_orders.customer_id
      threshold: 100%
      description: "All customer_ids in orders exist in dim_customers"
```

**Quality Contract Monitoring**:

- Daily automated test execution
- Alert on threshold violations
- Track quality trends over time
- Escalation for critical failures

---

### 3. Freshness Contracts

**Guarantees about data update frequency and recency**

```yaml
freshnessContract:
  entity: dim_customers

  updateSchedule:
    frequency: DAILY
    expectedTime: "06:00 UTC"
    window: "+/- 30 minutes"
    description: "Table refreshes daily at 6 AM UTC"

  maxAge:
    value: 24
    unit: HOURS
    description: "Data is never more than 24 hours old"

  partitionFreshness:
    - partition: created_date
      latestPartition: "TODAY - 1"
      description: "Yesterday's partition available by 6 AM"

  monitoring:
    checkInterval: HOURLY
    alertOnViolation: true
    alertChannels:
      - slack: "#data-alerts"
      - email: "data-eng-oncall@company.com"
```

**Freshness Monitoring**:
```mermaid
graph LR
    A[Pipeline Completes] --> B{Data Refreshed?}
    B -->|Yes| C[Update Last Refresh]
    B -->|No| D[Alert: Freshness Violation]

    C --> E{Within SLA?}
    E -->|Yes| F[Contract Met ✓]
    E -->|No| D

    style F fill:#00ac69,color:#fff
    style D fill:#f5576c,color:#fff
```

---

### 4. Availability Contracts

**SLAs for data availability and performance**

```yaml
availabilityContract:
  entity: dim_customers

  uptime:
    sla: 99.9%
    measurement: MONTHLY
    description: "Table available 99.9% of time"

  performance:
    - metric: QUERY_LATENCY
      percentile: p95
      threshold: 1.0
      unit: SECONDS
      description: "95% of queries return in < 1 second"

    - metric: SCAN_EFFICIENCY
      threshold: 10
      unit: PERCENT
      description: "Queries scan < 10% of table data"

  maintenanceWindows:
    - day: SUNDAY
      start: "02:00 UTC"
      end: "04:00 UTC"
      description: "Weekly maintenance window"

  disasterRecovery:
    rpo: 1
    rto: 2
    unit: HOURS
    description: "Max 1 hour data loss, 2 hour recovery time"
```

---

## Real-World Example: Customer Data Contract

Complete contract for a critical customer dimension table:

```mermaid
graph TB
    subgraph "Producer: Data Engineering"
        P1[MySQL customers table]
        P2[Airflow ETL Pipeline]
        P3[Snowflake dim_customers]
    end

    subgraph "Data Contract: dim_customers v2.1.0"
        DC[Contract Owner: Data Engineering]

        DC --> SC[Schema Contract]
        DC --> QC[Quality Contract]
        DC --> FC[Freshness Contract]
        DC --> AC[Availability Contract]

        SC --> SC1[15 required columns<br/>No breaking changes<br/>Backward compatible]

        QC --> QC1[100% customer_id completeness<br/>99% email validity<br/>100% segment in allowed values]

        FC --> FC1[Daily refresh by 6 AM<br/>Max age: 24 hours<br/>Alert on violation]

        AC --> AC1[99.9% uptime<br/>< 1 sec p95 latency<br/>Sunday 2-4 AM maintenance]
    end

    subgraph "Consumers"
        C1[Tableau<br/>Customer Dashboard<br/>Requires: Freshness]
        C2[Python<br/>Churn Model<br/>Requires: Schema Stability]
        C3[dbt<br/>Customer Metrics<br/>Requires: Quality]
    end

    P1 --> P2
    P2 --> P3
    P3 --> DC
    DC --> C1
    DC --> C2
    DC --> C3

    style P2 fill:#f5576c,color:#fff
    style P3 fill:#4facfe,color:#fff
    style DC fill:#0061f2,color:#fff
    style SC fill:#00ac69,color:#fff
    style QC fill:#00ac69,color:#fff
    style FC fill:#00ac69,color:#fff
    style AC fill:#00ac69,color:#fff
    style C1 fill:#6900c7,color:#fff
    style C2 fill:#6900c7,color:#fff
    style C3 fill:#6900c7,color:#fff
```

**Contract Implementation**:

1. **Schema Contract**:
   - Schema changes require approval from consumer teams
   - New columns can be added (backward compatible)
   - Existing columns cannot be removed or changed

2. **Quality Contract**:
   - 100% completeness for `customer_id`, `email`
   - 99% valid email formats
   - 100% segments must be in ["enterprise", "smb", "individual"]
   - Daily automated quality tests

3. **Freshness Contract**:
   - Data refreshes daily at 6 AM UTC
   - Maximum age: 24 hours
   - Alert if refresh is late or fails

4. **Availability Contract**:
   - 99.9% uptime (< 45 minutes downtime/month)
   - Query latency < 1 second (p95)
   - Scheduled maintenance: Sunday 2-4 AM UTC

---

## Contract Lifecycle

```mermaid
stateDiagram-v2
    [*] --> Draft: Create Contract
    Draft --> Review: Submit for Review
    Review --> Draft: Request Changes
    Review --> Active: Approve
    Active --> Modified: Propose Change
    Modified --> Review: Consumer Approval
    Active --> Deprecated: Mark Deprecated
    Deprecated --> Retired: Sunset Period Complete
    Retired --> [*]

    Active --> Violated: Quality Check Fails
    Violated --> Active: Issue Resolved
    Violated --> Suspended: Multiple Violations
    Suspended --> Active: Remediation Complete
```

**Lifecycle Stages**:

1. **Draft**: Contract being defined by producer
2. **Review**: Consumers review and provide feedback
3. **Active**: Contract in effect, monitored automatically
4. **Modified**: Proposed changes pending approval
5. **Violated**: Contract terms not met, alerts triggered
6. **Suspended**: Critical violations, consumers warned
7. **Deprecated**: Contract scheduled for retirement
8. **Retired**: Contract no longer in effect

---

## Contract Enforcement

### Automated Monitoring

```mermaid
graph TB
    subgraph "Contract Validation"
        V1[Schema Validator] --> V1A{Schema Valid?}
        V2[Quality Tests] --> V2A{Quality Met?}
        V3[Freshness Check] --> V3A{Data Fresh?}
        V4[Performance Monitor] --> V4A{SLA Met?}
    end

    V1A -->|No| E1[Block Pipeline]
    V2A -->|No| E2[Alert + Continue]
    V3A -->|No| E3[Alert Consumers]
    V4A -->|No| E4[Escalate to Eng]

    V1A -->|Yes| S[Contract Satisfied]
    V2A -->|Yes| S
    V3A -->|Yes| S
    V4A -->|Yes| S

    style E1 fill:#f5576c,color:#fff
    style E2 fill:#f5576c,color:#fff
    style E3 fill:#f5576c,color:#fff
    style E4 fill:#f5576c,color:#fff
    style S fill:#00ac69,color:#fff
```

**Enforcement Levels**:

| Violation Type | Enforcement | Impact |
|----------------|-------------|---------|
| **Schema Breaking Change** | BLOCK | Pipeline cannot proceed |
| **Quality Failure (Critical)** | ALERT + BLOCK | Alert sent, pipeline blocked |
| **Quality Failure (Warning)** | ALERT + CONTINUE | Alert sent, pipeline continues |
| **Freshness Violation** | ALERT | Notify consumers of stale data |
| **Availability Violation** | ESCALATE | Page on-call engineer |

---

## Contract Examples by Asset Type

### Tables

```yaml
contract:
  type: TABLE
  entity: dim_customers

  schema:
    columns:
      - customer_id: INTEGER NOT NULL PRIMARY KEY
      - email: STRING NOT NULL
      - name: STRING
    changePolicy: REQUIRE_APPROVAL

  quality:
    completeness: 100% on customer_id, email
    uniqueness: 100% on customer_id

  freshness:
    schedule: DAILY at 06:00 UTC
    maxAge: 24 HOURS
```

### Topics (Streaming)

```yaml
contract:
  type: TOPIC
  entity: customer_events

  schema:
    format: AVRO
    registry: confluent
    changePolicy: BACKWARD_COMPATIBLE

  quality:
    completeness: 99% on event_id, customer_id, timestamp
    lateness: < 5 MINUTES p99

  freshness:
    frequency: REAL_TIME
    maxLag: 1 MINUTE

  throughput:
    expected: 1000 messages/second
    peak: 5000 messages/second
```

### APIs

```yaml
contract:
  type: API
  entity: customer_api

  schema:
    openapi: 3.0
    version: 2.1.0
    changePolicy: VERSIONED

  availability:
    uptime: 99.99%
    latency_p95: 100 MILLISECONDS
    latency_p99: 500 MILLISECONDS

  rateLimit:
    requests: 1000 per MINUTE
    burst: 2000
```

### Dashboards

```yaml
contract:
  type: DASHBOARD
  entity: customer_executive_dashboard

  freshness:
    dataAge: < 1 HOUR
    refreshSchedule: HOURLY

  availability:
    uptime: 99.9%
    loadTime: < 3 SECONDS

  accuracy:
    dataReconciliation: WEEKLY
    sourceOfTruth: dim_customers, fact_orders
```

---

## Benefits of Data Contracts

### For Producers

- **Clear Expectations**: Know exactly what consumers need
- **Controlled Changes**: Plan breaking changes with consumer approval
- **Quality Metrics**: Track contract compliance over time
- **Reduced Support**: Fewer consumer complaints about data issues

### For Consumers

- **Guaranteed Quality**: SLAs for completeness, accuracy, freshness
- **Schema Stability**: No surprise breaking changes
- **Trust**: Confidence in data reliability
- **Proactive Alerts**: Know immediately when contract violated

### For Organizations

- **Data Reliability**: Higher quality data across the organization
- **Faster Development**: Consumers trust data, build faster
- **Better Collaboration**: Clear producer-consumer agreements
- **Reduced Incidents**: Prevent issues before they reach production

---

## Best Practices

### 1. Start with Critical Assets
Implement contracts for tier-1 tables first (those powering critical dashboards and reports).

### 2. Involve Consumers in Contract Definition
Consumer input ensures contracts address actual needs.

### 3. Set Realistic Thresholds
Don't aim for 100% on everything - balance quality with operational reality.

### 4. Monitor and Iterate
Review contract violations regularly and adjust thresholds as needed.

### 5. Automate Enforcement
Use automated testing and CI/CD checks to enforce contracts.

### 6. Version Contracts
Maintain contract versions and migration plans for breaking changes.

### 7. Document Business Context
Explain why each contract term matters and what happens if violated.

### 8. Establish Ownership
Assign clear ownership for contract maintenance and violation resolution.

---

## Getting Started

### Step 1: Identify Critical Assets
List your most important tables, topics, and APIs that need contracts.

### Step 2: Define Initial Contract
Start simple with schema and basic quality checks.

```yaml
contract:
  entity: dim_customers
  schema:
    required_columns: [customer_id, email, name]
  quality:
    completeness: 99% on customer_id, email
  freshness:
    schedule: DAILY
```

### Step 3: Implement Validation
Add automated tests to validate contract terms.

### Step 4: Monitor and Alert
Set up alerting for contract violations.

### Step 5: Iterate and Expand
Add more contract terms as you learn what matters most.

---

## Next Steps

1. **Explore examples** - See [contract examples](../examples/data-contracts/index.md)
2. **Implementation guide** - Learn [how to create contracts](../getting-started/data-contracts.md)
3. **API reference** - Review [contract API documentation](../reference/api/contracts.md)
4. **Best practices** - Read [contract design patterns](../developer/contract-patterns.md)
