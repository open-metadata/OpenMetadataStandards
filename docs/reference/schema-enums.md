# Schema Enum Reference

This reference lists enum fields in the pinned 2.0.7 source schemas under `schemas/`. Values and defaults are taken directly from the schemas.

## analytics/basic.json

### definitions.webAnalyticEventType

event type

**Allowed values:**

- `PageView`
- `CustomEvent`

## analytics/reportData.json

### properties.reportDataType

Type of data

**Allowed values:**

- `entityReportData`
- `webAnalyticUserActivityReportData`
- `webAnalyticEntityViewReportData`
- `rawCostAnalysisReportData`
- `aggregatedCostAnalysisReportData`

## analytics/webAnalyticEventType/customEvent.json

### definitions.customEventTypes

Type of events that can be performed

**Allowed values:**

- `CLICK`

## api/ai/createAIGovernancePolicy.json

### properties.enforcementLevel

How strictly the policy is enforced

**Default:** `Warning`

**Allowed values:**

- `Advisory`
- `Warning`
- `Blocking`

## api/ai/createAgentExecution.json

### properties.environment

Environment where execution occurred

**Allowed values:**

- `Development`
- `Staging`
- `Production`

## api/ai/createLLMModel.json

### properties.governanceStatus

Governance status - tracks unauthorized/shadow AI models

**Allowed values:**

- `Approved`
- `PendingReview`
- `Rejected`
- `Unauthorized`

## api/ai/createPromptTemplate.json

### properties.templateType

Type of prompt template

**Allowed values:**

- `ChatCompletion`
- `TextGeneration`
- `CodeGeneration`
- `Embedding`
- `Classification`
- `Extraction`
- `Custom`

## api/ai/frameworkCoverageResponse.json

### definitions.frameworkControlCoverage.properties.status

Aggregated coverage status for this control.

**Allowed values:**

- `Met`
- `Partial`
- `Gap`

## api/classification/createClassification.json

### properties.autoClassificationConfig.properties.conflictResolution

Strategy for resolving conflicts when multiple tags match

**Default:** `highest_confidence`

**Allowed values:**

- `highest_confidence`
- `highest_priority`
- `most_specific`

## api/configuration/appConfiguration.json

### properties.defaultAppMode

Tenant-wide 'first impression' app-mode default. Seeds the app mode for users who have not chosen one; user preference and persona-level app mode still win over this default. Null means no tenant default is configured.

**Default:** `None`

**Allowed values:**

- `ai`
- `classic`
- `None`

## api/configuration/rdfConfiguration.json

### definitions.reasoningLevel

Level of reasoning/inference to apply to SPARQL queries

**Default:** `NONE`

**Allowed values:**

- `NONE`
- `RDFS`
- `OWL_LITE`
- `OWL_DL`
- `CUSTOM`

### properties.storageType

Type of RDF storage backend

**Default:** `FUSEKI`

**Allowed values:**

- `FUSEKI`
- `QLEVER`

## api/dataInsight/custom/createDataInsightCustomChart.json

### properties.chartType

Type of chart, used for UI to render the chart

**Allowed values:**

- `LineChart`
- `AreaChart`
- `BarChart`
- `SummaryCard`

## api/dataInsight/kpi/createKpiRequest.json

### properties.dataInsightChart

Fully qualified name of the Chart this kpi refers to

**Allowed values:**

- `percentage_of_data_asset_with_description_kpi`
- `percentage_of_data_asset_with_owner_kpi`
- `number_of_data_asset_with_description_kpi`
- `number_of_data_asset_with_owner_kpi`

## api/data/columnGridResponse.json

### definitions.metadataStatus

Metadata completeness status for a column or group of columns.

**Allowed values:**

- `MISSING` ? No description and no tags.
- `INCOMPLETE` ? Has description or tags, but not both.
- `INCONSISTENT` ? Metadata varies across occurrences (different descriptions, tags, or glossary terms).
- `COMPLETE` ? Has both description and tags, and is consistent across all occurrences.

## api/entityRelationship/entityRelationshipDirection.json

### (schema)

Entity Relationship Direction Schema.

**Allowed values:**

- `Upstream`
- `Downstream`

## api/learning/createLearningResource.json

### properties.status

**Default:** `Active`

**Allowed values:**

- `Draft`
- `Active`
- `Deprecated`

## api/lineage/lineageDirection.json

### (schema)

Lineage Direction Schema.

**Allowed values:**

- `Upstream`
- `Downstream`

## api/lineage/openlineage/openLineageResponse.json

### properties.status

Overall status of the request.

**Allowed values:**

- `success`
- `partial_success`
- `failure`

## api/lineage/openlineage/openLineageRunEvent.json

### definitions.eventType

The type of lifecycle event.

**Allowed values:**

- `START`
- `RUNNING`
- `COMPLETE`
- `ABORT`
- `FAIL`
- `OTHER`

## api/mcp/mcpToolDefinition.json

### definitions.toolParameter.properties

**Default:** `{'description': 'Default value for this parameter'}`

**Allowed values:**

- `description`
- `type`
- `items`

### definitions.toolParameter.properties.type

Type of parameter

**Allowed values:**

- `string`
- `number`
- `integer`
- `boolean`
- `array`
- `object`

## api/rdf/sparqlQuery.json

### properties.format

Response format for the query results

**Default:** `json`

**Allowed values:**

- `json`
- `xml`
- `csv`
- `tsv`
- `turtle`
- `rdfxml`
- `ntriples`
- `jsonld`

### properties.inference

Inference/reasoning level to apply

**Default:** `none`

**Allowed values:**

- `none`
- `rdfs`
- `owl`
- `custom`

## api/rdf/sparqlResponse.json

### properties.results.properties.bindings.items.additionalProperties.properties.type

**Allowed values:**

- `uri`
- `literal`
- `bnode`

## api/scim/scimPatchOp.json

### properties.Operations.items.properties.op

**Allowed values:**

- `add`
- `replace`
- `remove`

## api/search/previewSearchRequest.json

### properties.sortOrder

**Default:** `desc`

**Allowed values:**

- `asc`
- `desc`

## api/services/servicesOverview.json

### definitions.serviceHealth

Reduction of a service's ingestion pipelines to a single state, worst-wins: `failed` > `partialSuccess` > `success`. A service with no pipelines, or whose pipelines have only non-terminal states (queued/running/stopped), is `notRun`.

**Allowed values:**

- `failed`
- `partialSuccess`
- `success`
- `notRun`

## api/tasks/bulkTaskOperation.json

### definitions.bulkOperation

Type of bulk operation.

**Allowed values:**

- `Approve`
- `Reject`
- `Assign`
- `UpdatePriority`
- `Cancel`

## api/teams/createUser.json

### properties.createPasswordType

User Password Method

**Default:** `USER_CREATE`

**Allowed values:**

- `ADMIN_CREATE`
- `USER_CREATE`

## api/teams/preferences/appModePreference.json

### properties.type

**Allowed values:**

- `appMode`

### properties.config.properties.value

**Allowed values:**

- `ai`
- `classic`
- `None`

## api/tests/bundleSuiteBulkAddRequest.json

### properties.mode

Mode of bulk addition. 'ids' to specify exact test suite IDs, 'all' to select all suites with optional exclusions.

**Allowed values:**

- `ids`
- `all`

## attachments/asset.json

### definitions.assetType

This schema defines the type used for describing different types of Attachments.

**Default:** `Inline`

**Allowed values:**

- `Inline`
- `External`

## auth/changePasswordRequest.json

### properties.requestType

Name of the column in a table.

**Default:** `SELF`

**Allowed values:**

- `SELF`
- `USER`

## auth/emailVerificationToken.json

### definitions.tokenType

Different Type of User token

**Allowed values:**

- `REFRESH_TOKEN`
- `EMAIL_VERIFICATION`
- `PASSWORD_RESET`
- `PERSONAL_ACCESS_TOKEN`
- `SUPPORT_TOKEN`

### properties.tokenStatus

Refresh Count

**Allowed values:**

- `STATUS_PENDING`
- `STATUS_CONFIRMED`

## auth/jwtAuth.json

### definitions.JWTTokenExpiry

JWT Auth Token expiration in days

**Allowed values:**

- `OneHour`
- `1`
- `7`
- `30`
- `60`
- `90`
- `Unlimited`

## auth/serviceTokenEnum.json

### (schema)

Different Type of OpenMetadata Service tokens

**Allowed values:**

- `BOT`
- `OM_USER`
- `PERSONAL_ACCESS`

## auth/ssoAuth.json

### properties.ssoServiceType

Type of database service such as Amundsen, Atlas...

**Allowed values:**

- `google`
- `okta`
- `auth0`
- `custom-oidc`
- `azure`

## configuration/authenticationConfiguration.json

### definitions.responseType

Response Type

**Default:** `id_token`

**Allowed values:**

- `id_token`
- `code`

### properties.clientType

Client Type

**Default:** `public`

**Allowed values:**

- `public`
- `confidential`

### properties.tokenValidationAlgorithm

Token Validation Algorithm to use.

**Default:** `RS256`

**Allowed values:**

- `RS256`
- `RS384`
- `RS512`
- `ES256`
- `ES384`
- `ES512`

### allOf[2].if.allOf[0].properties.provider

**Allowed values:**

- `google`
- `azure`
- `okta`
- `auth0`
- `aws-cognito`
- `custom-oidc`

### allOf[3].if.allOf[0].properties.provider

**Allowed values:**

- `google`
- `azure`
- `okta`
- `auth0`
- `aws-cognito`
- `custom-oidc`

## configuration/elasticSearchConfiguration.json

### definitions.searchIndexMappingLanguage

This schema defines the language options available for search index mappings.

**Default:** `EN`

**Allowed values:**

- `EN`
- `JP`
- `ZH`
- `RU`

### properties.searchType

This enum defines the search Type elastic/open search.

**Default:** `elasticsearch`

**Allowed values:**

- `elasticsearch`
- `opensearch`

## configuration/glossaryTermRelationSettings.json

### definitions.relationCategory

Category of the relation type.

**Allowed values:**

- `hierarchical`
- `associative`
- `equivalence`

### definitions.relationCardinality

Preset cardinality for term-to-term relations.

**Allowed values:**

- `ONE_TO_ONE`
- `ONE_TO_MANY`
- `MANY_TO_ONE`
- `MANY_TO_MANY`
- `CUSTOM`

## configuration/kafkaEventConfiguration.json

### properties.securityProtocol

Kafka security protocol config

**Default:** `PLAINTEXT`

**Allowed values:**

- `PLAINTEXT`
- `SSL`

## configuration/ldapConfiguration.json

### properties.truststoreConfigType

Truststore Type e.g. TrustAll, HostName, JVMDefault, CustomTrustStore.

**Allowed values:**

- `TrustAll`
- `JVMDefault`
- `HostName`
- `CustomTrustStore`

## configuration/lineageSettings.json

### definitions.lineageLayer

Lineage Layers

**Default:** `EntityLineage`

**Allowed values:**

- `EntityLineage`
- `ColumnLevelLineage`
- `DataObservability`

### definitions.pipelineViewMode

Determines the view mode for pipelines in lineage.

**Default:** `Node`

**Allowed values:**

- `Edge`
- `Node`

## configuration/llmConfiguration.json

### definitions.llmProvider

Supported LLM completion providers.

**Default:** `noop`

**Allowed values:**

- `bedrock`
- `openai`
- `azureOpenAI`
- `google`
- `anthropic`
- `noop`

### properties.embeddings.properties.provider

Embedding provider to use for semantic search vectors.

**Default:** `bedrock`

**Allowed values:**

- `bedrock`
- `openai`
- `google`
- `djl`

## configuration/logStorageConfiguration.json

### properties.type

Type of log storage implementation

**Default:** `default`

**Allowed values:**

- `default`
- `s3`

### properties.sseAlgorithm

Server-side encryption algorithm (if applicable)

**Allowed values:**

- `AES256`
- `aws:kms`

### properties.storageClass

S3 storage class for log objects

**Default:** `STANDARD_IA`

**Allowed values:**

- `STANDARD`
- `STANDARD_IA`
- `ONEZONE_IA`
- `INTELLIGENT_TIERING`
- `GLACIER`
- `DEEP_ARCHIVE`

## configuration/openLineageConfiguration.json

### properties.eventTypeFilter.items

**Allowed values:**

- `START`
- `RUNNING`
- `COMPLETE`
- `ABORT`
- `FAIL`
- `OTHER`

## configuration/openLineageSettings.json

### properties.eventTypeFilter.items

**Allowed values:**

- `START`
- `RUNNING`
- `COMPLETE`
- `ABORT`
- `FAIL`
- `OTHER`

### properties.ownershipUpdateMode

Set how owners from OpenLineage job ownership facets update Pipeline owners. In replace mode, resolved owners from the current event replace existing owners. In append mode, resolved owners are appended to active existing Pipeline owners.

**Default:** `replace`

**Allowed values:**

- `replace`
- `append`

## configuration/profilerConfiguration.json

### definitions.metricType

This schema defines all possible metric types in OpenMetadata.

**Allowed values:**

- `mean`
- `valuesCount`
- `countInSet`
- `columnCount`
- `distinctCount`
- `distinctProportion`
- `iLikeCount`
- `likeCount`
- `notLikeCount`
- `regexCount`
- `notRegexCount`
- `max`
- `maxLength`
- `min`
- `minLength`
- `nullCount`
- `rowCount`
- `stddev`
- `sum`
- `uniqueCount`
- `uniqueProportion`
- `columnNames`
- `duplicateCount`
- `iLikeRatio`
- `likeRatio`
- `nullProportion`
- `interQuartileRange`
- `nonParametricSkew`
- `median`
- `firstQuartile`
- `thirdQuartile`
- `system`
- `histogram`
- `cardinalityDistribution`
- `valueRank`
- `nullMissingCount`

## configuration/searchSettings.json

### definitions.assetTypeConfiguration.properties.scoreMode

How to combine function scores if multiple boosts are applied.

**Allowed values:**

- `multiply`
- `sum`
- `avg`
- `first`
- `max`
- `min`

### definitions.assetTypeConfiguration.properties.boostMode

How the function score is combined with the main query score.

**Allowed values:**

- `multiply`
- `replace`
- `sum`
- `avg`
- `max`
- `min`

### definitions.rankingStage.properties.matchType

Query strategy for this ranking stage.

**Default:** `standard`

**Allowed values:**

- `exact`
- `phrase`
- `prefix`
- `tokenCoverage`
- `standard`
- `fuzzy`

### definitions.rankingSignals.properties.scoreMode

How to combine metadata signal functions.

**Default:** `sum`

**Allowed values:**

- `multiply`
- `sum`
- `avg`
- `first`
- `max`
- `min`

### definitions.rankingSignals.properties.boostMode

How metadata signals combine with the lexical score.

**Default:** `sum`

**Allowed values:**

- `multiply`
- `replace`
- `sum`
- `avg`
- `max`
- `min`

### definitions.fieldBoost.properties.matchType

Type of matching to use for this field. 'exact' uses term query for .keyword fields, 'phrase' uses match_phrase, 'fuzzy' allows fuzzy matching, 'standard' uses the default behavior.

**Default:** `standard`

**Allowed values:**

- `exact`
- `phrase`
- `fuzzy`
- `standard`

### definitions.fieldValueBoost.properties.modifier

Optional mathematical transformation to apply to the field value.

**Allowed values:**

- `none`
- `log`
- `log1p`
- `log2p`
- `ln`
- `ln1p`
- `ln2p`
- `square`
- `sqrt`
- `reciprocal`

### definitions.aggregation.properties.type

The type of aggregation to perform.

**Allowed values:**

- `terms`
- `range`
- `histogram`
- `date_histogram`
- `filters`
- `missing`
- `nested`
- `reverse_nested`
- `top_hits`
- `max`
- `min`
- `avg`
- `sum`
- `stats`

## dataInsight/custom/chartFunctions.json

### definitions.function

aggregation function for chart

**Allowed values:**

- `count`
- `sum`
- `avg`
- `min`
- `max`
- `unique`

## dataInsight/custom/dataAssetType.json

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

## dataInsight/custom/dataInsightCustomChart.json

### properties.chartType

Type of chart, used for UI to render the chart

**Allowed values:**

- `LineChart`
- `AreaChart`
- `BarChart`
- `SummaryCard`

## dataInsight/custom/lineChart.json

### properties.type

Type of the data insight chart.

**Default:** `LineChart`

**Allowed values:**

- `LineChart`

## dataInsight/custom/summaryCard.json

### properties.type

Type of the data insight chart.

**Default:** `SummaryCard`

**Allowed values:**

- `SummaryCard`

## dataInsight/dataInsightChart.json

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

## dataInsight/dataInsightChartResult.json

### definitions.dataInsightChartType

chart type. Must match `name` of a `dataInsightChartDefinition`.

**Allowed values:**

- `DailyActiveUsers`
- `MostActiveUsers`
- `MostViewedEntities`
- `PageViewsByEntities`
- `UnusedAssets`
- `AggregatedUnusedAssetsSize`
- `AggregatedUnusedAssetsCount`
- `AggregatedUsedVsUnusedAssetsSize`
- `AggregatedUsedVsUnusedAssetsCount`

## dataInsight/kpi/basic.json

### definitions.kpiTargetType

This enum defines the type of key Result

**Allowed values:**

- `NUMBER`
- `PERCENTAGE`

## email/emailRequest.json

### properties.contentType

**Default:** `plain`

**Allowed values:**

- `plain`
- `html`

## email/smtpSettings.json

### properties.transportationStrategy

**Default:** `SMTP`

**Allowed values:**

- `SMTP`
- `SMTPS`
- `SMTP_TLS`

### properties.templates

**Default:** `openmetadata`

**Allowed values:**

- `openmetadata`
- `collate`

## entity/activity/activityEvent.json

### definitions.activityEventType

Type of activity event.

**Allowed values:**

- `EntityCreated`
- `EntityUpdated`
- `EntityDeleted`
- `EntitySoftDeleted`
- `EntityRestored`
- `DescriptionUpdated`
- `TagsUpdated`
- `OwnerUpdated`
- `DomainUpdated`
- `TierUpdated`
- `CustomPropertyUpdated`
- `ColumnDescriptionUpdated`
- `ColumnTagsUpdated`
- `TestCaseStatusChanged`
- `PipelineStatusChanged`

## entity/activity/activityStreamConfig.json

### definitions.activityStreamScope

Scope of the activity stream configuration.

**Default:** `domain`

**Allowed values:**

- `global`
- `domain`

### definitions.activityStreamVisibility

Who can see activity events.

**Default:** `domainOnly`

**Allowed values:**

- `domainOnly`
- `organization`

## entity/ai/agentExecution.json

### definitions.executionStatus

**Allowed values:**

- `Running`
- `Success`
- `Failed`
- `Timeout`
- `Cancelled`
- `PartialSuccess`

### definitions.dataAccess.properties.accessType

Type of access

**Allowed values:**

- `Read`
- `Write`
- `Update`
- `Delete`

### definitions.dataAccess.properties.sensitivityLevel

**Allowed values:**

- `Public`
- `Internal`
- `Confidential`
- `Restricted`

### definitions.complianceCheck.properties.severity

**Allowed values:**

- `Low`
- `Medium`
- `High`
- `Critical`

### properties.environment

Environment where execution occurred

**Allowed values:**

- `Development`
- `Staging`
- `Production`

## entity/ai/aiApplication.json

### definitions.applicationType

Type of AI application based on primary function and interaction pattern

**Allowed values:**

- `Chatbot`
- `Agent`
- `Copilot`
- `Assistant`
- `RAG`
- `CodeGenerator`
- `DataAnalyst`
- `AutomationBot`
- `MultiAgent`
- `Custom`

### definitions.developmentStage

Development stage of the AI application. 'Unauthorized' indicates Shadow AI that needs governance review.

**Allowed values:**

- `Proposal`
- `Development`
- `Testing`
- `Staging`
- `Production`
- `Deprecated`
- `Unauthorized`

### definitions.modelConfiguration.properties.purpose

Purpose of this model in the application workflow

**Allowed values:**

- `Primary`
- `Reasoning`
- `Embedding`
- `CodeGeneration`
- `Fallback`
- `CostOptimization`

### definitions.governanceMetadata.properties.registrationStatus

Registration status - used to track Shadow AI

**Allowed values:**

- `Registered`
- `Unregistered`
- `PendingApproval`
- `Approved`
- `Rejected`

### definitions.governanceMetadata.properties.riskAssessment.properties.riskLevel

**Allowed values:**

- `Low`
- `Medium`
- `High`
- `Critical`

### definitions.frameworkInfo.properties.name

**Allowed values:**

- `LangChain`
- `LlamaIndex`
- `AutoGen`
- `CrewAI`
- `Semantic Kernel`
- `Haystack`
- `Custom`

### definitions.frameworkInfo.properties.language

**Allowed values:**

- `Python`
- `TypeScript`
- `JavaScript`
- `Java`
- `C#`
- `Go`

