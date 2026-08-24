---
title: OpenMetadata 2.0 Schema Change Inventory
description: Complete file-level inventory and compatibility summary for the OpenMetadata Standards 2.0.0 schema snapshot.
---

# OpenMetadata 2.0 Schema Change Inventory

This page records the complete schema synchronization used for OpenMetadata Standards 2.0.0.

## Provenance

| Item | Value |
|---|---|
| Upstream repository | [`open-metadata/OpenMetadata`](https://github.com/open-metadata/OpenMetadata) |
| Source branch | [`2.0`](https://github.com/open-metadata/OpenMetadata/tree/2.0/openmetadata-spec/src/main/resources/json/schema) |
| Release tag | [`2.0.0-release`](https://github.com/open-metadata/OpenMetadata/releases/tag/2.0.0-release) |
| Source commit | [`6861999f`](https://github.com/open-metadata/OpenMetadata/commit/6861999f332b75ce46c5f01b31b71c71168314ba) |
| Snapshot contents | 911 JSON Schema files |

The file inventory below compares the previous OpenMetadata Standards snapshot on `origin/main`
with the upstream 2.0.0 snapshot. It contains **98 added**, **135 modified**, and **3 removed**
schema files. The official OpenMetadata release comparison from
[`1.13.4-release` to `2.0.0-release`](https://github.com/open-metadata/OpenMetadata/compare/1.13.4-release...2.0.0-release)
contains **86 added**, **107 modified**, and **3 removed** schemas. The counts differ because the
previous standards snapshot predates schema updates that later shipped on the 1.13 patch line.

## Synchronization summary

| Area | Added | Modified | Removed |
|---|---:|---:|---:|
| API | 33 | 22 | 0 |
| Attachments | 1 | 0 | 0 |
| Configuration | 2 | 11 | 0 |
| Data Insight | 1 | 5 | 0 |
| Entity | 30 | 65 | 3 |
| Events | 0 | 2 | 0 |
| Governance | 3 | 3 | 0 |
| Jobs | 0 | 1 | 0 |
| Metadata Ingestion | 4 | 9 | 0 |
| Search | 0 | 1 | 0 |
| Security | 0 | 2 | 0 |
| Settings | 0 | 1 | 0 |
| System | 2 | 1 | 0 |
| Tests | 2 | 2 | 0 |
| Types | 20 | 10 | 0 |
| **Total** | **98** | **135** | **3** |

## Compatibility-sensitive schema changes

The following release-to-release changes can require client or configuration updates:

- Embedding-provider settings move from `elasticSearchConfiguration.naturalLanguageSearch` to the new top-level `llmConfiguration` schema.
- Databricks Pipeline connections remove the top-level `token` field and require the structured `authType` field.
- Search Indexing app configuration removes `recreateIndex` and `useDistributedIndexing`; Data Insights configuration removes its `dataQuality` module.
- Application `agentType` removes `CollateAI`, `CollateAITierAgent`, and `CollateAIQualityAgent`, together with their three configuration schemas.
- Entity, column, search-index field, schema field, and pipeline-task names reject `>`, double quotes, control characters, and empty pipeline-task names.
- Auto-classification now constrains `sampleDataCount` to at least 1 and `confidence` to the inclusive range 0–100.
- RDF indexing defaults change: entity batches 50→100, relationship-source batches 25→100, and inference defaults from enabled to disabled.
- Workflow async job acquisition changes from 10,000 ms to 1,000 ms.
- Data Insight chart function and KPI definitions move to `dataInsight/custom/chartFunctions.json`; regenerate code or update hand-written `$ref` resolution.

See [API & Schema Contracts](../breaking-changes/api.md) for migration guidance and the
[complete 1.13→2.0 guide](../breaking-changes/index.md) for behavioral and platform changes.

## Added schemas (98)

### API

- `api/ai/aiGovernanceActivityResponse.json`
- `api/ai/aiGovernanceBulkTriageRequest.json`
- `api/ai/aiGovernanceBulkTriageResponse.json`
- `api/ai/aiGovernanceDashboardResponse.json`
- `api/ai/aiGovernanceIntakeChecksResponse.json`
- `api/ai/aiGovernancePolicyStatusResponse.json`
- `api/ai/aiGovernancePolicyViolationsResponse.json`
- `api/ai/aiGovernanceTransitionRequest.json`
- `api/ai/createAIFrameworkControl.json`
- `api/ai/createAIGovernanceFramework.json`
- `api/ai/createAuditReport.json`
- `api/ai/forkAIGovernanceFrameworkRequest.json`
- `api/ai/forkAIGovernanceFrameworkResponse.json`
- `api/ai/frameworkCoverageResponse.json`
- `api/attachments/createAsset.json`
- `api/configuration/appConfiguration.json`
- `api/context/createContextMemory.json`
- `api/data/createContextFile.json`
- `api/data/createFolder.json`
- `api/data/createPage.json`
- `api/data/moveContextFileRequest.json`
- `api/feed/createAnnouncement.json`
- `api/governance/createIntakeForm.json`
- `api/lineage/hydrateLineageRequest.json`
- `api/lineage/hydrateLineageResponse.json`
- `api/services/servicesOverview.json`
- `api/tasks/bulkTaskOperation.json`
- `api/tasks/createTask.json`
- `api/tasks/createTaskComment.json`
- `api/tasks/resolveTask.json`
- `api/tasks/taskCount.json`
- `api/teams/preferences/appModePreference.json`
- `api/teams/userPreferences.json`

### Attachments

- `attachments/asset.json`

### Configuration

- `configuration/llmConfiguration.json`
- `configuration/sentryConfiguration.json`

### Data Insight

- `dataInsight/custom/chartFunctions.json`

### Entity

- `entity/activity/activityEvent.json`
- `entity/activity/activityStreamConfig.json`
- `entity/ai/aiFrameworkControl.json`
- `entity/ai/aiGovernanceFramework.json`
- `entity/ai/auditReport.json`
- `entity/applications/mcp/mcpToolCallUsage.json`
- `entity/context/contextMemory.json`
- `entity/data/article.json`
- `entity/data/contextFile.json`
- `entity/data/contextFileContent.json`
- `entity/data/folder.json`
- `entity/data/page.json`
- `entity/data/pageHierarchy.json`
- `entity/data/quickLink.json`
- `entity/domains/odps/odpsDataProduct.json`
- `entity/feed/announcement.json`
- `entity/feed/taskFormSchema.json`
- `entity/services/connections/dashboard/omniConnection.json`
- `entity/services/connections/dashboard/sapS4HanaConnection.json`
- `entity/services/connections/database/questdbConnection.json`
- `entity/services/connections/database/sapBw4HanaConnection.json`
- `entity/services/connections/database/sapSuccessFactorsConnection.json`
- `entity/services/connections/pipeline/prefect/cloudAuth.json`
- `entity/services/connections/pipeline/prefect/serverAuth.json`
- `entity/services/connections/pipeline/prefectConnection.json`
- `entity/services/connections/pipeline/sapBw4HanaPipelineConnection.json`
- `entity/services/ingestionPipelines/agentType.json`
- `entity/services/ingestionPipelines/logStreamEvent.json`
- `entity/services/ingestionPipelines/serviceProgressEvent.json`
- `entity/tasks/task.json`

### Governance

- `governance/intakeForm.json`
- `governance/workflows/elements/nodes/automatedTask/createAndRunAIAutomationTask.json`
- `governance/workflows/elements/nodes/automatedTask/policyAgentTaskDefinition.json`

### Metadata Ingestion

- `metadataIngestion/messagingServiceAutoClassificationPipeline.json`
- `metadataIngestion/policyAgentPipeline.json`
- `metadataIngestion/policyagentconfig/databasePolicyConfig.json`
- `metadataIngestion/storageServiceAutoClassificationPipeline.json`

### System

- `system/testLoginResult.json`
- `system/testLoginTokenRequest.json`

### Tests

- `tests/dataQualityReportBatchRequest.json`
- `tests/dataQualityReportBatchResponse.json`

### Types

- `type/aiContext.json`
- `type/bulkDeleteStaleRequest.json`
- `type/bulkTaskOperationResult.json`
- `type/dataAccessRequestPayload.json`
- `type/descriptionUpdatePayload.json`
- `type/domainUpdatePayload.json`
- `type/dynamicSamplingConfig.json`
- `type/genericTaskPayload.json`
- `type/glossaryApprovalPayload.json`
- `type/incidentResolutionPayload.json`
- `type/ownershipUpdatePayload.json`
- `type/personaContext.json`
- `type/personaContextDefinition.json`
- `type/reviewPayload.json`
- `type/samplingConfig.json`
- `type/staticSamplingConfig.json`
- `type/suggestionPayload.json`
- `type/tagUpdatePayload.json`
- `type/testCaseResolutionPayload.json`
- `type/tierUpdatePayload.json`

## Modified schemas (135)

### API

- `api/ai/createLLMModel.json`
- `api/bulkAssets.json`
- `api/configuration/rdfConfiguration.json`
- `api/createBot.json`
- `api/data/createGlossaryTerm.json`
- `api/data/createMetric.json`
- `api/domains/createDataProduct.json`
- `api/governance/createWorkflowDefinition.json`
- `api/lineage/entityCountLineageRequest.json`
- `api/lineage/openlineage/openLineageFacets.json`
- `api/lineage/searchLineageRequest.json`
- `api/search/previewSearchRequest.json`
- `api/services/createDashboardService.json`
- `api/services/createDatabaseService.json`
- `api/services/createDriveService.json`
- `api/services/createMessagingService.json`
- `api/services/createMlModelService.json`
- `api/services/createPipelineService.json`
- `api/services/createSearchService.json`
- `api/services/createStorageService.json`
- `api/teams/createPersona.json`
- `api/tests/createTestDefinition.json`

### Configuration

- `configuration/aiPlatformConfiguration.json`
- `configuration/authenticationConfiguration.json`
- `configuration/elasticSearchConfiguration.json`
- `configuration/glossaryTermRelationSettings.json`
- `configuration/ldapConfiguration.json`
- `configuration/logStorageConfiguration.json`
- `configuration/openLineageSettings.json`
- `configuration/pipelineServiceClientConfiguration.json`
- `configuration/searchSettings.json`
- `configuration/themeConfiguration.json`
- `configuration/workflowSettings.json`

### Data Insight

- `dataInsight/custom/dataInsightCustomChart.json`
- `dataInsight/custom/dataInsightCustomChartResultList.json`
- `dataInsight/custom/formulaHolder.json`
- `dataInsight/custom/lineChart.json`
- `dataInsight/custom/summaryCard.json`

### Entity

- `entity/ai/aiApplication.json`
- `entity/ai/llmModel.json`
- `entity/ai/mcpServer.json`
- `entity/applications/app.json`
- `entity/applications/configuration/applicationConfig.json`
- `entity/applications/configuration/external/metadataExporterConnectors/databricksConnection.json`
- `entity/applications/configuration/external/metadataExporterConnectors/snowflakeConnection.json`
- `entity/applications/configuration/internal/cacheWarmupAppConfig.json`
- `entity/applications/configuration/internal/dataInsightsAppConfig.json`
- `entity/applications/configuration/internal/rdfIndexingAppConfig.json`
- `entity/applications/configuration/internal/searchIndexingAppConfig.json`
- `entity/automations/queryRunnerRequest.json`
- `entity/automations/response/queryRunnerResponse.json`
- `entity/data/container.json`
- `entity/data/dashboardDataModel.json`
- `entity/data/database.json`
- `entity/data/databaseSchema.json`
- `entity/data/glossary.json`
- `entity/data/glossaryTerm.json`
- `entity/data/metric.json`
- `entity/data/pipeline.json`
- `entity/data/searchIndex.json`
- `entity/data/table.json`
- `entity/domains/dataProduct.json`
- `entity/policies/accessControl/resourceDescriptor.json`
- `entity/services/connections/connectionBasicType.json`
- `entity/services/connections/database/azureSQLConnection.json`
- `entity/services/connections/database/cockroachConnection.json`
- `entity/services/connections/database/databricksConnection.json`
- `entity/services/connections/database/exasolConnection.json`
- `entity/services/connections/database/greenplumConnection.json`
- `entity/services/connections/database/mssqlConnection.json`
- `entity/services/connections/database/mysqlConnection.json`
- `entity/services/connections/database/postgresConnection.json`
- `entity/services/connections/database/redshiftConnection.json`
- `entity/services/connections/database/snowflakeConnection.json`
- `entity/services/connections/database/synapseConnection.json`
- `entity/services/connections/database/timescaleConnection.json`
- `entity/services/connections/database/unityCatalogConnection.json`
- `entity/services/connections/drive/sftpConnection.json`
- `entity/services/connections/messaging/kafkaConnection.json`
- `entity/services/connections/messaging/kinesisConnection.json`
- `entity/services/connections/messaging/pubSubConnection.json`
- `entity/services/connections/messaging/redpandaConnection.json`
- `entity/services/connections/pipeline/databricksPipelineConnection.json`
- `entity/services/connections/pipeline/fivetranConnection.json`
- `entity/services/connections/pipeline/ssisConnection.json`
- `entity/services/connections/storage/adlsConnection.json`
- `entity/services/connections/storage/customStorageConnection.json`
- `entity/services/connections/storage/gcsConnection.json`
- `entity/services/connections/storage/s3Connection.json`
- `entity/services/connections/testConnectionDefinition.json`
- `entity/services/connections/testConnectionResult.json`
- `entity/services/dashboardService.json`
- `entity/services/databaseService.json`
- `entity/services/driveService.json`
- `entity/services/ingestionPipelines/ingestionPipeline.json`
- `entity/services/ingestionPipelines/pipelineServiceClientResponse.json`
- `entity/services/ingestionPipelines/progressUpdate.json`
- `entity/services/messagingService.json`
- `entity/services/mlmodelService.json`
- `entity/services/pipelineService.json`
- `entity/services/searchService.json`
- `entity/services/storageService.json`
- `entity/teams/persona.json`

### Events

- `events/filterResourceDescriptor.json`
- `events/subscriptionResourceDescriptor.json`

### Governance

- `governance/workflows/elements/nodeSubType.json`
- `governance/workflows/elements/nodes/userTask/userApprovalTask.json`
- `governance/workflows/workflowInstance.json`

### Jobs

- `jobs/backgroundJob.json`

### Metadata Ingestion

- `metadataIngestion/dashboardServiceMetadataPipeline.json`
- `metadataIngestion/databaseServiceAutoClassificationPipeline.json`
- `metadataIngestion/databaseServiceMetadataPipeline.json`
- `metadataIngestion/databaseServiceProfilerPipeline.json`
- `metadataIngestion/dbtPipeline.json`
- `metadataIngestion/dbtconfig/dbtHttpConfig.json`
- `metadataIngestion/pipelineServiceMetadataPipeline.json`
- `metadataIngestion/testSuitePipeline.json`
- `metadataIngestion/workflow.json`

### Search

- `search/searchRequest.json`

### Security

- `security/client/oktaSSOClientConfig.json`
- `security/credentials/gcpValues.json`

### Settings

- `settings/settings.json`

### System

- `system/eventPublisherJob.json`

### Tests

- `tests/testCase.json`
- `tests/testDefinition.json`

### Types

- `type/aiCompliance.json`
- `type/basic.json`
- `type/bulkOperationResult.json`
- `type/changeEvent.json`
- `type/changeEventType.json`
- `type/customProperty.json`
- `type/entityRelationship.json`
- `type/personaPreferences.json`
- `type/schema.json`
- `type/workflowTriggerFields.json`

## Removed schemas (3)

### Entity

- `entity/applications/configuration/external/collateAIQualityAgentAppConfig.json`
- `entity/applications/configuration/external/collateAITierAgentAppConfig.json`
- `entity/applications/configuration/private/internal/collateAITierAgentAppPrivateConfig.json`
