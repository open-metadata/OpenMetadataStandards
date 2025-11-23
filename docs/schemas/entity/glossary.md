
# Glossary

Business glossary and terminology management in OpenMetadata.

## Overview

Glossaries define business terminology, providing a common vocabulary for data assets across the organization.

## Glossary Entity

**Schema**: `schemas/entity/data/glossary.json`

A glossary is a collection of business terms.

```json
{
  "id": "uuid",
  "name": "BusinessGlossary",
  "displayName": "Business Glossary",
  "description": "Corporate business terminology",
  "owner": {
    "type": "team",
    "name": "DataGovernance"
  },
  "terms": [],
  "reviewers": [
    {
      "type": "user",
      "name": "john.doe"
    }
  ]
}
```

## Glossary Terms

**Schema**: `schemas/entity/data/glossaryTerm.json`

Individual business terms within a glossary.

### Term Structure

```json
{
  "id": "uuid",
  "name": "Customer",
  "fullyQualifiedName": "BusinessGlossary.Customer",
  "displayName": "Customer",
  "description": "An individual or organization that purchases our products or services",
  "glossary": {
    "id": "glossary-uuid",
    "type": "glossary",
    "name": "BusinessGlossary"
  },
  "synonyms": ["Client", "Consumer", "Buyer"],
  "relatedTerms": [
    {
      "id": "term-uuid",
      "type": "glossaryTerm",
      "name": "Account"
    }
  ],
  "references": [
    {
      "name": "Company Policy",
      "endpoint": "https://wiki.example.com/customer-definition"
    }
  ],
  "status": "Approved",
  "reviewers": []
}
```

### Term Properties

- **Name & Description**: Clear definition
- **Synonyms**: Alternative names
- **Related Terms**: Conceptually related terms
- **References**: External documentation
- **Status**: Draft, Approved, Deprecated
- **Reviewers**: Who reviews this term

### Term Relationships

- **Synonyms**: `Customer` = `Client`
- **Related**: `Customer` ~ `Account`
- **Parent/Child**: `Customer` → `Enterprise Customer`, `Individual Customer`

## Linking Terms to Assets

Associate glossary terms with data assets:

```json
{
  "name": "customers_table",
  "glossaryTerms": [
    {
      "id": "term-uuid",
      "type": "glossaryTerm",
      "name": "Customer"
    }
  ]
}
```

### Benefits

- Discover assets by business meaning
- Understand data in business context
- Ensure consistent terminology
- Bridge technical and business users

## Glossary Workflow

### 1. Create Glossary

Define top-level glossaries by domain:
- Business Glossary
- Technical Glossary
- Domain-Specific Glossaries

### 2. Define Terms

Add terms with:
- Clear definitions
- Synonyms and related terms
- Examples
- References

### 3. Review & Approve

- Assign reviewers
- Review process
- Approve or request changes
- Publish approved terms

### 4. Apply to Assets

- Tag assets with terms
- Document relationships
- Enable discovery

### 5. Maintain

- Regular reviews
- Update definitions
- Deprecate old terms
- Add new terms

## Hierarchical Terms

Terms can be organized hierarchically:

```
Customer
├── Enterprise Customer
│   ├── Fortune 500 Customer
│   └── Mid-Market Customer
└── Individual Customer
    ├── Premium Customer
    └── Standard Customer
```

## Term Status

- **Draft**: Being defined
- **Approved**: Reviewed and approved
- **Deprecated**: No longer used
- **Deleted**: Removed (soft delete)

## Best Practices

1. **Business Language**: Use business terminology, not technical jargon
2. **Clear Definitions**: Avoid ambiguity
3. **Consistent Structure**: Use templates
4. **Review Process**: Formal approval workflow
5. **Regular Updates**: Keep current
6. **Stewardship**: Assign term owners
7. **Usage Tracking**: Monitor term usage

## Related Documentation

- [Data Assets](data-assets.md)
- [Teams & Users](teams-users.md)