## entity/ai/aiFrameworkControl.json

### definitions.controlCategory

**Allowed values:**

- `Risk`
- `Process`
- `Data`
- `Transparency`
- `Quality`
- `Governance`

## entity/ai/aiGovernanceFramework.json

### definitions.frameworkSource

Where the framework definition came from

**Allowed values:**

- `BuiltIn`
- `Custom`
- `ForkedFrom`

### definitions.assessmentCadence

How often this framework requires reassessment of in-scope assets

**Allowed values:**

- `Monthly`
- `Quarterly`
- `SemiAnnual`
- `Annual`

## entity/ai/aiGovernancePolicy.json

### definitions.policyType

**Allowed values:**

- `ModelApproval`
- `DataAccess`
- `BiasThreshold`
- `ComplianceCheck`
- `CostControl`
- `PerformanceStandard`
- `SecurityControl`

### definitions.policyRule.properties.ruleType

Type of rule

**Allowed values:**

- `Threshold`
- `Approval`
- `Prohibition`
- `Requirement`
- `Notification`

### definitions.policyRule.properties.action

Action to take when rule is triggered

**Allowed values:**

- `Block`
- `Warn`
- `Notify`
- `Require_Approval`
- `Log`

### definitions.policyRule.properties.severity

**Allowed values:**

- `Low`
- `Medium`
- `High`
- `Critical`

### definitions.biasThreshold.properties.evaluationFrequency

How often to evaluate bias

**Allowed values:**

- `Continuous`
- `Daily`
- `Weekly`
- `Monthly`
- `OnDemand`

### definitions.dataAccessControl.properties.maxSensitivityLevel

Maximum data sensitivity level allowed

**Allowed values:**

- `Public`
- `Internal`
- `Confidential`
- `Restricted`

### definitions.complianceRequirement.properties.standard

Compliance standard

**Allowed values:**

- `GDPR`
- `HIPAA`
- `SOC2`
- `ISO27001`
- `NIST_AI_RMF`
- `EU_AI_Act`
- `OWASP_LLM_Top10`
- `Custom`

### definitions.complianceRequirement.properties.auditFrequency

**Allowed values:**

- `Continuous`
- `Weekly`
- `Monthly`
- `Quarterly`
- `Annually`

### properties.enforcementLevel

How strictly to enforce this policy

**Default:** `Warning`

**Allowed values:**

- `Advisory`
- `Warning`
- `Blocking`

## entity/ai/auditReport.json

### definitions.reportScope

Breadth of the audit pack

**Allowed values:**

- `Estate`
- `Domain`
- `Asset`

### definitions.reportFormat

Artifact format(s) to generate

**Allowed values:**

- `Json`
- `Pdf`
- `Both`

### definitions.reportStatus

Current state of the audit pack job

**Allowed values:**

- `Queued`
- `Running`
- `Completed`
- `Failed`
- `Cancelled`

## entity/ai/llmModel.json

### definitions.modelType

Type of LLM model

**Allowed values:**

- `BaseModel`
- `FineTuned`
- `Quantized`
- `Distilled`
- `Adapter`
- `Custom`

### definitions.modelCapability

**Allowed values:**

- `TextGeneration`
- `CodeGeneration`
- `Embeddings`
- `Chat`
- `Vision`
- `Audio`
- `FunctionCalling`
- `ToolUse`

### definitions.trainingMetadata.properties.trainingType

**Allowed values:**

- `FullFineTune`
- `LoRA`
- `QLoRA`
- `PrefixTuning`
- `PromptTuning`
- `RLHF`

### definitions.trainingMetadata.properties.dataLineage.items.properties.sensitivityLevel

**Allowed values:**

- `Public`
- `Internal`
- `Confidential`
- `Restricted`

### definitions.deploymentInfo.properties.deploymentType

**Allowed values:**

- `API`
- `SelfHosted`
- `Hybrid`
- `OnPremise`

### properties.governanceStatus

Governance status - tracks unauthorized/shadow AI models

**Allowed values:**

- `Approved`
- `PendingReview`
- `Rejected`
- `Unauthorized`

## entity/ai/mcpExecution.json

### definitions.executionStatus

Status of the MCP execution

**Allowed values:**

- `Running`
- `Success`
- `Failed`
- `Timeout`
- `Cancelled`

### definitions.accessType

Type of data access

**Allowed values:**

- `Read`
- `Write`
- `Delete`

### definitions.sensitivityLevel

Sensitivity level of data accessed

**Allowed values:**

- `Public`
- `Internal`
- `Confidential`
- `Restricted`

### definitions.complianceSeverity

Severity level for compliance checks

**Allowed values:**

- `Info`
- `Warning`
- `Error`
- `Critical`

### properties.environment

Environment where execution occurred

**Allowed values:**

- `Development`
- `Testing`
- `Staging`
- `Production`

## entity/ai/mcpServer.json

### definitions.serverType

Type of MCP server based on its primary function

**Allowed values:**

- `DataAccess`
- `FileSystem`
- `WebAPI`
- `Database`
- `Cloud`
- `Security`
- `Development`
- `Communication`
- `Custom`

### definitions.transportType

Transport protocol used by the MCP server

**Allowed values:**

- `Stdio`
- `SSE`
- `StreamableHTTP`

### definitions.developmentStage

Development stage of the MCP server. 'Unauthorized' indicates Shadow AI that needs governance review.

**Allowed values:**

- `Proposal`
- `Development`
- `Testing`
- `Staging`
- `Production`
- `Deprecated`
- `Unauthorized`

### definitions.governanceMetadata.properties.registrationStatus

Registration status - used to track Shadow AI

**Allowed values:**

- `Registered`
- `Unregistered`
- `PendingApproval`
- `Approved`
- `Rejected`

### definitions.governanceMetadata.properties.riskAssessment.properties.riskLevel

**Allowed values:**

- `Low`
- `Medium`
- `High`
- `Critical`

### definitions.dataAccessSummary.properties.accessPatterns.items

**Allowed values:**

- `Read`
- `Write`
- `Execute`

### definitions.dataAccessSummary.properties.sensitivityLevel

Highest sensitivity level of data accessed

**Allowed values:**

- `Public`
- `Internal`
- `Confidential`
- `Restricted`

### definitions.toolCategory

Category of the MCP tool based on its primary function

**Allowed values:**

- `FileOperation`
- `WebOperation`
- `DataOperation`
- `DatabaseOperation`
- `SystemOperation`
- `SecurityOperation`
- `CommunicationOperation`
- `CodeOperation`
- `SearchOperation`
- `Custom`

### definitions.riskLevel

Risk level based on capabilities and data access

**Allowed values:**

- `Low`
- `Medium`
- `High`
- `Critical`

### definitions.sensitivityLevel

Sensitivity level of data

**Allowed values:**

- `Public`
- `Internal`
- `Confidential`
- `Restricted`

### definitions.resourceType

Type of MCP resource

**Allowed values:**

- `File`
- `Directory`
- `URL`
- `Database`
- `API`
- `Blob`
- `Stream`
- `Document`
- `Custom`

### definitions.mcpResource.properties.accessLevel

**Allowed values:**

- `ReadOnly`
- `ReadWrite`
- `Full`

### definitions.promptType

Type of MCP prompt

**Allowed values:**

- `Analysis`
- `Generation`
- `Transformation`
- `Validation`
- `Query`
- `Summarization`
- `Extraction`
- `Classification`
- `Custom`

### definitions.promptArgument.properties

**Default:** `{'description': 'Default value'}`

**Allowed values:**

- `type`
- `description`

### definitions.promptArgument.properties.type

**Allowed values:**

- `String`
- `Number`
- `Boolean`
- `Array`
- `Object`

### definitions.promptMessage.properties.role

**Allowed values:**

- `user`
- `assistant`
- `system`

## entity/ai/promptTemplate.json

### definitions.templateVariable.properties.dataType

Expected data type for this variable

**Allowed values:**

- `String`
- `Number`
- `Boolean`
- `Array`
- `Object`

### properties.templateType

Type of prompt template

**Allowed values:**

- `ChatCompletion`
- `TextGeneration`
- `CodeGeneration`
- `Embedding`
- `Classification`
- `Extraction`
- `Custom`

## entity/applications/app.json

### definitions.scheduleType

This schema defines the type of application.

**Allowed values:**

- `Live` ? An app that has other trigger mechanisms.
- `Scheduled` ? An app that has a schedule and cannot be run manually.
- `ScheduledOrManual` ? An app that has a schedule and can be run manually.
- `NoSchedule` ? An app that has no schedule and cannot be run manually.
- `OnlyManual` ? An app that has no schedule but can be run manually.

### definitions.scheduleTimeline

This schema defines the Application ScheduleTimeline Options

**Default:** `Weekly`

**Allowed values:**

- `Hourly`
- `Daily`
- `Weekly`
- `Monthly`
- `Custom`
- `None`

### definitions.appType

This schema defines the type of application.

**Allowed values:**

- `internal`
- `external`

### definitions.agentType

This schema defines the type of application.

**Allowed values:**

- `Metadata`

### definitions.permissions

This schema defines the Permission used by Native Application.

**Allowed values:**

- `All`

## entity/applications/appExtension.json

### definitions.extensionType

Extension type.

**Allowed values:**

- `status`
- `limits`
- `custom`

## entity/applications/appRunRecord.json

### properties.status

Status for the Job.

**Allowed values:**

- `started`
- `running`
- `completed`
- `failed`
- `active`
- `activeError`
- `stopped`
- `stopInProgress`
- `success`
- `pending`

## entity/applications/configuration/external/automatorAppConfig.json

### definitions.automatorAppType

Application type.

**Default:** `Automator`

**Allowed values:**

- `Automator`

## entity/applications/configuration/external/automator/addCustomProperties.json

### definitions.AddCustomPropertiesActionType

Add Custom Properties Action Type.

**Default:** `AddCustomPropertiesAction`

**Allowed values:**

- `AddCustomPropertiesAction`

## entity/applications/configuration/external/automator/addDataProductAction.json

### definitions.AddDataProductActionType

Add Data Products Action Type.

**Default:** `AddDataProductAction`

**Allowed values:**

- `AddDataProductAction`

## entity/applications/configuration/external/automator/addDescriptionAction.json

### definitions.addDescriptionActionType

Add Description Action Type.

**Default:** `AddDescriptionAction`

**Allowed values:**

- `AddDescriptionAction`

## entity/applications/configuration/external/automator/addDomainAction.json

### definitions.addDomainActionType

Add Domain Action Type.

**Default:** `AddDomainAction`

**Allowed values:**

- `AddDomainAction`

## entity/applications/configuration/external/automator/addOwnerAction.json

### definitions.addOwnerActionType

Add Owner Action Type.

**Default:** `AddOwnerAction`

**Allowed values:**

- `AddOwnerAction`

## entity/applications/configuration/external/automator/addTagsAction.json

### definitions.addTagsActionType

Add Tags action type.

**Default:** `AddTagsAction`

**Allowed values:**

- `AddTagsAction`

## entity/applications/configuration/external/automator/addTermsAction.json

### definitions.addTermsActionType

Add Terms action type.

**Default:** `AddTermsAction`

**Allowed values:**

- `AddTermsAction`

## entity/applications/configuration/external/automator/addTestCaseAction.json

### definitions.addTestCaseActionType

Add Test Case Action Type.

**Default:** `AddTestCaseAction`

**Allowed values:**

- `AddTestCaseAction`

## entity/applications/configuration/external/automator/addTierAction.json

### definitions.addTierActionType

Add Tier Action Type.

**Default:** `AddTierAction`

**Allowed values:**

- `AddTierAction`

## entity/applications/configuration/external/automator/lineagePropagationAction.json

### definitions.lineagePropagationActionType

Lineage propagation action type.

**Default:** `LineagePropagationAction`

**Allowed values:**

- `LineagePropagationAction`

### properties.propagationFilterMode

Determines how the filter selects entities. 'SOURCE' (default): filtered entities push their metadata downstream to all discovered entities via lineage. 'TARGET': filtered entities receive metadata from upstream lineage.

**Default:** `SOURCE`

**Allowed values:**

- `TARGET`
- `SOURCE`

### properties.propagationDepthMode

Mode for calculating propagation depth. 'ROOT' calculates depth from root nodes (sources with no parents). 'DATA_ASSET' calculates depth relative to each data asset being processed, ensuring each asset only receives metadata from nodes within the specified number of hops upstream.

**Default:** `ROOT`

**Allowed values:**

- `ROOT`
- `DATA_ASSET`

## entity/applications/configuration/external/automator/mlTaggingAction.json

### definitions.mlTaggingActionType

ML PII Tagging action type.

**Default:** `MLTaggingAction`

**Allowed values:**

- `MLTaggingAction`

## entity/applications/configuration/external/automator/propagationStopConfig.json

### properties.metadataAttribute

The metadata attribute to check for stopping propagation

**Allowed values:**

- `description`
- `tags`
- `glossaryTerms`
- `owner`
- `tier`
- `domains`

## entity/applications/configuration/external/automator/removeCustomPropertiesAction.json

### definitions.removeCustomPropertiesActionType

Remove Custom Properties Action Type.

**Default:** `RemoveCustomPropertiesAction`

**Allowed values:**

- `RemoveCustomPropertiesAction`

## entity/applications/configuration/external/automator/removeDataProductAction.json

### definitions.RemoveDataProductActionType

Remove Data Products Action Type.

**Default:** `RemoveDataProductAction`

**Allowed values:**

- `RemoveDataProductAction`

## entity/applications/configuration/external/automator/removeDescriptionAction.json

### definitions.removeDescriptionActionType

Remove Description Action Type

**Default:** `RemoveDescriptionAction`

**Allowed values:**

- `RemoveDescriptionAction`

## entity/applications/configuration/external/automator/removeDomainAction.json

### definitions.removeDomainActionType

Remove Domain Action Type

**Default:** `RemoveDomainAction`

**Allowed values:**

- `RemoveDomainAction`

## entity/applications/configuration/external/automator/removeOwnerAction.json

### definitions.removeOwnerActionType

Remove Owner Action Type

**Default:** `RemoveOwnerAction`

**Allowed values:**

- `RemoveOwnerAction`

## entity/applications/configuration/external/automator/removeTagsAction.json

### definitions.removeTagsActionType

Remove Classification Tags Action Type.

**Default:** `RemoveTagsAction`

**Allowed values:**

- `RemoveTagsAction`

### definitions.labelType

Remove tags by its label type

**Allowed values:**

- `Manual`
- `Propagated`
- `Automated`

## entity/applications/configuration/external/automator/removeTermsAction.json

### definitions.removeTermsActionType

Remove Terms Action Type.

**Default:** `RemoveTermsAction`

**Allowed values:**

- `RemoveTermsAction`

### definitions.labelType

Remove terms by its label type

**Allowed values:**

- `Manual`
- `Propagated`
- `Automated`

## entity/applications/configuration/external/automator/removeTestCaseAction.json

### definitions.removeTestCaseActionType

Remove Test Case Action Type

**Default:** `RemoveTestCaseAction`

**Allowed values:**

- `RemoveTestCaseAction`

## entity/applications/configuration/external/automator/removeTierAction.json

### definitions.removeTierActionType

Remove Tier Action Type

**Default:** `RemoveTierAction`

**Allowed values:**

- `RemoveTierAction`

## entity/applications/configuration/external/collateAIAppConfig.json

### definitions.collateAIAppType

Application type.

**Default:** `CollateAI`

**Allowed values:**

- `CollateAI`

## entity/applications/configuration/external/metadataExporterAppConfig.json

### definitions.metadataExporterAppType

Application type.

**Default:** `MetadataExporter`

**Allowed values:**

- `MetadataExporter`

### definitions.exportRangeConfig.properties.rangeType

Type of range for data export.

**Default:** `ALL`

**Allowed values:**

- `ALL`
- `LATEST`
- `DATE_RANGE`

### definitions.exportRangeConfig.properties.unit

Unit of time for the export range.

**Allowed values:**

- `DAYS`
- `HOURS`

### properties.eventTypes.items

**Allowed values:**

- `PROFILE`
- `TEST_CASE_RESULTS`
- `ENTITY_HISTORY`

## entity/applications/configuration/external/metadataExporterConnectors/bigQueryConnection.json

### definitions.bigqueryType

Service type.

**Default:** `BigQuery`

**Allowed values:**

- `BigQuery`

### definitions.bigqueryScheme

SQLAlchemy driver scheme options.

**Default:** `bigquery`

**Allowed values:**

- `bigquery`

## entity/applications/configuration/external/metadataExporterConnectors/databricksConnection.json

### definitions.databricksType

Service type.

**Default:** `Databricks`

**Allowed values:**

- `Databricks`

### definitions.databricksScheme

SQLAlchemy driver scheme options.

**Default:** `databricks`

**Allowed values:**

- `databricks`

## entity/applications/configuration/external/metadataExporterConnectors/redshiftConnection.json

### definitions.redshiftType

Service type.

**Default:** `Redshift`

**Allowed values:**

- `Redshift`

### definitions.redshiftScheme

SQLAlchemy driver scheme options.

**Default:** `redshift+psycopg2`

**Allowed values:**

- `redshift+psycopg2`

## entity/applications/configuration/external/metadataExporterConnectors/snowflakeConnection.json

### definitions.snowflakeType

Service type.

**Default:** `Snowflake`

**Allowed values:**

- `Snowflake`

### definitions.snowflakeScheme

SQLAlchemy driver scheme options.

**Default:** `snowflake`

**Allowed values:**

- `snowflake`

## entity/applications/configuration/external/metadataExporterConnectors/trinoConnection.json

### definitions.trinoType

Service type.

**Default:** `Trino`

**Allowed values:**

- `Trino`

### definitions.trinoScheme

SQLAlchemy driver scheme options.

**Default:** `trino`

**Allowed values:**

- `trino`

## entity/applications/configuration/internal/autoPilotAppConfig.json

### definitions.autoPilotAppType

Application type.

**Default:** `AutoPilotApplication`

**Allowed values:**

- `AutoPilotApplication`

## entity/applications/configuration/internal/cacheWarmupAppConfig.json

### definitions.cacheWarmupType

Application type.

**Default:** `CacheWarmup`

**Allowed values:**

- `CacheWarmup`

## entity/applications/configuration/internal/dataInsightsAppConfig.json

### definitions.dataInsightsAppType

Application Type

**Default:** `DataInsights`

**Allowed values:**

- `DataInsights`

## entity/applications/configuration/internal/dataInsightsReportAppConfig.json

### definitions.dataInsightsReportAppType

Application type.

**Default:** `DataInsightsReport`

**Allowed values:**

- `DataInsightsReport`

## entity/applications/configuration/internal/rdfIndexingAppConfig.json

### definitions.rdfIndexingType

Application type.

**Default:** `RdfIndexing`

**Allowed values:**

- `RdfIndexing`

### properties.entities.items

**Allowed values:**

- `aiApplication`
- `aiGovernancePolicy`
- `apiCollection`
- `apiEndpoint`
- `apiService`
- `app`
- `appMarketPlaceDefinition`
- `bot`
- `chart`
- `classification`
- `container`
- `dashboard`
- `dashboardDataModel`
- `dashboardService`
- `dataContract`
- `dataInsightChart`
- `dataInsightCustomChart`
- `dataProduct`
- `database`
- `databaseSchema`
- `databaseService`
- `directory`
- `document`
- `domain`
- `driveService`
- `eventsubscription`
- `file`
- `glossary`
- `glossaryTerm`
- `ingestionPipeline`
- `kpi`
- `learningResource`
- `llmModel`
- `llmService`
- `messagingService`
- `metadataService`
- `metric`
- `mlmodel`
- `mlmodelService`
- `notificationTemplate`
- `persona`
- `pipeline`
- `pipelineService`
- `policy`
- `promptTemplate`
- `query`
- `report`
- `role`
- `searchIndex`
- `searchService`
- `securityService`
- `spreadsheet`
- `storageService`
- `storedProcedure`
- `table`
- `tag`
- `team`
- `testCase`
- `testConnectionDefinition`
- `testDefinition`
- `testSuite`
- `topic`
- `type`
- `user`
- `webAnalyticEvent`
- `workflow`
- `workflowDefinition`
- `worksheet`

## entity/applications/configuration/internal/searchIndexingAppConfig.json

### definitions.searchIndexingType

Application type.

**Default:** `SearchIndexing`

**Allowed values:**

- `SearchIndexing`

## entity/applications/mcp/mcpToolCallUsage.json

### definitions.errorCategory

Coarse bucket for failed tool invocations. Drives the 'Failed' tile subtext and the errorByCategory aggregate on the redesigned Billing > MCP page.

**Allowed values:**

- `AUTH`
- `RATE_LIMIT`
- `VALIDATION`
- `TIMEOUT`
- `INTERNAL`
- `OTHER`

## entity/automations/queryRunnerRequest.json

### properties.credentialSourceType

