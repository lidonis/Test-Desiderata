---
layout: default
---
# Behavioral Tests

## Table of Contents

- [Definition](#definition)
- [Part of a Larger Framework](#part-of-a-larger-framework)
- [Why Behavioral Testing Matters](#why-behavioral-testing-matters)
- [Challenges of Behavioral Tests](#challenges-of-behavioral-tests)
- [Best Practices for Behavioral Tests](#best-practices-for-behavioral-tests)
- [Practical Example](#practical-example)
- [Common Pitfalls](#common-pitfalls)
- [Conclusion](#conclusion)
- [Further Reading](#further-reading)

## Definition

Behavioral tests focus on testing the behavior of the system rather than its internal implementation.

**Also known as**: Sensitive to Behaviour (in the Test Desiderata 2.0 framework, this name emphasizes that tests should detect when behavior changes).

## Part of a Larger Framework

This principle contributes to the macro goal of **Predict Success in Production**. Tests that are sensitive to functional behavior ensure the system acts as expected from the user's perspective, catching behavioral regressions before they reach production.

**Related Properties**:
- [Predictive](predictive.md) - Behavioral tests are essential for predicting production success
- [Sensitive to Execution Qualities](execution-qualities.md) - Extends beyond functional behavior to performance and other qualities
- [Structure-Insensitive](structure-insensitive.md) - Behavioral tests remain valid during refactoring

*Learn more about how test properties work together in our [framework overview](framework.md).*

## Why Behavioral Testing Matters

### User-Centric
Behavioral tests ensure that the system behaves as expected from the user's perspective.

### Requirements Validation
Behavioral tests validate that the system meets the specified requirements and behaves correctly in various scenarios.

### Communication
Behavioral tests serve as a form of documentation, communicating the expected behavior of the system to stakeholders.

## Challenges of Behavioral Tests

### Comprehensiveness
Ensuring that behavioral tests cover all possible scenarios and edge cases can be challenging.

### Maintenance
Behavioral tests need to be updated as the system's requirements and behavior evolve.

## Best Practices for Behavioral Tests

### Use BDD Frameworks
**Utilize Behavior-Driven Development (BDD) frameworks to write behavioral tests in natural language.**

- Write tests in a natural language that is understandable to non-technical stakeholders.
- Collaborate with stakeholders to define the expected behavior of the system.

### Focus on User Stories
**Write behavioral tests based on user stories and acceptance criteria.**

- Ensure that each test covers a specific scenario and expected outcome.
- Use given-when-then format to structure your tests.

### Keep Tests Up-to-Date
**Regularly review and update behavioral tests to ensure they reflect the current requirements and behavior of the system.**

- Update tests as the system evolves to maintain their relevance and accuracy.
- Remove or modify tests that no longer apply to the current behavior of the system.

## Practical Example
Behavioral tests can be written using BDD frameworks. The key is to ensure that tests are written in a natural language and cover specific scenarios and expected outcomes.

## Common Pitfalls

### Over-Generalization
**Avoid writing overly general behavioral tests that do not cover specific scenarios and edge cases.**

### Ignoring Non-Functional Requirements
**Do not overlook non-functional requirements like performance and security when writing behavioral tests.**

## Conclusion
Behavioral tests are crucial for ensuring that the system behaves as expected from the user's perspective. By following best practices and focusing on user stories and acceptance criteria, teams can create effective behavioral tests that validate the system's behavior.

## Further Reading

- [Specification by Example](https://gojko.net/books/specification-by-example/)
- [GivenWhenThen](https://martinfowler.com/bliki/GivenWhenThen.html)
