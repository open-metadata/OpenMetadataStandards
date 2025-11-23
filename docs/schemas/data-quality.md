
# Data Quality

Comprehensive data quality framework for testing, profiling, and monitoring data assets.

## Overview

OpenMetadata provides a robust data quality framework that enables you to:

- **Define reusable test definitions** across multiple platforms
- **Create and run test cases** against tables, columns, and other data assets
- **Organize tests** into test suites for systematic execution
- **Track test results** and maintain quality history
- **Profile data** to understand distributions and patterns
- **Monitor quality metrics** and set up alerts

The framework supports multiple testing platforms including **OpenMetadata native tests**, **Great Expectations**, **dbt tests**, **Deequ**, and **Soda**.

---

## Core Entities

### Test Definitions

**Schema**: [`schemas/tests/testDefinition.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/tests/testDefinition.json)

Test Definitions are reusable templates that define the logic and parameters for data quality tests.

**Properties**:

- **Name and Description**: Identifies the test type
- **Entity Type**: What the test applies to
  - `TABLE` - Tests against entire tables
  - `COLUMN` - Tests against specific columns
- **Test Platform**: Where the test executes
  - OpenMetadata (native)
  - Great Expectations
  - dbt
  - Deequ
  - Soda
  - Other
- **Parameter Definitions**: Configurable parameters for the test
  - Parameter name and display name
  - Data type (NUMBER, STRING, BOOLEAN, DATE, etc.)
  - Required vs optional
  - Option values (for enum-like parameters)
  - Default values

**Built-in Test Definitions**:

**Table-Level Tests**:

- `tableRowCountToBeBetween` - Verify row count is within range
- `tableColumnCountToBeBetween` - Verify column count is within range
- `tableColumnNameToExist` - Verify specific columns exist
- `tableColumnToMatchSet` - Verify columns match expected set
- `tableCustomSQLQuery` - Run custom SQL assertions
- `tableRowInsertedCountToBeBetween` - Monitor data freshness

**Column-Level Tests**:

- `columnValuesToBeBetween` - Range checks for numeric columns
- `columnValuesToBeNotNull` - Null value checks
- `columnValuesToBeUnique` - Uniqueness constraints
- `columnValuesToMatchRegex` - Pattern matching
- `columnValuesToBeInSet` - Enum validation
- `columnValueLengthsToBeBetween` - String length validation
- `columnValueMaxToBeLessThanOrEqual` - Max value checks
- `columnValueMinToBeGreaterThanOrEqual` - Min value checks
- `columnValueMeanToBeBetween` - Statistical checks
- `columnValueStdDevToBeBetween` - Distribution checks
- `columnValuesSumToBeBetween` - Aggregate checks

**Example Test Definition**:

```json
{
  "name": "columnValuesToBeBetween",
  "displayName": "Column Values To Be Between",
  "description": "Ensure column values are within a specified range",
  "entityType": "COLUMN",
  "testPlatforms": ["OpenMetadata"],
  "parameterDefinition": [
    {
      "name": "minValue",
      "displayName": "Minimum Value",
      "dataType": "NUMBER",
      "description": "Lower bound for column values",
      "required": false
    },
    {
      "name": "maxValue",
      "displayName": "Maximum Value",
      "dataType": "NUMBER",
      "description": "Upper bound for column values",
      "required": false
    }
  ]
}
```

---

### Test Cases

**Schema**: [`schemas/tests/testCase.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/tests/testCase.json)

Test Cases are specific instances of test definitions applied to data assets with concrete parameter values.

**Properties**:

- **Identity**:
  - Name and display name
  - Fully qualified name
  - Description

- **Test Configuration**:
  - **Test Definition**: Reference to the test definition being used
  - **Entity Link**: Link to the entity being tested (table or column)
  - **Parameter Values**: Concrete values for test parameters

- **Test Organization**:
  - **Test Suite**: Primary test suite this case belongs to
  - **Test Suites**: All test suites (basic and logical) containing this test

- **Results and Status**:
  - **Test Case Result**: Latest execution result
    - Success/failure status
    - Actual values observed
    - Timestamp of execution
    - Result details
  - **Test Case Status**: Overall status
    - `Success` - Test passed
    - `Failed` - Test failed
    - `Aborted` - Execution aborted
    - `Queued` - Waiting to run

- **Ownership**: Owners responsible for the test
- **Versioning**: Change tracking and audit trail

**Example Test Case**:

