Inspired by [testdesiderata.com](https://testdesiderata.com)

## Understanding Test Desiderata

Test desiderata refers to the essential aspects and principles that ensure your test suite is both comprehensive and
efficient. Striving for excellent code quality and reliable software delivery, these principles guide the development of
tests that are maintainable, readable, and valuable.

## Key Principles

### Isolated

Tests should be independent of each other, ensuring that the outcome of one test does not affect another. This isolation allows for easier debugging and more reliable test results.

**Benefit**: Provides accurate pinpointing of failures and simplifies test maintenance.

**Trade-off**: There can be potential overhead in setting up and tearing down the state before and after each test. This
might increase the total execution time of the test suite, especially if the tests require extensive setup or deal with
large datasets. However, this trade-off is often justified by the increased reliability and maintainability of the
tests.

**Best Practice**: Use the "Boy Scout Rule": Leave the system in the same state as you found it. Clean up resources and
reset global variables.