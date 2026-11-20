# Shared Enum Types

Enum fields used across OpenMetadata entity and API schemas. Values and defaults are reproduced from the pinned 2.0.7 source schemas.

## ClassificationLanguage

**Source schema:** `schemas/type/classificationLanguages.json`

## Enum fields

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

## csvErrorType

**Source schema:** `schemas/type/csvErrorType.json`

## Enum fields

### (schema)

What type of error occurred when importing a CSV file.

**Allowed values:**

- `UNKNOWN`
- `PARSER_FAILURE`
- `INVALID_HEADER`
- `INVALID_FIELD_COUNT`
- `FIELD_REQUIRED`
- `INVALID_FIELD`

## RecognizerFeedback

**Source schema:** `schemas/type/recognizerFeedback.json`

## Enum fields

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

## PersonaPreferences

**Source schema:** `schemas/type/personaPreferences.json`

## Enum fields

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

## Reaction

**Source schema:** `schemas/type/reaction.json`

## Enum fields

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

## ReviewPayload

**Source schema:** `schemas/type/reviewPayload.json`

## Enum fields

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

## SamplingConfig

**Source schema:** `schemas/type/samplingConfig.json`

## Enum fields

### definitions.profileSampleConfig.properties.sampleConfigType

Type of sampling to apply. STATIC: fixed sample size. DYNAMIC: sample size determined at runtime based on row count thresholds.

**Default:** `DYNAMIC`

**Allowed values:**

- `STATIC`
- `DYNAMIC`

## TestCaseResolutionPayload

**Source schema:** `schemas/type/testCaseResolutionPayload.json`

## Enum fields

### properties.severity

Severity of the incident.

**Allowed values:**

- `Severity1`
- `Severity2`
- `Severity3`
- `Severity4`
- `Severity5`

## PIIEntity

**Source schema:** `schemas/type/piiEntity.json`

## Enum fields

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

## WorkflowTriggerFields

**Source schema:** `schemas/type/workflowTriggerFields.json`

## Enum fields

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

## Votes

**Source schema:** `schemas/type/votes.json`

## Enum fields

### definitions.voteType

Vote Type

**Default:** `unVoted`

**Allowed values:**

- `votedUp`
- `votedDown`
- `unVoted`

## Thread

**Source schema:** `schemas/entity/feed/thread.json`

## Enum fields

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