```json
{
  "name": "customer_email_format_check",
  "displayName": "Customer Email Format Validation",
  "description": "Validates that customer email addresses match expected format",
  "testDefinition": {
    "id": "test-def-uuid",
    "type": "testDefinition",
    "name": "columnValuesToMatchRegex"
  },
  "entityLink": "<#E::table::customer_db.public.customers::columns::email>",
  "entityFQN": "postgres.customer_db.public.customers.email",
  "testSuite": {
    "id": "suite-uuid",
    "type": "testSuite",
    "name": "customers_test_suite"
  },
  "parameterValues": [
    {
      "name": "regex",
      "value": "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
    }
  ],
  "testCaseResult": {
    "timestamp": 1704240000000,
    "testCaseStatus": "Success",
    "result": "100% of values match the regex pattern",
    "passedRows": 10000,
    "failedRows": 0
  }
}
```

**How Test Cases Attach to Data Assets**:

Test cases connect to data assets through the `entityLink` and `entityFQN` properties:

- **Table Tests**: `entityLink: "<#E::table::database.schema.table_name>"`
- **Column Tests**: `entityLink: "<#E::table::database.schema.table_name::columns::column_name>"`

When viewing a Table entity, all associated test cases are displayed, providing immediate visibility into data quality status.

---

### Test Suites

