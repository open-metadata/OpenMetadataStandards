---
title: Breaking Changes — OpenMetadata 1.13 → 2.0
description: Complete component-level breakdown of API, schema, ingestion and UI breaking changes between OpenMetadata 1.13 and 2.0.
---

# Breaking Changes: 1.13 → 2.0

**Everything that changes behaviour when you move from the 1.13 line to 2.0.0 — broken out by component.**

OpenMetadata 2.0 is a major release. It retires the thread-backed collaboration model, replaces the
Explore experience, moves LLM/embedding configuration out of the search block, adds a database-backed
session store, and reshapes several API contracts. This section documents every change that can break
an existing client, script, deployment, or user workflow.

---

## How to read this section

Every entry is classified so you can triage quickly:

| Badge | Meaning |
|-------|---------|
| :material-close-octagon:{ .om-breaking } **Breaking** | Existing callers/configs fail outright. Action is required before or during upgrade. |
| :material-alert:{ .om-behavioral } **Behavioural** | Requests still succeed, but the result, ordering, or side effect differs. |
| :material-clock-alert:{ .om-deprecated } **Deprecated** | Still works in 2.0, scheduled for removal. Migrate at your convenience. |
| :material-plus-circle:{ .om-additive } **Additive** | New surface only — listed where it replaces something you may be using. |

Each entry states **what changed**, **who is affected**, and **what to do**.

---

## Component index

<div class="grid cards" markdown>

-   :material-api:{ .lg .middle } **[API & Schema Contracts](api.md)**

    ---

    Removed endpoints, changed request/response shapes, tightened validation,
    enum and default changes across the JSON Schema spec.

-   :material-magnify:{ .lg .middle } **[Discovery & Search (Explore)](discovery-and-search.md)**

    ---

    The redesigned Explore page, the new browse + filter query bar, changed URL
    parameters, facet scoping semantics, staged ranking, and async CSV export.

-   :material-account-group:{ .lg .middle } **[Collaboration: Tasks, Suggestions, Announcements, Feed](collaboration.md)**

    ---

    The Task redesign, removal of `/v1/suggestions`, standalone Announcements,
    the ephemeral Activity Stream, and alert-filter changes.

-   :material-shield-account:{ .lg .middle } **[Data Governance](data-governance.md)**

    ---

    Glossary/ontology, classification & tags, policies and new task operations,
    governance workflows, Data Access Requests and the Policy Agent.

-   :material-check-decagram:{ .lg .middle } **[Data Quality & Observability](data-quality.md)**

    ---

    Test case incident inlining, auto-close, multi-status filters, batch DQ
    reporting, profiler sampling, and the removed Data Insights DQ module.

-   :material-sitemap:{ .lg .middle } **[Lineage](lineage.md)**

    ---

    FQN-based edge APIs, batch hydration, time-window traversal semantics, and
    new lineage change events.

-   :material-database-import:{ .lg .middle } **[Ingestion & Connectors](ingestion-and-connectors.md)**

    ---

    `pipelineStatuses` shape change, Databricks Pipeline auth, Great Expectations
    1.x, new connectors, progress tracking and the log-stream SSE contract.

-   :material-apps:{ .lg .middle } **[Applications & Automation](applications-and-automation.md)**

    ---

    Search Indexing app config removals, RDF Index app defaults, Data Insights
    module config, MCP tool contracts, and CSV/background job changes.

-   :material-server-security:{ .lg .middle } **[Platform, Config & Security](platform-and-security.md)**

    ---

    `llmConfiguration`, session management and concurrent-session limits,
    `openmetadata.yaml` changes, and the 2.0.0 database migration.

-   :material-palette-swatch:{ .lg .middle } **[UI, Personas & Customization](ui-and-customization.md)**

    ---

    Design-system consolidation, App Mode, persona preferences, Context Center,
    and removed UI components for fork/plugin maintainers.

</div>

---

## At a glance — the ten changes most likely to break you

