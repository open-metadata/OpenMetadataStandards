# ResourcePermission

A set of permissions for a user that shows what operation is denied, allowed, or not allowed for all the resources.

**Source schema:** `schemas/entity/policies/accessControl/resourcePermission.json`

## Properties

The following table summarizes the direct properties defined by this schema.

| Property | Type | Description |
|---|---|---|
| `resource` | `string` | Name of the resource |
| `permissions` | `array` | Permissions for a `resource`. |

## Enum fields

### definitions.permission.properties.access

Access decided after evaluating rules in a policy. Note the access is defined in the order of precedence.

**Allowed values:**

- `deny`
- `allow`
- `conditionalDeny`
- `conditionalAllow`
- `notAllow`