Source type of the resolved credentials. Indicates whether the credentials come from a user-level config or a team-level config. Set by the backend during credential resolution.

**Default:** `user`

**Allowed values:**

- `user`
- `team`

## entity/automations/response/queryRunnerResponse.json

### definitions.statusType

Enum defining possible Query Runner status

**Allowed values:**

- `Successful`
- `Failed`
- `Running`

## entity/automations/workflow.json

### definitions.workflowType

This enum defines the type for which this workflow applies to.

**Allowed values:**

- `TEST_CONNECTION`
- `REVERSE_INGESTION`
- `QUERY_RUNNER`
- `TEST_SPARK_ENGINE_CONNECTION`

### definitions.workflowStatus

Enum defining possible Workflow status

**Allowed values:**

- `Pending`
- `Successful`
- `Failed`
- `Running`

## entity/classification/classification.json

### properties.autoClassificationConfig.properties.conflictResolution

Strategy for resolving conflicts when multiple tags match

**Default:** `highest_confidence`

**Allowed values:**

- `highest_confidence`
- `highest_priority`
- `most_specific`

## entity/context/contextMemory.json

### definitions.memoryType

High-level type of reusable memory.

**Default:** `Note`

**Allowed values:**

- `Preference`
- `UseCase`
- `Note`
- `Runbook`
- `Faq`

### definitions.memoryScope

Scope where the memory should be applied.

**Default:** `EntityScoped`

**Allowed values:**

- `UserGlobal`
- `EntityScoped`

### definitions.memoryStatus

Lifecycle state of the memory. Any status may be set at creation (e.g. importing an already-archived memory); the Draft -> Active -> Archived transition rules are only enforced on subsequent updates.

**Default:** `Active`

**Allowed values:**

- `Draft`
- `Active`
- `Archived`

### definitions.sourceType

How the memory was created.

**Default:** `Manual`

**Allowed values:**

- `Manual`
- `ChatPromotion`
- `RememberRequest`
- `FileExtraction`
- `PageExtraction`

### definitions.shareVisibility

Visibility level for the memory.

**Default:** `Private`

**Allowed values:**

- `Private`
- `Entity`
- `Shared`

### definitions.shareRole

Role granted to a shared principal.

**Default:** `Viewer`

**Allowed values:**

- `Viewer`
- `Editor`

### definitions.machineRepresentationStatus

Availability state of the machine-oriented representation.

**Default:** `Pending`

**Allowed values:**

- `Pending`
- `Ready`
- `Stale`
- `Failed`

### definitions.memoryProcessingStatus

Lifecycle status of the asynchronous Memory Agent derivation for a memory.

**Allowed values:**

- `Queued`
- `Processing`
- `Processed`
- `Failed`

## entity/data/apiEndpoint.json

### definitions.apiRequestMethod

This schema defines the Request Method type for APIs .

**Default:** `GET`

**Allowed values:**

- `GET`
- `POST`
- `PUT`
- `PATCH`
- `DELETE`
- `HEAD`
- `CONNECT`
- `OPTIONS`
- `TRACE`

## entity/data/chart.json

### definitions.chartType

This schema defines the type used for describing different types of charts.

**Allowed values:**

- `Line`
- `Table`
- `Bar`
- `Area`
- `Pie`
- `Histogram`
- `Scatter`
- `Text`
- `BoxPlot`
- `SanKey`
- `Gauge`
- `Map`
- `Graph`
- `Heatmap`
- `Timeline`
- `Other`

## entity/data/container.json

### definitions.fileFormat

This schema defines the file formats for the object/files within a container.

**Allowed values:**

- `zip`
- `gz`
- `zstd`
- `csv`
- `tsv`
- `json`
- `parquet`
- `avro`
- `MF4`

## entity/data/contextFile.json

### definitions.fileType

Type of file based on content.

**Allowed values:**

- `PDF`
- `Spreadsheet`
- `Presentation`
- `Image`
- `Document`
- `CSV`
- `Text`
- `Archive`
- `Other`

### definitions.processingStatus

Processing state of the file after upload.

**Default:** `Uploaded`

**Allowed values:**

- `Uploaded`
- `Analyzing`
- `ExtractingContext`
- `Processed`
- `Failed`
- `Unsupported`

### definitions.sourceType

How this file was added to the drive.

**Default:** `Upload`

**Allowed values:**

- `Upload`
- `DriveSync`
- `Confluence`
- `Notion`

## entity/data/dashboard.json

### definitions.dashboardType

This schema defines the type used for describing different types of dashboards.

**Default:** `Dashboard`

**Allowed values:**

- `Dashboard`
- `Report`

## entity/data/dashboardDataModel.json

### definitions.dataModelType

This schema defines the type used for describing different types of data models.

**Allowed values:**

- `TableauDataModel`
- `TableauPublishedDatasource`
- `TableauEmbeddedDatasource`
- `SupersetDataModel`
- `MetabaseDataModel`
- `ModeDataModel`
- `LookMlView`
- `LookMlExplore`
- `PowerBIDataModel`
- `QlikDataModel`
- `QuickSightDataModel`
- `SigmaDataModel`
- `PowerBIDataFlow`
- `PowerBIDatamart`
- `MicroStrategyDataset`
- `ThoughtSpotDataModel`
- `SapS4HanaCdsView`
- `SsrsDataModel`
- `OmniDataModel`

## entity/data/dataContract.json

### definitions.contractStatus

Status of the data contract.

**Allowed values:**

- `Draft`
- `Active`
- `Deprecated`

### definitions.contractSLA.properties.refreshFrequency.properties.unit

**Allowed values:**

- `hour`
- `day`
- `week`
- `month`
- `year`

### definitions.contractSLA.properties.maxLatency.properties.unit

**Allowed values:**

- `minute`
- `hour`
- `day`

### definitions.contractSLA.properties.timezone

Timezone for the availability time. UTC by default.

**Default:** `GMT+00:00 (Europe/London)`

**Allowed values:**

- `GMT-11:00 (Pacific/Niue)`
- `GMT-10:00 (Pacific/Honolulu)`
- `GMT-09:30 (Pacific/Marquesas)`
- `GMT-09:00 (America/Anchorage)`
- `GMT-08:00 (America/Los Angeles)`
- `GMT-07:00 (America/Denver)`
- `GMT-06:00 (America/Chicago)`
- `GMT-05:00 (America/New York)`
- `GMT-04:00 (America/Santiago)`
- `GMT-03:00 (America/Sao Paulo)`
- `GMT-02:30 (Atlantic/Newfoundland)`
- `GMT-02:00 (Atlantic/South_Georgia)`
- `GMT-01:00 (Atlantic/Azores)`
- `GMT+00:00 (Europe/London)`
- `GMT+01:00 (Europe/Paris)`
- `GMT+02:00 (Europe/Athens)`
- `GMT+03:00 (Europe/Moscow)`
- `GMT+03:00 (Asia/Iran)`
- `GMT+04:00 (Asia/Dubai)`
- `GMT+04:30 (Asia/Afghanistan)`
- `GMT+05:00 (Asia/Karachi)`
- `GMT+05:30 (Asia/Kolkata)`
- `GMT+05:45 (Asia/Nepal)`
- `GMT+06:00 (Asia/Dhaka)`
- `GMT+06:00 (Asia/Myanmar)`
- `GMT+07:00 (Asia/Bangkok)`
- `GMT+08:00 (Asia/Shanghai)`
- `GMT+08:45 (Australia/Australian Central Western Standard Time)`
- `GMT+09:00 (Asia/Tokyo)`
- `GMT+09:00 (Australia/Adelaide)`
- `GMT+10:00 (Australia/Sydney)`
- `GMT+10:30 (Australia/Lord Howe)`
- `GMT+11:00 (Pacific/Norfolk)`
- `GMT+12:00 (Pacific/Auckland)`
- `GMT+13:00 (Pacific/Tongatapu)`
- `GMT+14:00 (Pacific/Kiritimati)`

### definitions.contractSLA.properties.retention.properties.unit

**Allowed values:**

- `day`
- `week`
- `month`
- `year`

## entity/data/directory.json

### definitions.directoryType

Type of directory

**Allowed values:**

- `Root`
- `MyDrive`
- `SharedDrive`
- `TeamDrive`
- `Folder`
- `SharePointSite`
- `SharePointLibrary`

## entity/data/file.json

### definitions.fileType

Type of file based on content

**Allowed values:**

- `Document`
- `Spreadsheet`
- `Presentation`
- `Image`
- `Video`
- `Audio`
- `PDF`
- `Archive`
- `Code`
- `Data`
- `CSV`
- `Text`
- `Other`

## entity/data/glossaryTerm.json

### definitions.conceptMappingType

Type of mapping used to align this term with an external concept.

**Allowed values:**

- `EXACT_MATCH`
- `CLOSE_MATCH`
- `BROAD_MATCH`
- `NARROW_MATCH`
- `RELATED_MATCH`
- `SAME_AS`

## entity/data/metric.json

### definitions.metricExpression.properties.language

This schema defines the type of the language used for Metric Expression Code.

**Allowed values:**

- `SQL`
- `Java`
- `JavaScript`
- `Python`
- `External`

### definitions.metricType

This schema defines the type of Metric.

**Allowed values:**

- `COUNT`
- `SUM`
- `AVERAGE`
- `RATIO`
- `PERCENTAGE`
- `MIN`
- `MAX`
- `MEDIAN`
- `MODE`
- `STANDARD_DEVIATION`
- `VARIANCE`
- `SIMPLE`
- `CUMULATIVE`
- `DERIVED`
- `CONVERSION`
- `OTHER`

### definitions.unitOfMeasurement

This schema defines the type of Metric's unit of measurement.

**Allowed values:**

- `COUNT`
- `DOLLARS`
- `PERCENTAGE`
- `TIMESTAMP`
- `SIZE`
- `REQUESTS`
- `EVENTS`
- `TRANSACTIONS`
- `OTHER`

### definitions.metricGranularity

This schema defines the type of Metric's granularity.

**Allowed values:**

- `SECOND`
- `MINUTE`
- `HOUR`
- `DAY`
- `WEEK`
- `MONTH`
- `QUARTER`
- `YEAR`

### definitions.metricDimension.properties.type

Type of the dimension.

**Allowed values:**

- `CATEGORICAL`
- `TIME`

## entity/data/mlmodel.json

### definitions.featureType

This enum defines the type of data stored in a ML Feature.

**Allowed values:**

- `numerical`
- `categorical`

### definitions.featureSourceDataType

This enum defines the type of data of a ML Feature source.

**Allowed values:**

- `integer`
- `number`
- `string`
- `array`
- `date`
- `timestamp`
- `object`
- `boolean`

## entity/data/page.json

### definitions.pageType

Type of the Knowledge Page.

**Allowed values:**

- `Article`
- `QuickLink`

### definitions.pageProcessingStatus

Status of the asynchronous knowledge-pill extraction for an article's body. Distinct from the governance entityStatus.

**Allowed values:**

- `Queued`
- `Processing`
- `Processed`
- `Failed`

## entity/data/pipeline.json

### definitions.statusType

Enum defining the possible Status.

**Allowed values:**

- `Successful`
- `Failed`
- `Pending`
- `Skipped`

### definitions.pipelineState

Enum defining the possible Pipeline State.

**Allowed values:**

- `Active`
- `Inactive`

### definitions.taskStatus.properties.transformationType

Type of transformation

**Allowed values:**

- `filter`
- `aggregate`
- `join`
- `pivot`
- `custom`
- `extract`
- `load`

### definitions.datasetGeneration.properties.mode

Write mode

**Allowed values:**

- `overwrite`
- `append`
- `merge`
- `upsert`

## entity/data/searchIndex.json

### definitions.indexType

Whether the entity is index or index template.

**Default:** `Index`

**Allowed values:**

- `Index`
- `IndexTemplate`

### definitions.dataType

This enum defines the type of data stored in a searchIndex.

**Allowed values:**

- `NUMBER`
- `TEXT`
- `BINARY`
- `TIMESTAMP`
- `TIMESTAMPZ`
- `TIME`
- `DATE`
- `DATETIME`
- `KEYWORD`
- `ARRAY`
- `OBJECT`
- `FLATTENED`
- `NESTED`
- `JOIN`
- `RANGE`
- `IP`
- `VERSION`
- `MURMUR3`
- `AGGREGATE_METRIC_DOUBLE`
- `HISTOGRAM`
- `ANNOTATED-TEXT`
- `COMPLETION`
- `SEARCH_AS_YOU_TYPE`
- `DENSE_VECTOR`
- `RANK_FEATURE`
- `RANK_FEATURES`
- `GEO_POINT`
- `GEO_SHAPE`
- `POINT`
- `SHAPE`
- `PERCOLATOR`
- `BOOLEAN`
- `CONSTANT_KEYWORD`
- `WILDCARD`
- `LONG`
- `INTEGER`
- `SHORT`
- `BYTE`
- `DOUBLE`
- `FLOAT`
- `HALF_FLOAT`
- `SCALED_FLOAT`
- `UNSIGNED_LONG`
- `UNKNOWN`

## entity/data/spreadsheet.json

### definitions.spreadsheetMimeType

MIME type for spreadsheet files

**Allowed values:**

- `application/vnd.google-apps.spreadsheet`
- `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`
- `application/vnd.ms-excel`
- `application/vnd.oasis.opendocument.spreadsheet`
- `text/csv`
- `text/tab-separated-values`
- `Other`

## entity/data/storedProcedure.json

### definitions.storedProcedureType

This schema defines the type of the type of Procedures

**Default:** `StoredProcedure`

**Allowed values:**

- `StoredProcedure`
- `UDF`
- `StoredPackage`
- `Function`

### definitions.storedProcedureCode.properties.language

This schema defines the type of the language used for Stored Procedure's Code.

**Allowed values:**

- `SQL`
- `Java`
- `JavaScript`
- `Python`
- `External`

## entity/data/table.json

### definitions.tableType

This schema defines the type used for describing different types of tables.

**Allowed values:**

- `Regular`
- `External`
- `Dynamic`
- `View`
- `SecureView`
- `MaterializedView`
- `Iceberg`
- `Local`
- `Partitioned`
- `Foreign`
- `Transient`
- `Stream`
- `Stage`
- `SemanticView`

### definitions.dataType

This enum defines the type of data stored in a column.

**Allowed values:**

- `NUMBER`
- `TINYINT`
- `SMALLINT`
- `INT`
- `BIGINT`
- `BYTEINT`
- `BYTES`
- `FLOAT`
- `DOUBLE`
- `DECIMAL`
- `NUMERIC`
- `TIMESTAMP`
- `TIMESTAMPZ`
- `TIME`
- `DATE`
- `DATETIME`
- `INTERVAL`
- `STRING`
- `MEDIUMTEXT`
- `TEXT`
- `CHAR`
- `LONG`
- `VARCHAR`
- `BOOLEAN`
- `BINARY`
- `VARBINARY`
- `ARRAY`
- `BLOB`
- `LONGBLOB`
- `MEDIUMBLOB`
- `MAP`
- `STRUCT`
- `UNION`
- `SET`
- `GEOGRAPHY`
- `ENUM`
- `JSON`
- `UUID`
- `VARIANT`
- `GEOMETRY`
- `BYTEA`
- `AGGREGATEFUNCTION`
- `ERROR`
- `FIXED`
- `RECORD`
- `NULL`
- `SUPER`
- `HLLSKETCH`
- `PG_LSN`
- `PG_SNAPSHOT`
- `TSQUERY`
- `TXID_SNAPSHOT`
- `XML`
- `MACADDR`
- `TSVECTOR`
- `UNKNOWN`
- `CIDR`
- `INET`
- `CLOB`
- `ROWID`
- `LOWCARDINALITY`
- `YEAR`
- `POINT`
- `POLYGON`
- `TUPLE`
- `SPATIAL`
- `TABLE`
- `NTEXT`
- `IMAGE`
- `IPV4`
- `IPV6`
- `DATETIMERANGE`
- `HLL`
- `LARGEINT`
- `QUANTILE_STATE`
- `AGG_STATE`
- `BITMAP`
- `UINT`
- `BIT`
- `MONEY`
- `MEASURE HIDDEN`
- `MEASURE VISIBLE`
- `MEASURE`
- `KPI`
- `HEIRARCHY`
- `HIERARCHYID`

### definitions.constraint

This enum defines the type for column constraint.

**Default:** `None`

**Allowed values:**

- `NULL`
- `NOT_NULL`
- `UNIQUE`
- `PRIMARY_KEY`

### definitions.tableConstraint.properties.constraintType

**Allowed values:**

- `UNIQUE`
- `PRIMARY_KEY`
- `FOREIGN_KEY`
- `SORT_KEY`
- `DIST_KEY`
- `CLUSTER_KEY`

### definitions.tableConstraint.properties.relationshipType

**Allowed values:**

- `ONE_TO_ONE`
- `ONE_TO_MANY`
- `MANY_TO_ONE`
- `MANY_TO_MANY`

### definitions.partitionIntervalTypes

type of partition interval

**Allowed values:**

- `TIME-UNIT`
- `INTEGER-RANGE`
- `INGESTION-TIME`
- `COLUMN-VALUE`
- `INJECTED`
- `ENUM`
- `OTHER`

### definitions.dmlOperationType

This schema defines the type of DML operation.

**Allowed values:**

- `UPDATE`
- `INSERT`
- `DELETE`
- `WRITE`

### definitions.partitionProfilerConfig.properties.partitionIntervalUnit

unit used for the partition interval

**Allowed values:**

- `YEAR`
- `MONTH`
- `DAY`
- `HOUR`

### definitions.modelType

**Allowed values:**

- `DBT`
- `DDL`

### definitions.fileFormat

File format in case of file/datalake tables.

**Allowed values:**

- `csv`
- `csv.gz`
- `tsv`
- `avro`
- `parquet`
- `pq`
- `pqt`
- `parq`
- `parquet.snappy`
- `json`
- `json.gz`
- `json.zip`
- `jsonl`
- `jsonl.gz`
- `jsonl.zip`
- `MF4`

### properties.compressionStrategy.properties.compressionType

Type of compression: AUTOMATIC (Snowflake/BigQuery), MANUAL (Redshift), POLICY_BASED (TimescaleDB)

**Default:** `None`

**Allowed values:**

- `AUTOMATIC`
- `MANUAL`
- `POLICY_BASED`

## entity/data/topic.json

### definitions.cleanupPolicy

Topic clean up policy. For Kafka - `cleanup.policy` configuration.

**Allowed values:**

- `delete`
- `compact`

## entity/datacontract/odcs/odcsDataContract.json

### definitions.odcsApiVersion

ODCS API version.

**Default:** `v3.1.0`

**Allowed values:**

- `v3.1.0`
- `v3.0.2`
- `v3.0.1`
- `v3.0.0`
- `v2.2.2`
- `v2.2.1`
- `v2.2.0`

### definitions.odcsKind

Kind of ODCS document.

**Default:** `DataContract`

**Allowed values:**

- `DataContract`

### definitions.odcsStatus

Status of the ODCS data contract.

**Allowed values:**

- `proposed`
- `draft`
- `active`
- `deprecated`
- `retired`

### definitions.odcsSchemaElement.properties.logicalType

Logical data type per ODCS v3.1.0 spec.

**Allowed values:**

- `string`
- `text`
- `date`
- `timestamp`
- `time`
- `number`
- `integer`
- `decimal`
- `float`
- `double`
- `long`
- `object`
- `array`
- `boolean`
- `bytes`
- `null`

### definitions.odcsQualityRule.properties.type

Quality rule type.

**Default:** `library`

**Allowed values:**

- `text`
- `library`
- `sql`
- `custom`

### definitions.odcsQualityRule.properties.dimension

KPI classification.

**Allowed values:**

- `accuracy`
- `completeness`
- `conformity`
- `consistency`
- `coverage`
- `timeliness`
- `uniqueness`
- `ac`
- `cp`
- `cf`
- `cs`
- `cv`
- `tm`
- `uq`

### definitions.odcsQualityMetric

Standard quality metrics library supported by ODCS 3.1.0.

**Allowed values:**

- `rowCount`
- `nullValues`
- `invalidValues`
- `duplicateValues`
- `missingValues`
- `uniqueValues`
- `distinctValues`
- `completeness`
- `freshness`

### definitions.odcsSupportChannel.properties.tool

Channel tool type.

**Allowed values:**

- `email`
- `slack`
- `teams`
- `discord`
- `ticket`
- `other`

### definitions.odcsSupportChannel.properties.scope

Channel scope.

**Allowed values:**

- `interactive`
- `announcements`
- `issues`

### definitions.odcsRole.properties.access

Access type.

**Allowed values:**

- `read`
- `write`
- `readWrite`

### definitions.odcsSlaProperty.properties.driver

SLA driver.

**Allowed values:**

- `regulatory`
- `analytics`
- `operational`

### definitions.odcsServer.properties.environment

Environment type.

**Allowed values:**

- `prod`
- `preprod`
- `dev`
- `uat`

