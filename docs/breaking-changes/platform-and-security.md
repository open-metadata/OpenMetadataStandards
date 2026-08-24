---
title: Platform, Configuration & Security Changes (1.13 → 2.0)
description: llmConfiguration, database-backed sessions and concurrent-session limits, openmetadata.yaml changes and the 2.0.0 database migration.
---

# Platform, Configuration & Security

**Two changes here will stop a 2.0 server from starting or behaving as expected with a 1.13
configuration: the LLM/embedding config move, and the new session limits.**

---

## LLM and embedding configuration moved { #llm-and-embedding-configuration-moved }

:material-close-octagon:{ .om-breaking } **Breaking** · Affects: every deployment using semantic
search, NLQ, or any LLM feature

Provider configuration is no longer nested inside `elasticsearch.naturalLanguageSearch`. It moves to
a new **top-level `llmConfiguration`** block, with embeddings as a sub-section that reuses the same
provider credentials.

### Removed from `elasticSearchConfiguration.naturalLanguageSearch`

```
embeddingProvider
maxConcurrentRequests
bedrock.*   (awsConfig, modelId, embeddingModelId, embeddingDimension, maxTokens, temperature, timeoutSeconds)
openai.*    (apiKey, endpoint, deploymentName, apiVersion, modelId, embeddingModelId, embeddingDimension, maxTokens, temperature, timeoutSeconds)
google.*    (apiKey, endpoint, modelId, embeddingModelId, embeddingDimension)
djl.*       (embeddingModel)
```

What remains under `naturalLanguageSearch`: `semanticSearchEnabled`, `knnNumCandidatesMultiplier`
(new, default `2`) and a new `filterExtractor` block (`cacheMaxSize` 1000, `cacheExpiryMinutes` 5,
`maxSampleValues`).

### The 2.0 shape

```yaml title="conf/openmetadata.yaml"
elasticsearch:
  naturalLanguageSearch:
    semanticSearchEnabled: ${SEMANTIC_SEARCH_ENABLED:-false}
    # Embedding provider/model/credentials now live under llmConfiguration.embeddings

llmConfiguration:
  enabled: ${LLM_ENABLED:-false}
  provider: ${LLM_PROVIDER:-noop}   # noop | openai | azureOpenAI | bedrock | google | anthropic
  maxConcurrentRequests: ${LLM_MAX_CONCURRENT_REQUESTS:-5}
  openai:
    apiKey: ${LLM_OPENAI_API_KEY:-""}
    modelId: ${LLM_OPENAI_MODEL_ID:-"gpt-4o-mini"}
    endpoint: ${LLM_OPENAI_ENDPOINT:-""}          # with deploymentName for Azure OpenAI
    deploymentName: ${LLM_OPENAI_DEPLOYMENT:-""}
    apiVersion: ${LLM_OPENAI_API_VERSION:-"2024-02-01"}
    maxTokens: ${LLM_OPENAI_MAX_TOKENS:-4096}
  bedrock:
    awsConfig:
      enabled: ${BEDROCK_AWS_IAM_AUTH_ENABLED:-true}
      region: ${AWS_DEFAULT_REGION:-""}
      accessKeyId: ${AWS_ACCESS_KEY_ID:-""}
      secretAccessKey: ${AWS_SECRET_ACCESS_KEY:-""}
      sessionToken: ${AWS_SESSION_TOKEN:-""}
    modelId: ${LLM_BEDROCK_MODEL_ID:-"eu.anthropic.claude-haiku-4-5-20251001-v1:0"}
    maxTokens: ${LLM_BEDROCK_MAX_TOKENS:-4096}
  google:
    apiKey: ${LLM_GOOGLE_API_KEY:-""}
    modelId: ${LLM_GOOGLE_MODEL_ID:-"gemini-2.5-flash"}
  anthropic:
    apiKey: ${LLM_ANTHROPIC_API_KEY:-""}
    modelId: ${LLM_ANTHROPIC_MODEL_ID:-"claude-3-5-sonnet-20240620"}
    baseUrl: ${LLM_ANTHROPIC_BASE_URL:-"https://api.anthropic.com"}
  embeddings:
    provider: ${EMBEDDING_PROVIDER:-bedrock}   # bedrock | openai | google | djl
    maxConcurrentRequests: ${MAX_CONCURRENT_EMBEDDING_REQUESTS:-10}
    bedrock:
      embeddingModelId: ${AWS_BEDROCK_EMBED_MODEL_ID:-"amazon.titan-embed-text-v2:0"}
      embeddingDimension: ${AWS_BEDROCK_EMBEDDING_DIMENSION:-512}
    openai:
      embeddingModelId: ${OPENAI_EMBEDDING_MODEL_ID:-"text-embedding-3-small"}
      embeddingDimension: ${OPENAI_EMBEDDING_DIMENSION:-1536}
    google:
      embeddingModelId: ${GOOGLE_EMBEDDING_MODEL_ID:-"gemini-embedding-001"}
      embeddingDimension: ${GOOGLE_EMBEDDING_DIMENSION:-768}
    djl:
      embeddingModel: ${DJL_EMBEDDING_MODEL:-"ai.djl.huggingface.pytorch/sentence-transformers/all-MiniLM-L6-v2"}
```

