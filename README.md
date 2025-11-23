<div align="center">

<img src="./docs/assets/logo.png" alt="OpenMetadata Standards" width="300" height="350"/>

# OpenMetadata Standards

### The Foundation for Modern Metadata Management

**Comprehensive schemas, ontologies, and specifications powering unified metadata across the data ecosystem**

[![Deploy Docs](https://github.com/open-metadata/OpenMetadataStandards/actions/workflows/deploy-docs.yml/badge.svg)](https://github.com/open-metadata/OpenMetadataStandards/actions/workflows/deploy-docs.yml)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Documentation](https://img.shields.io/badge/docs-latest-brightgreen.svg)](https://openmetadatastandards.org)
[![Slack](https://img.shields.io/badge/slack-join-orange.svg)](https://slack.open-metadata.org)
[![GitHub Stars](https://img.shields.io/github/stars/open-metadata/OpenMetadataStandards?style=social)](https://github.com/open-metadata/OpenMetadataStandards/stargazers)

[Documentation](https://openmetadatastandards.org) | [Getting Started](https://openmetadatastandards.org/getting-started/quick-start/) | [Examples](https://openmetadatastandards.org/examples/) | [Community](https://slack.open-metadata.org)

</div>

---

## 🌟 What is OpenMetadata Standards?

**OpenMetadata Standards** is the official repository for comprehensive metadata schemas, ontologies, and specifications that power the [OpenMetadata](https://open-metadata.org) platform and ecosystem. It provides a **unified, open-source framework** for representing, validating, and exchanging metadata across the entire data landscape.

Built with **open standards** and designed for **interoperability**, OpenMetadata Standards enables organizations to:

- 📊 **Unify metadata** across databases, data warehouses, data lakes, ML models, dashboards, and APIs
- 🔍 **Discover and catalog** data assets with rich, structured metadata
- 🎯 **Govern data** with policies, classifications, and glossaries
- 🔗 **Track lineage** from source to consumption across multi-platform data pipelines
- ✅ **Ensure quality** with comprehensive data validation and profiling schemas
- 🌐 **Build knowledge graphs** using RDF/OWL ontologies and semantic web standards
- 🔄 **Integrate seamlessly** with existing tools through JSON Schema, OpenAPI, and JSON-LD

---

## 📦 What's Inside

<table>
<tr>
<td width="50%">

### 🎯 JSON Schemas
**700+ comprehensive schemas** covering:
- **Entities**: Tables, databases, topics, dashboards, pipelines, ML models, APIs
- **Types**: Rich type system with custom properties
- **APIs**: Complete OpenAPI specifications
- **Events**: Change events and audit logs
- **Config**: Service and integration configurations

</td>
<td width="50%">

### 🌐 RDF & Semantic Web
**Semantic standards** for linked data:
- **OWL Ontology**: Full OpenMetadata ontology
- **SHACL Shapes**: Validation constraints
- **JSON-LD Contexts**: Semantic contexts
- **PROV-O**: Provenance and lineage tracking
- **SKOS**: Knowledge organization

</td>
</tr>
<tr>
<td width="50%">

### 📚 Documentation
**Comprehensive guides** including:
- Interactive schema documentation
- API reference with 200+ endpoints
- Real-world examples and patterns
- Integration guides
- Best practices

</td>
<td width="50%">

### 🔧 Developer Tools
**Resources for developers**:
- Schema validation examples
- Code generation templates
- Testing frameworks
- Migration guides
- SDK patterns

</td>
</tr>
</table>

---

## 🚀 Key Capabilities

### 🗂️ Data Asset Schemas

Comprehensive metadata models for all data assets:

<table>
<tr>
<td><b>Databases</b></td>
<td>Tables, Columns, Schemas, Views, Stored Procedures, Queries</td>
</tr>
<tr>
<td><b>Storage</b></td>
<td>Containers, Directories, Files, Spreadsheets, Worksheets</td>
</tr>
<tr>
<td><b>Pipelines</b></td>
<td>Data Pipelines, Tasks, Workflow Definitions, Scheduling</td>
</tr>
<tr>
<td><b>Messaging</b></td>
<td>Topics, Message Schemas, Partitions, Consumer Groups</td>
</tr>
<tr>
<td><b>Dashboards</b></td>
<td>Dashboards, Charts, Data Models, Reports</td>
</tr>
<tr>
<td><b>ML Models</b></td>
<td>Models, Features, Hyperparameters, Metrics, Experiments</td>
</tr>
<tr>
<td><b>APIs</b></td>
<td>Collections, Endpoints, Request/Response Schemas, Authentication</td>
</tr>
<tr>
<td><b>Search</b></td>
<td>Search Indexes, Fields, Mappings</td>
</tr>
</table>

### 🏛️ Governance & Compliance

Enterprise-grade governance schemas:

- **📖 Glossaries** - Business terminology with hierarchies and relationships
- **🏷️ Classifications & Tags** - Automated and manual classification systems
- **📋 Policies** - Access control, data policies, and compliance rules
- **📏 Metrics** - Business metrics and KPI definitions
- **📝 Data Contracts** - Schema contracts and SLAs

### ✅ Data Quality & Observability

Comprehensive quality and monitoring:

- **🧪 Test Definitions** - 50+ built-in test types (schema, freshness, completeness, etc.)
- **📊 Test Suites** - Organized test collections with execution history
- **⚠️ Incidents** - Issue tracking and resolution workflows
- **📈 Data Profiling** - Statistical profiles and distribution analysis
- **🔔 Alerts** - Configurable alerting and notification rules

### 🔗 Lineage & Relationships

End-to-end data lineage tracking:

- **Column-level lineage** with transformation logic
- **Cross-platform lineage** across databases, pipelines, and dashboards
- **Manual lineage** editing and augmentation
- **Impact analysis** for upstream and downstream dependencies
- **Provenance tracking** using W3C PROV-O standard

### 👥 Teams & Collaboration

People and organizational metadata:

- **Users & Teams** - Hierarchical team structures
- **Roles & Policies** - Fine-grained access control
- **Personas** - User personas for targeted experiences
- **Domains** - Business domain organization
- **Ownership** - Asset ownership and stewardship

### 🔌 Service Integration

84+ connector schemas for data sources:

- **Databases**: PostgreSQL, MySQL, Oracle, SQL Server, Snowflake, BigQuery, Redshift, etc.
- **Warehouses**: Databricks, Synapse, Teradata, Vertica, etc.
- **Lakes**: S3, GCS, Azure Data Lake, HDFS, etc.
- **Messaging**: Kafka, Pulsar, RabbitMQ, Kinesis, etc.
- **Dashboards**: Tableau, PowerBI, Looker, Superset, Metabase, etc.
- **Pipelines**: Airflow, dbt, Dagster, Fivetran, etc.
- **ML Platforms**: MLflow, SageMaker, Kubeflow, etc.

---

## 🎯 Use Cases

<table>
<tr>
<td width="33%">

### 📚 Data Catalogs
Build comprehensive, searchable data catalogs with rich metadata, automated discovery, and collaborative documentation.

</td>
<td width="33%">

### 🛡️ Data Governance
Implement enterprise governance with automated classification, policy enforcement, and compliance tracking.

</td>
<td width="33%">

### 🔍 Data Discovery
Enable self-service data discovery with semantic search, recommendations, and popularity metrics.

</td>
</tr>
<tr>
<td width="33%">

### 📊 Data Quality
Define, monitor, and enforce data quality rules with automated testing and incident management.

</td>
<td width="33%">

### 🔗 Data Lineage
Track complete data lineage from source to consumption with column-level granularity and impact analysis.

</td>
<td width="33%">

### 🌐 Knowledge Graphs
Build semantic knowledge graphs using RDF, OWL, and SPARQL for advanced analytics and AI applications.

</td>
</tr>
<tr>
<td width="33%">

### 🔄 Data Integration
Standardize metadata exchange across tools and platforms using open standards (JSON Schema, OpenAPI, RDF).

</td>
<td width="33%">

### 📋 Compliance
Ensure regulatory compliance (GDPR, CCPA, HIPAA) with metadata-driven policies and audit trails.

</td>
<td width="33%">

### 🤖 ML Metadata
Manage ML model metadata including features, experiments, versioning, and deployment tracking.

</td>
</tr>
</table>

---

## 🏃 Quick Start

### 📖 Explore Documentation

Visit **[openmetadatastandards.org](https://openmetadatastandards.org)** for comprehensive documentation, including:

- [Introduction & Core Concepts](https://openmetadatastandards.org/getting-started/introduction/)
- [Quick Start Guide](https://openmetadatastandards.org/getting-started/quick-start/)
- [Complete Schema Reference](https://openmetadatastandards.org/metadata-specifications/overview/)
- [RDF & Ontologies](https://openmetadatastandards.org/metadata-standards/rdf-ontology/)
- [Real-World Examples](https://openmetadatastandards.org/examples/)

### 💻 Local Development

```bash
# Clone the repository
git clone https://github.com/open-metadata/OpenMetadataStandards.git
cd OpenMetadataStandards

# Install Python dependencies
pip install -r requirements.txt

# Serve documentation locally at http://localhost:8000
mkdocs serve
```

### ✅ Validate Your Metadata

**Python Example:**

```python
import json
import jsonschema

# Load the table schema
with open('schemas/entity/data/table.json') as f:
    table_schema = json.load(f)

# Load your table metadata
with open('my_table_metadata.json') as f:
    table_data = json.load(f)

# Validate
try:
    jsonschema.validate(instance=table_data, schema=table_schema)
    print("✓ Valid metadata!")
except jsonschema.ValidationError as e:
    print(f"✗ Validation error: {e.message}")
```

**JavaScript/TypeScript Example:**

```javascript
const Ajv = require('ajv');
const fs = require('fs');

const ajv = new Ajv();

// Load schema and data
const schema = JSON.parse(fs.readFileSync('schemas/entity/data/table.json'));
const data = JSON.parse(fs.readFileSync('my_table_metadata.json'));

// Validate
const validate = ajv.compile(schema);
const valid = validate(data);

if (valid) {
  console.log('✓ Valid metadata!');
} else {
  console.log('✗ Validation errors:', validate.errors);
}
```

### 🌐 Use with OpenMetadata Platform

OpenMetadata Standards power the [OpenMetadata](https://open-metadata.org) platform:

```bash
# Try OpenMetadata with Docker
docker run -d -p 8585:8585 \
  --name openmetadata \
  openmetadata/server:latest
```

Visit [docs.open-metadata.org](https://docs.open-metadata.org) for full installation guide.

---

## 📚 Documentation Structure

```
OpenMetadataStandards/
├── 📁 schemas/                    # 700+ JSON Schema files
│   ├── entity/
│   │   ├── data/                 # Data entities (tables, topics, etc.)
│   │   ├── services/             # Service configurations
│   │   ├── governance/           # Governance entities (glossaries, policies)
│   │   ├── teams/                # Teams and users
│   │   └── ...
│   ├── type/                     # Type system definitions
│   ├── api/                      # API specifications
│   ├── events/                   # Event schemas
│   └── configuration/            # Configuration schemas
│
├── 📁 rdf/                        # RDF/OWL Ontologies
│   ├── ontology/                 # OpenMetadata OWL ontology
│   ├── shapes/                   # SHACL validation shapes
│   └── contexts/                 # JSON-LD contexts
│
├── 📁 docs/                       # Documentation source (MkDocs)
│   ├── getting-started/          # Tutorials and guides
│   ├── data-assets/              # Entity documentation
│   ├── governance/               # Governance docs
│   ├── examples/                 # Usage examples
│   └── reference/                # API reference
│
└── 📁 examples/                   # Example metadata files
    ├── basic/                    # Simple examples
    ├── advanced/                 # Complex scenarios
    └── integration/              # Integration patterns
```

---

## 🛠️ Standards & Compliance

OpenMetadata Standards is built on industry-standard specifications:

<table>
<tr>
<td width="25%" align="center">
<img src="https://json-schema.org/assets/logo.svg" width="80"/><br/>
<b>JSON Schema</b><br/>
Draft 07 & 2020-12
</td>
<td width="25%" align="center">
<img src="https://www.w3.org/StyleSheets/TR/2016/logos/W3C" width="80"/><br/>
<b>RDF/OWL</b><br/>
W3C RDF 1.1 & OWL 2
</td>
<td width="25%" align="center">
<img src="https://www.w3.org/StyleSheets/TR/2016/logos/W3C" width="80"/><br/>
<b>SHACL</b><br/>
W3C Validation
</td>
<td width="25%" align="center">
<img src="https://json-ld.org/images/json-ld-logo.png" width="80"/><br/>
<b>JSON-LD</b><br/>
Linked Data
</td>
</tr>
</table>

**Additional Standards:**
- [OpenAPI 3.0](https://www.openapis.org/) - API specifications
- [PROV-O](https://www.w3.org/TR/prov-o/) - W3C Provenance Ontology for lineage
- [SKOS](https://www.w3.org/2004/02/skos/) - Simple Knowledge Organization System
- [DCAT](https://www.w3.org/TR/vocab-dcat-3/) - Data Catalog Vocabulary

---

## 🌍 Community & Support

<table>
<tr>
<td width="33%" align="center">

### 💬 Join Slack
Connect with the community, ask questions, and share ideas.

[![Slack](https://img.shields.io/badge/Slack-Join%20Community-orange?style=for-the-badge&logo=slack)](https://slack.open-metadata.org)

</td>
<td width="33%" align="center">

### 📖 Read Docs
Comprehensive documentation with guides, examples, and API reference.

[![Docs](https://img.shields.io/badge/Docs-Read%20Now-blue?style=for-the-badge&logo=read-the-docs)](https://openmetadatastandards.org)

</td>
<td width="33%" align="center">

### 🐛 Report Issues
Found a bug or have a feature request? Let us know!

[![Issues](https://img.shields.io/badge/GitHub-Issues-green?style=for-the-badge&logo=github)](https://github.com/open-metadata/OpenMetadataStandards/issues)

</td>
</tr>
</table>

### 🤝 Get Involved

We welcome contributions from the community! Here's how you can help:

- ⭐ **Star this repository** to show your support
- 🐛 **Report bugs** and suggest features via [GitHub Issues](https://github.com/open-metadata/OpenMetadataStandards/issues)
- 📝 **Improve documentation** by submitting pull requests
- 💡 **Share use cases** and examples in our community
- 🗣️ **Spread the word** about OpenMetadata Standards

### 📞 Support Channels

- **Slack**: [slack.open-metadata.org](https://slack.open-metadata.org) - Active community chat
- **GitHub Discussions**: [Discussions](https://github.com/open-metadata/OpenMetadata/discussions) - Q&A and announcements
- **GitHub Issues**: [Issues](https://github.com/open-metadata/OpenMetadataStandards/issues) - Bug reports and feature requests
- **Twitter**: [@open_metadata](https://twitter.com/open_metadata) - News and updates
- **LinkedIn**: [OpenMetadata](https://www.linkedin.com/company/open-metadata) - Professional network

---

## 🚢 Deployment & Hosting

This documentation is automatically deployed to **GitHub Pages** with every commit to the `main` branch.

- **Live Documentation**: [openmetadatastandards.org](https://openmetadatastandards.org)
- **Deployment Workflow**: [`.github/workflows/deploy-docs.yml`](.github/workflows/deploy-docs.yml)
- **Validation Workflow**: [`.github/workflows/docs-validation.yml`](.github/workflows/docs-validation.yml)
- **Deployment Guide**: [DEPLOYMENT.md](DEPLOYMENT.md)
- **Setup Checklist**: [SETUP_CHECKLIST.md](SETUP_CHECKLIST.md)

### 🌐 Custom Domains

The documentation is accessible via multiple domains:

- **Primary**: [openmetadatastandards.org](https://openmetadatastandards.org)
- **Alternate**: openmetadatastandards.com (redirects to .org)
- **Alternate**: openmetadatastandard.com (redirects to .org)

---

## 🤝 Contributing

We love contributions! Whether you're fixing bugs, adding new schemas, improving documentation, or sharing examples, your help is appreciated.

### 📋 Contribution Guidelines

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Make** your changes in the appropriate directory:
   - Schemas: `schemas/`
   - Documentation: `docs/`
   - Examples: `examples/`
   - RDF/Ontologies: `rdf/`
4. **Test** your changes locally:
   ```bash
   # Serve documentation locally
   mkdocs serve

   # Validate documentation (checks for broken links, 404s, build warnings)
   ./scripts/check-docs.sh
   ```
5. **Commit** your changes (`git commit -m 'Add amazing feature'`)
6. **Push** to the branch (`git push origin feature/amazing-feature`)
7. **Open** a Pull Request

### 📖 Detailed Guides

- [Contributing Guide](https://openmetadatastandards.org/developer/contributing/)
- [Schema Development](https://openmetadatastandards.org/developer/schema-development/)
- [Testing & Validation](https://openmetadatastandards.org/developer/validation/)

### ✅ Code of Conduct

Please read our [Code of Conduct](CODE_OF_CONDUCT.md) before contributing.

---

## 📊 Project Statistics

<div align="center">

### 📈 Repository Stats

![GitHub stars](https://img.shields.io/github/stars/open-metadata/OpenMetadataStandards?style=social)
![GitHub forks](https://img.shields.io/github/forks/open-metadata/OpenMetadataStandards?style=social)
![GitHub contributors](https://img.shields.io/github/contributors/open-metadata/OpenMetadataStandards)
![GitHub last commit](https://img.shields.io/github/last-commit/open-metadata/OpenMetadataStandards)
![GitHub repo size](https://img.shields.io/github/repo-size/open-metadata/OpenMetadataStandards)

### 📦 Content Statistics

- **700+ JSON Schemas** covering all major metadata entities
- **200+ API Operations** fully documented
- **100+ Entity Types** with comprehensive properties
- **50+ Test Definitions** for data quality
- **84+ Service Connectors** schemas
- **Full RDF/OWL Ontology** with SHACL validation

</div>

---

## 📄 License

OpenMetadata Standards is licensed under the **Apache License, Version 2.0**.

```
Copyright 2021-2025 OpenMetadata

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

See [LICENSE](LICENSE) for the full license text.

---

## 🙏 Acknowledgements

OpenMetadata Standards is built with love by the [OpenMetadata Community](https://open-metadata.org) and powered by:

<table>
<tr>
<td align="center">
<a href="https://www.mkdocs.org/">
<img src="https://www.mkdocs.org/img/mkdocs.png" width="60"/><br/>
<b>MkDocs</b>
</a>
</td>
<td align="center">
<a href="https://squidfunk.github.io/mkdocs-material/">
<img src="https://squidfunk.github.io/mkdocs-material/assets/logo.svg" width="60"/><br/>
<b>Material for MkDocs</b>
</a>
</td>
<td align="center">
<a href="https://json-schema.org/">
<img src="https://json-schema.org/assets/logo.svg" width="60"/><br/>
<b>JSON Schema</b>
</a>
</td>
<td align="center">
<a href="https://www.w3.org/RDF/">
<img src="https://www.w3.org/StyleSheets/TR/2016/logos/W3C" width="60"/><br/>
<b>W3C RDF/OWL</b>
</a>
</td>
<td align="center">
<a href="https://pages.github.com/">
<img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" width="60"/><br/>
<b>GitHub Pages</b>
</a>
</td>
</tr>
</table>

### 🌟 Special Thanks

Special thanks to all our [contributors](https://github.com/open-metadata/OpenMetadataStandards/graphs/contributors) and the organizations using OpenMetadata Standards in production.

---

## 🔗 Related Projects

<table>
<tr>
<td width="50%">

### 🚀 OpenMetadata Platform
The unified metadata platform powered by these standards.

[![OpenMetadata](https://img.shields.io/badge/GitHub-OpenMetadata-blue?logo=github)](https://github.com/open-metadata/OpenMetadata)

</td>
<td width="50%">

### 📚 OpenMetadata Docs
Complete documentation for the OpenMetadata platform.

[![Docs](https://img.shields.io/badge/Docs-docs.open--metadata.org-green)](https://docs.open-metadata.org)

</td>
</tr>
</table>

---

<div align="center">

### 💙 Built with love by the OpenMetadata Community

[![Website](https://img.shields.io/badge/Website-open--metadata.org-blue?style=for-the-badge)](https://open-metadata.org)
[![Slack](https://img.shields.io/badge/Slack-Join%20Community-orange?style=for-the-badge&logo=slack)](https://slack.open-metadata.org)
[![Twitter](https://img.shields.io/badge/Twitter-@open__metadata-1DA1F2?style=for-the-badge&logo=twitter)](https://twitter.com/open_metadata)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-OpenMetadata-0077B5?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/company/open-metadata)

**⭐ If you find OpenMetadata Standards useful, please star this repository! ⭐**

</div>
