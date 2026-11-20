# OpenLineage Broker Configuration

OpenLineage pipeline events can be consumed from Kafka or AWS Kinesis. The broker configuration properties are defined by the pinned 2.0.7 schemas.

## Kafka

**Source schema:** `schemas/entity/services/connections/pipeline/openlineage/kafkaBrokerConfig.json`

### consumerOffsets

Initial Kafka consumer offset.

**Default:** `earliest`

**Allowed values:**

- `earliest`
- `latest`

### securityProtocol

Kafka security protocol configuration.

**Default:** `PLAINTEXT`

**Allowed values:**

- `PLAINTEXT`
- `SASL_PLAINTEXT`
- `SSL`
- `SASL_SSL`

## AWS Kinesis

**Source schema:** `schemas/entity/services/connections/pipeline/openlineage/kinesisBrokerConfig.json`

### consumerOffsets

Initial Kinesis shard iterator type.

**Default:** `TRIM_HORIZON`

**Allowed values:**

- `TRIM_HORIZON`
- `LATEST`
