# Domain

A `Domain` is a bounded context that is aligned with a Business Unit or a function within an organization.

## Overview

Domains provide a way to organize data assets by business domains, enabling better ownership and governance. They support hierarchical structures with parent-child relationships and can be categorized by type (Source-aligned, Consumer-aligned, or Aggregate).

## JSON Schema

```json
{
  "$id": "https://open-metadata.org/schema/entity/domains/domain.json",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Domain",
  "description": "A `Domain` is a bounded context that is aligned with a Business Unit or a function within an organization.",
  "type": "object",
  "properties": {
    "id": {
      "description": "Unique ID of the Domain",
      "$ref": "../../type/basic.json#/definitions/uuid"
    },
    "domainType": {
      "description": "Domain type",
      "type": "string",
      "enum": ["Source-aligned", "Consumer-aligned", "Aggregate"]
    },
    "name": {
      "description": "A unique name of the Domain",
      "$ref": "../../type/basic.json#/definitions/entityName"
    },
    "fullyQualifiedName": {
      "description": "FullyQualifiedName same as `name`.",
      "$ref": "../../type/basic.json#/definitions/fullyQualifiedEntityName"
    },
    "displayName": {
      "description": "Name used for display purposes. Example 'Marketing', 'Payments', etc.",
      "type": "string"
    },
    "description": {
      "description": "Description of the Domain.",
      "$ref": "../../type/basic.json#/definitions/markdown"
    },
    "style": {
      "$ref": "../../type/basic.json#/definitions/style"
    },
    "version": {
      "description": "Metadata version of the entity.",
      "$ref": "../../type/entityHistory.json#/definitions/entityVersion"
    },
    "updatedAt": {
      "description": "Last update time corresponding to the new version of the entity in Unix epoch time milliseconds.",
      "$ref": "../../type/basic.json#/definitions/timestamp"
    },
    "updatedBy": {
      "description": "User who made the update.",
      "type": "string"
    },
    "impersonatedBy": {
      "description": "Bot user that performed the action on behalf of the actual user.",
      "$ref": "../../type/basic.json#/definitions/impersonatedBy"
    },
    "href": {
      "description": "Link to the resource corresponding to this entity.",
      "$ref": "../../type/basic.json#/definitions/href"
    },
    "parent": {
      "description": "Parent domains. When 'null' or not set, indicates that this is the top level domain.",
      "$ref": "../../type/entityReference.json"
    },
    "children": {
      "description": "Children domains or sub-domains.",
      "$ref": "../../type/entityReferenceList.json"
    },
    "childrenCount": {
      "description": "Count of all nested children domains under this domain",
      "type": "integer"
    },
    "owners": {
      "description": "Owners of this Domain.",
      "$ref": "../../type/entityReferenceList.json"
    },
    "experts": {
      "description": "List of users who are experts in this Domain.",
      "$ref": "../../type/entityReferenceList.json"
    },
    "assets": {
      "description": "Data assets collection that is part of this domain.",
      "$ref": "../../type/entityReferenceList.json",
      "deprecated": true
    },
    "tags": {
      "description": "Tags associated with the Domain.",
      "type": "array",
      "items": {
        "$ref": "../../type/tagLabel.json"
      }
    },
    "changeDescription": {
      "description": "Change that lead to this version of the entity.",
      "$ref": "../../type/entityHistory.json#/definitions/changeDescription"
    },
    "incrementalChangeDescription": {
      "description": "Change that lead to this version of the entity.",
      "$ref": "../../type/entityHistory.json#/definitions/changeDescription"
    },
    "extension": {
      "description": "Entity extension data with custom attributes added to the entity.",
      "$ref": "../../type/basic.json#/definitions/entityExtension"
    },
    "followers": {
      "description": "Followers of this entity.",
      "$ref": "../../type/entityReferenceList.json"
    }
  },
  "required": ["id", "name", "description", "domainType"]
}
```

## Properties

### Core Properties

- **id** (uuid, required): Unique identifier of the Domain
- **name** (string, required): A unique name of the Domain
- **fullyQualifiedName** (string): FullyQualifiedName same as `name`
- **displayName** (string): Name used for display purposes (e.g., 'Marketing', 'Payments')
- **description** (markdown, required): Description of the Domain
- **domainType** (enum, required): Type of domain - one of:
  - `Source-aligned`: Domain aligned with data sources
  - `Consumer-aligned`: Domain aligned with data consumers
  - `Aggregate`: Aggregate domain combining multiple domains

### Hierarchy Properties

- **parent** (EntityReference): Parent domain. When null or not set, indicates this is a top-level domain
- **children** (EntityReferenceList): Child domains or sub-domains
- **childrenCount** (integer): Count of all nested children domains under this domain

### Ownership & Collaboration

- **owners** (EntityReferenceList): Owners of this Domain
- **experts** (EntityReferenceList): List of users who are experts in this Domain
- **followers** (EntityReferenceList): Followers of this entity

### Asset Management

- **assets** (EntityReferenceList, deprecated): Data assets collection that is part of this domain
  - Note: This property is deprecated. Use `GET /v1/domains/{id}/assets` API endpoint for paginated access to domain assets

### Metadata Properties

