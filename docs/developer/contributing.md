
# Contributing

This page provides guidelines for contributing to OpenMetadata Standards.

## Quick Start

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Areas to Contribute

- Schema improvements
- Documentation
- Examples
- RDF ontology enhancements
- Testing and validation
- Tooling and automation

## Getting Help

- Slack: [#openmetadata-standards](https://slack.open-metadata.org)
- GitHub Discussions
- Documentation

Thank you for contributing!

## How to Contribute

We welcome contributions from the community! Here's how you can help:

### Reporting Issues

If you find a bug or have a suggestion:

1. Check existing [GitHub Issues](https://github.com/open-metadata/OpenMetadataStandards/issues)
2. Create a new issue with:
   - Clear title and description
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Schema version

### Proposing Schema Changes

For schema changes:

1. Open a discussion first
2. Create a proposal outlining:
   - Problem being solved
   - Proposed solution
   - Backward compatibility impact
   - Migration path
3. Wait for community feedback
4. Implement after consensus

### Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes
4. Test thoroughly
5. Commit with clear messages
6. Push and create a Pull Request

## Development Guidelines

### JSON Schema Best Practices

- Use `$ref` for reusability
- Provide clear descriptions
- Include examples
- Set appropriate constraints
- Add version information

### Documentation

- Update relevant documentation
- Add code examples
- Use clear, concise language
- Include diagrams where helpful

### Testing

Before submitting:

```bash
# Validate schemas
npm run validate:schemas

# Build documentation
mkdocs build --strict
```

## Code of Conduct

Be respectful and professional in all interactions.

## Getting Help

- **Slack**: [Join #openmetadata-standards](https://slack.open-metadata.org)
- **GitHub Discussions**: Ask questions
- **Documentation**: Read the docs

## Recognition

Contributors will be recognized in release notes and documentation.

For complete contribution guidelines, see the [CONTRIBUTING.md](https://github.com/open-metadata/OpenMetadataStandards/blob/main/CONTRIBUTING.md) file in the repository.
