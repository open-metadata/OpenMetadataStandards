---
title: Data Quality & Observability Changes (1.13 → 2.0)
description: Test case incident inlining, incident auto-close, multi-status filters, batch DQ reporting and the removed Data Insights data quality module in OpenMetadata 2.0.
---

# Data Quality & Observability

**Test cases, incidents, and the reporting surface all change shape in 2.0.**

---

## Incidents move onto the Task entity

:material-close-octagon:{ .om-breaking } **Breaking** · Affects: incident automation, feed-based
incident integrations

Incident tasks were thread-based in 1.13. In 2.0 they are Tasks:

| | 1.13 | 2.0 |
|---|------|-----|
| Storage | `thread_entity` (`type=Task`, `taskType=RequestTestCaseFailureResolution`) | `task_entity` |
| Task type | thread `TaskType` | `TestCaseResolution` / `IncidentResolution` |
| Category | — | `Incident` |
| Payload | untyped `taskDetails` | `testCaseResolutionPayload` / `incidentResolutionPayload` |
| Resolve | `PUT /v1/feed/tasks/{id}/resolve` | `POST /v1/tasks/{id}/resolve` |

`TestCaseResolutionStatus` (TCRS) records are unchanged — the resolution *status* time series still
drives incident state. What changed is the **task** that hangs off it.

!!! note "Legacy feed path still accepts test-case-failure-resolution tasks"
    `POST /v1/feed` still allows `isTestCaseFailureResolutionTask` types, so existing integrations
    keep working. New work should target `/v1/tasks`.

The 2.0.0 migration also runs `runRecognizerFeedbackTaskTypeMigration()` to correct the recognizer
feedback task type, and `addTaskResourceToMentionAlerts()` so incident-task comment mentions and
assignee alerts keep firing after the redesign.

---

## `incidentStatus` is inlined on TestCase { #incidentstatus-is-inlined-on-testcase }

:material-plus-circle:{ .om-additive } · Affects: clients that made an extra call per test case

```json title="tests/testCase.json"
"incidentStatus": {
  "description": "Latest incident resolution status for this test case. Inlined so clients can render
   the current incident status without an additional lookup per test case.",
  "$ref": "./testCaseResolutionStatus.json"
}
```

!!! success "Action"
    Drop the per-test-case `GET /v1/dataQuality/testCases/testCaseIncidentStatus` round trip in list
    views. The field is populated on the test case itself.

---

## Incident auto-close on test pass

:material-plus-circle:{ .om-additive } **Opt-in per test case** · Affects: incident lifecycle

```json title="tests/testCase.json"
"autoCloseIncident": {
  "description": "Automatically resolve an open incident when a subsequent test result succeeds.",
  "type": "boolean",
  "default": false
}
```

When enabled and a subsequent result succeeds, `TestCaseResultRepository.autoResolveIncidentOnSuccess()`
finds the open `TestCaseResolution` task for the test case, rehydrates it so workflow transitions are
available, and resolves it as `Completed` with reason **`AutoResolved`**, acting as the governance bot.

!!! warning "Default is `false` — behaviour is unchanged unless you opt in"
    In 1.13 an incident stayed open indefinitely after the underlying failure was fixed. 2.0 makes
    auto-close available but does not enable it retroactively. Set `autoCloseIncident: true` on the
    test cases where you want it.

!!! info "Not to be confused with the incident-lifecycle workflow proposals"
    The repository carries OpenSpec proposals (`incident-lifecycle-workflow`, `incident-auto-close`,
    `incident-ttl`) that migrate incident management onto governance workflows with `openTask` /
    `closeTask` / `resolveIncidentTask` nodes. **Those did not ship in 2.0.0** — `nodeSubType` has no
    such values and `TestCaseFailureReasonType` has no `AutoResolved` member. The 2.0 auto-close
    described above is implemented in the repository layer.

---

## Multi-status test case filtering

:material-plus-circle:{ .om-additive } **with stricter validation** · Affects: DQ list clients

`GET /v1/dataQuality/testCases` binds `testCaseStatus` as a repeated parameter:

```http
GET /api/v1/dataQuality/testCases?testCaseStatus=Failed&testCaseStatus=Aborted
```

The values are validated against `TestCaseStatus` and an unknown value returns `400` listing the
allowed values. Previously an invalid status was tolerated.

In the UI, the Test Cases, Test Suites, Test Definitions, Incidents and DQ Dashboard pages all move
to the shared filter-chip pattern (`useTestCaseFilters`, `useIncidentFilters`,
`useTestSuiteFilters`, `useTestDefinitionFilters`, `useDataQualityDashboardFilters`) with
multi-select on **Platform**, **Status** and **Tags**, searchable **Table**, **Tags**, **Service**
and **Data Product** filters, and a date control for **Last Run**.

---

## Batch data quality reporting

:material-plus-circle:{ .om-additive } · Replaces N sequential report calls

```http
POST /v1/dataQuality/testSuites/dataQualityReport/batch
```

```json title="dataQualityReportBatchRequest"
{
  "requests": [
    { "key": "byStatus", "index": "testCase", "aggregationQuery": "…", "q": "…", "domain": "…" },
    { "key": "byDimension", "index": "testCase", "aggregationQuery": "…" }
  ]
}
```

Each request carries a client-supplied `key` used to correlate it with its result in the response.
The 2.0 UI batches its dashboard aggregations through a client-side `dataQualityReportBatcher`.

---

## Data Insights no longer computes data quality

