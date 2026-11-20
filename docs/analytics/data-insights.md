# Data Insights and KPIs

Enum fields for data insight charts, KPIs, and custom chart definitions.

## DataInsightChart

**Source schema:** `schemas/dataInsight/dataInsightChart.json`

## Enum fields

### definitions.chartParameterValues.properties.chartDataType

Data type of the parameter (int, date etc.).

**Allowed values:**

- `NUMBER`
- `INT`
- `FLOAT`
- `DOUBLE`
- `DECIMAL`
- `TIMESTAMP`
- `TIME`
- `DATE`
- `DATETIME`
- `ARRAY`
- `MAP`
- `SET`
- `STRING`
- `BOOLEAN`
- `PERCENTAGE`

### definitions.dataReportIndex

Index where data are stored

**Allowed values:**

- `entity_report_data_index`
- `web_analytic_entity_view_report_data_index`
- `web_analytic_user_activity_report_data_index`
- `raw_cost_analysis_report_data_index`
- `aggregated_cost_analysis_report_data_index`

## Kpi

**Source schema:** `schemas/dataInsight/kpi/kpi.json`

## Enum fields

This schema defines no enum properties.

## Basic

**Source schema:** `schemas/dataInsight/kpi/basic.json`

## Enum fields

### definitions.kpiTargetType

This enum defines the type of key Result

**Allowed values:**

- `NUMBER`
- `PERCENTAGE`

## ChartFunctions

**Source schema:** `schemas/dataInsight/custom/chartFunctions.json`

## Enum fields

### definitions.function

aggregation function for chart

**Allowed values:**

- `count`
- `sum`
- `avg`
- `min`
- `max`
- `unique`

## Data Asset Type

**Source schema:** `schemas/dataInsight/custom/dataAssetType.json`

## Enum fields

### (schema)

Entity type reachable under the `di-data-assets-*` wildcard, and the single source of truth for which entity types Data Insights covers. The first sixteen are ingested by DataInsightsApp into a datastream of their own and are keyed by `dataInsights/config.json`. The last two are supplied instead by a `dataInsightAliases` entry in `indexMapping.json`, which aliases the live entity search index into the wildcard, so Data Insights reads them without ever writing them; those two must never be added to the ingestion subset.

**Allowed values:**

- `table`
- `storedProcedure`
- `databaseSchema`
- `database`
- `chart`
- `dashboard`
- `dashboardDataModel`
- `pipeline`
- `topic`
- `container`
- `searchIndex`
- `mlmodel`
- `dataProduct`
- `glossaryTerm`
- `tag`
- `metric`
- `testCaseResult`
- `testCaseResolutionStatus`

## Chart

**Source schema:** `schemas/dataInsight/custom/dataInsightCustomChart.json`

## Enum fields

### properties.chartType

Type of chart, used for UI to render the chart

**Allowed values:**

- `LineChart`
- `AreaChart`
- `BarChart`
- `SummaryCard`

## DataInsightCustomChartResult

**Source schema:** `schemas/dataInsight/custom/dataInsightCustomChartResult.json`

## Enum fields

This schema defines no enum properties.

## DataInsightCustomChartResultList

**Source schema:** `schemas/dataInsight/custom/dataInsightCustomChartResultList.json`

## Enum fields

This schema defines no enum properties.

## formulaHolder

**Source schema:** `schemas/dataInsight/custom/formulaHolder.json`

## Enum fields

This schema defines no enum properties.

## LineChart

**Source schema:** `schemas/dataInsight/custom/lineChart.json`

## Enum fields

### properties.type

Type of the data insight chart.

**Default:** `LineChart`

**Allowed values:**

- `LineChart`

## SummaryCard

**Source schema:** `schemas/dataInsight/custom/summaryCard.json`

## Enum fields

### properties.type

Type of the data insight chart.

**Default:** `SummaryCard`

**Allowed values:**

- `SummaryCard`