The **embedding provider may differ from the chat provider**; embeddings reuse the credentials from
the provider blocks above (`bedrock.awsConfig`, `openai.apiKey`/`endpoint`, `google.apiKey`).

### Environment variable renames

| 1.13 | 2.0 |
|------|-----|
| `AWS_BEDROCK_REGION` | `AWS_DEFAULT_REGION` |
| `AWS_BEDROCK_ACCESS_KEY` | `AWS_ACCESS_KEY_ID` |
| `AWS_BEDROCK_SECRET_KEY` | `AWS_SECRET_ACCESS_KEY` |
| `AWS_BEDROCK_SESSION_TOKEN` | `AWS_SESSION_TOKEN` |
| `AWS_BEDROCK_MODEL_ID` | `LLM_BEDROCK_MODEL_ID` |
| `OPENAI_API_KEY` | `LLM_OPENAI_API_KEY` |
| `OPENAI_API_ENDPOINT` | `LLM_OPENAI_ENDPOINT` |
| `OPENAI_DEPLOYMENT_NAME` | `LLM_OPENAI_DEPLOYMENT` |
| `OPENAI_API_VERSION` | `LLM_OPENAI_API_VERSION` |
| `GOOGLE_API_KEY` | `LLM_GOOGLE_API_KEY` |
| `GOOGLE_API_ENDPOINT` | *(removed)* |

`AWS_BEDROCK_EMBED_MODEL_ID`, `AWS_BEDROCK_EMBEDDING_DIMENSION`, `OPENAI_EMBEDDING_MODEL_ID`,
`OPENAI_EMBEDDING_DIMENSION`, `GOOGLE_EMBEDDING_MODEL_ID`, `GOOGLE_EMBEDDING_DIMENSION`,
`DJL_EMBEDDING_MODEL`, `EMBEDDING_PROVIDER` and `MAX_CONCURRENT_EMBEDDING_REQUESTS` keep their names
but move under `llmConfiguration.embeddings`.

!!! danger "Bedrock IAM auth now defaults to enabled"
    `BEDROCK_AWS_IAM_AUTH_ENABLED` flips from `false` to **`true`**. Deployments that relied on the
    default being off, and supplied static keys, should confirm which credential chain is used.

!!! success "Action"
    Port your NLQ/embedding configuration into `llmConfiguration` **before** upgrading. Semantic
    search silently degrades (provider resolves to `noop`) rather than failing loudly if the block is
    missing.

---

## Session management

### Sessions are database-backed

:material-alert:{ .om-behavioral } **Behavioural** · Affects: multi-pod deployments

2.0 adds a `user_session` table so sessions survive pod restarts and are shared across pods.
Previously each pod held its own in-memory session state, which caused spurious logouts behind a load
balancer without sticky sessions.

Columns: `id`, `userId`, `status`, `expiresAt`, `idleExpiresAt`, `updatedAt`, `sessionType`,
`provider`, `version`, `lastAccessedAt`, `refreshLeaseUntil`, plus the session JSON.