- **style** (Style): Visual styling information for the domain
- **tags** (array of TagLabel): Tags associated with the Domain
- **version** (number): Metadata version of the entity
- **updatedAt** (timestamp): Last update time in Unix epoch time milliseconds
- **updatedBy** (string): User who made the update
- **impersonatedBy** (string): Bot user that performed the action on behalf of the actual user
- **href** (string): Link to the resource corresponding to this entity
- **changeDescription** (ChangeDescription): Change that led to this version of the entity
- **incrementalChangeDescription** (ChangeDescription): Incremental change information
- **extension** (EntityExtension): Entity extension data with custom attributes

## RDF Representation

```turtle
@prefix om: <https://open-metadata.org/schema/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

om:Domain a owl:Class ;
    rdfs:label "Domain" ;
    rdfs:comment "A Domain is a bounded context that is aligned with a Business Unit or a function within an organization." ;
    rdfs:subClassOf om:Entity .

om:domainType a owl:DatatypeProperty ;
    rdfs:label "domainType" ;
    rdfs:comment "Domain type" ;
    rdfs:domain om:Domain ;
    rdfs:range xsd:string .

om:parent a owl:ObjectProperty ;
    rdfs:label "parent" ;
    rdfs:comment "Parent domains. When null or not set, indicates that this is the top level domain." ;
    rdfs:domain om:Domain ;
    rdfs:range om:Domain .

om:children a owl:ObjectProperty ;
    rdfs:label "children" ;
    rdfs:comment "Children domains or sub-domains." ;
    rdfs:domain om:Domain ;
    rdfs:range om:Domain .

om:childrenCount a owl:DatatypeProperty ;
    rdfs:label "childrenCount" ;
    rdfs:comment "Count of all nested children domains under this domain" ;
    rdfs:domain om:Domain ;
    rdfs:range xsd:integer .

om:experts a owl:ObjectProperty ;
    rdfs:label "experts" ;
    rdfs:comment "List of users who are experts in this Domain." ;
    rdfs:domain om:Domain ;
    rdfs:range om:User .

om:assets a owl:ObjectProperty ;
    rdfs:label "assets" ;
    rdfs:comment "Data assets collection that is part of this domain." ;
    rdfs:domain om:Domain ;
    owl:deprecated true .
```

## JSON-LD Context

```json
{
  "@context": {
    "@vocab": "https://open-metadata.org/schema/",
    "om": "https://open-metadata.org/schema/",
    "xsd": "http://www.w3.org/2001/XMLSchema#",
    "id": "@id",
    "type": "@type",
    "Domain": "om:Domain",
    "domainType": {
      "@id": "om:domainType",
      "@type": "xsd:string"
    },
    "name": {
      "@id": "om:name",
      "@type": "xsd:string"
    },
    "fullyQualifiedName": {
      "@id": "om:fullyQualifiedName",
      "@type": "xsd:string"
    },
    "displayName": {
      "@id": "om:displayName",
      "@type": "xsd:string"
    },
    "description": {
      "@id": "om:description",
      "@type": "xsd:string"
    },
    "parent": {
      "@id": "om:parent",
      "@type": "@id"
    },
    "children": {
      "@id": "om:children",
      "@type": "@id",
      "@container": "@set"
    },
    "childrenCount": {
      "@id": "om:childrenCount",
      "@type": "xsd:integer"
    },
    "owners": {
      "@id": "om:owners",
      "@type": "@id",
      "@container": "@set"
    },
    "experts": {
      "@id": "om:experts",
      "@type": "@id",
      "@container": "@set"
    },
    "assets": {
      "@id": "om:assets",
      "@type": "@id",
      "@container": "@set"
    },
    "tags": {
      "@id": "om:tags",
      "@type": "@id",
      "@container": "@set"
    },
    "followers": {
      "@id": "om:followers",
      "@type": "@id",
      "@container": "@set"
    },
    "version": {
      "@id": "om:version",
      "@type": "xsd:decimal"
    },
    "updatedAt": {
      "@id": "om:updatedAt",
      "@type": "xsd:dateTime"
    },
    "updatedBy": {
      "@id": "om:updatedBy",
      "@type": "xsd:string"
    },
    "href": {
      "@id": "om:href",
      "@type": "@id"
    }
  }
}
```

## Example

```json
{
  "@context": "https://open-metadata.org/schema/entity/domains/domain.jsonld",
  "@type": "Domain",
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "name": "marketing",
  "fullyQualifiedName": "marketing",
  "displayName": "Marketing",
  "description": "Marketing domain containing all marketing-related data assets",
  "domainType": "Consumer-aligned",
  "owners": [
    {
      "id": "user123",
      "type": "user",
      "name": "john.doe"
    }
  ],
  "experts": [
    {
      "id": "user456",
      "type": "user",
      "name": "jane.smith"
    }
  ],
  "parent": null,
  "children": [
    {
      "id": "subdomain123",
      "type": "domain",
      "name": "marketing.campaigns"
    }
  ],
  "childrenCount": 1,
  "tags": [
    {
      "tagFQN": "PII.Sensitive",
      "labelType": "Manual"
    }
  ],
  "version": 1.0,
  "updatedAt": 1701234567890,
  "updatedBy": "admin",
  "href": "https://open-metadata.org/api/v1/domains/a1b2c3d4-e5f6-7890-abcd-ef1234567890"
}
```

## Related Documentation

- [Governance Overview](overview.md)
- [Data Products](../data-products/overview.md)