## entity/domains/dataProduct.json

### definitions.lifecycleStage

Lifecycle stage of the data product

**Default:** `DEVELOPMENT`

**Allowed values:**

- `IDEATION`
- `DESIGN`
- `DEVELOPMENT`
- `TESTING`
- `PRODUCTION`
- `DEPRECATED`
- `RETIRED`

### definitions.dataProductType

Type of the data product, aligned with the Open Data Product Standard (ODPS) v4.1 type taxonomy.

**Allowed values:**

- `RAW_DATA`
- `DERIVED_DATA`
- `DATASET`
- `REPORTS`
- `ANALYTIC_VIEW`
- `VISUALISATION_3D`
- `ALGORITHM`
- `DECISION_SUPPORT`
- `AUTOMATED_DECISION_MAKING`
- `DATA_ENHANCED_PRODUCT`
- `DATA_DRIVEN_SERVICE`
- `DATA_ENABLED_PERFORMANCE`
- `BI_DIRECTIONAL`

### definitions.visibility

Visibility level of the data product. Controls who can discover and access this data product. Promotion to more open levels (e.g., ORGANISATION, PUBLIC) should go through the governance workflow.

**Default:** `PRIVATE`

**Allowed values:**

- `PRIVATE`
- `INVITATION`
- `ORGANISATION`
- `DATASPACE`
- `PUBLIC`

### definitions.portfolioPriority

Portfolio-level priority of this data product, indicating its importance in the organization's data product portfolio.

**Allowed values:**

- `CRITICAL`
- `HIGH`
- `MEDIUM`
- `LOW`

### definitions.portType

Type of the data product port

**Allowed values:**

- `INPUT`
- `OUTPUT`

### definitions.portProtocol

Protocol used by the port for data access

**Default:** `REST`

**Allowed values:**

- `REST`
- `GRPC`
- `GRAPHQL`
- `JDBC`
- `KAFKA`
- `FILE`
- `S3`
- `AZURE_BLOB`
- `GCS`
- `WEBHOOK`
- `CUSTOM`

### definitions.portFormat

Data format supported by the port

**Default:** `JSON`

**Allowed values:**

- `JSON`
- `CSV`
- `PARQUET`
- `AVRO`
- `ORC`
- `XML`
- `PROTOBUF`
- `DELTA`
- `ICEBERG`
- `CUSTOM`

### definitions.slaDefinition.properties.tier

SLA tier (e.g., GOLD, SILVER, BRONZE)

**Allowed values:**

- `GOLD`
- `SILVER`
- `BRONZE`
- `CUSTOM`

## entity/domains/domain.json

### definitions.domainType

Type of a domain

**Allowed values:**

- `Source-aligned`
- `Consumer-aligned`
- `Aggregate`

## entity/domains/odps/odpsDataProduct.json

### definitions.odpsApiVersion

ODPS specification version.

**Default:** `4.1`

**Allowed values:**

- `4.1`
- `4.0`

### definitions.odpsVisibility

Visibility level of the data product per ODPS v4.1.

**Allowed values:**

- `private`
- `invitation`
- `organisation`
- `dataspace`
- `public`

### definitions.odpsStatus

Lifecycle status of the data product per ODPS v4.1.

**Allowed values:**

- `announcement`
- `draft`
- `development`
- `testing`
- `acceptance`
- `production`
- `sunset`
- `retired`

### definitions.odpsType

Type of the data product per ODPS v4.1 taxonomy.

**Allowed values:**

- `raw data`
- `derived data`
- `dataset`
- `reports`
- `analytic view`
- `3D visualisation`
- `algorithm`
- `decision support`
- `automated decision-making`
- `data-enhanced product`
- `data-driven service`
- `data-enabled performance`
- `bi-directional`

### definitions.odpsPortfolioPriority

Portfolio-level priority of the data product.

**Allowed values:**

- `critical`
- `high`
- `medium`
- `low`

### definitions.odpsGovernanceProfile

Governance maturity level of the data product per ODPS v4.1.

**Allowed values:**

- `structured`
- `enforced`
- `automated`
- `audit_ready`

## entity/events/authentication/webhookBearerAuth.json

### properties.type

Authentication type discriminator.

**Default:** `bearer`

**Allowed values:**

- `bearer`

## entity/events/authentication/webhookNoAuth.json

### properties.type

Authentication type discriminator.

**Default:** `none`

**Allowed values:**

- `none`

## entity/events/authentication/webhookOAuth2Config.json

### properties.type

Authentication type discriminator.

**Default:** `oauth2`

**Allowed values:**

- `oauth2`

## entity/events/webhook.json

### properties.httpMethod

HTTP operation to send the webhook request. Supports POST or PUT.

**Default:** `POST`

**Allowed values:**

- `POST`
- `PUT`

## entity/feed/announcement.json

### definitions.announcementStatus

Status of the announcement based on its time window.

**Allowed values:**

- `Active`
- `Expired`
- `Scheduled`

## entity/feed/suggestion.json

### definitions.suggestionType

Type of a Suggestion.

**Allowed values:**

- `SuggestDescription`
- `SuggestTagLabel`

### definitions.suggestionStatus

Status of a Suggestion.

**Default:** `Open`

**Allowed values:**

- `Open`
- `Accepted`
- `Rejected`

## entity/feed/thread.json

### definitions.taskType

Type of a task.

**Allowed values:**

- `RequestDescription`
- `UpdateDescription`
- `RequestTag`
- `UpdateTag`
- `RequestApproval`
- `RequestTestCaseFailureResolution`
- `RecognizerFeedbackApproval`
- `Generic`

### definitions.threadTaskStatus

Status of a task.

**Default:** `Open`

**Allowed values:**

- `Open`
- `Closed`

### definitions.threadType

Type of thread.

**Default:** `Conversation`

**Allowed values:**

- `Conversation`
- `Task`
- `Announcement`
- `Chatbot`

### properties.generatedBy

User or team that generated the thread.

**Default:** `user`

**Allowed values:**

- `user`
- `system`

### properties.cardStyle

Card style for the thread.

**Default:** `default`

**Allowed values:**

- `default`
- `logicalTestCaseAdded`
- `entityCreated`
- `entityDeleted`
- `entitySoftDeleted`
- `description`
- `tags`
- `owner`
- `testCaseResult`
- `customProperties`
- `assets`
- `domain`

### properties.fieldOperation

Operation on thread, whether the field was added, or updated or deleted.

**Default:** `updated`

**Allowed values:**

- `added`
- `updated`
- `deleted`
- `none`

## entity/learning/learningResource.json

### definitions.resourceType

Kind of learning asset represented.

**Allowed values:**

- `Storylane`
- `Video`
- `Article`

### definitions.resourceCategory

Primary topic grouping for the resource.

**Allowed values:**

- `Discovery`
- `Administration`
- `DataGovernance`
- `DataQuality`
- `Observability`
- `AI`

### definitions.resourceDifficulty

Suggested proficiency tier for the resource.

**Allowed values:**

- `Intro`
- `Intermediate`
- `Advanced`

### properties.status

Lifecycle state for controllable publishing.

**Default:** `Active`

**Allowed values:**

- `Draft`
- `Active`
- `Deprecated`

## entity/policies/accessControl/resourceDescriptor.json

### definitions.operation

This schema defines all possible operations on metadata of entities in OpenMetadata.

**Allowed values:**

- `All`
- `Create`
- `BulkCreate`
- `CreateIngestionPipelineAutomator`
- `CreateTests`
- `Delete`
- `ViewAll`
- `ViewBasic`
- `ViewUsage`
- `ViewTests`
- `ViewQueries`
- `ViewDataProfile`
- `ViewProfilerGlobalConfiguration`
- `ViewSampleData`
- `ViewTestCaseFailedRowsSample`
- `ViewCustomFields`
- `EditAll`
- `BulkUpdate`
- `EditCustomFields`
- `EditDataProfile`
- `EditDescription`
- `EditDisplayName`
- `EditDomains`
- `EditLineage`
- `EditEntityRelationship`
- `EditPolicy`
- `EditOwners`
- `EditQueries`
- `EditReviewers`
- `EditRole`
- `EditSampleData`
- `EditStatus`
- `EditTags`
- `EditGlossaryTerms`
- `EditTeams`
- `EditTier`
- `EditCertification`
- `CreateTask`
- `EditTask`
- `EditTests`
- `EditUsage`
- `EditUsers`
- `EditLifeCycle`
- `EditKnowledgePanel`
- `EditPage`
- `EditIngestionPipelineStatus`
- `EditUserNotificationTemplate`
- `DeleteTestCaseFailedRowsSample`
- `Deploy`
- `Trigger`
- `Kill`
- `GenerateToken`
- `EditScim`
- `CreateScim`
- `DeleteScim`
- `ViewScim`
- `Impersonate`
- `AuditLogs`
- `ViewTestDefinitionLibrary`
- `EditTestDefinitionLibrary`
- `ResolveTask`
- `CloseTask`
- `ReassignTask`

## entity/policies/accessControl/resourcePermission.json

### definitions.permission.properties.access

Access decided after evaluating rules in a policy. Note the access is defined in the order of precedence.

**Allowed values:**

- `deny`
- `allow`
- `conditionalDeny`
- `conditionalAllow`
- `notAllow`

## entity/policies/accessControl/rule.json

### properties.effect

**Allowed values:**

- `allow`
- `deny`

## entity/services/apiService.json

### definitions.apiServiceType

Type of api service such as REST, Webhook,...

**Allowed values:**

- `Rest`
- `WEBHOOK`

## entity/services/connections/api/restConnection.json

### definitions.restType

REST API type

**Default:** `Rest`

**Allowed values:**

- `Rest`

## entity/services/connections/dashboard/customDashboardConnection.json

### definitions.customDashboardType

Custom dashboard service type

**Default:** `CustomDashboard`

**Allowed values:**

- `CustomDashboard`

## entity/services/connections/dashboard/domoDashboardConnection.json

### definitions.domoDashboardType

 service type

**Default:** `DomoDashboard`

**Allowed values:**

- `DomoDashboard`

## entity/services/connections/dashboard/grafanaConnection.json

### definitions.grafanaType

Grafana service type

**Default:** `Grafana`

**Allowed values:**

- `Grafana`

## entity/services/connections/dashboard/hexConnection.json

### definitions.hexType

Service type.

**Default:** `Hex`

**Allowed values:**

- `Hex`

### properties.tokenType

Type of token to use for authentication

**Default:** `personal`

**Allowed values:**

- `personal`
- `workspace`

## entity/services/connections/dashboard/lightdashConnection.json

### definitions.lightdashType

Lightdash service type

**Default:** `Lightdash`

**Allowed values:**

- `Lightdash`

## entity/services/connections/dashboard/lookerConnection.json

### definitions.lookerType

Looker service type

**Default:** `Looker`

**Allowed values:**

- `Looker`

## entity/services/connections/dashboard/metabaseConnection.json

### definitions.metabaseType

Metabase service type

**Default:** `Metabase`

**Allowed values:**

- `Metabase`

## entity/services/connections/dashboard/microStrategyConnection.json

### definitions.microStrategyType

MicroStrategy service type

**Default:** `MicroStrategy`

**Allowed values:**

- `MicroStrategy`

## entity/services/connections/dashboard/modeConnection.json

### definitions.modeType

Mode service type

**Default:** `Mode`

**Allowed values:**

- `Mode`

## entity/services/connections/dashboard/omniConnection.json

### definitions.omniType

Service type.

**Default:** `Omni`

**Allowed values:**

- `Omni`

## entity/services/connections/dashboard/powerBIConnection.json

### definitions.powerBiType

PowerBI service type

**Default:** `PowerBI`

**Allowed values:**

- `PowerBI`

### definitions.localConfig.properties.pbitFileConfigType

pbit File Configuration type

**Default:** `local`

**Allowed values:**

- `local`

## entity/services/connections/dashboard/powerBIReportServerConnection.json

### definitions.powerBIReportServerType

PowerBIReportServer service type

**Default:** `PowerBIReportServer`

**Allowed values:**

- `PowerBIReportServer`

## entity/services/connections/dashboard/powerbi/azureConfig.json

### properties.pbitFileConfigType

pbit File Configuration type

**Default:** `azure`

**Allowed values:**

- `azure`

## entity/services/connections/dashboard/powerbi/gcsConfig.json

### properties.pbitFileConfigType

pbit File Configuration type

**Default:** `gcs`

**Allowed values:**

- `gcs`

## entity/services/connections/dashboard/powerbi/s3Config.json

### properties.pbitFileConfigType

pbit File Configuration type

**Default:** `s3`

**Allowed values:**

- `s3`

## entity/services/connections/dashboard/qlikCloudConnection.json

### definitions.qlikCloudType

Qlik Cloud service type

**Default:** `QlikCloud`

**Allowed values:**

- `QlikCloud`

### properties.spaceTypes.items

**Allowed values:**

- `Managed`
- `Shared`
- `Personal`
- `Data`

## entity/services/connections/dashboard/qlikSenseConnection.json

### definitions.qlikSenseType

Qlik sense service type

**Default:** `QlikSense`

**Allowed values:**

- `QlikSense`

## entity/services/connections/dashboard/quickSightConnection.json

### definitions.quickSightType

QuickSight service type

**Default:** `QuickSight`

**Allowed values:**

- `QuickSight`

### properties.identityType

The authentication method that the user uses to sign in.

**Default:** `IAM`

**Allowed values:**

- `IAM`
- `QUICKSIGHT`
- `ANONYMOUS`

## entity/services/connections/dashboard/redashConnection.json

### definitions.redashType

Redash service type

**Default:** `Redash`

**Allowed values:**

- `Redash`

## entity/services/connections/dashboard/sapS4HanaConnection.json

### definitions.sapS4HanaType

SAP S/4HANA service type

**Default:** `SapS4Hana`

**Allowed values:**

- `SapS4Hana`

### definitions.sapS4HanaBasicAuthType.properties.authType

Authentication type identifier.

**Default:** `basic`

**Allowed values:**

- `basic`

### definitions.sapS4HanaOAuthType.properties.authType

Authentication type identifier.

**Default:** `oauth2`

**Allowed values:**

- `oauth2`

## entity/services/connections/dashboard/sigmaConnection.json

### definitions.sigmaType

Sigma service type

**Default:** `Sigma`

**Allowed values:**

- `Sigma`

## entity/services/connections/dashboard/ssrsConnection.json

### definitions.ssrsType

Service type.

**Default:** `Ssrs`

**Allowed values:**

- `Ssrs`

## entity/services/connections/dashboard/supersetConnection.json

### definitions.supersetType

Superset service type

**Default:** `Superset`

**Allowed values:**

- `Superset`

## entity/services/connections/dashboard/tableauConnection.json

### definitions.tableauType

Tableau service type

**Default:** `Tableau`

**Allowed values:**

- `Tableau`

## entity/services/connections/dashboard/thoughtSpotConnection.json

### definitions.thoughtSpotType

ThoughtSpot service type

**Default:** `ThoughtSpot`

**Allowed values:**

- `ThoughtSpot`

### properties.apiVersion

ThoughtSpot API version to use

**Default:** `v2`

**Allowed values:**

- `v1`
- `v2`

## entity/services/connections/database/athenaConnection.json

### definitions.athenaType

Service type.

**Default:** `Athena`

**Allowed values:**

- `Athena`

### definitions.athenaScheme

SQLAlchemy driver scheme options.

**Default:** `awsathena+rest`

**Allowed values:**

- `awsathena+rest`

## entity/services/connections/database/azureSQLConnection.json

### definitions.azureSQLType

Service type.

**Default:** `AzureSQL`

**Allowed values:**

- `AzureSQL`

### definitions.azureSQLScheme

SQLAlchemy driver scheme options.

**Default:** `mssql+pyodbc`

**Allowed values:**

- `mssql+pyodbc`

### properties.authenticationMode.properties.authentication

Authentication from Connection String for AzureSQL.

**Allowed values:**

- `ActiveDirectoryIntegrated`
- `ActiveDirectoryPassword`

## entity/services/connections/database/bigQueryConnection.json

### definitions.bigqueryType

Service type.

**Default:** `BigQuery`

**Allowed values:**

- `BigQuery`

### definitions.bigqueryScheme

SQLAlchemy driver scheme options.

**Default:** `bigquery`

**Allowed values:**

- `bigquery`

## entity/services/connections/database/bigTableConnection.json

### definitions.bigtableType

Service type.

**Default:** `BigTable`

**Allowed values:**

- `BigTable`

## entity/services/connections/database/burstIQConnection.json

### definitions.burstIQType

Service type.

**Default:** `BurstIQ`

**Allowed values:**

- `BurstIQ`

## entity/services/connections/database/cassandraConnection.json

### definitions.cassandraType

Service type.

**Default:** `Cassandra`

**Allowed values:**

- `Cassandra`

## entity/services/connections/database/clickhouseConnection.json

### definitions.clickhouseType

Service type.

**Default:** `Clickhouse`

**Allowed values:**

- `Clickhouse`

### definitions.clickhouseScheme

SQLAlchemy driver scheme options.

**Default:** `clickhouse+http`

**Allowed values:**

- `clickhouse+http`
- `clickhouse+native`

## entity/services/connections/database/cockroachConnection.json

### definitions.cockroachType

Service type.

**Default:** `Cockroach`

**Allowed values:**

- `Cockroach`

### definitions.cockroachScheme

SQLAlchemy driver scheme options.

**Default:** `cockroachdb+psycopg2`

**Allowed values:**

- `cockroachdb+psycopg2`

## entity/services/connections/database/common/noConfigAuthenticationTypes.json

### (schema)

Database Authentication types not requiring config.

**Default:** `OAuth2`

**Allowed values:**

- `OAuth2`

## entity/services/connections/database/couchbaseConnection.json

### definitions.couchbaseType

Service type.

**Default:** `Couchbase`

**Allowed values:**

- `Couchbase`

### definitions.couchbaseScheme

Couchbase driver scheme options.

**Default:** `couchbase`

**Allowed values:**

- `couchbase`

## entity/services/connections/database/customDatabaseConnection.json

### definitions.customDatabaseType

Custom database service type

**Default:** `CustomDatabase`

**Allowed values:**

- `CustomDatabase`

## entity/services/connections/database/databricksConnection.json

### definitions.databricksType

Service type.

**Default:** `Databricks`

**Allowed values:**

- `Databricks`

### definitions.databricksScheme

SQLAlchemy driver scheme options.

**Default:** `databricks`

**Allowed values:**

- `databricks`

## entity/services/connections/database/datalakeConnection.json

### definitions.datalakeType

Service type.

**Default:** `Datalake`

**Allowed values:**

- `Datalake`

## entity/services/connections/database/db2Connection.json

### definitions.db2Type

Service type.

**Default:** `Db2`

**Allowed values:**

- `Db2`

### definitions.db2Scheme

SQLAlchemy driver scheme options.

**Default:** `db2+ibm_db`

**Allowed values:**

- `db2+ibm_db`
- `ibmi`

## entity/services/connections/database/deltaLakeConnection.json

### definitions.deltaLakeType

Service type.

**Default:** `DeltaLake`

**Allowed values:**

- `DeltaLake`

## entity/services/connections/database/domoDatabaseConnection.json

### definitions.domoDatabaseType

 service type

**Default:** `DomoDatabase`

**Allowed values:**

- `DomoDatabase`

## entity/services/connections/database/dorisConnection.json

### definitions.dorisType

Service type.

**Default:** `Doris`

**Allowed values:**

- `Doris`

### definitions.dorisScheme

SQLAlchemy driver scheme options.

**Default:** `doris`

**Allowed values:**

- `doris`

## entity/services/connections/database/dremioConnection.json

### definitions.dremioType

Service type.

**Default:** `Dremio`

**Allowed values:**

- `Dremio`

## entity/services/connections/database/dremio/cloudAuth.json

### properties.region

Dremio Cloud region where your organization is hosted. Choose 'US' for United States region or 'EU' for European region.

**Default:** `US`

**Allowed values:**

- `US`
- `EU`

## entity/services/connections/database/druidConnection.json

### definitions.druidType

Service type.

**Default:** `Druid`

**Allowed values:**

- `Druid`

### definitions.druidScheme

SQLAlchemy driver scheme options.

**Default:** `druid`

**Allowed values:**

- `druid`

## entity/services/connections/database/dynamoDBConnection.json

### definitions.dynamoDBType

Service type.

**Default:** `DynamoDB`

**Allowed values:**

- `DynamoDB`

## entity/services/connections/database/epicConnection.json

### definitions.epicType

Service type.

**Default:** `Epic`

**Allowed values:**

- `Epic`

### properties.fhirVersion

FHIR specification version (R4, STU3, DSTU2)

**Default:** `R4`

**Allowed values:**

- `R4`
- `STU3`
- `DSTU2`

## entity/services/connections/database/exasolConnection.json

### definitions.exasolType

Service type.

**Default:** `Exasol`

**Allowed values:**

- `Exasol`

### definitions.exasolScheme