### Concurrent sessions are capped per user { #concurrent-sessions-are-capped-per-user }

:material-alert:{ .om-behavioral } **Behavioural — users will be logged out**

```yaml
authenticationConfiguration:
  sessionExpiry: ${AUTHENTICATION_SESSION_EXPIRY:-"604800"}   # 7 days, all auth providers
  maxActiveSessionsPerUser: ${AUTHENTICATION_MAX_ACTIVE_SESSIONS_PER_USER:-5}
```

> Maximum number of active authenticated sessions allowed per user. When the limit is exceeded, the
> **least recently used active sessions are revoked**. If unset, OpenMetadata uses the default of 5.

`sessionExpiry` now applies to **all** auth providers (minimum 3600 s).
`oidcConfiguration.sessionExpiry` becomes a deprecated fallback.

!!! warning "Who this affects"
    Users who work across several browsers/devices, and **service accounts or shared users driving
    many concurrent sessions**, will start being silently signed out of the oldest sessions. Raise
    `AUTHENTICATION_MAX_ACTIVE_SESSIONS_PER_USER` if that is your pattern — but prefer bot tokens for
    automation.

### Additional trusted redirect URIs

:material-plus-circle:{ .om-additive }

```yaml
additionalTrustedRedirectUris: ${AUTHENTICATION_ADDITIONAL_TRUSTED_REDIRECT_URIS:-[]}
```

Allows redirect URIs beyond `callbackUrl` and the server's own callbacks — each entry must match the
requested URI **exactly** (scheme, host, port, path, query). Intended for browser-extension logins,
e.g. `https://<extension-id>.chromiumapp.org/auth0`.

Related SSO hardening in 2.0: the server `/auth/callback` is trusted in the SAML redirect allowlist,
SAML pending-session ids are carried in `RelayState`, and the OIDC login-loop is hardened with an
interactive fallback on `login_required` that preserves pending logins.

### Admin test-login

:material-plus-circle:{ .om-additive }

```http
POST /v1/system/security/test-login/validate-token
```

Validates a browser-obtained OIDC `id_token` against a **candidate (unsaved)** security
configuration, so an admin can confirm a real login resolves the expected identity before saving.
Schemas: `system/testLoginTokenRequest.json`, `system/testLoginResult.json`.

### LDAP

:material-plus-circle:{ .om-additive }

`recursiveGroupMembership` (default `false`) enables transitive group resolution for Active Directory
nested groups via `LDAP_MATCHING_RULE_IN_CHAIN`.

---

## Database connection timeouts changed

:material-alert:{ .om-behavioral } **Behavioural — long-running queries will now be cut off**

| Setting | 1.13 | 2.0 |
|---------|------|-----|
| `database.queryTimeoutSeconds` | — | **`300`** (new, `DB_QUERY_TIMEOUT_SECONDS`) |
| Postgres `loginTimeout` (s) | `300` | `30` |
| Postgres `postgresqlConnectTimeout` (s) | `60` | `30` |
| Postgres `postgresqlSocketTimeout` (s) | `30000` (≈8.3 h) | **`300`** (5 min) |
| MySQL `mysqlSocketTimeout` (ms) | `30000000` (≈8.3 h) | **`300000`** (5 min) |

!!! warning "Five-minute ceiling on statements"
    Any query that previously ran for more than five minutes — a large reindex batch, a heavy Data
    Insights aggregation, an oversized CSV import — now aborts. Raise `DB_QUERY_TIMEOUT_SECONDS`,
    `DB_POSTGRESQL_SOCKET_TIMEOUT` or `DB_MYSQL_SOCKET_TIMEOUT` if you have legitimately long
    statements, and check upgrade logs for statement-timeout errors.

---

## Server & logging configuration

### HTTP/2 is available (opt-in)

:material-plus-circle:{ .om-additive }

```yaml
server:
  applicationConnectors:
    - type: ${SERVER_PROTOCOL:-http}   # http (default) | h2c (cleartext HTTP/2) | h2 (TLS)
```

`dropwizard-http2` is on the classpath, so `h2c` and `h2` connector types work out of the box. Both
are backwards compatible — HTTP/1.1 clients keep working on the same port. Worth enabling when
browsers hit Jetty directly (Docker Compose, on-prem single node); not worth it behind an
HTTP/2-terminating load balancer.

