---
title: UI, Personas & Customization Changes (1.13 → 2.0)
description: Design-system consolidation, App Mode, persona preferences, Context Center and removed UI components in OpenMetadata 2.0.
---

# UI, Personas & Customization

**For end users this is a visual and navigational refresh. For anyone who forks the UI, writes a UI
plugin, or maintains Playwright/Cypress suites, it is a large refactor.**

The Explore page changes are documented separately in
[Discovery & Search](discovery-and-search.md).

---

## Design system consolidation

:material-close-octagon:{ .om-breaking } **Breaking for forks and plugins** · Cosmetic for end users

1.13 carried a transitional set of `MUI*` wrapper components inside `openmetadata-ui`. 2.0 removes
them and standardises on the shared **`@openmetadata/ui-core-components`** package (Untitled UI v8
naming: `components/base/*` and `components/application/*`).

### Removed component modules

```
components/common/MUISelect/                 components/common/MUITextField/
components/common/MUIUserTeamSelect/         components/common/MUIDomainSelect/
components/common/MUIFormItemLabel/          components/common/MUIGlossaryTagSuggestion/
components/common/MUIAsyncTreeSelect/**      components/common/MuiDatePickerMenu/
components/common/MuiDrawer/                 components/common/ColorPicker/MUIColorPicker.tsx
components/common/IconPicker/MUIIconPicker.tsx
components/common/CoverImageUpload/MUICoverImageUpload.tsx
components/common/FileUpload/MUIFileUpload.tsx
components/common/DeleteModal/DeleteModalMUI.tsx
components/form/MUIAutocomplete/
components/common/atoms/asyncTreeSelect/**   components/common/atoms/navigation/useSearch.tsx
components/common/atoms/navigation/useBreadcrumbs.tsx
components/common/atoms/navigation/useViewToggle.tsx
components/common/atoms/pagination/usePaginationControls.tsx
components/common/atoms/notifications/NotificationMessage.tsx
components/common/atoms/table/TagsCell.tsx
components/common/atoms/data/useQueryBuilder.tsx
```

The **`SELECT_MUI` field type is removed** from the form builder.

### Other removed UI modules

| Removed | Replacement |
|---------|-------------|
| `components/CondensedBreadcrumb/**` | core-components `Breadcrumbs` |
| `components/common/EntityDescription/DescriptionV1.tsx` | new description components |
| `components/Modals/DeleteModal/**`, `components/Modals/EntityDeleteModal/**`, `components/common/DeleteWidget/DeleteWidgetModal.tsx` | consolidated delete modal |
| `components/ActivityFeed/ActivityFeedCardV2/**`, `FeedCardBodyV1.tsx`, `Shared/TaskBadge.tsx` | activity-stream components |
| `components/KnowledgeGraph/**` | RDF-backed 3D graph in `components/OntologyExplorer/**` |
| `components/Entity/EntityList/EntityList.tsx` | shared listing atoms |
| `components/DataQuality/AddDataQualityTest/**` (`EditTestCaseModal`, `TestCaseForm`, `TestCaseFormV1`, `BundleSuiteForm`) | react-hook-form based forms |
| `components/SearchSettings/FilterConfiguration/FilterConfiguration.tsx` | new search-settings UI |
| `pages/LogsViewerPage/**` | `LogViewerModal` with SSE live tailing |
| `utils/CommonUtils.tsx` | split into domain-specific utility modules |
| `utils/NotistackUtils.tsx`, `hooks/useAlertStore.ts` | `ToastUtils` + core-components `Toast` |
| `utils/TasksUtils.ts`, `utils/KnowledgeGraph.utils.ts`, `utils/LogsClassBase.ts` | replaced by the redesigned equivalents |
| `constants/Tags.constant.ts` | inlined/relocated |
| `components/Settings/Applications/AppLiveIndexing/**` (graph panels & utils) | `components/OntologyExplorer/**` |
| `components/common/atoms/shared/utils/entityFilterProcessors.ts` | `utils/FilterQueryUtils.ts` |

Generated model files for the removed Collate AI agent configs are deleted too.