SQLAlchemy driver scheme options.

**Default:** `exa+websocket`

**Allowed values:**

- `exa+websocket`

### properties.tls

Client SSL/TLS settings.

**Default:** `validate-certificate`

**Allowed values:**

- `disable-tls`
- `ignore-certificate`
- `validate-certificate`

## entity/services/connections/database/glueConnection.json

### definitions.glueType

Service type.

**Default:** `Glue`

**Allowed values:**

- `Glue`

## entity/services/connections/database/greenplumConnection.json

### definitions.greenplumType

Service type.

**Default:** `Greenplum`

**Allowed values:**

- `Greenplum`

### definitions.greenplumScheme

SQLAlchemy driver scheme options.

**Default:** `postgresql+psycopg2`

**Allowed values:**

- `postgresql+psycopg2`

## entity/services/connections/database/hiveConnection.json

### definitions.hiveType

Service type.

**Default:** `Hive`

**Allowed values:**

- `Hive`

### definitions.hiveScheme

SQLAlchemy driver scheme options.

**Default:** `hive`

**Allowed values:**

- `hive`
- `hive+http`
- `hive+https`

### properties.auth

Authentication mode to connect to hive.

**Default:** `NONE`

**Allowed values:**

- `NONE`
- `LDAP`
- `KERBEROS`
- `CUSTOM`
- `NOSASL`
- `BASIC`
- `GSSAPI`
- `JWT`
- `PLAIN`

## entity/services/connections/database/impalaConnection.json

### definitions.impalaType

Service type.

**Default:** `Impala`

**Allowed values:**

- `Impala`

### definitions.impalaScheme

SQLAlchemy driver scheme options.

**Default:** `impala`

**Allowed values:**

- `impala`
- `impala4`

### properties.authMechanism

Authentication mode to connect to Impala.

**Default:** `PLAIN`

**Allowed values:**

- `NOSASL`
- `PLAIN`
- `GSSAPI`
- `LDAP`
- `JWT`

## entity/services/connections/database/informixConnection.json

### definitions.informixType

Service type.

**Default:** `Informix`

**Allowed values:**

- `Informix`

### definitions.informixScheme

SQLAlchemy driver scheme options.

**Default:** `informix`

**Allowed values:**

- `informix`

## entity/services/connections/database/iometeConnection.json

### definitions.iometeType

Service type.

**Default:** `Iomete`

**Allowed values:**

- `Iomete`

## entity/services/connections/database/mariaDBConnection.json

### definitions.mariaDBType

Service type.

**Default:** `MariaDB`

**Allowed values:**

- `MariaDB`

### definitions.mariaDBScheme

SQLAlchemy driver scheme options.

**Default:** `mysql+pymysql`

**Allowed values:**

- `mysql+pymysql`

## entity/services/connections/database/microsoftAccessConnection.json

### definitions.microsoftAccessType

Service type.

**Default:** `MicrosoftAccess`

**Allowed values:**

- `MicrosoftAccess`

## entity/services/connections/database/microsoftFabricConnection.json

### definitions.microsoftFabricType

Service type.

**Default:** `MicrosoftFabric`

**Allowed values:**

- `MicrosoftFabric`

### definitions.microsoftFabricScheme

SQLAlchemy driver scheme options.

**Default:** `mssql+pyodbc`

**Allowed values:**

- `mssql+pyodbc`

## entity/services/connections/database/mongoDBConnection.json

### definitions.mongoDBType

Service type.

**Default:** `MongoDB`

**Allowed values:**

- `MongoDB`

### definitions.mongoDBScheme

Mongo connection scheme options.

**Default:** `mongodb`

**Allowed values:**

- `mongodb`
- `mongodb+srv`

## entity/services/connections/database/mssqlConnection.json

### definitions.mssqlType

Service type.

**Default:** `Mssql`

**Allowed values:**

- `Mssql`

### definitions.mssqlScheme

SQLAlchemy driver scheme options.

**Default:** `mssql+pytds`

**Allowed values:**

- `mssql+pyodbc`
- `mssql+pytds`
- `mssql+pymssql`

## entity/services/connections/database/myDbConnection.json

### definitions.myDbType

Service type.

**Default:** `MyDb`

**Allowed values:**

- `MyDb`

### definitions.myDbScheme

SQLAlchemy driver scheme options.

**Default:** `mydb+pymydb`

**Allowed values:**

- `mydb+pymydb`

## entity/services/connections/database/mysqlConnection.json

### definitions.mySQLType

Service type.

**Default:** `Mysql`

**Allowed values:**

- `Mysql`

### definitions.mySQLScheme

SQLAlchemy driver scheme options.

**Default:** `mysql+pymysql`

**Allowed values:**

- `mysql+pymysql`

## entity/services/connections/database/oracleConnection.json

### definitions.oracleType

Service type.

**Default:** `Oracle`

**Allowed values:**

- `Oracle`

### definitions.oracleScheme

SQLAlchemy driver scheme options.

**Default:** `oracle+cx_oracle`

**Allowed values:**

- `oracle+cx_oracle`

## entity/services/connections/database/pinotDBConnection.json

### definitions.pinotDBType

Service type.

**Default:** `PinotDB`

**Allowed values:**

- `PinotDB`

### definitions.pinotDBScheme

SQLAlchemy driver scheme options.

**Default:** `pinot`

**Allowed values:**

- `pinot`
- `pinot+http`
- `pinot+https`

## entity/services/connections/database/postgresConnection.json

### definitions.postgresType

Service type.

**Default:** `Postgres`

**Allowed values:**

- `Postgres`

### definitions.postgresScheme

SQLAlchemy driver scheme options.

**Default:** `postgresql+psycopg2`

**Allowed values:**

- `postgresql+psycopg2`
- `pgspider+psycopg2`

## entity/services/connections/database/prestoConnection.json

### definitions.prestoType

Service type.

**Default:** `Presto`

**Allowed values:**

- `Presto`

### definitions.prestoScheme

SQLAlchemy driver scheme options.

**Default:** `presto`

**Allowed values:**

- `presto`

## entity/services/connections/database/questdbConnection.json

### definitions.questDBType

Service type.

**Default:** `QuestDB`

**Allowed values:**

- `QuestDB`

### definitions.questDBScheme

SQLAlchemy driver scheme options.

**Default:** `postgresql+psycopg2`

**Allowed values:**

- `postgresql+psycopg2`

## entity/services/connections/database/redshiftConnection.json

### definitions.redshiftType

Service type.

**Default:** `Redshift`

**Allowed values:**

- `Redshift`

### definitions.redshiftScheme

SQLAlchemy driver scheme options.

**Default:** `redshift+psycopg2`

**Allowed values:**

- `redshift+psycopg2`

## entity/services/connections/database/salesforceConnection.json

### definitions.salesforceType

Service type.

**Default:** `Salesforce`

**Allowed values:**

- `Salesforce`

## entity/services/connections/database/sapBw4HanaConnection.json

### definitions.sapBw4HanaType

Service type.

**Default:** `SapBw4Hana`

**Allowed values:**

- `SapBw4Hana`

## entity/services/connections/database/sapErpConnection.json

### definitions.sapErpType

Service type.

**Default:** `SapErp`

**Allowed values:**

- `SapErp`

## entity/services/connections/database/sapHanaConnection.json

### definitions.sapHanaType

Service type.

**Default:** `SapHana`

**Allowed values:**

- `SapHana`

### definitions.sapHanaScheme

SQLAlchemy driver scheme options.

**Default:** `hana`

**Allowed values:**

- `hana`

## entity/services/connections/database/sapSuccessFactorsConnection.json

### definitions.sapSuccessFactorsType

Service type.

**Default:** `SapSuccessFactors`

**Allowed values:**

- `SapSuccessFactors`

### definitions.authType

Authentication type to connect to SAP SuccessFactors.

**Default:** `BasicAuth`

**Allowed values:**

- `OAuth2Credentials`
- `BasicAuth`

## entity/services/connections/database/sasConnection.json

### definitions.sasType

Service type.

**Default:** `SAS`

**Allowed values:**

- `SAS`

## entity/services/connections/database/serviceNowConnection.json

### definitions.serviceNowType

Service type.

**Default:** `ServiceNow`

**Allowed values:**

- `ServiceNow`

## entity/services/connections/database/singleStoreConnection.json

### definitions.singleStoreType

Service type.

**Default:** `SingleStore`

**Allowed values:**

- `SingleStore`

### definitions.singleStoreScheme

SQLAlchemy driver scheme options.

**Default:** `mysql+pymysql`

**Allowed values:**

- `mysql+pymysql`

## entity/services/connections/database/snowflakeConnection.json

### definitions.snowflakeType

Service type.

**Default:** `Snowflake`

**Allowed values:**

- `Snowflake`

### definitions.snowflakeScheme

SQLAlchemy driver scheme options.

**Default:** `snowflake`

**Allowed values:**

- `snowflake`

## entity/services/connections/database/sqliteConnection.json

### definitions.SQLiteType

Service type.

**Default:** `SQLite`

**Allowed values:**

- `SQLite`

### definitions.SQLiteScheme

SQLAlchemy driver scheme options.

**Default:** `sqlite+pysqlite`

**Allowed values:**

- `sqlite+pysqlite`

## entity/services/connections/database/ssasConnection.json

### definitions.SSASType

Service type.

**Default:** `SSAS`

**Allowed values:**

- `SSAS`

## entity/services/connections/database/starrocksConnection.json

### definitions.starrocksType

Service type.

**Default:** `StarRocks`

**Allowed values:**

- `StarRocks`

### definitions.starrocksScheme

SQLAlchemy driver scheme options.

**Default:** `mysql+pymysql`

**Allowed values:**

- `mysql+pymysql`

## entity/services/connections/database/synapseConnection.json

### definitions.synapseType

Service type.

**Default:** `Synapse`

**Allowed values:**

- `Synapse`

### definitions.synapseScheme

SQLAlchemy driver scheme options.

**Default:** `mssql+pyodbc`

**Allowed values:**

- `mssql+pyodbc`

### properties.authenticationMode.properties.authentication

Authentication from Connection String for Azure Synapse.

**Allowed values:**

- `ActiveDirectoryIntegrated`
- `ActiveDirectoryPassword`
- `ActiveDirectoryServicePrincipal`

## entity/services/connections/database/teradataConnection.json

### definitions.teradataType

Service type.

**Default:** `Teradata`

**Allowed values:**

- `Teradata`

### definitions.teradataScheme

SQLAlchemy driver scheme options.

**Default:** `teradatasql`

**Allowed values:**

- `teradatasql`

### properties.logmech

Specifies the logon authentication method. Possible values are TD2 (the default), JWT, LDAP, KRB5 for Kerberos, or TDNEGO

**Default:** `TD2`

**Allowed values:**

- `TD2`
- `LDAP`
- `JWT`
- `KRB5`
- `CUSTOM`
- `TDNEGO`

### properties.tmode

Specifies the transaction mode for the connection

**Default:** `DEFAULT`

**Allowed values:**

- `ANSI`
- `TERA`
- `DEFAULT`

## entity/services/connections/database/timescaleConnection.json

### definitions.timescaleType

Service type.

**Default:** `Timescale`

**Allowed values:**

- `Timescale`

### definitions.timescaleScheme

SQLAlchemy driver scheme options.

**Default:** `postgresql+psycopg2`

**Allowed values:**

- `postgresql+psycopg2`

## entity/services/connections/database/trinoConnection.json

### definitions.trinoType

Service type.

**Default:** `Trino`

**Allowed values:**

- `Trino`

### definitions.trinoScheme

SQLAlchemy driver scheme options.

**Default:** `trino`

**Allowed values:**

- `trino`

## entity/services/connections/database/unityCatalogConnection.json

### definitions.databricksType

Service type.

**Default:** `UnityCatalog`

**Allowed values:**

- `UnityCatalog`

### definitions.databricksScheme

SQLAlchemy driver scheme options.

**Default:** `databricks`

**Allowed values:**

- `databricks`

## entity/services/connections/database/verticaConnection.json

### definitions.verticaType

Service type.

**Default:** `Vertica`

**Allowed values:**

- `Vertica`

### definitions.verticaScheme

SQLAlchemy driver scheme options.

**Default:** `vertica+vertica_python`

**Allowed values:**

- `vertica+vertica_python`

## entity/services/connections/drive/customDriveConnection.json

### definitions.customDriveType

Custom Drive service type

**Default:** `CustomDrive`

**Allowed values:**

- `CustomDrive`

## entity/services/connections/drive/googleDriveConnection.json

### definitions.googleDriveType

Google Drive service type

**Default:** `GoogleDrive`

**Allowed values:**

- `GoogleDrive`

## entity/services/connections/drive/sftpConnection.json

### definitions.sftpType

SFTP service type

**Default:** `Sftp`

**Allowed values:**

- `Sftp`

## entity/services/connections/drive/sharePointConnection.json

### definitions.sharePointType

SharePoint service type

**Default:** `SharePoint`

**Allowed values:**

- `SharePoint`

## entity/services/connections/llm/anthropicConnection.json

### definitions.anthropicType

Service type

**Default:** `Anthropic`

**Allowed values:**

- `Anthropic`

## entity/services/connections/llm/azureOpenAIConnection.json

### definitions.azureOpenAIType

Service type

**Default:** `AzureOpenAI`

**Allowed values:**

- `AzureOpenAI`

## entity/services/connections/llm/bedrockConnection.json

### definitions.bedrockType

Service type

**Default:** `Bedrock`

**Allowed values:**

- `Bedrock`

## entity/services/connections/llm/customLLMConnection.json

### definitions.customLLMType

Service type

**Default:** `CustomLLM`

**Allowed values:**

- `CustomLLM`

### properties.authType

Type of authentication

**Default:** `APIKey`

**Allowed values:**

- `None`
- `APIKey`
- `Bearer`
- `BasicAuth`
- `Custom`

## entity/services/connections/llm/huggingFaceConnection.json

### definitions.huggingFaceType

Service type

**Default:** `HuggingFace`

**Allowed values:**

- `HuggingFace`

## entity/services/connections/llm/ollamaConnection.json

### definitions.ollamaType

Service type

**Default:** `Ollama`

**Allowed values:**

- `Ollama`

## entity/services/connections/llm/openAIConnection.json

### definitions.openAIType

Service type

**Default:** `OpenAI`

**Allowed values:**

- `OpenAI`

## entity/services/connections/llm/vertexAIConnection.json

### definitions.vertexAIType

Service type

**Default:** `VertexAI`

**Allowed values:**

- `VertexAI`

## entity/services/connections/mcp/mcpConnection.json

### definitions.mcpType

Service type

**Default:** `Mcp`

**Allowed values:**

- `Mcp`

### definitions.discoveryMethod

Method to discover MCP servers

**Allowed values:**

- `ConfigFile` ? Discover servers from configuration files (e.g., claude_desktop_config.json)
- `DirectConnection` ? Connect directly to a specific MCP server
- `Registry` ? Discover servers from an MCP registry

### definitions.transportType

MCP transport protocol type

**Allowed values:**

- `Stdio` ? Deprecated and unsupported. Stdio transport has been removed; use SSE or StreamableHTTP with a URL.
- `SSE` ? Server-Sent Events transport over HTTP
- `StreamableHTTP` ? Streamable HTTP transport

## entity/services/connections/messaging/customMessagingConnection.json

### definitions.customMessagingType

Custom messaging service type

**Default:** `CustomMessaging`

**Allowed values:**

- `CustomMessaging`

## entity/services/connections/messaging/kafkaConnection.json

### definitions.kafkaType

Kafka service type

**Default:** `Kafka`

**Allowed values:**

- `Kafka`

### properties.securityProtocol

security.protocol consumer config property

**Default:** `PLAINTEXT`

**Allowed values:**

- `PLAINTEXT`
- `SASL_PLAINTEXT`
- `SASL_SSL`
- `SSL`

## entity/services/connections/messaging/kinesisConnection.json

### definitions.kinesisType

Service type.

**Default:** `Kinesis`

**Allowed values:**

- `Kinesis`

## entity/services/connections/messaging/pubSubConnection.json

### definitions.pubSubType

Service type.

**Default:** `PubSub`

**Allowed values:**

- `PubSub`

## entity/services/connections/messaging/pulsarConnection.json

### definitions.pulsarType

Pulsar service type

**Default:** `Pulsar`

**Allowed values:**

- `Pulsar`

## entity/services/connections/messaging/redpandaConnection.json

### definitions.RedpandaType

Redpanda service type

**Default:** `Redpanda`

**Allowed values:**

- `Redpanda`

### properties.securityProtocol

security.protocol consumer config property

**Default:** `PLAINTEXT`

**Allowed values:**

- `PLAINTEXT`
- `SASL_PLAINTEXT`
- `SASL_SSL`
- `SSL`

## entity/services/connections/messaging/saslMechanismType.json

### (schema)

SASL Mechanism consumer config property

**Default:** `PLAIN`

**Allowed values:**

- `PLAIN`
- `GSSAPI`
- `SCRAM-SHA-256`
- `SCRAM-SHA-512`
- `OAUTHBEARER`

## entity/services/connections/metadata/alationConnection.json

### definitions.alationType

Service type.

**Default:** `Alation`

**Allowed values:**

- `Alation`

## entity/services/connections/metadata/alationSinkConnection.json

### definitions.alationSinkType

Service type.

**Default:** `AlationSink`

**Allowed values:**

- `AlationSink`

## entity/services/connections/metadata/amundsenConnection.json

### definitions.amundsenType

Amundsen service type

**Default:** `Amundsen`

**Allowed values:**

- `Amundsen`

## entity/services/connections/metadata/atlasConnection.json

### definitions.atlasType

Service type.

**Default:** `Atlas`

**Allowed values:**

- `Atlas`

## entity/services/connections/metadata/collibraConnection.json

### definitions.collibraType

Collibra service type

**Default:** `Collibra`

**Allowed values:**

- `Collibra`

## entity/services/connections/metadata/metadataESConnection.json

### definitions.metadataESType

Metadata to Elastic Search type

**Default:** `MetadataES`

**Allowed values:**

- `MetadataES`

## entity/services/connections/metadata/openMetadataConnection.json

### definitions.openmetadataType

OpenMetadata service type

**Default:** `OpenMetadata`

**Allowed values:**

- `OpenMetadata`

### definitions.authProvider

OpenMetadata Server Authentication Provider. Make sure configure same auth providers as the one configured on OpenMetadata server.

**Default:** `basic`

**Allowed values:**

- `basic`
- `azure`
- `google`
- `okta`
- `auth0`
- `aws-cognito`
- `custom-oidc`
- `ldap`
- `saml`
- `openmetadata`

## entity/services/connections/mlmodel/customMlModelConnection.json

### definitions.customMlModelType

Custom Ml model service type

**Default:** `CustomMlModel`

**Allowed values:**

- `CustomMlModel`

## entity/services/connections/mlmodel/mlflowConnection.json

### definitions.mlflowType

Service type.

**Default:** `Mlflow`

**Allowed values:**

- `Mlflow`

## entity/services/connections/mlmodel/sageMakerConnection.json

### definitions.sageMakerType

Service type.

**Default:** `SageMaker`

**Allowed values:**

- `SageMaker`

## entity/services/connections/mlmodel/sklearnConnection.json

### definitions.sklearnType

Service type.

**Default:** `Sklearn`

**Allowed values:**

- `Sklearn`

## entity/services/connections/mlmodel/vertexaiConnection.json

### definitions.vertexAIType

Service type.

**Default:** `VertexAI`

**Allowed values:**

- `VertexAI`

## entity/services/connections/pipeline/airbyteConnection.json

### definitions.AirbyteType

Service type.

**Default:** `Airbyte`

**Allowed values:**

- `Airbyte`

## entity/services/connections/pipeline/airflowConnection.json

### definitions.AirflowType

Service type.

**Default:** `Airflow`

**Allowed values:**

- `Airflow`

## entity/services/connections/pipeline/backendConnection.json

### definitions.BackendType

Service type.

**Default:** `Backend`

**Allowed values:**

- `Backend`

## entity/services/connections/pipeline/customPipelineConnection.json

### definitions.customPipelineType

Custom pipeline service type

**Default:** `CustomPipeline`

**Allowed values:**

- `CustomPipeline`

## entity/services/connections/pipeline/dagsterConnection.json

### definitions.DagsterType

Service type.

**Default:** `Dagster`

**Allowed values:**

- `Dagster`

## entity/services/connections/pipeline/databricksPipelineConnection.json

### definitions.databricksType

Service type.

**Default:** `DatabricksPipeline`

**Allowed values:**

- `DatabricksPipeline`

## entity/services/connections/pipeline/datafactoryConnection.json

### definitions.DataFactoryType

Service type.

**Default:** `DataFactory`

**Allowed values:**

- `DataFactory`

## entity/services/connections/pipeline/dbtCloudConnection.json

### definitions.DBTCloudType

Service type.

**Default:** `DBTCloud`

**Allowed values:**