### Response compression enabled

:material-alert:{ .om-behavioral }

`server.gzip.enabled` is `true` and the comment changes from *"Response compression disabled for
maximum throughput"* to a description of Jetty's `GzipHandler`. Responses above ~256 bytes are now
gzipped. Clients that mishandle `Content-Encoding: gzip` — rare, but possible in hand-rolled HTTP
code — will need `Accept-Encoding: identity`.

### Logging hardening

:material-alert:{ .om-behavioral } **Security-relevant**

```yaml
logging:
  loggers:
    org.eclipse.jetty:
      level: ${JETTY_LOG_LEVEL:-INFO}
    org.openmetadata.service.audit.AuditLogRepository:
      level: INFO
  appenders:
    - type: console
      filterFactories:
        - type: audit-exclude-filter-factory
```

`LOG_LEVEL` sets the **root** logger, and at `DEBUG` Jetty's `HttpParser` prints every request header
verbatim — including `Authorization: Bearer <jwt>` and `Cookie: OM_SESSION=<id>`. Since `DEBUG` is
exactly what support asks customers to enable, and those logs get attached to tickets, the Jetty
logger is now pinned independently via `JETTY_LOG_LEVEL`.

Audit entries are logged at `INFO` with an `AUDIT` marker and routed to `logs/audit.log`; the level is
pinned so audit capture does not depend on the global `LOG_LEVEL`, and an
`audit-exclude-filter-factory` keeps them out of the console appender.

!!! success "Action"
    If you parsed audit entries out of stdout, read `logs/audit.log` instead. If you need Jetty
    debug output, set `JETTY_LOG_LEVEL=DEBUG` explicitly — and be aware of what it prints.

### Object storage configuration expanded

:material-alert:{ .om-behavioral } · Affects: deployments using file attachments

```diff
  objectStorage:
-   enabled: false
-   provider: NOOP
-   maxFileSize: 5242880
+   enabled: ${ASSET_UPLOADER_ENABLE:-false}
+   provider: ${ASSET_UPLOADER_PROVIDER:-s3}   # s3 | azure | inmemory
+   maxFileSize: ${ASSET_UPLOADER_MAX_FILE_SIZE:-5242880}
+   s3: { endpoint, bucketName, region, accessKey, secretKey, useIamRole, iamRoleArn,
+         prefixPath, sseAlgorithm, kmsKeyId }
+   azure: { containerName, connectionString, useManagedIdentity, clientId, tenantId,
+            clientSecret, blobEndpoint, prefixPath }
```

The default `provider` changes from `NOOP` to `s3` — but `enabled` still defaults to `false`, so
nothing activates until you turn it on. This backs the new `/v1/attachments` API (uploaded assets for
Context Center files, Knowledge Center pages and cover images). For MinIO, use provider `s3` and
point `s3.endpoint` at the MinIO server.

### Query timeouts and workflow polling

