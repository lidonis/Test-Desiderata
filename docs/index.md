Inspired by [testdesiderata.com](https://testdesiderata.com)

## Table of Contents

- [Understanding Test Desiderata](#understanding-test-desiderata)
- [Test Desiderata 2.0](#test-desiderata-20)
- [Introduction](#introduction)
- [Key Principles](#key-principles)
  - [Isolated](#isolated)
  - [Composable](#composable)
  - [Deterministic](#deterministic)
  - [Fast](#fast)
  - [Minimal Data](#minimal-data)
  - [Run in Parallel](#run-in-parallel)
  - [Writable](#writable)
  - [Readable](#readable)
  - [Behavioral](#behavioral)
  - [Sensitive to Execution Qualities](#sensitive-to-execution-qualities)
  - [Structure-Insensitive](#structure-insensitive)
  - [Automated](#automated)
  - [Specific](#specific)
  - [Predictive](#predictive)
  - [Inspiring](#inspiring)
- [Balancing Test Properties](#balancing-test-properties)
- [Conclusion](#conclusion)
- [Further Reading](#further-reading)

## Understanding Test Desiderata

Test desiderata refers to essential principles ensuring your test suite is efficient and comprehensive. These principles guide the creation of tests that are maintainable, readable, and valuable.

## Test Desiderata 2.0

This documentation is based on Kent Beck's original [Test Desiderata](https://testdesiderata.com), enhanced with insights from Emily Bache's [Test Desiderata 2.0](https://coding-is-like-cooking.info/2025/12/test-desiderata-2-0/).

Bache's research revealed that Beck's original list mixed properties of individual tests with properties of entire test suites, and didn't explicitly address how tests support ongoing design work. The 2.0 framework organizes test properties around four macro goals:

1. **Predict success in production** - Ensure tests reflect real-world behavior
2. **Fast to get feedback** - Enable rapid iteration and problem detection
3. **Support ongoing code design change** - Tests as active partners in design work
4. **Minimize total cost of ownership** - Keep tests maintainable long-term

The 12 core principles below, plus additional properties identified by Bache and other testing experts, work together to achieve these goals. For a deeper understanding of how these properties work together, see our [Framework Overview](framework.html).

### What's New in 2.0

Emily Bache's research identified several properties not explicitly covered in Beck's original framework:

**New Properties**:
- **[Sensitive to Execution Qualities](execution-qualities.html)** - Tests detect performance, security, and other non-functional issues
- **[Minimal Data](minimal-data.html)** - Tests use only essential data for speed and clarity
- **[Run in Parallel](run-in-parallel.html)** - Tests can execute simultaneously without interference

This enhanced framework provides a more complete foundation for building effective test suites.

## Introduction

Test desiderata are a set of guidelines that help ensure your test suite is effective and efficient. By following these principles, you can create tests that are easy to write, understand, and maintain, while also being reliable and fast. This document outlines the key principles of test desiderata and provides best practices for each.

## Key Principles

### Isolated

- **Description**: Each test runs independently to avoid interference.
- **Macro Goal**: Fast to Get Feedback
- **Benefit**: Accurate failure pinpointing simplifies debugging.
- **Trade-off**: Setup/teardown may increase execution time.
- **Best Practice**: Reset resources and global state between tests.
- **Read More**: [Isolated](isolated.html)

### Composable

- **Description**: Tests focus on individual components that combine seamlessly.
- **Macro Goal**: Support Ongoing Code Design Change
- **Benefit**: Minimizes number tests avoiding combinatorial growth.
- **Trade-off**: Increases initial complexity.
- **Best Practice**: Use modular code and dependency injection.
- **Read More**: [Composable](composable.html)

### Deterministic

- **Description**: Tests produce consistent results for the same inputs.
- **Macro Goal**: Minimize Total Cost of Ownership
- **Benefit**: Reliable tests build confidence by ensuring consistent outcomes.
- **Trade-off**: Requires control over external factors like time or randomness.
- **Best Practice**: Use test doubles to isolate dependencies.
- **Read More**: [Deterministic](deterministic.html)

### Fast

- **Description**: Tests execute quickly to provide rapid feedback.
- **Macro Goal**: Fast to Get Feedback
- **Benefit**: Rapid feedback accelerates development.
- **Trade-off**: May sacrifice thoroughness for speed.
- **Best Practice**: Optimize test setups and aim for millisecond execution.
- **Read More**: [Fast](fast.html)

### Minimal Data

- **Description**: Tests use only essential data needed to verify behavior.
- **Macro Goal**: Fast to Get Feedback
- **Benefit**: Faster execution and clearer test intent with less setup.
- **Trade-off**: May not reflect production data complexity.
- **Best Practice**: Use object mothers or builders for minimal valid test data.
- **Read More**: [Minimal Data](minimal-data.html)

### Run in Parallel

- **Description**: Tests execute simultaneously without interference.
- **Macro Goal**: Fast to Get Feedback
- **Benefit**: Dramatically reduces total test suite runtime.
- **Trade-off**: Requires elimination of shared state and resources.
- **Best Practice**: Use unique identifiers and isolated resources per test.
- **Read More**: [Run in Parallel](run-in-parallel.html)

### Writable

- **Description**: Tests are easy to write and maintain.
- **Macro Goal**: Minimize Total Cost of Ownership
- **Benefit**: Encourages adoption and contribution to the test suite.
- **Trade-off**: Oversimplification risks inadequate coverage.
- **Best Practice**: Provide clear guidelines and use simple naming conventions.
- **Read More**: [Writable](writable.html)

### Readable

- **Description**: Tests are easy to understand at a glance.
- **Macro Goal**: Minimize Total Cost of Ownership
- **Benefit**: Simplifies collaboration and onboarding.
- **Trade-off**: Requires effort to maintain clarity.
- **Best Practice**: Use descriptive names and clearly express test intent.
- **Read More**: [Readable](readable.html)

### Behavioral

- **Description**: Tests reflect the expected behavior of the system.
- **Macro Goal**: Predict Success in Production
- **Benefit**: Aligns tests with user expectations.
- **Trade-off**: Needs thorough documentation of expected behavior.
- **Best Practice**: Define behaviors collaboratively with stakeholders.
- **Read More**: [Behavioral](behavioral.html)

### Sensitive to Execution Qualities

- **Description**: Tests detect changes in performance, security, and other non-functional qualities.
- **Macro Goal**: Predict Success in Production
- **Benefit**: Catches performance regressions and quality issues before production.
- **Trade-off**: Requires careful measurement and realistic test environments.
- **Best Practice**: Set performance budgets and test at production scale.
- **Read More**: [Sensitive to Execution Qualities](execution-qualities.html)

### Structure-Insensitive

- **Description**: Tests remain valid despite internal code changes.
- **Macro Goal**: Minimize Total Cost of Ownership
- **Benefit**: Ensures tests remain valid during refactors.
- **Trade-off**: Decoupling tests from implementation requires effort.
- **Best Practice**: Focus on public interfaces over internal details.
- **Read More**: [Structure-Insensitive](structure-insensitive.html)

### Automated

- **Description**: Tests run automatically to ensure consistency.
- **Macro Goal**: Minimize Total Cost of Ownership
- **Benefit**: Enables frequent, consistent execution.
- **Trade-off**: Automation setup demands upfront investment.
- **Best Practice**: Run automated tests via CI/CD pipelines.
- **Read More**: [Automated](automated.html)

### Specific

- **Description**: Tests pinpoint issues precisely for faster debugging.
- **Macro Goal**: Minimize Total Cost of Ownership
- **Benefit**: Quickly identifies root causes of failures.
- **Trade-off**: Writing highly focused tests can be challenging.
- **Best Practice**: Break down functionalities and write precise assertions.
- **Read More**: [Specific](specific.html)

### Predictive

- **Description**: Tests mirror real-world behavior to ensure reliability.
- **Macro Goal**: Predict Success in Production
- **Benefit**: Provides confidence in production behavior.
- **Trade-off**: Requires understanding of the production environment.
- **Best Practice**: Use real-world scenarios and data for test cases.
- **Read More**: [Predictive](predictive.html)

### Inspiring

- **Description**: Tests foster confidence in the system's quality.
- **Note**: In Test Desiderata 2.0, this is considered an outcome of achieving "Predict Success in Production" rather than a separate property.
- **Macro Goal**: Predict Success in Production (outcome)
- **Benefit**: Motivates quality-focused development practices.
- **Trade-off**: Meaningful tests may require extra creativity and effort.
- **Best Practice**: Share success metrics to highlight testing's value.
- **Read More**: [Inspiring](inspiring.html)

## Balancing Test Properties

Not every test must embody all properties. The four macro goals help understand which trade-offs make sense:

- **Production Confidence vs. Speed**: Predictive tests may be slower; balance with fast unit tests
- **Design Support vs. Maintenance Cost**: Composable tests enable design change but require upfront investment
- **Individual Tests vs. Test Suite**: Some properties (like parallel execution) apply to the whole suite rather than individual tests
- **Fast Feedback Trade-offs**: Minimal data and parallel execution both improve speed but require different approaches to isolation

Understanding the macro goals each property serves helps teams make informed trade-offs. See our [framework guide](framework.html) for detailed guidance on balancing properties.

## Conclusion

By understanding and applying these test desiderata principles, you can create a robust and effective test suite that balances various test properties. This will help you build confidence in your system's quality and foster a culture of quality-focused development.

## Further Reading
- [Emily Bache - Test Desiderata 2.0](https://coding-is-like-cooking.info/2025/12/test-desiderata-2-0/)
- [Kent Beck - Test Desiderata](https://testdesiderata.com)
- [Framework Overview](framework.html) - Understanding how properties work together
- [Martin Fowler - Testing](https://martinfowler.com/testing/)
- [Google Testing Blog](https://testing.googleblog.com/)
