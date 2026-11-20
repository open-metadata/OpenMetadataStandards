# IntakeForm

An **IntakeForm** declares the fields shown when creating or updating a governance entity and which fields are required. Required fields are enforced consistently at the API and UI layers.

**Source schema:** `schemas/governance/intakeForm.json`

## Enum fields

### entityType

The entity type this IntakeForm applies to.

**Allowed values:**

- `dataProduct`
- `domain`
- `glossary`
- `glossaryTerm`
- `metric`

### targetEntityType

Entity types supported by IntakeForm.

**Allowed values:**

- `dataProduct`
- `domain`
- `glossary`
- `glossaryTerm`
- `metric`

### fieldKind

Whether a required field refers to a native entity attribute or a custom property defined by the Type system.

**Allowed values:**

- `native`
- `customProperty`