See [Data Governance → Workflows fire far sooner](data-governance.md#workflows-fire-far-sooner) for
the Flowable interval changes, which raise steady-state database polling.

### Ingestion pipeline client

:material-plus-circle:{ .om-additive }

`pipelineServiceClientConfiguration` gains `queuedStatusTimeoutSeconds` (default `3600`) — how long a
`queued` status stays visible before being treated as stale and hidden. Covers runs an orchestrator
accepted but never started.

---

## The 2.0.0 database migration

:material-alert:{ .om-behavioral } **Plan a maintenance window**

### New tables

| Table | Purpose |
|-------|---------|
| `task_entity`, `new_task_sequence`, `task_migration_mapping` | Task redesign |
| `task_form_schema_entity` | Task form schemas |
| `announcement_entity` | Standalone announcements |
| `activity_stream` (partitioned), `activity_stream_config` | Activity stream |
| `background_job_logs` | Background job logs |
| `search_index_job`, `search_index_retry_queue` | Distributed reindexing |
| `user_session` | DB-backed sessions |
| `user_preferences` | App-managed per-user preferences (no FK; cascade-deleted via `UserRepository#postDelete`) |
| `knowledge_center`, `drive_folder`, `context_file`, `context_file_content`, `context_memory`, `asset_entity` | Knowledge / Context Center + attachments |
| `ai_governance_framework_entity`, `ai_framework_control_entity`, `audit_report_entity` | AI Governance Studio |

### Altered tables

- `background_jobs` — adds `progress`, `total`, `result`, `error`, `message`, `cancelRequested`, `completedAt`
- `tag_usage` — adds `metadata JSON`
- `audit_log_event` — adds `search_text LONGTEXT`
- `thread_entity` → **renamed** to `thread_entity_legacy`

### Data migrations

| Step | Effect |
|------|--------|
| `migrateSuggestionsToTaskEntity` | `suggestions` → `task_entity` |
| `migrateThreadTasksToTaskEntity` | thread tasks → `task_entity` (+ `task_migration_mapping`) |
| `migrateLegacyActivityThreadsToActivityStream` | generated feed threads → `activity_stream` |
| Announcement `INSERT … SELECT` | `thread_entity` → `announcement_entity` |
| `backfillAnnouncementRelationships` | Announcement ↔ entity relationships |
| `backfillSearchRankingSettings` + `SearchIndexSettingsRepair` | Staged ranking config into `searchSettings` |
| `addTableColumnSearchSettings` | Column search settings |
| `migrateRdfIndexAppScheduleToWeekly` | RDF app cadence |
| `addTaskAuthorPolicyToDataConsumerRole` and three sibling policy steps | Task permissions |
| `TaskWorkflow.runTaskWorkflowCutoverMigration` / `addTaskResourceToMentionAlerts` / `runRecognizerFeedbackTaskTypeMigration` | Workflow + alert cutover |
| SQL rewrites | Databricks Pipeline `authType`, Snowflake/Databricks/UnityCatalog `policyAgentConfig`, Postgres `policyAgentConfig` removal, app runtime-field stripping, DataInsights `dataQuality` removal, McpApplication config removal, `AutoClassificationBotPolicy` Topic rule, `CvvRecognizer` regex anchor, stale `pipelineStatuses` cleanup |

### Index additions

Many, including `(deleted, name)` and `(deleted, serviceType)` composites on all 13 service tables
(for `/v1/services/overview`), `name` indexes on the new entity tables (so the distributed reindex
cursor runs index-only instead of a filesort that can exhaust sort memory on large tables), and
`idx_wf_instance_state_execution_id` on `workflow_instance_state_time_series`.

!!! warning "Index creation on large tables"
    On clusters with tens of millions of rows, the composite index creation on service and entity
    tables is the long pole of the migration. Size your maintenance window accordingly.

---

## Dependency and CVE updates

:material-plus-circle:{ .om-additive } — not breaking, but relevant to hardened deployments.

Backend: Jetty `12.1.7 → 12.1.10` (with `jetty-bom` imported so transitive modules follow),
Netty `4.1.137.Final`, BouncyCastle `1.85`, jackson-databind `2.18.8`, `tools.jackson` BOM `3.1.5`,
log4j `2.25.5`, libthrift/thrift `0.24.0`, reactor-netty-http `1.2.18`, tomcat-jdbc/juli `11.0.11`,
httpcore5 `5.4.3`, Redshift JDBC `2.1.0.30 → 2.2.2`, Kubernetes `client-java 25.0.1`,
Apache Airflow `3.3.0` on Python 3.12.

Frontend: `ws 8.21.0`, `handlebars 4.5.2`, `js-yaml 5.2.2`, `fast-uri 3.1.5`, `nanoid 3.3.17`,
`brace-expansion 1.1.18 / 5.0.9`.

Ingestion images: apt package trimming for gnutls, libcap, openssh, rsync, util-linux and the Go CVE
surface; `mlflow-skinny` and `pyarrow` bumped.

Other security fixes worth noting operationally:

- Test-connection workflow triggers are authorized.
- CSRF failures fail-secure and retry on the next request instead of permanently breaking.
- `POST .../testDestination` redacts destination config from the response.
- SCIM `displayName` sync is fixed (a bot-PUT guard was reverting it).