:material-close-octagon:{ .om-breaking } **Breaking** · Affects: `DataInsightsApplication`
configuration and any DI dashboards built on the DQ module

```diff title="entity/applications/configuration/internal/dataInsightsAppConfig.json"
- "dataQualityConfig": { "enabled": true },
  "moduleConfiguration": {
-   "dataQuality": { "$ref": "#/definitions/dataQualityConfig" },
-   "required": ["dataAssets", "appAnalytics", "dataQuality", "costAnalysis"]
+   "required": ["dataAssets", "appAnalytics", "costAnalysis"]
  }
```

`moduleConfiguration` is `additionalProperties: false`, so **any persisted config still carrying the
`dataQuality` key makes `DataInsightsApplication` fail to deserialise on startup.** The 2.0.0
migration strips it from `installed_apps`, `apps_marketplace` and every `app.version.*` row in
`entity_extension`.

What replaces it: `testCaseResult` and `testCaseResolutionStatus` are read **straight from their live
search indexes** via the `di-data-assets-*` aliases, which search indexing now owns. This also drops
the previous **30-day cap** on DQ incident data in Data Insights — incident history is no longer
truncated.

!!! danger "Do not POST a 1.13 DataInsights app config to 2.0"
    A config containing `moduleConfiguration.dataQuality` will be rejected. Strip the key before
    replaying stored configuration through the API or IaC.

Related Data Insights fixes in 2.0:

- A chart metric with no function or formula returns `400`, not `500`.
- Chart formulas are validated by `DataInsightFormulaEvaluator`, not the policy validator.
- `entityStatus` is snapshotted so DI charts can filter by lifecycle status.
- `classificationTags` and `glossaryTags` are projected into the DI snapshot.
- Nested subfields are no longer advertised as chart fields.
- Enricher step failures are isolated, with per-step `EntityStats`.

---

## Custom SQL test definitions — documentation correction

:material-alert:{ .om-behavioral } **Not a behaviour change — a corrected description**

`testDefinition.sqlExpression`'s description was rewritten in 2.0:

=== "1.13 description (incorrect)"

    > Supports substitution variables: `{table}` and `{column}` for runtime entity references, and
    > `{{paramName}}` for user-defined parameters.

=== "2.0 description (accurate)"

    > The template is rendered with Jinja2, so every substitution variable must use double curly
    > braces: `{{ table_name }}` for the runtime table reference, `{{ column_name }}` for the runtime
    > column reference (column-level test definitions only), and `{{ paramName }}` for user-defined
    > parameters. Single-brace placeholders are not substituted and will produce invalid SQL.

The renderer is identical in both releases — single-brace placeholders never worked. If you followed
the 1.13 documentation and wrote `{table}`, your test was already producing invalid SQL.

!!! success "Action"
    Audit custom SQL test definitions for single-brace placeholders and convert them to
    `{{ table_name }}` / `{{ column_name }}`.

---

## Profiler & sampling

:material-alert:{ .om-behavioral } **Behavioural** · Affects: profiler runs using agent defaults

The sampling schema files are unchanged between 1.13.4 and 2.0, but the 2.0 profiler agent now
defaults to **Dynamic Sampling** instead of scanning 100% of rows. Existing explicit profiler
configurations are preserved.

Cardinality distribution is also removed from the default metric set. Workflows that depend on
distinct-value counts for classification, tagging, or custom rules must explicitly add cardinality
distribution to their profiler configuration.

2.0 adds:

- Progress tracking for the profiler and auto-classification workflows (see
  [Ingestion → progress tracking](ingestion-and-connectors.md#hierarchical-progress-tracking-and-sse)).
- The sample config is used for data-quality sample data ingestion.
- `SamplerInterface` collapses to a single typed config object (internal refactor; affects custom
  sampler implementations).
- `tableCustomSQLQuery` honours `computePassedFailedRowCount`.

!!! success "Action"
    Pin an explicit sampling configuration if you require full-table scans, and explicitly enable
    cardinality distribution wherever downstream logic consumes distinct-value metrics.

### Removed from `columnProfile`

:material-close-octagon:{ .om-breaking } · low impact

`entity/data/table.json` replaces the inline `columnProfile.cardinalityDistribution` object with a
`$ref` to a named `#/definitions/cardinalityDistribution`. The wire shape is unchanged — only the
schema pointer moved. Regenerate spec-derived models.

---

## Test suite & test case search

:material-plus-circle:{ .om-additive }

- `testSuite` and `testCase` are vectorised for hybrid search.
- `search_metadata` (MCP) can search test cases and test suites.
- Orphan test cases no longer break search indexing.

---

## Observability UI

:material-alert:{ .om-behavioral } · Affects: forks and plugin authors

- `ObservabilityRouterClassBase` replaces `RouterUtils` for data quality / observability navigation
  paths, making them overridable by downstream distributions.
- Test case and bundle-suite forms migrate from AntD `Form` to **react-hook-form** with reusable
  field docs; `EditTestCaseModal`, `EditTestCaseModalV1`, `TestCaseForm`, `TestCaseFormV1` and
  `BundleSuiteForm` are removed.
- Incident test-case status and severity components move from MUI to the shared core components.
- Data quality dashboard hooks (`useDataQualityDashboardFilters`) and presentational components are
  extracted and shared.

!!! success "Action"
    Forks that imported `EditTestCaseModal`, `TestCaseForm` or `BundleSuiteForm` directly must move
    to the new hook-and-component split. See [UI & Customization](ui-and-customization.md).