- `DBTCloud`

## entity/services/connections/pipeline/domoPipelineConnection.json

### definitions.DomoPipelineType

Service type.

**Default:** `DomoPipeline`

**Allowed values:**

- `DomoPipeline`

## entity/services/connections/pipeline/fivetranConnection.json

### definitions.FivetranType

Service type.

**Default:** `Fivetran`

**Allowed values:**

- `Fivetran`

## entity/services/connections/pipeline/flinkConnection.json

### definitions.FlinkType

Service type.

**Default:** `Flink`

**Allowed values:**

- `Flink`

## entity/services/connections/pipeline/gluePipelineConnection.json

### definitions.glueType

Service type.

**Default:** `GluePipeline`

**Allowed values:**

- `GluePipeline`

## entity/services/connections/pipeline/kafkaConnectConnection.json

### definitions.KafkaConnectType

Service type.

**Default:** `KafkaConnect`

**Allowed values:**

- `KafkaConnect`

## entity/services/connections/pipeline/kinesisFirehoseConnection.json

### definitions.kinesisFirehoseType

Service type.

**Default:** `KinesisFirehose`

**Allowed values:**

- `KinesisFirehose`

## entity/services/connections/pipeline/matillionConnection.json

### definitions.matillionType

Service type.

**Default:** `Matillion`

**Allowed values:**

- `Matillion`

## entity/services/connections/pipeline/matillion/matillionDPC.json

### properties.type

**Default:** `MatillionDPC`

**Allowed values:**

- `MatillionDPC`

### properties.region

Matillion DPC region. Determines the API base URL.

**Default:** `us1`

**Allowed values:**

- `us1`
- `eu1`

## entity/services/connections/pipeline/matillion/matillionETL.json

### properties.type

**Default:** `MatillionETL`

**Allowed values:**

- `MatillionETL`

## entity/services/connections/pipeline/microsoftFabricPipelineConnection.json

### definitions.MicrosoftFabricPipelineType

Service type.

**Default:** `MicrosoftFabricPipeline`

**Allowed values:**

- `MicrosoftFabricPipeline`

## entity/services/connections/pipeline/mulesoftConnection.json

### definitions.MulesoftType

Service type.

**Default:** `Mulesoft`

**Allowed values:**

- `Mulesoft`

## entity/services/connections/pipeline/nifiConnection.json

### definitions.NifiType

Service type.

**Default:** `Nifi`

**Allowed values:**

- `Nifi`

## entity/services/connections/pipeline/openLineageConnection.json

### definitions.OpenLineageType

Service type.

**Default:** `OpenLineage`

**Allowed values:**

- `OpenLineage`

## entity/services/connections/pipeline/openlineage/kafkaBrokerConfig.json

### properties.consumerOffsets

Initial Kafka consumer offset.

**Default:** `earliest`

**Allowed values:**

- `earliest`
- `latest`

### properties.securityProtocol

Kafka security protocol config.

**Default:** `PLAINTEXT`

**Allowed values:**

- `PLAINTEXT`
- `SASL_PLAINTEXT`
- `SSL`
- `SASL_SSL`

## entity/services/connections/pipeline/openlineage/kinesisBrokerConfig.json

### properties.consumerOffsets

Initial Kinesis shard iterator type.

**Default:** `TRIM_HORIZON`

**Allowed values:**

- `TRIM_HORIZON`
- `LATEST`

## entity/services/connections/pipeline/prefectConnection.json

### definitions.prefectType

Service type.

**Default:** `Prefect`

**Allowed values:**

- `Prefect`

## entity/services/connections/pipeline/sapBw4HanaPipelineConnection.json

### definitions.sapBw4HanaPipelineType

SAP BW/4HANA pipeline service type.

**Default:** `SapBw4HanaPipeline`

**Allowed values:**

- `SapBw4HanaPipeline`

## entity/services/connections/pipeline/snowplowConnection.json

### definitions.SnowplowType

Service type.

**Default:** `Snowplow`

**Allowed values:**

- `Snowplow`

### definitions.SnowplowDeployment

Snowplow deployment type

**Default:** `BDP`

**Allowed values:**

- `BDP`
- `Community`

### properties.cloudProvider

Cloud provider where Snowplow is deployed

**Default:** `AWS`

**Allowed values:**

- `AWS`
- `GCP`
- `Azure`

## entity/services/connections/pipeline/sparkConnection.json

### definitions.SparkType

Service type.

**Default:** `Spark`

**Allowed values:**

- `Spark`

## entity/services/connections/pipeline/splineConnection.json

### definitions.SplineType

Service type.

**Default:** `Spline`

**Allowed values:**

- `Spline`

## entity/services/connections/pipeline/ssisConnection.json

### definitions.SSISType

Service type.

**Default:** `SSIS`

**Allowed values:**

- `SSIS`

## entity/services/connections/pipeline/stitchConnection.json

### definitions.stitchType

Service type.

**Default:** `Stitch`

**Allowed values:**

- `Stitch`

## entity/services/connections/pipeline/wherescapeConnection.json

### definitions.WherescapeType

Service type.

**Default:** `Wherescape`

**Allowed values:**

- `Wherescape`

## entity/services/connections/search/customSearchConnection.json

### definitions.customSearchType

Custom search service type

**Default:** `CustomSearch`

**Allowed values:**

- `CustomSearch`

## entity/services/connections/search/elasticSearchConnection.json

### definitions.elasticSearchType

ElasticSearch service type

**Default:** `ElasticSearch`

**Allowed values:**

- `ElasticSearch`

## entity/services/connections/search/openSearchConnection.json

### definitions.openSearchType

OpenSearch service type

**Default:** `OpenSearch`

**Allowed values:**

- `OpenSearch`

## entity/services/connections/security/rangerConnection.json

### definitions.rangerType

Apache Ranger service type

**Default:** `Ranger`

**Allowed values:**

- `Ranger`

## entity/services/connections/storage/adlsConnection.json

### definitions.azureType

ADLS service type

**Default:** `ADLS`

**Allowed values:**

- `ADLS`

## entity/services/connections/storage/customStorageConnection.json

### definitions.customStorageType

Custom storage service type

**Default:** `CustomStorage`

**Allowed values:**

- `CustomStorage`

## entity/services/connections/storage/gcsConnection.json

### definitions.gcsType

Gcs service type

**Default:** `GCS`

**Allowed values:**

- `GCS`

## entity/services/connections/storage/s3Connection.json

### definitions.s3Type

S3 service type

**Default:** `S3`

**Allowed values:**

- `S3`

## entity/services/connections/testConnectionDefinition.json

### definitions.testConnectionStep.properties.category

Whether the step gates connectivity (ConnectionGate) or verifies an optional capability (Capability). When a gate fails, later steps are skipped as ConnectionNotEstablished.

**Default:** `Capability`

**Allowed values:**

- `ConnectionGate`
- `Capability`

## entity/services/connections/testConnectionResult.json

### definitions.testConnectionStepResult.properties.status

Lifecycle state of this step.

**Allowed values:**

- `Queued`
- `Running`
- `Passed`
- `Failed`
- `Skipped`
- `Warning`

### definitions.testConnectionStepResult.properties.skipReason

Why a step did not run, when status is Skipped.

**Allowed values:**

- `NotImplemented`
- `ConnectionNotEstablished`

### definitions.statusType

Enum defining possible Test Connection Result status

**Allowed values:**

- `Successful`
- `Failed`
- `Running`

## entity/services/dashboardService.json

### definitions.dashboardServiceType

Type of Dashboard service - Superset, Looker, Redash, Tableau, Metabase, PowerBi, Mode, or Lightdash

**Allowed values:**

- `Superset`
- `Looker`
- `Tableau`
- `Redash`
- `Metabase`
- `PowerBI`
- `PowerBIReportServer`
- `Mode`
- `CustomDashboard`
- `DomoDashboard`
- `QuickSight`
- `QlikSense`
- `Lightdash`
- `MicroStrategy`
- `QlikCloud`
- `Sigma`
- `ThoughtSpot`
- `Grafana`
- `Hex`
- `Ssrs`
- `SapS4Hana`
- `Omni`

## entity/services/databaseService.json

### definitions.databaseServiceType

Type of database service such as MySQL, BigQuery, Snowflake, Redshift, Postgres...

**Allowed values:**

- `BigQuery`
- `BigTable`
- `Mysql`
- `Redshift`
- `Snowflake`
- `Postgres`
- `Timescale`
- `Mssql`
- `MicrosoftAccess`
- `Oracle`
- `Athena`
- `Hive`
- `Impala`
- `Presto`
- `Trino`
- `Vertica`
- `Glue`
- `MariaDB`
- `Druid`
- `Db2`
- `Clickhouse`
- `Databricks`
- `AzureSQL`
- `DynamoDB`
- `SingleStore`
- `SQLite`
- `DeltaLake`
- `Salesforce`
- `PinotDB`
- `Datalake`
- `DomoDatabase`
- `QueryLog`
- `CustomDatabase`
- `Dbt`
- `SapHana`
- `SapSuccessFactors`
- `MongoDB`
- `Cassandra`
- `Couchbase`
- `Greenplum`
- `Doris`
- `StarRocks`
- `UnityCatalog`
- `SAS`
- `Teradata`
- `SapErp`
- `Synapse`
- `Exasol`
- `Cockroach`
- `SSAS`
- `Epic`
- `ServiceNow`
- `Dremio`
- `MicrosoftFabric`
- `BurstIQ`
- `Informix`
- `Iomete`
- `QuestDB`
- `SapBw4Hana`

## entity/services/driveService.json

### definitions.driveServiceType

Type of drive service such as Google Drive...

**Allowed values:**

- `GoogleDrive`
- `SharePoint`
- `Sftp`
- `CustomDrive`

## entity/services/ingestionPipelines/agentType.json

### (schema)

Coarse grouping of Ingestion Pipelines. Used as a list filter so that clients do not have to enumerate the `pipelineType` values that make up an agent group.

**Allowed values:**

- `metadata`
- `application`

## entity/services/ingestionPipelines/ingestionPipeline.json

### definitions.pipelineType

Type of Pipeline - metadata, usage

**Allowed values:**

- `metadata`
- `usage`
- `lineage`
- `profiler`
- `autoClassification`
- `TestSuite`
- `dataInsight`
- `elasticSearchReindex`
- `dbt`
- `application`
- `policyAgent`

### definitions.pipelineStatus.properties.pipelineState

Pipeline status denotes if its failed or succeeded.

**Allowed values:**

- `queued`
- `success`
- `failed`
- `running`
- `partialSuccess`
- `stopped`

## entity/services/ingestionPipelines/logStreamEvent.json

### definitions.logStreamEventType

Kind of event delivered on the stream.

**Allowed values:**

- `logs`
- `complete`
- `error`

### definitions.logStreamEndReason

Why the server stopped streaming. Only set on a `complete` event. A stream that ends without one of these was cut short — reconnect from the last cursor.

**Allowed values:**

- `runFinished`
- `idleTimeout`
- `maxDuration`
- `maxBytes`

## entity/services/ingestionPipelines/progressUpdate.json

### definitions.progressUpdateType

Type of progress update

**Allowed values:**

- `DISCOVERY`
- `PROCESSING`
- `STEP_COMPLETE`
- `PIPELINE_COMPLETE`
- `ERROR`

## entity/services/llmService.json

### definitions.llmServiceType

Type of LLM service provider

**Allowed values:**

- `OpenAI`
- `Anthropic`
- `AzureOpenAI`
- `Bedrock`
- `VertexAI`
- `Ollama`
- `HuggingFace`
- `CustomLLM`

## entity/services/mcpService.json

### definitions.mcpServiceType

Type of MCP service - currently only Mcp is supported

**Allowed values:**

- `Mcp`

## entity/services/messagingService.json

### definitions.messagingServiceType

Type of messaging service - Kafka or Pulsar.

**Allowed values:**

- `Kafka`
- `Redpanda`
- `Kinesis`
- `PubSub`
- `CustomMessaging`

## entity/services/metadataService.json

### definitions.metadataServiceType

Type of database service such as Amundsen, Atlas...

**Allowed values:**

- `Amundsen`
- `MetadataES`
- `OpenMetadata`
- `Atlas`
- `Alation`
- `AlationSink`
- `Collibra`

## entity/services/mlmodelService.json

### definitions.mlModelServiceType

Type of MlModel service

**Allowed values:**

- `Mlflow`
- `Sklearn`
- `CustomMlModel`
- `SageMaker`
- `VertexAI`

## entity/services/pipelineService.json

### definitions.pipelineServiceType

Type of pipeline service - Airflow or Prefect.

**Allowed values:**

- `Airflow`
- `GluePipeline`
- `KinesisFirehose`
- `Airbyte`
- `Fivetran`
- `Flink`
- `Dagster`
- `Nifi`
- `DomoPipeline`
- `CustomPipeline`
- `DatabricksPipeline`
- `Spline`
- `Spark`
- `OpenLineage`
- `Prefect`
- `KafkaConnect`
- `DBTCloud`
- `Matillion`
- `Stitch`
- `DataFactory`
- `Wherescape`
- `SSIS`
- `Snowplow`
- `Mulesoft`
- `MicrosoftFabricPipeline`
- `SapBw4HanaPipeline`

## entity/services/searchService.json

### definitions.searchServiceType

Type of search service such as ElasticSearch or OpenSearch.

**Allowed values:**

- `ElasticSearch`
- `OpenSearch`
- `CustomSearch`

## entity/services/securityService.json

### definitions.securityServiceType

Type of security service - Apache Ranger, etc.

**Allowed values:**

- `Ranger`

## entity/services/serviceType.json

### (schema)

This schema defines the service types entities which requires a connection.

**Allowed values:**

- `Dashboard`
- `Database`
- `Drive`
- `Messaging`
- `Metadata`
- `MlModel`
- `Pipeline`
- `Storage`
- `Search`
- `Api`
- `Security`
- `LLM`
- `Mcp`

## entity/services/storageService.json

### definitions.storageServiceType

Type of storage service such as S3, GFS, AZURE...

**Allowed values:**

- `S3`
- `ADLS`
- `GCS`
- `CustomStorage`

## entity/tasks/task.json

### definitions.taskCategory

Category of task for grouping similar task types.

**Allowed values:**

- `Approval`
- `DataAccess`
- `MetadataUpdate`
- `Incident`
- `Review`
- `Custom`

### definitions.taskType

Type of task determining the workflow and required payload.

**Allowed values:**

- `GlossaryApproval`
- `RequestApproval`
- `DataAccessRequest`
- `DescriptionUpdate`
- `TagUpdate`
- `OwnershipUpdate`
- `TierUpdate`
- `DomainUpdate`
- `Suggestion`
- `TestCaseResolution`
- `IncidentResolution`
- `PipelineReview`
- `DataQualityReview`
- `RecognizerFeedbackApproval`
- `CustomTask`

### definitions.taskStatus

Current status of the task in its lifecycle.

**Default:** `Open`

**Allowed values:**

- `Open`
- `InProgress`
- `Pending`
- `Approved`
- `Granted`
- `ManualRevoke`
- `Rejected`
- `Completed`
- `Cancelled`
- `Failed`
- `Revoked`
- `Expired`

### definitions.taskPriority

Priority level of the task.

**Default:** `Medium`

**Allowed values:**

- `Critical`
- `High`
- `Medium`
- `Low`

### definitions.resolutionType

How the task was resolved.

**Allowed values:**

- `Approved`
- `Rejected`
- `Completed`
- `Cancelled`
- `TimedOut`
- `AutoApproved`
- `AutoRejected`
- `Revoked`
- `Expired`

### definitions.externalReference.properties.syncStatus

Status of sync with external system.

**Default:** `synced`

**Allowed values:**

- `synced`
- `pending`
- `conflict`
- `error`

## entity/teams/team.json

### definitions.teamType

Organization is the highest level entity. An Organization has one of more Business Units, Division, Departments, Group, or Users. A Business Unit has one or more Divisions, Departments, Group, or Users. A Division has one or more Divisions, Departments, Group, or Users. A Department has one or more Departments, Group, or Users. A Group has only Users

**Default:** `Group`

**Allowed values:**

- `Group`
- `Department`
- `Division`
- `BusinessUnit`
- `Organization`

## entity/teams/user.json

### definitions.authenticationMechanism.properties.authType

**Allowed values:**

- `JWT`
- `SSO`
- `BASIC`

## entity/type.json

### definitions.category

Metadata category to which a type belongs to.

**Allowed values:**

- `field`
- `entity`

## entity/utils/airflowRestApiConnection.json

### definitions.ApiVersion

Airflow REST API version. Use v1 for Airflow 2.x and v2 for Airflow 3.x. Auto will detect the version automatically.

**Default:** `auto`

**Allowed values:**

- `v1`
- `v2`
- `auto`

### properties.type

Service Type

**Default:** `RestAPI`

**Allowed values:**

- `RestAPI`

## entity/utils/supersetApiConnection.json

### definitions.apiProvider

Authentication provider for the Superset service. For basic user/password authentication, the default value `db` can be used. This parameter is used internally to connect to Superset's REST API.

**Default:** `db`

**Allowed values:**

- `db`
- `ldap`

## events/api/typedEvent.json

### properties.status

The status of the event, such as 'failed', 'successful', or 'unprocessed'.

**Allowed values:**

- `failed`
- `successful`
- `unprocessed`

## events/eventFilterRule.json

### definitions.effect

**Default:** `include`

**Allowed values:**

- `include`
- `exclude`

### definitions.prefixCondition

Prefix Condition to be applied to the Condition.

**Default:** `AND`

**Allowed values:**

- `AND`
- `OR`

### properties.inputType

**Allowed values:**

- `static`
- `runtime`
- `none`

## events/eventSubscription.json

### definitions.triggerType

Trigger Configuration for Alerts.

**Default:** `RealTime`

**Allowed values:**

- `RealTime`
- `Scheduled`

### definitions.alertType

Type of Alerts supported.

**Default:** `Notification`

**Allowed values:**

- `Notification`
- `Observability`
- `ActivityFeed`
- `GovernanceWorkflowChangeEvent`
- `Custom`

### definitions.subscriptionCategory

Subscription Endpoint Type.

**Allowed values:**

- `Users`
- `Teams`
- `Admins`
- `Assignees`
- `Owners`
- `Mentions`
- `Followers`
- `External`

### definitions.subscriptionType

Subscription Endpoint Type.

**Allowed values:**

- `Webhook`
- `Slack`
- `MsTeams`
- `GChat`
- `Email`
- `ActivityFeed`
- `GovernanceWorkflowChangeEvent`

### definitions.status

Status is `disabled`, when eventSubscription was created with `enabled` set to false and it never started publishing events. Status is `active` when eventSubscription is normally functioning and 200 OK response was received for callback notification. Status is `failed` on bad callback URL, connection failures, `1xx`, and `3xx` response was received for callback notification. Status is `awaitingRetry` when previous attempt at callback timed out or received `4xx`, `5xx` response. Status is `retryLimitReached` after all retries fail.

**Allowed values:**

- `disabled`
- `failed`
- `retryLimitReached`
- `awaitingRetry`
- `active`

### definitions.trigger.properties.scheduleInfo

Schedule Info

**Default:** `Weekly`

**Allowed values:**

- `Daily`
- `Weekly`
- `Monthly`
- `Custom`

## events/subscriptionResourceDescriptor.json

### definitions.operation

This schema defines all possible filter operations on metadata of entities in OpenMetadata.

**Allowed values:**

- `filterBySource`
- `filterByEntityId`
- `filterByOwnerName`
- `filterByFqn`
- `filterByEventType`
- `filterByUpdaterName`
- `filterByFieldChange`
- `filterByDomain`
- `filterByMentionedName`
- `filterByGeneralMetadataEvents`
- `filterByUpdaterIsBot`

## events/subscriptionStatus.json

### properties.status

Status is `disabled` when the event subscription was created with `enabled` set to false and it never started publishing events. Status is `active` when the event subscription is functioning normally and a 200 OK response was received for the callback notification. Status is `failed` when a bad callback URL, connection failures, or `1xx` or `3xx` response was received for the callback notification. Status is `awaitingRetry` when the previous attempt at callback timed out or received a `4xx` or `5xx` response. Status is `retryLimitReached` after all retries fail.

**Allowed values:**

- `disabled`
- `failed`
- `retryLimitReached`
- `awaitingRetry`
- `active`

## events/testDestinationStatus.json

### properties.status

Overall test status, indicating if the test operation succeeded or failed.

**Allowed values:**

- `Success`
- `Failed`

## governance/intakeForm.json

### definitions.targetEntityType

Entity types supported by IntakeForm today.

**Allowed values:**

- `dataProduct`
- `domain`
- `glossaryTerm`

### definitions.fieldKind

Whether a required field refers to a native entity attribute or a custom property defined via the Type system.

**Allowed values:**

- `native`
- `customProperty`

### definitions.intakeFormField.properties.fieldKind

Whether a form field refers to a native entity attribute or a custom property defined via the Type system.

