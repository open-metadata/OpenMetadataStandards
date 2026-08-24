---
title: Lineage Changes (1.13 → 2.0)
description: FQN-based lineage edge APIs, batch hydration, time-window traversal semantics and lineage change events in OpenMetadata 2.0.
---

# Lineage

**Mostly additive — but the new time-window filter has non-obvious traversal semantics, and the
knowledge-graph renderer is replaced.**

---

## New FQN-based edge APIs

:material-plus-circle:{ .om-additive } · Affects: nobody negatively — the UUID-based endpoints remain

| New endpoint | Purpose |
|--------------|---------|
| `PUT /v1/lineage/{fromEntity}/name/{fromFQN}/{toEntity}/name/{toFQN}` | Create/replace an edge by FQN |
| `PATCH /v1/lineage/{fromEntity}/name/{fromFQN}/{toEntity}/name/{toFQN}` | Patch an edge by FQN |
| `GET /v1/lineage/getLineageEdge/{fromEntity}/name/{fromFQN}/{toEntity}/name/{toFQN}` | Read a single edge by FQN |
| `DELETE /v1/lineage/source/name/{entityType}/{entityFQN}/type/{lineageSource}` | Delete all edges of one `lineageSource` for an entity |

The `DELETE .../source/...` endpoint is the clean way to re-run a lineage source (dbt, OpenLineage,
manual) without wiping edges contributed by other sources.

---

## Batch hydration

:material-plus-circle:{ .om-additive } · Replaces N per-node `GET`s

```http
POST /v1/lineage/hydrate
```

```json title="hydrateLineageRequest"
{
  "entities": [ { "type": "table", "id": "…" } ],   // 1–200 items, only type + id required
  "fields": "tags,owners,domains",
  "include": "non-deleted"
}
```

The response groups hydrated entities by `entityType`. `fields` is applied uniformly — fields that
do not apply to a given entity type are silently skipped by that type's repository.

!!! success "Action"
    Graph UIs and lineage exporters that fan out one entity `GET` per node should switch to a single
    `hydrate` call per page of nodes.

---

## Time-window lineage — read the traversal semantics

:material-alert:{ .om-behavioral } **New capability with surprising semantics**

`searchLineageRequest` and `entityCountLineageRequest` gain `startTime` / `endTime` (epoch millis),
matched by range overlap on edge `createdAt` / `updatedAt`.

!!! warning "The window is a hard prune, not a post-filter"
    From the schema:

    > the window is applied as a hard prune during graph traversal (point-in-time semantics) — an
    > out-of-window edge severs discovery of everything reachable only through it, in both upstream
    > and downstream directions. This means `preservePaths` does **not** extend to the time window: a
    > node is shown only if it is reachable from the root through edges that are **all** in-window.

Two consequences worth planning for:

1. **A single stale edge hides a whole subtree.** If the edge from `A → B` falls outside the window,
   nothing downstream of `B` is returned even if those edges are in-window.
2. **Legacy edges always match.** Edges with no timestamps match any window for backwards
   compatibility, so a window query over a mix of legacy and temporal data returns *all* legacy edges
   plus the in-window temporal ones. Do not read the result as a clean point-in-time snapshot until
   your graph is fully timestamped.

Setting `endTime` alone gives as-of/point-in-time semantics: edges that existed on or before that
instant.

---

## Lineage change events

:material-plus-circle:{ .om-additive } · Affects: webhook and event-subscription consumers

`type/changeEventType.json` adds `entityLineageAdded`, `entityLineageDeleted` and
`entityLineageUpdated`. Lineage mutations previously surfaced only as generic entity updates (or not
at all).

!!! success "Action"
    Alert and webhook consumers with exhaustive event-type handling need branches for the three new
    types. Subscriptions that filtered on `entityUpdated` to catch lineage changes may now see those
    changes arrive under the new types instead.

---

## Lineage UI

:material-alert:{ .om-behavioral } · Affects: users and fork maintainers

| Change | Detail |
|--------|--------|
| **Time filter** | New `LineageTimeFilter` control drives the `startTime`/`endTime` request fields |
| **Traced paths** | Traced edges and nodes are rendered distinctly |
| **Pagination** | Execution history and edge deletion are paginated |
| **Node edits** | Entity edits reflect on graph nodes without a full graph reload |
| **Component stack** | `LineageLayers`, `CanvasEdgeRenderer`, `LineageTable`, `LineageNodeLabelV1` and `LineageControlButtons` migrate off MUI/AntD onto the shared core components; the MUI Drawer and AntD Modal are replaced |
| **Utilities** | `EntityLineagePureUtils` extracted and split into domain files |

### Knowledge Graph renderer replaced

:material-close-octagon:{ .om-breaking } · Affects: forks importing the graph components

The AntV-G6 based knowledge graph is removed and replaced by an RDF-backed **3D Knowledge Graph** tab
with an Ontology mode and full-viewport expand.

Removed modules:

```
components/KnowledgeGraph/KnowledgeGraph.tsx
components/KnowledgeGraph/KnowledgeGraph.constants.ts
components/KnowledgeGraph/KnowledgeGraph.interface.ts
components/KnowledgeGraph/KnowledgeGraph.style.less
components/KnowledgeGraph/GraphElements/CustomNode.tsx
components/KnowledgeGraph/GraphElements/custom-node.less
components/OntologyExplorer/NodeContextMenu.tsx
```

New/replacement modules live under `components/OntologyExplorer/` —
`OntologyEntityPanel.tsx`, `hooks/useOntologyExplorer.ts`, `hooks/useOntologyGraphDerived.ts`,
`utils/graphBuilders.ts`, `utils/cardinalityLabelUtils.ts`, `utils/textMeasure.ts`.

!!! warning "RDF must be enabled for the graph tab"
    The 3D graph reads from the RDF store. If `rdf.enabled` is `false`, the tab has no data. Note
    also that `rdf.inferenceEnabled` now defaults to **`false`** — see
    [Applications & Automation](applications-and-automation.md#rdf-index-app-defaults-changed).

---

## OpenLineage

:material-plus-circle:{ .om-additive }

`api/lineage/openlineage/openLineageFacets.json` and `configuration/openLineageSettings.json` are
both modified in 2.0 (additive fields). Snowflake gains an opt-in `ACCESS_HISTORY` lineage path, dbt
Cloud gains column-level lineage from compiled SQL, dbt gains semantic-layer metric ingestion with
column-level lineage, and Kafka Connect creates lineage for `EventRouter`/`RegexRouter`-routed topics.
