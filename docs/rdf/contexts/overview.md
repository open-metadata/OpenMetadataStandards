
# JSON-LD Contexts Overview

JSON-LD context files for semantic JSON.

## Available Contexts

- `base.jsonld` - Base context
- `activity.jsonld` - Activity Stream events and configuration
- `ai.jsonld` - AI, LLM, MCP, and AI governance
- `announcement.jsonld` - Announcements
- `contextCenter.jsonld` - Context Center content and memories
- `dataAsset.jsonld` and `dataAsset-complete.jsonld` - Data assets
- `entityRelationship.jsonld` - Entity relationships
- `governance.jsonld` - Governance
- `intakeForm.jsonld` - Governance intake forms
- `learning.jsonld` - Learning resources
- `operations.jsonld` - Operational entities
- `quality.jsonld` - Data quality
- `service.jsonld` - Services
- `task.jsonld` - Tasks and task forms
- `team.jsonld` - Teams and users
- `thread.jsonld` - Legacy discussion threads

!!! note "Task terms in 2.0"
    `task.jsonld` maps the first-class Task entity to `om:GovernanceTask`, preserving `om:Task` for
    the nested pipeline task model used by `dataAsset-complete.jsonld`.

## Usage

```json
{
  "@context": "https://open-metadata.org/contexts/dataAsset.jsonld",
  "@type": "Table",
  "name": "customers"
}
```

## Related Documentation
- [Using Contexts](usage.md)