**Allowed values:**

- `native`
- `customProperty`

## governance/workflows/elements/nodeSubType.json

### (schema)

SubType of the Node.

**Allowed values:**

- `userApprovalTask`
- `checkEntityAttributesTask`
- `setEntityAttributeTask`
- `setEntityCertificationTask`
- `setGlossaryTermStatusTask`
- `endEvent`
- `startEvent`
- `createAndRunIngestionPipelineTask`
- `runAppTask`
- `rollbackEntityTask`
- `dataCompletenessTask`
- `parallelGateway`
- `sinkTask`
- `createRecognizerFeedbackApprovalTask`
- `applyRecognizerFeedbackTask`
- `rejectRecognizerFeedbackTask`
- `checkChangeDescriptionTask`
- `policyAgentTask`
- `createAndRunAIAutomationTask`

## governance/workflows/elements/nodeType.json

### (schema)

Type of the Node.

**Allowed values:**

- `automatedTask`
- `userTask`
- `endEvent`
- `startEvent`
- `gateway`

## governance/workflows/elements/nodes/automatedTask/checkChangeDescriptionTask.json

### properties.config.properties.condition

Logical operator to combine multiple field checks (AND requires all fields to match, OR requires at least one).

**Default:** `OR`

**Allowed values:**

- `AND`
- `OR`

## governance/workflows/elements/nodes/automatedTask/setEntityCertificationTask.json

### definitions.certificationEnum

**Allowed values:**

- ``
- `Certification.Gold`
- `Certification.Silver`
- `Certification.Bronze`

## governance/workflows/elements/nodes/automatedTask/sinkConfig/gitSinkConfig.json

### definitions.gitCredentialsType

Type of authentication for Git API operations.

**Default:** `token`

**Allowed values:**

- `token`

### definitions.conflictResolution

How to handle files that were modified directly in git.

**Default:** `overwriteExternal`

**Allowed values:**

- `overwriteExternal`
- `preserveExternal`
- `fail`

## governance/workflows/elements/nodes/automatedTask/sinkConfig/webhookSinkConfig.json

### definitions.httpMethod

HTTP method to use for the webhook request.

**Default:** `POST`

**Allowed values:**

- `POST`
- `PUT`
- `PATCH`

### definitions.authType

Type of authentication for webhook requests.

**Allowed values:**

- `none`
- `bearer`
- `basic`
- `apiKey`

## governance/workflows/elements/nodes/automatedTask/sinkTask.json

### definitions.sinkType

Type of sink destination.

**Allowed values:**

- `git`
- `webhook`
- `httpEndpoint`

### definitions.syncMode

How entities should be synchronized to the sink.

**Default:** `overwrite`

**Allowed values:**

- `append`
- `overwrite`
- `merge`

### definitions.outputFormat

Format for serialized entity output.

**Default:** `yaml`

**Allowed values:**

- `yaml`
- `json`

## governance/workflows/elements/nodes/userTask/userApprovalTask.json

### properties.config.properties.assignees.properties.emptyAssigneeStrategy

Strategy applied when no reviewers, owners, or candidates resolve to assignees. 'none' keeps the default behavior (the gateway auto-approves event-driven approvals and leaves workflow-managed tasks unassigned); 'assignAdmins' falls back to all platform admins, excluding the requester so self-approval can never happen.

**Default:** `none`

**Allowed values:**

- `none`
- `assignAdmins`

## governance/workflows/elements/triggers/eventBasedEntityTrigger.json

### definitions.event

Event for which it should be triggered.

**Allowed values:**

- `Created`
- `Updated`

## governance/workflows/workflowDefinition.json

### definitions.type

**Allowed values:**

- `eventBasedEntity`
- `noOp`
- `periodicBatchEntity`

## governance/workflows/workflowInstance.json

### definitions.workflowStatus

**Allowed values:**

- `RUNNING`
- `FINISHED`
- `FAILURE`
- `EXCEPTION`
- `SUPERSEDED`

## jobs/backgroundJob.json

### properties.jobType

Type of the job.

**Allowed values:**

- `CUSTOM_PROPERTY_ENUM_CLEANUP`
- `DELETE_ENTITY`
- `DELETE_TOKEN`
- `CSV_IMPORT`
- `CSV_EXPORT`
- `AUDIT_EXPORT`

### properties.status

Current status of the job.

**Allowed values:**

- `COMPLETED`
- `FAILED`
- `RUNNING`
- `PENDING`
- `CANCELLED`

## metadataIngestion/apiServiceMetadataPipeline.json

### definitions.ApiMetadataConfigType

Api Source Config Metadata Pipeline type

**Default:** `ApiMetadata`

**Allowed values:**

- `ApiMetadata`

## metadataIngestion/applicationPipeline.json

### definitions.applicationConfigType

Pipeline Source Config For Application Pipeline type. Nothing is required.

**Default:** `Application`

**Allowed values:**

- `Application`

## metadataIngestion/dashboardServiceMetadataPipeline.json

### definitions.dashboardMetadataConfigType

Dashboard Source Config Metadata Pipeline type

**Default:** `DashboardMetadata`

**Allowed values:**

- `DashboardMetadata`

## metadataIngestion/dataInsightPipeline.json

### definitions.dataInsightConfigType

Pipeline Source Config Metadata Pipeline type

**Default:** `dataInsight`

**Allowed values:**

- `dataInsight`

## metadataIngestion/databaseServiceAutoClassificationPipeline.json

### definitions.autoClassificationConfigType

Profiler Source Config Pipeline type

**Default:** `AutoClassification`

**Allowed values:**

- `AutoClassification`

## metadataIngestion/databaseServiceMetadataPipeline.json

### definitions.databaseMetadataConfigType

Database Source Config Metadata Pipeline type

**Default:** `DatabaseMetadata`

**Allowed values:**

- `DatabaseMetadata`

## metadataIngestion/databaseServiceProfilerPipeline.json

### definitions.profilerConfigType

Profiler Source Config Pipeline type

**Default:** `Profiler`

**Allowed values:**

- `Profiler`

## metadataIngestion/databaseServiceQueryLineagePipeline.json

### definitions.databaseLineageConfigType

Database Source Config Usage Pipeline type

**Default:** `DatabaseLineage`

**Allowed values:**

- `DatabaseLineage`

## metadataIngestion/databaseServiceQueryUsagePipeline.json

### definitions.databaseUsageConfigType

Database Source Config Usage Pipeline type

**Default:** `DatabaseUsage`

**Allowed values:**

- `DatabaseUsage`

## metadataIngestion/dbtPipeline.json

### definitions.dbtConfigType

DBT Config Pipeline type

**Default:** `DBT`

**Allowed values:**

- `DBT`

## metadataIngestion/dbtconfig/dbtAzureConfig.json

### properties.dbtConfigType

dbt Configuration type

**Default:** `azure`

**Allowed values:**

- `azure`

## metadataIngestion/dbtconfig/dbtCloudConfig.json

### properties.dbtConfigType

dbt Configuration type

**Default:** `cloud`

**Allowed values:**

- `cloud`

## metadataIngestion/dbtconfig/dbtGCSConfig.json

### properties.dbtConfigType

dbt Configuration type

**Default:** `gcs`

**Allowed values:**

- `gcs`

## metadataIngestion/dbtconfig/dbtHttpConfig.json

### properties.dbtConfigType

dbt Configuration type

**Default:** `http`

**Allowed values:**

- `http`

## metadataIngestion/dbtconfig/dbtLocalConfig.json

### properties.dbtConfigType

dbt Configuration type

**Default:** `local`

**Allowed values:**

- `local`

## metadataIngestion/dbtconfig/dbtS3Config.json

### properties.dbtConfigType

dbt Configuration type

**Default:** `s3`

**Allowed values:**

- `s3`

## metadataIngestion/driveServiceMetadataPipeline.json

### definitions.driveMetadataConfigType

Drive Source Config Metadata Pipeline type

**Default:** `DriveMetadata`

**Allowed values:**

- `DriveMetadata`

## metadataIngestion/engine/nativeEngineConfig.json

### properties.type

The type of the engine configuration

**Allowed values:**

- `Native`

## metadataIngestion/engine/sparkEngineConfig.json

### properties.type

**Default:** `Spark`

**Allowed values:**

- `Spark`

## metadataIngestion/mcpServiceMetadataPipeline.json

### definitions.McpMetadataConfigType

MCP Source Config Metadata Pipeline type

**Default:** `McpMetadata`

**Allowed values:**

- `McpMetadata`

## metadataIngestion/messagingServiceAutoClassificationPipeline.json

### definitions.autoClassificationConfigType

Messaging Service Auto Classification Pipeline type

**Default:** `AutoClassification`

**Allowed values:**

- `AutoClassification`

## metadataIngestion/messagingServiceMetadataPipeline.json

### definitions.messagingMetadataConfigType

Messaging Source Config Metadata Pipeline type

**Default:** `MessagingMetadata`

**Allowed values:**

- `MessagingMetadata`

## metadataIngestion/metadataToElasticSearchPipeline.json

### definitions.metadataToESConfigType

Pipeline Source Config Metadata Pipeline type

**Default:** `MetadataToElasticSearch`

**Allowed values:**

- `MetadataToElasticSearch`

## metadataIngestion/mlmodelServiceMetadataPipeline.json

### definitions.mlModelMetadataConfigType

MlModel Source Config Metadata Pipeline type

**Default:** `MlModelMetadata`

**Allowed values:**

- `MlModelMetadata`

## metadataIngestion/parserconfig/queryParserConfig.json

### definitions.QueryParserType

Type of SQL query parser to use for lineage and usage extraction. Auto mode is recommended for best results.

**Default:** `Auto`

**Allowed values:**

- `Auto`
- `SqlGlot`
- `SqlFluff`

## metadataIngestion/pipelineServiceMetadataPipeline.json

### definitions.pipelineMetadataConfigType

Pipeline Source Config Metadata Pipeline type

**Default:** `PipelineMetadata`

**Allowed values:**

- `PipelineMetadata`

### properties.ownershipUpdateMode

Set how owners from source metadata update Pipeline owners. In replace mode, resolved owners from the current source replace existing owners. In append mode, resolved owners are appended to active existing Pipeline owners.

**Default:** `replace`

**Allowed values:**

- `replace`
- `append`

## metadataIngestion/policyAgentPipeline.json

### definitions.policyAgentConfigType

Policy Agent Pipeline type

**Default:** `PolicyAgent`

**Allowed values:**

- `PolicyAgent`

## metadataIngestion/policyagentconfig/databasePolicyConfig.json

### definitions.principalType

Type of principal the grant is issued to.

**Default:** `USER`

**Allowed values:**

- `USER`
- `ROLE`

### definitions.accessType

Access operation the Policy Agent should perform. Grant variants — FullAccess (all columns), ColumnLevel (restricted to the columns listed in 'columns'), Masked (anonymized/masked columns) — grant privileges at the given scope. Revoke tears down whatever the principal currently holds at the scope (a revoke takes back everything, not a specific level).

**Allowed values:**

- `FullAccess`
- `ColumnLevel`
- `Masked`
- `Revoke`

### definitions.requestedAccess

Permission level being requested.

**Allowed values:**

- `Read`
- `Write`
- `Admin`

## metadataIngestion/reverseIngestionPipeline.json

### definitions.reverseIngestionType

Reverse Ingestion Config Pipeline type

**Default:** `ReverseIngestion`

**Allowed values:**

- `ReverseIngestion`

### definitions.operation.properties.type

Type of operation to perform

**Allowed values:**

- `UPDATE_DESCRIPTION`
- `UPDATE_OWNER`
- `UPDATE_TAGS`

## metadataIngestion/searchServiceMetadataPipeline.json

### definitions.searchMetadataConfigType

Search Source Config Metadata Pipeline type

**Default:** `SearchMetadata`

**Allowed values:**

- `SearchMetadata`

## metadataIngestion/securityServiceMetadataPipeline.json

### definitions.securityMetadataConfigType

Security Source Config Metadata Pipeline type

**Default:** `SecurityMetadata`

**Allowed values:**

- `SecurityMetadata`

## metadataIngestion/storageServiceAutoClassificationPipeline.json

### definitions.autoClassificationConfigType

Storage Service Auto Classification Pipeline type

**Default:** `AutoClassification`

**Allowed values:**

- `AutoClassification`

## metadataIngestion/storageServiceMetadataPipeline.json

### definitions.storageMetadataConfigType

Object Store Source Config Metadata Pipeline type

**Default:** `StorageMetadata`

**Allowed values:**

- `StorageMetadata`

## metadataIngestion/testSuitePipeline.json

### definitions.testSuiteConfigType

Pipeline Source Config Metadata Pipeline type

**Default:** `TestSuite`

**Allowed values:**

- `TestSuite`

## metadataIngestion/workflow.json

### definitions.logLevels

Supported logging levels

**Default:** `INFO`

**Allowed values:**

- `DEBUG`
- `INFO`
- `WARN`
- `ERROR`

## monitoring/eventMonitorProvider.json

### (schema)

OpenMetadata Event Monitor Provider.

**Allowed values:**

- `cloudwatch`
- `prometheus`

## search/aggregationRequest.json

### properties.topHits.properties.sortOrder

Sort order for top hits - asc or desc.

**Default:** `asc`

**Allowed values:**

- `asc`
- `desc`

## security/client/oidcClientConfig.json

### properties.clientAuthenticationMethod

Client Authentication Method.

**Allowed values:**

- `client_secret_basic`
- `client_secret_post`
- `client_secret_jwt`
- `private_key_jwt`

## security/credentials/bitbucketCredentials.json

### definitions.bitbucketType

BitBucket Credentials type

**Default:** `BitBucket`

**Allowed values:**

- `BitBucket`

## security/credentials/githubCredentials.json

### definitions.githubType

GitHub Credentials type

**Default:** `GitHub`

**Allowed values:**

- `GitHub`

## security/credentials/gitlabCredentials.json

### definitions.gitlabType

Gitlab Credentials type

**Default:** `Gitlab`

**Allowed values:**

- `Gitlab`

## security/secrets/secretsManagerClientLoader.json

### (schema)

OpenMetadata Secrets Manager Client Loader. Lets the client know how the Secrets Manager Credentials should be loaded from the environment.

**Default:** `noop`

**Allowed values:**

- `noop`
- `airflow`
- `env`

## security/secrets/secretsManagerProvider.json

### (schema)

OpenMetadata Secrets Manager Provider. Make sure to configure the same secrets manager providers as the ones configured on the OpenMetadata server.

**Default:** `db`

**Allowed values:**

- `db`
- `managed-aws`
- `aws`
- `managed-aws-ssm`
- `aws-ssm`
- `managed-azure-kv`
- `azure-kv`
- `in-memory`
- `gcp`
- `kubernetes`

## security/ssl/verifySSLConfig.json

### definitions.verifySSL

Client SSL verification. Make sure to configure the SSLConfig if enabled.

**Default:** `no-ssl`

**Allowed values:**

- `no-ssl`
- `ignore`
- `validate`

### definitions.sslMode

SSL Mode to connect to database.

**Default:** `disable`

**Allowed values:**

- `disable`
- `allow`
- `prefer`
- `require`
- `verify-ca`
- `verify-full`

## settings/settings.json

### definitions.settingType

This schema defines all possible filters enum in OpenMetadata.

**Allowed values:**

- `authorizerConfiguration`
- `authenticationConfiguration`
- `jwtTokenConfiguration`
- `elasticsearch`
- `eventHandlerConfiguration`
- `airflowConfiguration`
- `fernetConfiguration`
- `slackEventPublishers`
- `secretsManagerConfiguration`
- `sandboxModeEnabled`
- `slackChat`
- `emailConfiguration`
- `openMetadataBaseUrlConfiguration`
- `customUiThemePreference`
- `loginConfiguration`
- `slackAppConfiguration`
- `slackBot`
- `slackInstaller`
- `slackState`
- `teamsAppConfiguration`
- `profilerConfiguration`
- `searchSettings`
- `assetCertificationSettings`
- `lineageSettings`
- `workflowSettings`
- `scimConfiguration`
- `securityConfiguration`
- `entityRulesSettings`
- `openLineageSettings`
- `mcpConfiguration`
- `glossaryTermRelationSettings`
- `appConfiguration`

## system/eventPublisherJob.json

### definitions.runMode

This schema publisher run modes.

**Allowed values:**

- `stream`
- `batch`

### definitions.publisherType

This schema event Publisher Types

**Allowed values:**

- `elasticSearch`
- `kafka`

### definitions.indexSettings.properties.translogDurability

'request' = fsync per write (durable). 'async' = fsync on interval (faster, can lose <syncInterval seconds on crash).

**Allowed values:**

- `request`
- `async`

### definitions.bulkIndexOverrides.properties.translogDurability

**Allowed values:**

- `request`
- `async`

### properties.status

This schema publisher run job status.

**Allowed values:**

- `started`
- `running`
- `completed`
- `failed`
- `active`
- `activeError`
- `stopped`
- `success`
- `stopInProgress`

## system/indexingError.json

### definitions.errorSource

**Allowed values:**

- `Job`
- `Reader`
- `Processor`
- `Sink`

## system/securityValidationResponse.json

### properties.status

Overall validation status (success/failed)

**Allowed values:**

- `success`
- `failed`

## system/testLoginResult.json

### properties.status

Overall outcome of the test login.

**Allowed values:**

- `success`
- `failed`

## system/ui/knowledgePanel.json

### properties.entityType

Entity Type.

**Default:** `KnowledgePanel`

**Allowed values:**

- `KnowledgePanel`

## system/ui/page.json

### definitions.pageType

This schema defines the type used for describing different types of pages.

**Allowed values:**

- `LandingPage`
- `Table`
- `StoredProcedure`
- `Database`
- `DatabaseSchema`
- `Topic`
- `Pipeline`
- `Dashboard`
- `DashboardDataModel`
- `DataMarketplace`
- `Container`
- `SearchIndex`
- `Glossary`
- `GlossaryTerm`
- `Domain`
- `DataProduct`
- `APICollection`
- `APIEndpoint`
- `Metric`
- `MlModel`
- `Tag`
- `Classification`
- `Chart`
- `Directory`
- `File`
- `Spreadsheet`
- `Worksheet`

### properties.entityType

Entity Type.

**Default:** `Page`

**Allowed values:**

- `Page`

## tests/basic.json

### definitions.testCaseStatus

Status of Test Case run.

**Allowed values:**

- `Success`
- `Failed`
- `Aborted`
- `Queued`

### definitions.testSuiteExecutionFrequency

How often the test case should run.

**Allowed values:**

- `Hourly`
- `Daily`
- `Weekly`

## tests/resolved.json

### definitions.testCaseFailureReasonType

Reason of Test Case initial failure.

**Allowed values:**

- `FalsePositive`
- `MissingData`
- `Duplicates`
- `OutOfBounds`
- `Other`

## tests/testCaseResolutionStatus.json

### definitions.testCaseResolutionStatusTypes

Test case resolution status type.

**Allowed values:**

- `New`
- `Ack`
- `Assigned`
- `Resolved`

### definitions.severities

Test case resolution status type.

**Allowed values:**

- `Severity1`
- `Severity2`
- `Severity3`
- `Severity4`
- `Severity5`

## tests/testDefinition.json

### definitions.testPlatform

This schema defines the platform where tests are defined and ran.

**Allowed values:**

- `OpenMetadata`
- `GreatExpectations`
- `dbt`
- `Deequ`
- `Soda`
- `Other`

### definitions.testDataType

This enum defines the type of data stored in a column.

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

### definitions.entityType

This enum defines the type for which this test definition applies to.

**Allowed values:**

- `TABLE`
- `COLUMN`

### definitions.testCaseParameterDefinition.properties.validationRule.properties.rule

This enum defines the type to use for a parameter validation rule.

**Allowed values:**

- `EQUALS`
- `NOT_EQUALS`
- `GREATER_THAN_OR_EQUALS`
- `LESS_THAN_OR_EQUALS`

### definitions.dataQualityDimensions

This enum defines the dimension a test case belongs to.

**Allowed values:**

- `Completeness`
- `Accuracy`
- `Consistency`
- `Validity`
- `Uniqueness`
- `Integrity`
- `SQL`
- `NoDimension`

## tests/testSuite.json

### properties.serviceType

Type of database service such as MySQL, BigQuery, Snowflake, Redshift, Postgres...

**Default:** `TestSuite`

**Allowed values:**

- `TestSuite`

## type/aiCompliance.json

### definitions.complianceFramework

Type of AI compliance framework

**Allowed values:**

- `EU_AI_Act`
- `Singapore_Model_AI_Governance`
- `Canada_AIDA`
- `US_AI_Bill_of_Rights`
- `NIST_AI_RMF`
- `ISO_IEC_42001`
- `UK_AI_Regulation`
- `China_AI_Regulations`
- `Custom`

### definitions.euAIActCompliance.properties.riskClassification

Risk classification under EU AI Act

**Allowed values:**