!!! success "Action for fork maintainers"
    Search your fork for `MUI` imports, `SELECT_MUI`, `usePaginationControls`, `NotistackUtils`,
    `CommonUtils` and `DescriptionV1`. Expect a mechanical but wide migration. `PaginationCardDefault`
    replaces `usePaginationControls`; `Input` from core-ui replaces the `useSearch` hook.

### New extension points

:material-plus-circle:{ .om-additive } — these are the supported way to customise in 2.0.

| Extension point | Purpose |
|-----------------|---------|
| `ObservabilityRouterClassBase` | Override data quality / observability navigation paths |
| `ConnectionsRouterClassBase` | Pluggable connection routing |
| `EntityUtilClassBase.getEntityTypes()` | Overridable entity-type list |
| App Mode primitives + routes registry | Downstream plugin routes |
| Extensible user-profile dropdown items | Add items to the profile menu |
| `withDomainFilter` HOC | Domain-scoped list pages |
| `brandName` | Replaces hard-coded "OpenMetadata" strings for white-labelling |

---

## App Mode { #app-mode }

:material-plus-circle:{ .om-additive } **New concept** · Affects: login experience and persona config

2.0 introduces two application experiences — **Classic** (the standard OpenMetadata UI) and **AI**
(the assistant-driven experience, which requires the AI plugin, e.g. Collate).

Resolution order, highest priority first:

1. **User preference** — `appModePreference` in the user's preferences bag
2. **Persona `appMode`** — `classic` \| `AI` (default `classic`), forced on login
3. **Tenant `defaultAppMode`** — the `appConfiguration` setting (`ai` \| `classic` \| `null`)

```json title="api/teams/preferences/appModePreference.json"
{ "type": "appMode", "config": { "value": "ai" | "classic" | null } }
```

The active mode is held in a single source of truth backed by a `sessionStorage` tuple, so sibling
tabs no longer lose the active mode.

!!! note "AI Mode is inert without the AI plugin"
    Setting a persona's `appMode` to `AI` on OSS has no effect beyond the mode flag — the AI
    experience ships with the Collate distribution.

---

## Per-user preferences API

:material-plus-circle:{ .om-additive } **New API**, backed by a new `user_preferences` table

```
GET    /v1/users/{userId}/preferences
PUT    /v1/users/{userId}/preferences/{type}
DELETE /v1/users/{userId}/preferences/{type}
```

```json title="api/teams/userPreferences.json"
{
  "userId": "…",
  "preferences": [ { "type": "appMode", "config": { "value": "classic" } } ],
  "updatedAt": 1712345678000
}
```

The preferences bag is a typed discriminated union keyed by `type`. It is deliberately **not** a full
entity — no versioning, audit or soft-delete — and is cascade-deleted via `UserRepository#postDelete`
rather than a foreign key.

!!! success "Action"
    Do not store per-user UI state in the `User` entity's `extension`. Use the preferences API.

---

## Personas gain AI context

:material-plus-circle:{ .om-additive } · Collate AI features

`persona.json` and `createPersona.json` gain `contextDefinition`
(`type/personaContextDefinition.json`) — *"rules and settings used to materialize the shared AI
context for this persona."* New endpoints:

```
GET  /v1/personas/search                       # server-side persona search
GET  /v1/personas/me/context
GET  /v1/personas/{id}/context
GET  /v1/personas/name/{fqn}/context
GET  /v1/personas/{id}/aiContext
PUT  /v1/personas/{id}/aiContext
GET  /v1/personas/{id}/aiContext/document
POST /v1/personas/{id}/aiContext/document:refresh
POST /v1/personas/{id}/aiContext/rules
POST /v1/personas/{id}/aiContext/rules/preview
PUT  /v1/personas/{id}/aiContext/rules/{ruleId}
DELETE /v1/personas/{id}/aiContext/rules/{ruleId}
```

Supporting schemas: `type/aiContext.json`, `type/personaContext.json`,
`type/personaContextDefinition.json`. A general `/v1/ai/context/find` and
`/v1/ai/context/attachedKnowledge` are also added.

---

## Context Center & Knowledge Center

:material-close-octagon:{ .om-breaking } **Route replacement** · Affects: navigation, bookmarks,
reverse proxies, and internal documentation

Knowledge Center is removed as a standalone section. Existing pages are migrated automatically to
Articles in Context Center, but hard-coded `/knowledge-center/...` URLs do not redirect and must be
updated.

