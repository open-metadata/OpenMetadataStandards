
# Schema Evolution

Managing schema changes over time.

## Principles

### Backward Compatibility
- Never remove required fields
- Add new fields as optional
- Deprecate before removing

### Forward Compatibility
- Ignore unknown fields
- Validate against schema version

## Evolution Process

1. Propose change
2. Review impact
3. Update schema
4. Increment version
5. Document migration
6. Deprecate old patterns

## Deprecation Policy

Fields marked deprecated:
- Remain for 2 major versions
- Documentation updated
- Migration path provided

## Related Documentation
- [Versioning](versioning.md)
- [Schema Overview](../schemas/overview.md)