- `Minimal`
- `Limited`
- `High`
- `Unacceptable`

### definitions.euAIActCompliance.properties.conformityAssessment.properties.assessmentType

Type of conformity assessment

**Allowed values:**

- `Internal`
- `ThirdParty`
- `NotRequired`

### definitions.ethicalAIAssessment.properties.privacyLevel

Level of privacy-sensitive data accessed

**Allowed values:**

- `Public`
- `Sensitive`
- `PersonalData`

### definitions.ethicalAIAssessment.properties.fairnessRisk

Risk level for fairness and discrimination

**Allowed values:**

- `Low`
- `Medium`
- `High`

### definitions.ethicalAIAssessment.properties.biasMitigationCoverage

Coverage of bias mitigation measures

**Allowed values:**

- `None`
- `Partial`
- `Full`

### definitions.ethicalAIAssessment.properties.reliabilitySafetyRisk

Risk level for reliability and safety

**Allowed values:**

- `Low`
- `Moderate`
- `High`

### definitions.ethicalAIAssessment.properties.transparencyLevel

Level of transparency in AI operations

**Allowed values:**

- `None`
- `Partial`
- `FullDisclosure`

### definitions.ethicalAIAssessment.properties.environmentalConsciousness

Environmental impact risk level (carbon footprint, energy consumption)

**Allowed values:**

- `LowRisk`
- `MediumRisk`
- `HighRisk`

### definitions.aiComplianceRecord.properties.status

Compliance status

**Allowed values:**

- `Compliant`
- `PartiallyCompliant`
- `NonCompliant`
- `UnderReview`
- `NotApplicable`

### definitions.aiComplianceRecord.properties.scopeAndDeployment.properties.scope

Scope of AI usage

**Allowed values:**

- `Internal`
- `External`
- `Both`

### definitions.aiDetection.properties.source

How this AI asset was detected

**Allowed values:**

- `OutboundApiTraffic`
- `SSOLogs`
- `ConnectorAudit`
- `ManualUpload`
- `Other`

### definitions.aiDetection.properties.flags.items

**Allowed values:**

- `PiiWithoutDpa`
- `NoOwner`
- `NewDeployment`
- `OrgWideEnable`
- `PrivilegedData`

### definitions.aiDetection.properties.severity

Triage severity assigned to this detection

**Allowed values:**

- `High`
- `Medium`
- `Low`

### definitions.remediationAction.properties.priority

**Allowed values:**

- `High`
- `Medium`
- `Low`

### definitions.remediationAction.properties.status

**Allowed values:**

- `Open`
- `InProgress`
- `Done`
- `Deferred`

## type/aiContext.json

### definitions.knowledgeItem.properties.type

The entity type of the knowledge item.

**Allowed values:**

- `glossaryTerm`
- `metric`
- `page`
- `contextMemory`

## type/auditLog.json

### properties.method

HTTP Method used in a call.

**Allowed values:**

- `POST`
- `PUT`
- `PATCH`
- `DELETE`

## type/basic.json

### definitions

**Allowed values:**

- `$comment`
- `description`
- `type`
- `items`

### definitions.providerType

Type of provider of an entity. Some entities are provided by the `system`. Some are entities created and provided by the `user`. Typically `system` provide entities can't be deleted and can only be disabled. Some apps such as AutoPilot create entities with `automation` provider type. These entities can be deleted by the user.

**Default:** `user`

**Allowed values:**

- `system`
- `user`
- `automation`

### definitions.status

State of an action over API.

**Allowed values:**

- `success`
- `failure`
- `aborted`
- `partialSuccess`
- `running`

### definitions.profileSampleType

Type of Profile Sample (percentage or rows)

**Default:** `PERCENTAGE`

**Allowed values:**

- `PERCENTAGE`
- `ROWS`

### definitions.samplingMethodType

Type of Sampling Method (BERNOULLI or SYSTEM)

**Allowed values:**

- `BERNOULLI`
- `SYSTEM`

## type/bulkTaskOperationResult.json

### definitions.bulkTaskOperationResultItem.properties.status

Status of the operation.

**Allowed values:**

- `success`
- `failed`

## type/changeEventType.json

### (schema)

Type of event.

**Allowed values:**

- `entityCreated`
- `entityUpdated`
- `entityFieldsChanged`
- `entityNoChange`
- `entitySoftDeleted`
- `entityDeleted`
- `entityRestored`
- `threadCreated`
- `threadUpdated`
- `postCreated`
- `postUpdated`
- `taskCreated`
- `taskUpdated`
- `taskResolved`
- `taskClosed`
- `logicalTestCaseAdded`
- `suggestionCreated`
- `suggestionUpdated`
- `suggestionAccepted`
- `suggestionRejected`
- `suggestionDeleted`
- `userLogin`
- `userLogout`
- `entityLineageAdded`
- `entityLineageDeleted`
- `entityLineageUpdated`

## type/changeSummaryMap.json

### definitions.changeSource

The source of the change. This will change based on the context of the change (example: manual vs programmatic)

**Default:** `Manual`

**Allowed values:**

- `Manual`
- `Propagated`
- `Automated`
- `Derived`
- `Ingested`
- `Suggested`

## type/classificationLanguages.json

### (schema)

Supported languages for auto classification recognizers (ISO 639-1 codes). Use 'any' to apply all recognizers regardless of their configured language.

**Default:** `en`

**Allowed values:**

- `any`
- `af`
- `sq`
- `am`
- `ar`
- `hy`
- `az`
- `eu`
- `be`
- `bn`
- `bs`
- `bg`
- `ca`
- `zh`
- `hr`
- `cs`
- `da`
- `nl`
- `en`
- `et`
- `fi`
- `fr`
- `gl`
- `ka`
- `de`
- `el`
- `gu`
- `ht`
- `he`
- `hi`
- `hu`
- `is`
- `id`
- `ga`
- `it`
- `ja`
- `kn`
- `kk`
- `km`
- `ko`
- `ku`
- `ky`
- `lo`
- `lv`
- `lt`
- `mk`
- `ms`
- `ml`
- `mt`
- `mi`
- `mr`
- `mn`
- `my`
- `ne`
- `no`
- `ps`
- `fa`
- `pl`
- `pt`
- `pa`
- `ro`
- `ru`
- `sr`
- `si`
- `sk`
- `sl`
- `so`
- `es`
- `sw`
- `sv`
- `tl`
- `ta`
- `te`
- `th`
- `tr`
- `uk`
- `ur`
- `uz`
- `vi`
- `cy`
- `yi`
- `zu`

## type/contractExecutionStatus.json

### (schema)

Status of the data contract execution.

**Allowed values:**

- `Running`
- `Success`
- `Failed`
- `PartialSuccess`
- `Aborted`
- `Queued`

## type/csvErrorType.json

### (schema)

What type of error occurred when importing a CSV file.

**Allowed values:**

- `UNKNOWN`
- `PARSER_FAILURE`
- `INVALID_HEADER`
- `INVALID_FIELD_COUNT`
- `FIELD_REQUIRED`
- `INVALID_FIELD`

## type/dataAccessRequestPayload.json

### definitions.accessType

Scope of access being requested against the target entity.

**Allowed values:**

- `FullAccess`
- `ColumnLevel`
- `Masked`

### definitions.requestedAccess

Permission level for the requested access.

**Default:** `Read`

**Allowed values:**

- `Read`
- `Write`
- `Admin`

## type/descriptionUpdatePayload.json

### properties.source

Source of the update request.

**Default:** `User`

**Allowed values:**

- `User`
- `Agent`
- `AutoPilot`
- `Ingestion`

## type/entityLineage.json

### definitions.lineageDetails.properties.source

Lineage type describes how a lineage was created.

**Default:** `Manual`

**Allowed values:**

- `Manual`
- `ViewLineage`
- `QueryLineage`
- `PipelineLineage`
- `DashboardLineage`
- `DbtLineage`
- `SparkLineage`
- `OpenLineage`
- `ExternalTableLineage`
- `CrossDatabaseLineage`
- `ChildAssets`

## type/entityProfile.json

### definitions.profileTypeEnum

profile type

**Allowed values:**

- `column`
- `table`
- `system`

## type/entityRelationship.json

### definitions.relationshipType

This enum captures all the relationships between Catalog entities. Note that the relationship from is a Strong entity and to is Weak entity when possible.

**Allowed values:**

- `contains`
- `createdBy`
- `repliedTo`
- `isAbout`
- `addressedTo`
- `mentionedIn`
- `testedBy`
- `uses`
- `owns`
- `parentOf`
- `has`
- `follows`
- `joinedWith`
- `upstream`
- `appliedTo`
- `relatedTo`
- `reviews`
- `reactedTo`
- `voted`
- `expert`
- `editedBy`
- `defaultsTo`
- `relatesTo`
- `inputPort`
- `outputPort`
- `assignedTo`

## type/function.json

### definitions.parameterType

**Allowed values:**

- `NotRequired`
- `AllIndexElasticSearch`
- `SpecificIndexElasticSearch`
- `ReadFromParamContext`
- `ReadFromParamContextPerEntity`

## type/glossaryApprovalPayload.json

### properties.action

Action being approved.

**Allowed values:**

- `Create`
- `Update`
- `Delete`

## type/incidentResolutionPayload.json

### properties.incidentType

Type of incident.

**Allowed values:**

- `DataQuality`
- `Pipeline`
- `Schema`
- `Freshness`
- `Volume`
- `Custom`

### properties.severity

Severity of the incident.

**Allowed values:**

- `Critical`
- `High`
- `Medium`
- `Low`

## type/include.json

### (schema)

GET entity by id, GET entity by name, and LIST entities can include deleted or non-deleted entities using the parameter include.

**Allowed values:**

- `all`
- `deleted`
- `non-deleted`

## type/personaContext.json

### definitions.manifestEntry.properties.reason

**Allowed values:**

- `compact`
- `omitted`

## type/personaContextDefinition.json

### definitions.contextSection

A section of an entity's documentation that can be included by a persona context rule.

**Allowed values:**

- `description`
- `schema`
- `constraints`
- `joins`
- `tags`
- `glossaryTerms`
- `articles`
- `metrics`
- `lineage`
- `profile`
- `dataQuality`
- `titleSummary`
- `fullBody`
- `relatedAssets`
- `definition`
- `formulaExpression`
- `unitGrain`
- `owner`
- `synonyms`
- `relatedTerms`

### definitions.cacheState

Current state of the compiled persona context document.

**Allowed values:**

- `FRESH`
- `STALE`
- `GENERATING`
- `FAILED`

## type/personaPreferences.json

### definitions.pageViewMode

Layout a page with a view toggle opens in.

**Allowed values:**

- `table`
- `card`
- `tree`

### properties.appMode

App experience this persona forces on login. Classic keeps the standard OpenMetadata UI; AI enables the assistant-driven experience and requires the AI plugin (e.g. Collate) to be installed.

**Default:** `classic`

**Allowed values:**

- `classic`
- `AI`

## type/piiEntity.json

### (schema)

Enum of PII (Personally Identifiable Information) tags for classification and detection of sensitive data. Based on Presidio supported entities (https://microsoft.github.io/presidio/supported_entities/).

**Allowed values:**

- `CREDIT_CARD`
- `CRYPTO`
- `DATE_TIME`
- `EMAIL_ADDRESS`
- `IBAN_CODE`
- `IP_ADDRESS`
- `NRP`
- `LOCATION`
- `PERSON`
- `PHONE_NUMBER`
- `MEDICAL_LICENSE`
- `URL`
- `US_BANK_NUMBER`
- `US_DRIVER_LICENSE`
- `US_ITIN`
- `US_PASSPORT`
- `US_SSN`
- `UK_NHS`
- `ES_NIF`
- `ES_NIE`
- `IT_FISCAL_CODE`
- `IT_DRIVER_LICENSE`
- `IT_VAT_CODE`
- `IT_PASSPORT`
- `IT_IDENTITY_CARD`
- `PL_PESEL`
- `SG_NRIC_FIN`
- `SG_UEN`
- `AU_ABN`
- `AU_ACN`
- `AU_TFN`
- `AU_MEDICARE`
- `IN_PAN`
- `IN_AADHAAR`
- `IN_VEHICLE_REGISTRATION`
- `IN_VOTER`
- `IN_PASSPORT`
- `FI_PERSONAL_IDENTITY_CODE`

## type/pipelineObservability.json

### properties.lastRunStatus

Status of the last pipeline execution.

**Allowed values:**

- `Successful`
- `Failed`
- `Pending`
- `Skipped`
- `Running`

## type/pipelineSummary.json

### properties.lastRunStatus

Status of last execution

**Default:** `None`

**Allowed values:**

- `Successful`
- `Failed`
- `Pending`
- `Skipped`
- `Running`
- `None`

## type/predefinedRecognizer.json

### properties.name

Name of the recognizer (defaults to class name if not provided)

**Allowed values:**

- `AbaRoutingRecognizer`
- `CreditCardRecognizer`
- `CryptoRecognizer`
- `DateRecognizer`
- `EmailRecognizer`
- `IbanRecognizer`
- `IpRecognizer`
- `NhsRecognizer`
- `MedicalLicenseRecognizer`
- `PhoneRecognizer`
- `SgFinRecognizer`
- `UrlRecognizer`
- `UsBankRecognizer`
- `UsItinRecognizer`
- `UsLicenseRecognizer`
- `UsPassportRecognizer`
- `UsSsnRecognizer`
- `EsNifRecognizer`
- `SpacyRecognizer`
- `StanzaRecognizer`
- `AuAbnRecognizer`
- `AuAcnRecognizer`
- `AuTfnRecognizer`
- `AuMedicareRecognizer`
- `TransformersRecognizer`
- `ItDriverLicenseRecognizer`
- `ItFiscalCodeRecognizer`
- `ItVatCodeRecognizer`
- `ItIdentityCardRecognizer`
- `ItPassportRecognizer`
- `InPanRecognizer`
- `GLiNERRecognizer`
- `PlPeselRecognizer`
- `AzureAILanguageRecognizer`
- `InAadhaarRecognizer`
- `InVehicleRegistrationRecognizer`
- `SgUenRecognizer`
- `InVoterRecognizer`
- `InPassportRecognizer`
- `FiPersonalIdentityCodeRecognizer`
- `EsNieRecognizer`
- `UkNinoRecognizer`

## type/reaction.json

### definitions.reactionType

Type of reaction.

**Allowed values:**

- `thumbsUp`
- `thumbsDown`
- `hooray`
- `laugh`
- `confused`
- `heart`
- `rocket`
- `eyes`

## type/recognizer.json

### definitions.recognizerType

Type of recognizer to use for detection

**Default:** `pattern`

**Allowed values:**

- `pattern`
- `exact_terms`
- `context`
- `predefined`
- `custom`

### properties.target

What the recognizer will analyze for classification. `column_name` means it classifies based on the column's name, `content` uses sample data from the column instead.

**Default:** `content`

**Allowed values:**

- `content`
- `column_name`

## type/recognizerFeedback.json

### properties.feedbackType

Type of feedback

**Default:** `FALSE_POSITIVE`

**Allowed values:**

- `FALSE_POSITIVE`
- `INCORRECT_CLASSIFICATION`
- `OVERLY_BROAD`
- `CONTEXT_SPECIFIC`

### properties.userReason

User-selected reason for reporting

**Allowed values:**

- `NOT_SENSITIVE_DATA`
- `WRONG_DATA_TYPE`
- `INTERNAL_IDENTIFIER`
- `PUBLIC_INFORMATION`
- `TEST_DATA`
- `ENCRYPTED_DATA`
- `OTHER`

### properties.status

Processing status

**Default:** `PENDING`

**Allowed values:**

- `PENDING`
- `REVIEWED`
- `APPLIED`
- `REJECTED`

### properties.resolution.properties.action

**Allowed values:**

- `ADDED_TO_EXCEPTION_LIST`
- `PATTERN_ADJUSTED`
- `THRESHOLD_INCREASED`
- `RECOGNIZER_DISABLED_FOR_ENTITY`
- `NO_ACTION_NEEDED`

## type/recognizerMetadata.json

### properties.target

What the recognizer analyzed to apply this tag

**Allowed values:**

- `content`
- `column_name`

## type/regexMode.json

### (schema)

Controls how regex filters are applied when listing entities. 'include' returns entities matching the pattern, 'exclude' returns entities that do not match.

**Allowed values:**

- `include`
- `exclude`

## type/reviewPayload.json

### definitions.reviewCriterion.properties.status

Status of this criterion.

**Allowed values:**

- `Pending`
- `Passed`
- `Failed`
- `NotApplicable`

### properties.reviewType

Type of review.

**Allowed values:**

- `Pipeline`
- `DataQuality`
- `Schema`
- `Documentation`
- `Security`
- `Custom`

### properties.recommendation

Reviewer's recommendation.

**Allowed values:**

- `Approve`
- `Reject`
- `NeedsWork`
- `Defer`

## type/samplingConfig.json

### definitions.profileSampleConfig.properties.sampleConfigType

Type of sampling to apply. STATIC: fixed sample size. DYNAMIC: sample size determined at runtime based on row count thresholds.

**Default:** `DYNAMIC`

**Allowed values:**

- `STATIC`
- `DYNAMIC`

## type/schema.json

### definitions.schemaType

Schema type used for the message.

**Allowed values:**

- `Avro`
- `Protobuf`
- `JSON`
- `Other`
- `None`

### definitions.dataTypeTopic

This enum defines the type of data defined in schema.

**Allowed values:**

- `RECORD`
- `NULL`
- `BOOLEAN`
- `INT`
- `LONG`
- `BYTES`
- `FLOAT`
- `DOUBLE`
- `TIMESTAMP`
- `TIMESTAMPZ`
- `TIME`
- `DATE`
- `STRING`
- `ARRAY`
- `MAP`
- `ENUM`
- `UNION`
- `FIXED`
- `ERROR`
- `UNKNOWN`

## type/status.json

### (schema)

Status of an entity. It is used for governance and is applied to all the entities in the catalog.

**Default:** `Unprocessed`

**Allowed values:**

- `Draft`
- `In Review`
- `Approved`
- `Archived`
- `Deprecated`
- `Rejected`
- `Unprocessed`

## type/suggestionPayload.json

### properties.suggestionType

Type of suggestion.

**Allowed values:**

- `Description`
- `Tag`
- `Owner`
- `Tier`
- `Domain`
- `CustomProperty`

### properties.source

Source of the suggestion.

**Allowed values:**

- `User`
- `Agent`
- `AutoPilot`
- `Ingestion`

## type/tagLabel.json

### definitions.TagSource

**Default:** `Classification`

**Allowed values:**

- `Classification`
- `Glossary`

### properties.labelType

Label type describes how a tag label was applied. 'Manual' indicates the tag label was applied by a person. 'Derived' indicates a tag label was derived using the associated tag relationship (see Classification.json for more details). 'Propagated` indicates a tag label was propagated from upstream based on lineage. 'Automated' is used when a tool was used to determine the tag label.

**Default:** `Manual`

**Allowed values:**

- `Manual`
- `Propagated`
- `Automated`
- `Derived`
- `Generated`

### properties.state

'Suggested' state is used when a tag label is suggested by users or tools. Owner of the entity must confirm the suggested labels before it is marked as 'Confirmed'.

**Default:** `Confirmed`

**Allowed values:**

- `Suggested`
- `Confirmed`

## type/tagLabelRecognizerMetadata.json

### properties.target

What the recognizer analyzed to apply this tag

**Allowed values:**

- `content`
- `column_name`

## type/tagUpdatePayload.json

### properties.operation

Type of tag operation.

**Default:** `Add`

**Allowed values:**

- `Add`
- `Remove`
- `Replace`

### properties.source

Source of the tag update.

**Default:** `User`

**Allowed values:**

- `User`
- `Agent`
- `AutoPilot`
- `Classification`

## type/testCaseResolutionPayload.json

### properties.severity

Severity of the incident.

**Allowed values:**

- `Severity1`
- `Severity2`
- `Severity3`
- `Severity4`
- `Severity5`

## type/votes.json

### definitions.voteType

Vote Type

**Default:** `unVoted`

**Allowed values:**

- `votedUp`
- `votedDown`
- `unVoted`

## type/workflowTriggerFields.json

### (schema)

Fields that can trigger workflow execution when changed

**Allowed values:**

- `name`
- `displayName`
- `fullyQualifiedName`
- `description`
- `owners`
- `reviewers`
- `tags`
- `certification`
- `domains`
- `dataProducts`
- `extension`
- `deleted`
- `synonyms`
- `relatedTerms`
- `references`
- `glossary`
- `parent`
- `children`
- `experts`
- `style`
- `lifeCycle`
- `schema`
- `semantics`
- `qualityExpectations`
- `termsOfUse`
- `security`
- `sla`
- `testSuite`
- `latestResult`
- `consumesFrom`
- `providesTo`
- `lifecycleStage`
- `glossaryTerms`
- `inputPorts`
- `outputPorts`
- `entityStatus`
