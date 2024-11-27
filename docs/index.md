Inspired by [testdesiderata.com](https://testdesiderata.com)

## Understanding Test Desiderata
Test desiderata refers to the essential aspects and principles that ensure your test suite is both comprehensive and efficient.
Striving for excellent code quality and reliable software delivery, these principles guide the development of tests that are maintainable, readable, and valuable.

## Key Principles
### Isolated
Tests should be independent of each other, ensuring that the outcome of one test does not affect another.
This isolation allows for easier debugging and more reliable test results.

**Benefit**: Provides accurate pinpointing of failures and simplifies test maintenance.

**Trade-off**: There can be potential overhead in setting up and tearing down the state before and after each test. This might increase the total execution time of the test suite, especially if the tests require extensive setup or deal with large datasets.
However, this trade-off is often justified by the increased reliability and maintainability of the tests.

**Best Practice**: Use the "Boy Scout Rule": Leave the system in the same state as you found it. Clean up resources and reset global variables.

### Composable

Tests and underlying code should be designed in a way that allows different dimensions of variability to be tested independently and then combined.

**Benefit**: Reduces the total number of tests needed by focusing on testing individual components and their interactions avoiding combinatorial growth.

**Trade-off**: Requires additional effort and forethought during the initial implementation, which can increase complexity.

**Best Practice**: Strive for modular code and use dependency injection. This allows you to swap components in and out easily, facilitating composability in tests.

### Deterministic 
Tests should produce the same results given the same inputs, ensuring that the behavior of the code is predictable and reliable.

**Benefit**: Enhances confidence in the code by ensuring that tests will consistently pass or fail based on the code's behavior.

**Trade-off**: Achieving determinism may require additional effort to control external factors, such as random number generation or time-dependent behavior.

**Best Practice**: Use test doubles to isolate tests from external dependencies, ensuring that tests remain deterministic and focused on the code being tested.