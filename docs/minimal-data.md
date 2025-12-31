# Minimal Data

## Table of Contents

- [Definition](#definition)
- [Part of a Larger Framework](#part-of-a-larger-framework)
- [Why Minimal Data Matters](#why-minimal-data-matters)
- [Challenges of Minimal Data](#challenges-of-minimal-data)
- [Best Practices for Minimal Data](#best-practices-for-minimal-data)
- [Practical Example](#practical-example)
- [Common Pitfalls](#common-pitfalls)
- [Conclusion](#conclusion)
- [Further Reading](#further-reading)

## Definition

Minimal data tests use only the essential data needed to verify the behavior under test, avoiding unnecessary setup and complex test fixtures. By minimizing test data, tests become faster, easier to understand, and less fragile.

## Part of a Larger Framework

This principle contributes to the macro goal of **Fast to Get Feedback**. Tests that use minimal data execute more quickly, are easier to set up, and provide faster iteration cycles during development.

**Related Properties**:
- [Fast](fast.html) - Minimal data directly improves test speed
- [Isolated](isolated.html) - Less data means simpler setup/teardown
- [Readable](readable.html) - Minimal data makes test intent clearer
- [Writable](writable.html) - Easier to write tests with less data setup

*Learn more about how test properties work together in our [framework overview](framework.html).*

## Why Minimal Data Matters

### Speed

Tests with minimal data run faster because there's less to set up, process, and tear down.

**Example**: A test validating email format only needs one email address, not a full user profile with addresses, preferences, and order history.

### Clarity

Minimal data makes it obvious what the test is verifying by eliminating noise.

**Example**: Testing a discount calculation? Use one product and one discount rule, not a full catalog with complex pricing tiers.

### Maintainability

Less test data means fewer points of failure when the data model changes.

**Example**: When a User model gains new required fields, tests using minimal data have fewer places to update.

### Debugging

When tests fail, minimal data makes it easier to understand what went wrong.

**Example**: A test with 3 objects is far easier to debug than one with 30.

## Challenges of Minimal Data

### Balancing Coverage

Using too little data might miss edge cases or integration issues.

**Example**: Testing only happy-path scenarios with one record might miss pagination bugs that appear with multiple records.

### Production Realism

Minimal data may not reflect production complexity, potentially missing realistic scenarios.

**Example**: A test with one user might miss permission issues that only appear when multiple users interact with the same resource.

## Best Practices for Minimal Data

### Use Object Mothers or Builders

**Create helper functions that generate minimal valid objects with sensible defaults.**

Object mother or builder functions create objects with only required fields populated, using sensible defaults:

**Pattern**:
- Define a helper function (e.g., `createMinimalUser`)
- Accept parameters only for fields the test needs to vary
- Provide sensible defaults for all other required fields
- Return a minimal valid object

**Example Usage**:
- Test validates email format
- Call helper: `createMinimalUser(email: "invalid-email")`
- Helper provides username automatically (derived from email)
- Test asserts the user is not valid
- **Benefit**: Test focuses on email validation, not user creation

### Parameterize What Matters

**Only vary the data that's relevant to the test, use defaults for everything else.**

Factory functions accept parameters for test-relevant fields while providing defaults for the rest:

**Pattern**:
- Create a factory function with default parameters
- Override only the values relevant to the specific test
- Auto-generate or default all other fields (IDs, timestamps, empty collections)

**Example**:
- Test applies a 10% discount to an order
- Factory function: `createOrder` with default total of 100
- Test specifies only `total: 100` (the relevant value)
- Factory auto-generates: ID, status, items array, creation timestamp
- **Benefit**: Test clearly shows that only the total matters for discount calculation

### Name Data Meaningfully

**Use descriptive names that explain why specific data values were chosen.**

Use meaningful constant names to explain boundary values and special test cases:

**Pattern**:
- Define constants with descriptive names for test values
- Names explain WHY the value was chosen, not just what it is
- Makes test boundaries and edge cases self-documenting

**Example**:
- Test verifies orders above maximum value are rejected
- Define constant: `JUST_OVER_MAXIMUM = 10000.01`
- Create order with that total
- Assert the order throws an exception when processed
- **Benefit**: Name `JUST_OVER_MAXIMUM` immediately clarifies this tests the upper boundary, unlike a magic number like `10000.01`

### Inline Data Creation

**Create data directly in the test when it's simple and relevant.**

For simple tests, create objects inline rather than using separate setup:

**Pattern**:
- Create test objects directly in assertion statements
- No separate setup method or fixture needed
- Only possible when object creation is simple (few required fields)

**Example**:
- Test validates email format
- Create user inline: `User(email: 'invalid')`
- Assert: not valid
- Create another user inline: `User(email: 'valid@example.com')`
- Assert: valid
- **Benefit**: Immediately obvious what values are being tested without looking at setup code

### Use Fixtures Sparingly

**Reserve fixtures for complex scenarios; prefer inline creation for simple cases.**

- Fixtures can obscure what data is actually relevant to the test
- Fixtures create coupling between tests and fixture definitions
- Use fixtures only when the same complex setup is genuinely needed across many tests

## Practical Example

**Before - Excessive Data:**

A test with unnecessary complexity:

**Setup**:
- Create full user fixture (address, payment methods, order history, preferences)
- Create full catalog fixture (hundreds of products with pricing, inventory, categories)
- Create complex cart fixture (multiple items, shipping calculations, tax rules)

**Test**:
- Calculate discount
- Assert discount equals 10.0

**Problems**:
- Slow: Must populate database with hundreds of records
- Unclear: What data actually affects the discount?
- Fragile: Test breaks when user model, catalog structure, or cart logic changes
- Comment admits: "Only testing discount calculation!"

**After - Minimal Data:**

A test with only essential data:

**Setup**:
- Create cart with total: 100.0
- Create user with loyalty tier: 'silver' (the one field affecting discount)

**Test**:
- Calculate discount
- Assert discount equals 10.0

**Benefits**:
- **Faster**: No database, no fixtures, minimal object creation
- **Clearer**: Obvious that only cart total and loyalty tier matter
- **More maintainable**: Only breaks if discount calculation or these two fields change
- **Self-documenting**: The test shows exactly what influences the discount

The minimal version runs in milliseconds vs. seconds and makes test intent crystal clear.

## Common Pitfalls

### Shared Fixtures

**Avoid large shared fixtures that contain data irrelevant to most tests.**

Instead of one `fixtures/users.json` with 50 users, create minimal users per test.

### Over-Realism

**Don't replicate production data complexity in tests unless specifically testing that complexity.**

Production may have users with 20 addresses, but testing email validation doesn't need that.

### Data Coupling

**Avoid tests that depend on specific IDs or ordering from fixtures.**

This creates brittleness and makes tests harder to understand in isolation.

## Conclusion

Minimal data is a powerful principle for creating fast, clear, and maintainable tests. By using only the essential data needed for each test, you improve speed, readability, and debuggability. While it requires balancing against coverage and realism, the benefits of minimal data make it a cornerstone of effective testing.

## Further Reading

- [Martin Fowler - ObjectMother](https://martinfowler.com/bliki/ObjectMother.html)
- [Test Data Builders](http://www.natpryce.com/articles/000714.html)
- [Growing Object-Oriented Software, Guided by Tests](http://www.growing-object-oriented-software.com/)