| # | Change | Component | Class |
|---|--------|-----------|-------|
| 1 | `/v1/suggestions/*` removed — suggestions are now Tasks | [Collaboration](collaboration.md#suggestions-api-removed) | Breaking |
| 2 | Announcements removed from `/v1/feed`, now `/v1/announcements` | [Collaboration](collaboration.md#announcements-are-a-standalone-entity) | Breaking |
| 3 | `ingestionPipeline.pipelineStatuses` is now an **array** | [Ingestion](ingestion-and-connectors.md#pipelinestatuses-is-now-an-array) | Breaking |
| 4 | Embedding/NLQ provider config moved to top-level `llmConfiguration` | [Platform](platform-and-security.md#llm-and-embedding-configuration-moved) | Breaking |
| 5 | `searchIndexingAppConfig.recreateIndex` / `useDistributedIndexing` removed | [Applications](applications-and-automation.md#search-indexing-app-configuration-fields-removed) | Breaking |
| 6 | Explore URL params `page`/`size` → `currentPage`/`pageSize` + new `browsePath` | [Discovery](discovery-and-search.md#explore-url-parameters-changed) | Breaking |
| 7 | `search_after` is now a repeated parameter, not a comma-joined string | [API](api.md#search_after-is-now-a-repeated-query-parameter) | Breaking |
| 8 | Databricks Pipeline connection requires `authType` instead of `token` | [Ingestion](ingestion-and-connectors.md#databricks-pipeline-connection-requires-authtype) | Breaking |
| 9 | `maxActiveSessionsPerUser` defaults to 5; sessions are DB-backed | [Platform](platform-and-security.md#concurrent-sessions-are-capped-per-user) | Behavioural |
| 10 | `entityName` now rejects `>`, `"` and control characters | [API](api.md#entity-name-validation-tightened) | Breaking |

---

## Upgrade checklist

!!! warning "Take a database backup before upgrading"
    The 2.0.0 migration renames `thread_entity`, creates 15+ new tables, and rewrites
    application, service-connection and tag rows in place. There is no automated downgrade.

### Before you upgrade

1. **Inventory your API clients.** Grep for `/v1/suggestions`, `/v1/feed`, `search_after=`,
   `pipelineStatuses`, and `recreateIndex` in scripts, dashboards, Terraform, and CI jobs.
2. **Export your `openmetadata.yaml`** and diff it against the 2.0 template. The
   `elasticsearch.naturalLanguageSearch.*` provider blocks no longer exist.
3. **Record your app configurations.** `SearchIndexingApplication`, `DataInsightsApplication`,
   `RdfIndexApp` and `McpApplication` configs are all rewritten by the migration.
4. **Check entity names** for `>` or `"` characters — they will fail validation on the next write.
5. **Note your Explore bookmarks / saved links.** `?page=` and `?size=` are no longer read.

### During the upgrade

1. Run the 2.0.0 migration with the standard `bootstrap` tooling. Expect these data migrations:
   suggestions → `task_entity`, thread tasks → `task_entity`, system feed threads → `activity_stream`,
   announcements → `announcement_entity`, `thread_entity` → `thread_entity_legacy`.
2. Allow a **full search reindex**. Reindexing in 2.0 always recreates the index — there is no
   incremental option, and the ranking configuration is backfilled into `searchSettings`.
3. Expect the RDF Index app to switch to a **weekly, full-rebuild** schedule with `entities: ["all"]`.

### After you upgrade

1. Verify Explore results and ordering — the staged ranking algorithm changes result order.
2. Re-check alert subscriptions whose filters relied on partial FQN matching.
3. Re-check Snowflake / Databricks / Unity Catalog services — `policyAgentConfig` defaults were
   backfilled onto existing rows.
4. Confirm users are not being logged out unexpectedly if they routinely exceed 5 sessions.

---

## Version scope

| | |
|---|---|
| **From** | OpenMetadata 1.13 line (1.13.0 – 1.13.4) |
| **To** | OpenMetadata 2.0.0 |
| **Source** | [`2.0.0-release` at `6861999f`](https://github.com/open-metadata/OpenMetadata/commit/6861999f332b75ce46c5f01b31b71c71168314ba) |
| **Schema spec** | 86 new schema files, 107 modified, 3 removed |
| **REST surface** | 208 endpoints added, 10 removed |

For an auditable file-by-file view, see the [2.0 schema change inventory](../reference/schema-changes-2.0.md)
or the [upstream release comparison](https://github.com/open-metadata/OpenMetadata/compare/1.13.4-release...2.0.0-release).

!!! info "Collate-only features"
    A handful of entries reference capabilities that ship in Collate (the managed distribution)
    rather than OpenMetadata OSS — AI Governance Studio, the Policy Agent, Context Center, and
    AI Mode. They are documented here because their **schemas and REST namespaces are part of the
    2.0 spec** and appear in the OpenAPI surface either way.
