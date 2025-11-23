
# Policies & Roles

Access control, permissions, and governance policies in OpenMetadata.

## Overview

OpenMetadata uses a role-based access control (RBAC) system combined with attribute-based policies to manage permissions and enforce governance rules.

## Roles

**Schema**: `schemas/entity/teams/role.json`

Roles group permissions and are assigned to users and teams.

### Role Structure

```json
{
  "id": "uuid",
  "name": "DataSteward",
  "displayName": "Data Steward",
  "description": "Manages data quality and governance",
  "policies": [
    {
      "id": "policy-uuid",
      "type": "policy",
      "name": "TagManagementPolicy"
    }
  ]
}
```

### Built-in Roles

- **Admin**: Full system access
- **Data Steward**: Governance management
- **Data Engineer**: Technical operations
- **Data Analyst**: Data discovery and analysis
- **Data Consumer**: Read-only access

## Policies

**Schema**: `schemas/entity/policies/policy.json`

Policies define rules for access control and governance.

### Policy Types

#### Access Control Policies

Control who can perform what actions:

```json
{
  "name": "TableEditPolicy",
  "policyType": "AccessControl",
  "rules": [
    {
      "name": "AllowTableOwnerEdit",
      "effect": "allow",
      "operations": ["EditAll"],
      "resources": ["table"],
      "condition": "isOwner()"
    }
  ]
}
```

#### Lifecycle Policies

Manage asset lifecycles:

- Retention policies
- Archival rules
- Deletion workflows

### Policy Rules

Each rule contains:

- **Effect**: `allow` or `deny`
- **Resources**: Assets affected (table, dashboard, etc.)
- **Operations**: Actions (ViewAll, EditAll, Delete, etc.)
- **Conditions**: When the rule applies

### Operations

Standard operations:

- `ViewAll`: View asset and metadata
- `ViewBasic`: View basic info only
- `ViewUsage`: View usage statistics
- `ViewTests`: View quality tests
- `EditAll`: Edit all metadata
- `EditDescription`: Edit descriptions only
- `EditOwners`: Edit ownership
- `EditTags`: Edit tags
- `EditCustomFields`: Edit custom properties
- `Delete`: Delete assets
- `EditLineage`: Edit lineage
- `SuggestTags`: Suggest tags
- `SuggestDescription`: Suggest descriptions

## Permissions Model

### Resource-Based Permissions

Permissions are checked at the resource level:

```
User → Role → Policy → Rule → Resource → Operation
```

### Ownership-Based Access

Asset owners automatically get edit permissions:

- **Owner**: Full edit access to owned assets
- **Non-Owner**: Restricted by policies

### Team-Based Access

Team membership affects permissions:

- Team ownership grants team members access
- Hierarchical teams can inherit permissions

## Access Conditions

Policies support conditional access:

### Ownership Conditions

```
isOwner() - User is the asset owner
matchAnyOwner() - User is in owner's team
```

### Tag-Based Conditions

```
hasTag('PII.Sensitive') - Asset has specific tag
noTags() - Asset has no tags
```

### Custom Conditions

Define custom access logic based on:
- User properties
- Team membership
- Asset properties
- Time-based rules

## Governance Policies

### Data Classification

Automatically classify data:

```json
{
  "name": "PII_Classification",
  "policyType": "Lifecycle",
  "rules": [
    {
      "name": "DetectEmail",
      "condition": "columnNameMatches('.*email.*')",
      "action": "addTag('PII.Email')"
    }
  ]
}
```

### Quality Enforcement

Require quality tests:

```json
{
  "name": "RequireQualityTests",
  "rules": [
    {
      "condition": "hasTag('Tier.Gold')",
      "require": "hasQualityTests()"
    }
  ]
}
```

## Policy Examples

### Restrict Sensitive Data Access

```json
{
  "name": "SensitiveDataPolicy",
  "rules": [
    {
      "effect": "deny",
      "resources": ["table"],
      "operations": ["ViewAll"],
      "condition": "hasTag('PII.Sensitive') AND !hasRole('DataSteward')"
    }
  ]
}
```

### Require Documentation

```json
{
  "name": "DocumentationPolicy",
  "rules": [
    {
      "effect": "deny",
      "operations": ["Publish"],
      "condition": "!hasDescription() OR !hasOwner()"
    }
  ]
}
```

## Best Practices

1. **Least Privilege**: Grant minimum necessary permissions
2. **Role Hierarchy**: Use roles for common permission sets
3. **Policy Testing**: Test policies before deployment
4. **Regular Audits**: Review access regularly
5. **Documentation**: Document policy rationale
6. **Change Management**: Version and track policy changes

## Related Documentation

- [Teams & Users](teams-users.md)
- [Data Assets](data-assets.md)
- [Configuration](../configuration/authorization.md)