**Schema**: [`schemas/tests/testSuite.json`](https://github.com/open-metadata/OpenMetadataStandards/blob/main/schemas/tests/testSuite.json)

Test Suites group related test cases for organized execution and monitoring.

**Properties**:

- **Identity**: Name, display name, description
- **Test Cases**: List of tests in this suite
- **Pipeline References**: Ingestion pipelines that execute the tests
- **Execution Summary**:
  - Total tests
  - Passed/failed/aborted counts
  - Success rate
  - Last execution time

**Test Suite Types**:

1. **Executable Test Suites**:
   - Contain tests that run on a schedule
   - Attached to specific data assets
   - Created during test case creation

2. **Logical Test Suites**:
   - Organizational groupings of existing tests
   - Filter and group tests across multiple assets
   - Created manually for reporting

**Example Test Suite**:

```json
{
  "name": "customer_data_quality_suite",
  "displayName": "Customer Data Quality Suite",
  "description": "Comprehensive quality checks for customer data",
  "tests": [
    {
      "id": "test-1-uuid",
      "type": "testCase",
      "name": "customer_email_format_check"
    },
    {
      "id": "test-2-uuid",
      "type": "testCase",
      "name": "customer_id_uniqueness_check"
    },
    {
      "id": "test-3-uuid",
      "type": "testCase",
      "name": "customer_created_date_range_check"
    }
  ],
  "summary": {
    "total": 3,
    "success": 2,
    "failed": 1,
    "aborted": 0,
    "successRate": 66.67
  }
}
```

---

## Data Profiling

Data profiling automatically analyzes data assets to understand their characteristics.

**Table Profiling**:

- Row count and size
- Column count
- Creation and modification timestamps
- Sample data preview

**Column Profiling**:

For each column, OpenMetadata captures:

- **Basic Statistics**:
  - Null count and percentage
  - Distinct count and percentage
  - Unique count
  - Duplicate count

- **Numeric Columns**:
  - Min, max, mean, median
  - Standard deviation
  - First quartile, third quartile
  - Inter-quartile range
  - Non-parametric skew

- **String Columns**:
  - Min/max/mean length
  - Distinct count
  - Most common values (histogram)

- **Date/Time Columns**:
  - Min/max dates
  - Date range
  - Most common dates

**Profile Integration**:

Profiles are displayed alongside:
- Test case results
- Schema information
- Lineage and usage

This provides comprehensive context for understanding data quality.

---

## Test Execution Workflow

### 1. Define Tests

Create test definitions (or use built-in ones):

```json
{
  "testDefinition": "columnValuesToBeNotNull",
  "entityLink": "<#E::table::db.schema.orders::columns::customer_id>",
  "parameterValues": []
}
```

### 2. Organize into Suites

Group related tests:

```json
{
  "testSuite": "orders_data_quality",
  "tests": [
    "customer_id_not_null",
    "order_date_not_null",
    "order_total_positive"
  ]
}
```

### 3. Schedule Execution

Configure ingestion pipeline:

```yaml
testSuite:
  name: orders_data_quality
  schedule:
    type: cron
    expression: "0 */6 * * *"  # Every 6 hours
```

### 4. Monitor Results

View test results:
- Success/failure trends over time
- Failed test details
- Impact on downstream assets
- Alerts for critical failures

---

## Quality Metrics and KPIs

Track data quality over time with metrics:

**Coverage Metrics**:

- Percentage of tables with tests
- Percentage of critical columns tested
- Test case count per asset

**Quality Metrics**:

- Overall test success rate
- Tests passed/failed/aborted
- Mean time to detect issues
- Mean time to resolution

**Trend Analysis**:

- Quality score trends
- Test failure patterns
- Seasonal variations
- Improvement trajectories

---

## Integration with Data Assets

### Tables

Tests attach directly to table entities:

```markdown
# Table: customers

## Quality Status: 🟢 Passing (12/12 tests)

### Test Results:
- ✅ Row count between 1000-50000
- ✅ All email addresses valid format
- ✅ Customer IDs unique
- ✅ No null values in required fields
```

### Columns

Column-level tests provide fine-grained quality:

```markdown
# Column: customer_email

## Tests:
- ✅ Values match email regex pattern (100% passing)
- ✅ No null values (0% null)
- ✅ All values unique (100% unique)
```

### Dashboards and ML Models

Quality tests on source data impact downstream assets:

```
Table: customers (2 tests failing)
  ↓ lineage
Dashboard: Customer Analytics
  ⚠️ Warning: Upstream data quality issues

ML Model: Churn Predictor
  ⚠️ Warning: Training data quality degraded
```

---

## Test Platforms Integration

### Native OpenMetadata Tests

Built-in tests that execute within OpenMetadata:

- No external dependencies
- Optimized for performance
- Integrated with profiler
- Real-time results

### Great Expectations

Import and run Great Expectations suites:

```json
{
  "testPlatform": "GreatExpectations",
  "config": {
    "dataAsset": "customers",
    "expectationSuite": "customer_suite_v1"
  }
}
```

### dbt Tests

Integrate dbt test results:

```json
{
  "testPlatform": "dbt",
  "sourceConfig": {
    "manifestPath": "target/manifest.json",
    "runResultsPath": "target/run_results.json"
  }
}
```

### Deequ (AWS)

Run Deequ quality checks on Spark datasets:

```json
{
  "testPlatform": "Deequ",
  "sparkConfig": {
    "master": "spark://cluster:7077"
  }
}
```

### Soda

Execute Soda scan tests:

```json
{
  "testPlatform": "Soda",
  "checks": [
    "row_count > 1000",
    "missing_count(email) = 0"
  ]
}
```

---

## Best Practices

### Test Design

1. **Start with Critical Data**: Test the most important tables and columns first
2. **Layer Tests**: Combine table-level and column-level tests
3. **Use Thresholds Wisely**: Set realistic bounds based on profiling data
4. **Test Business Rules**: Encode domain knowledge as tests

### Test Organization

1. **Group by Domain**: Create suites per business domain
2. **Separate Criticality**: Different suites for critical vs nice-to-have
3. **Match Schedules**: High-frequency tests for real-time data, lower for batch

### Monitoring

1. **Set Up Alerts**: Notify owners when critical tests fail
2. **Track Trends**: Monitor quality scores over time
3. **Review Regularly**: Adjust thresholds as data evolves
4. **Document Failures**: Record root causes and fixes

---

## API Examples

### Create Test Case

```json
POST /api/v1/dataQuality/testCases

{
  "name": "order_total_positive",
  "testDefinition": "columnValueMinToBeGreaterThanOrEqual",
  "entityLink": "<#E::table::db.schema.orders::columns::total>",
  "parameterValues": [
    {"name": "minValue", "value": "0"}
  ],
  "testSuite": {
    "id": "suite-uuid",
    "type": "testSuite"
  }
}
```

### Run Test Suite

```json
POST /api/v1/dataQuality/testSuites/{id}/execute

{
  "testCases": ["all"]
}
```

### Get Test Results

```json
GET /api/v1/dataQuality/testCases/{id}/testCaseResult

Response:
{
  "timestamp": 1704240000000,
  "testCaseStatus": "Success",
  "result": "All values >= 0",
  "passedRows": 5000,
  "failedRows": 0
}
```

---

## Related Documentation

- **[Data Assets](entity/data-assets.md)** - Assets that tests apply to
- **[Governance](governance.md)** - Classifications and policies
- **[Use Cases](../getting-started/use-cases.md)** - Data quality use cases
- **[Lineage](../rdf/provenance/lineage.md)** - Quality impact tracking
