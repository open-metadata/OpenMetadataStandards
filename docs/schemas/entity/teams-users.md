
# Teams & Users

Teams and Users represent the organizational structure and people in OpenMetadata.

## Overview

OpenMetadata's team and user entities model your organization's structure, enabling proper ownership, access control, and collaboration.

## User Entity

**Schema**: `schemas/entity/teams/user.json`

Represents an individual user in the system.

### User Properties

```json
{
  "id": "uuid",
  "name": "john.doe",
  "email": "john.doe@example.com",
  "displayName": "John Doe",
  "description": "Senior Data Engineer",
  "isAdmin": false,
  "isBot": false,
  "profile": {
    "images": {
      "image": "https://example.com/avatar.jpg"
    }
  },
  "teams": [
    {
      "id": "team-uuid",
      "type": "team",
      "name": "DataEngineering"
    }
  ],
  "roles": [
    {
      "id": "role-uuid",
      "type": "role",
      "name": "DataEngineer"
    }
  ],
  "timezone": "America/Los_Angeles",
  "isEmailVerified": true
}
```

### User Types

- **Regular Users**: Standard platform users
- **Admin Users**: Platform administrators (`isAdmin: true`)
- **Bot Users**: Service accounts and automation (`isBot: true`)

### User Attributes

- **Identity**: Email, username, display name
- **Profile**: Avatar, bio, timezone
- **Membership**: Teams they belong to
- **Roles**: Assigned permission roles
- **Ownership**: Assets they own
- **Following**: Assets they're following

## Team Entity

**Schema**: `schemas/entity/teams/team.json`

Represents groups of users working together.

### Team Properties

```json
{
  "id": "uuid",
  "name": "DataEngineering",
  "displayName": "Data Engineering",
  "description": "Team responsible for data pipelines and infrastructure",
  "teamType": "Department",
  "email": "data-eng@example.com",
  "parents": [
    {
      "id": "parent-team-uuid",
      "type": "team",
      "name": "Engineering"
    }
  ],
  "children": [
    {
      "id": "child-team-uuid",
      "type": "team",
      "name": "DataPlatform"
    }
  ],
  "users": [
    {
      "id": "user-uuid",
      "type": "user",
      "name": "john.doe"
    }
  ],
  "owns": [
    {
      "id": "asset-uuid",
      "type": "table",
      "name": "customer_data"
    }
  ]
}
```

### Team Types

- **Organization**: Top-level organizational unit
- **Business Unit**: Major business division
- **Department**: Functional department
- **Division**: Sub-department
- **Group**: Working group or squad

### Team Hierarchy

Teams can have parent-child relationships:

```
Organization: Acme Corp
  └── Business Unit: Engineering
        ├── Department: Data Engineering
        │     ├── Group: Data Platform
        │     └── Group: Analytics Engineering
        └── Department: Software Engineering
```

### Team Capabilities

- **Ownership**: Teams can own data assets
- **Membership**: Users belong to teams
- **Hierarchy**: Nested team structures
- **Delegation**: Ownership can be delegated through hierarchy

## Roles

**Schema**: `schemas/entity/teams/role.json`

Roles define permissions and access levels.

### Role Properties

```json
{
  "id": "uuid",
  "name": "DataSteward",
  "displayName": "Data Steward",
  "description": "Responsible for data governance and quality",
  "policies": [
    {
      "id": "policy-uuid",
      "type": "policy",
      "name": "DataGovernancePolicy"
    }
  ]
}
```

### Built-in Roles

- **Admin**: Full platform access
- **Data Steward**: Governance and quality management
- **Data Engineer**: Pipeline and infrastructure management
- **Data Analyst**: Data discovery and analysis
- **Data Consumer**: Read-only data access

### Custom Roles

Organizations can define custom roles:
- Define specific permissions through policies
- Assign to users and teams
- Control access to specific assets or operations

## Personas

**Schema**: `schemas/entity/teams/persona.json`

Personas represent user archetypes and their typical workflows.

### Persona Types

- **Data Engineer**: Builds and maintains pipelines
- **Data Analyst**: Analyzes data and creates reports
- **Data Scientist**: Builds ML models
- **Data Steward**: Ensures data quality and governance
- **Business User**: Consumes data for business decisions

### Persona Benefits

- Tailored UI experiences
- Role-specific documentation
- Relevant asset recommendations
- Customized dashboards

## Ownership Model

### Asset Ownership

Assets can be owned by:
- **Individual Users**: Personal ownership
- **Teams**: Shared team ownership
- **Combination**: Primary owner + reviewers/stakeholders

### Ownership Inheritance

- Assets can inherit ownership from parent containers
- Example: Tables inherit from database → service owner

### Ownership Responsibilities

Owners are responsible for:
- Maintaining accurate descriptions
- Ensuring data quality
- Responding to access requests
- Updating documentation
- Setting appropriate tags and classifications

## Collaboration Features

### Following

Users can follow assets to:
- Receive notifications on changes
- Track important datasets
- Build personal catalogs

### Activity Feed

Track user activities:
- Asset updates
- Ownership changes
- Comments and discussions
- Test results

### Notifications

Users receive notifications for:
- Changes to followed assets
- Mentions in discussions
- Task assignments
- Quality test failures

## Authentication & Authorization

### Authentication Methods

- **Basic Auth**: Username/password
- **LDAP**: Enterprise directory
- **OAuth 2.0**: Google, GitHub, Okta
- **SAML**: Enterprise SSO
- **OIDC**: OpenID Connect

### Authorization

Access control based on:
- User roles
- Team membership
- Asset ownership
- Policy rules

## Best Practices

1. **Team Structure**: Mirror your org structure
2. **Ownership**: Every asset should have an owner
3. **Role Assignment**: Assign appropriate roles
4. **Regular Reviews**: Audit access and ownership
5. **Documentation**: Document team responsibilities
6. **Onboarding**: Process for adding new users
7. **Offboarding**: Process for removing users

## Related Documentation

- [Policies & Roles](policies-roles.md) - Access control policies
- [Data Assets](data-assets.md) - Asset ownership
- [Configuration](../configuration/authentication.md) - Authentication setup
