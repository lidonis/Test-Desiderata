# Deterministic Tests

## Table of Contents

- [Definition](#definition)
- [Part of a Larger Framework](#part-of-a-larger-framework)
- [Why Determinism Matters](#why-determinism-matters)
- [Challenges of Deterministic Tests](#challenges-of-deterministic-tests)
- [Best Practices for Deterministic Tests](#best-practices-for-deterministic-tests)
- [Practical Example](#practical-example)
- [Common Pitfalls](#common-pitfalls)
- [Conclusion](#conclusion)
- [Further Reading](#further-reading)

## Definition

Deterministic tests are tests that produce consistent results for the same inputs, regardless of external factors.

## Part of a Larger Framework

This principle contributes to the macro goal of **Minimize Total Cost of Ownership**. Tests that are deterministic reduce debugging costs by producing reliable, reproducible results, preventing time wasted on flaky tests.

**Related Properties**:
- [Isolated](isolated.html) - Isolated tests are more likely to be deterministic
- [Automated](automated.html) - Automation relies on deterministic tests for reliability
- [Specific](specific.html) - Deterministic failures are easier to diagnose

*Learn more about how test properties work together in our [framework overview](framework.html).*

## Why Determinism Matters

### Reliability
Deterministic tests ensure that the test results are reliable and reproducible.

### Debugging
Deterministic tests make it easier to identify and debug issues by providing consistent outcomes.

### Confidence
Deterministic tests build confidence in the test suite by ensuring that tests produce the same results every time they are run.

## Challenges of Deterministic Tests

### Controlling External Factors
Ensuring that tests are deterministic requires controlling external factors like time, randomness, and dependencies.

### Complexity
Designing deterministic tests can be complex and requires careful planning.

## Best Practices for Deterministic Tests

### Use Test Doubles
**Replace real dependencies with test doubles to isolate the system under test and control external factors.**

- Use mocks, stubs, and fakes to simulate dependencies and control their behavior.
- Ensure that test doubles provide consistent and predictable responses.

### Control Randomness
**Make random behavior deterministic by controlling sources of variability.**

- Replace calls to random number generators with predefined values.
- Use fixed seeds for random number generators to ensure consistent outcomes.

### Isolate Time-Dependent Code
**Isolate time-dependent code and use fixed values for date and time.**

- Use libraries that allow for time manipulation and control over system clocks.
- Ensure that time-dependent code produces consistent results regardless of the current time.

## Practical Example
Deterministic tests can be implemented using various testing frameworks and tools. The key is to ensure that tests produce consistent results for the same inputs, regardless of external factors.

## Common Pitfalls

### Over-Mocking
**Avoid mocking too many dependencies, as this can make tests brittle and less representative of real behavior.**

### Ignoring Non-Deterministic Factors
**Do not overlook non-deterministic factors like network latency or concurrency issues that can affect test outcomes.**

## Conclusion
Deterministic tests are crucial for building a reliable and maintainable test suite. By following best practices and focusing on test doubles and controlling external factors, teams can ensure their tests remain consistent and reproducible.

## Further Reading

- [Martin Fowler - Eradicating Non-Determinism in Tests](https://martinfowler.com/articles/nonDeterminism.html)
- [Martin Fowler - Test Doubles](https://martinfowler.com/bliki/TestDouble.html)
