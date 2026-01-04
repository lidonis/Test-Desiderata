# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Test-Desiderata is a documentation repository that provides guidance on creating comprehensive yet efficient test suites. It integrates Kent Beck's original 12 test principles from [testdesiderata.com](https://testdesiderata.com) with Emily Bache's Test Desiderata 2.0 framework, which organizes these principles around 4 macro test suite properties.

This repository contains **documentation only** - there is no source code, build process, or test suite to run. All documentation is **language and framework agnostic**, focusing on universal testing principles that apply to any technology stack.

The site is published as GitHub Pages using Jekyll with the Architect theme.

## Repository Structure

```
/
├── docs/               # All documentation content (published to GitHub Pages)
│   ├── index.md       # Main landing page with overview of all principles
│   ├── framework.md   # Test Desiderata 2.0 framework overview (4 macro properties)
│   ├── *.md           # Individual principle pages (17 total)
│   └── _config.yml    # Jekyll configuration
├── Gemfile            # Ruby dependencies matching GitHub Pages versions
├── .ruby-version      # Ruby version (3.3.4 to match GitHub Pages)
├── justfile           # Common development commands
└── CLAUDE.md          # This file
```

**Note:** Build artifacts (`_site/`, `.sass-cache/`, etc.) are in `.gitignore` and not committed.

## Test Desiderata 2.0 Framework

The documentation is organized around Emily Bache's 4 macro test suite properties:

1. **Predict Success in Production** - Tests accurately predict production behavior
2. **Fast to Get Feedback** - Rapid iteration with immediate feedback
3. **Support Ongoing Code Design Change** - Tests enable refactoring and evolution
4. **Minimize Total Cost of Ownership** - Reduce long-term maintenance burden

Each individual test property maps to one or more of these macro goals.

## Test Properties

This documentation covers 15 test properties organized by macro goal:

### Predict Success in Production
- **Predictive** - Tests mirror real-world behavior
- **Behavioral** (Sensitive to Behaviour) - Tests reflect expected system behavior
- **Sensitive to Execution Qualities** - Tests validate non-functional requirements (NEW in 2.0)

### Fast to Get Feedback
- **Fast** - Tests execute quickly for rapid feedback
- **Isolated** (Run in any Order) - Tests run independently without interference
- **Minimal Data** - Tests use only essential data (NEW in 2.0)
- **Run in Parallel** - Tests can execute concurrently (NEW in 2.0)

### Support Ongoing Code Design Change
- **Composable** - Tests focus on components that combine seamlessly
- **Structure-Insensitive** (Insensitive to Code Structure) - Tests remain valid despite refactoring

### Minimize Total Cost of Ownership
- **Automated** - Tests run automatically for consistency
- **Deterministic** - Tests produce consistent results
- **Readable** - Tests are easy to understand
- **Specific** (Diagnosable) - Tests pinpoint issues precisely
- **Writable** (Easy to Write) - Tests are easy to write and maintain

**Note:** "Inspiring" is considered an outcome of achieving "Predict Success in Production" rather than a separate property in the 2.0 framework.

## Documentation Standards

### Content Structure

Each principle document follows this standard structure:
- **Table of Contents** - Required for navigation
- **Definition** - Clear explanation of the principle (include alternative names from 2.0 framework if applicable)
- **Part of a Larger Framework** - Maps the property to macro goal(s) and related properties
- **Why It Matters** - Benefits and value
- **Challenges** - Trade-offs and difficulties
- **Best Practices** - Actionable guidance
- **Practical Example** - When applicable (tech-agnostic examples only)
- **Common Pitfalls** - What to avoid
- **Conclusion** - Summary
- **Further Reading** - Topic-specific, language-agnostic external references

### Writing Guidelines

**General:**
- All text files must end with an empty line
- Use descriptive section headers
- Keep explanations concise and actionable
- Include both benefits and trade-offs for each principle

**Tech-Agnostic Approach:**
- **NO code examples** in specific programming languages (Python, JavaScript, Java, etc.)
- **NO references** to specific frameworks or tools (pytest, Jest, Cucumber, Rails, .NET, etc.)
- Focus on **universal testing principles** that apply to any technology stack
- Use **conceptual examples** and design patterns rather than technology-specific implementations

**Further Reading Guidelines:**
- **Individual principle pages**: 1-3 topic-specific, language-agnostic references only
- **NO generic references** on individual pages (Emily Bache, Kent Beck, or "Martin Fowler - Testing")
- **Overview pages** (index.md, framework.md): Keep foundational Bache and Beck references
- Each reference must be directly relevant to that specific principle
- Acceptable: Martin Fowler specific articles, design patterns, universal testing concepts
- Unacceptable: Technology-specific URLs (docs.pytest.org, cucumber.io, microsoft.com, etc.)

### Cross-References

- The `index.md` file provides an overview and links to individual principle pages
- The `framework.md` file explains the 2.0 framework and macro properties
- **Use relative links with `.md` extension**: `[Isolated](isolated.md)` for cross-referencing
  - In markdown editors: Links are clickable and navigate to source files
  - On GitHub Pages: The `jekyll-relative-links` plugin automatically converts `.md` → `.html`
- Each principle page cross-references related properties in "Part of a Larger Framework" section
- Maintain consistency between index summaries and detailed pages

### Front Matter

All markdown files in `docs/` must include minimal front matter:

```yaml
---
layout: default
---
```

This enables Jekyll to apply the Architect theme and process the markdown correctly.

## Local Development

### Prerequisites

- Ruby 3.3.4 (managed via rbenv)
- Bundler 4.x
- Just (command runner)

### Quick Start

```bash
# Install dependencies
just install

# Start local Jekyll server
just serve

# View site at http://127.0.0.1:4000
```

### Available Commands (via justfile)

| Command | Description |
|---------|-------------|
| `just serve` | Start local Jekyll server on port 4000 |
| `just serve-livereload` | Start server with auto-reload on file changes |
| `just build` | Build the site to `_site/` |
| `just clean` | Remove build artifacts |
| `just install` | Install Ruby dependencies |
| `just update` | Update dependencies to match GitHub Pages |
| `just check-versions` | Show current GitHub Pages dependency versions |
| `just check-links` | Validate all `.md` internal links exist |
| `just status` | Show git status |

### Dependency Management

**Gemfile versions must match GitHub Pages exactly:**
- See current versions: `just check-versions`
- Update reference: https://pages.github.com/versions.json

The local environment uses:
- Jekyll 3.10.0
- jekyll-theme-architect 0.2.0
- jekyll-relative-links 0.6.1 (converts `.md` → `.html`)
- kramdown-parser-gfm 1.1.0 (GitHub Flavored Markdown)

### Jekyll Configuration

**File:** `docs/_config.yml`

```yaml
title: Test Desiderata
description: Strategies for Creating Comprehensive Yet Efficient Test Suites
theme: jekyll-theme-architect

plugins:
  - jekyll-relative-links

relative_links:
  enabled: true
  collections: false
```

The `jekyll-relative-links` plugin ensures `.md` links work in both:
- Markdown editors (click to navigate source files)
- Published GitHub Pages (automatically converted to `.html`)

## Git Workflow

- Main branch: `main`
- Commit messages should be descriptive of documentation changes
- Changes to `docs/` directory are automatically published via GitHub Pages