New Context Center UI routes:

```
/context-center
/context-center/dashboard    /context-center/articles     /context-center/documents
/context-center/filter       /context-center/memories     /context-center/integrations
/context-center/archive
```

New REST namespaces: `/v1/contextCenter/pages`, `/v1/contextCenter/memories`,
`/v1/contextCenter/drive/files`, `/v1/contextCenter/drive/folders`, and `/v1/attachments`.

New entities: `page`, `article`, `quickLink`, `pageHierarchy`, `folder`, `contextFile`,
`contextFileContent`, `contextMemory`, `asset`.

!!! warning "Reverse proxies and CSP"
    If you front OpenMetadata with a proxy that allowlists paths, add `/context-center`,
    `/api/v1/contextCenter`, and `/api/v1/attachments`; remove rules that assume
    `/knowledge-center` remains available. Uploads require `objectStorage` to be enabled — see
    [Platform → Object storage](platform-and-security.md#object-storage-configuration-expanded).

---

## Visual and navigation changes

:material-alert:{ .om-behavioral } · Affects: end users, screenshots in your internal docs, E2E tests

| Change | Detail |
|--------|--------|
| **Entity page header** | Redesigned to the 2.0 card layout |
| **Dark theme** | Supported via design tokens |
| **Owner display** | Multi-owner headers stack avatars with a hover popover |
| **Announcements** | Rendered in the entity header, not only in the feed widget |
| **Sidebar** | "Marketplace" renamed to **Data Marketplace** / **Overview** |
| **Agents tab** | Revamped agent listing and details wired to real data |
| **Service icons** | Migrated from PNG to WebP |
| **Glossary Terms table** | Moves to `TableV2` — adaptable search, column resize, drag reorder, sticky header |
| **Landing page** | Widgets lazy-loaded; admins can set a default landing-page panel colour |
| **Log viewer** | Modal with live SSE tailing, replacing the standalone Logs Viewer page |
| **Empty states** | New prefilled `EmptyPlaceholder` variants across glossary, classification, metric, domain and data-product pages |
| **Toasts** | Consolidated on the core-components `Toast` provider |
| **Permission errors** | `403` responses surface a proper toast |
| **Asset Health widget** | Added to the table detail page |
| **Language** | Swedish (`sv-SE`) added; the UI sends an `X-OpenMetadata-Language` header matching the active locale |

!!! success "Action for E2E suites"
    Expect widespread `data-testid` and DOM-structure churn. Budget for a Playwright/Cypress
    refresh — the OpenMetadata suite itself absorbed 71 Playwright-scoped commits in this release.

---

## Performance refactor (fork-visible)

:material-alert:{ .om-behavioral } · Affects: forks with deep imports

2.0 does a large code-splitting and lazy-loading pass:

- Pure utility functions are extracted out of large modules into `*PureUtils` files
  (`ExplorePureUtils`, `AdvancedSearchPureUtils`, `QueryBuilderPureUtils`, `TablePureUtils`,
  `TagsPureUtils`, `EntityLineagePureUtils`, `DataProductPureUtils`, `DataInsightPureUtils`,
  `DataQualityPureUtils`, `FeedUtilsPure`, `EntityBreadcrumbPureUtils`, …).
- `utils/CommonUtils.tsx` and `utils/EntityUtils.tsx` are deleted; facade imports are migrated to
  direct sources.
- `CustomizePageUtils.ts` splits into three focused modules.
- Settings, Entity and Entity-Import routers, tab-level components and heavy components are
  lazy-loaded behind `withSuspenseFallback`.
- Vite config is reworked for code splitting and chunk loading.

!!! success "Action"
    Deep imports from `utils/CommonUtils` or `utils/EntityUtils` will not resolve. Import from the
    specific domain module instead.

---

## Storybook & component library

:material-plus-circle:{ .om-additive }

`openmetadata-ui-core-components` gains `Breadcrumbs`, `EmptyPlaceholder`, `ProgressSteps`, `Toast`,
an Untitled UI v8 `FilterBar`, an `xs` button size, and a nightly Storybook Docker build.

Two renames to be aware of when consuming the package:

- Untitled UI v8 "safe class renames" applied across components.
- The Select-family `placeholderIcon` prop is renamed to **`icon`**.
