
# Sensitive to Execution Qualities

## Table of Contents

- [Definition](#definition)
- [Part of a Larger Framework](#part-of-a-larger-framework)
- [Why Execution Qualities Matter](#why-execution-qualities-matter)
- [Challenges of Testing Execution Qualities](#challenges-of-testing-execution-qualities)
- [Best Practices for Execution Quality Tests](#best-practices-for-execution-quality-tests)
- [Practical Example](#practical-example)
- [Common Pitfalls](#common-pitfalls)
- [Conclusion](#conclusion)
- [Further Reading](#further-reading)

## Definition

Tests that are sensitive to execution qualities detect changes in non-functional characteristics of the system, such as performance, scalability, security, reliability, and resource consumption. These tests go beyond validating that the system produces correct outputs to ensure it does so with acceptable quality attributes.

## Part of a Larger Framework

This principle contributes to the macro goal of **Predict Success in Production**. While functional tests verify that code produces correct results, execution quality tests ensure the system will perform acceptably under real-world conditions.

**Related Properties**:
- [Behavioral](behavioral.html) - Focuses on functional behavior; execution qualities extend beyond function to performance
- [Predictive](predictive.html) - Execution quality tests are essential for predicting production success
- [Deterministic](deterministic.html) - Consistent performance measurements require deterministic tests

*Learn more about how test properties work together in our [framework overview](framework.html).*

## Why Execution Qualities Matter

### Performance Degradation

Functional correctness doesn't guarantee acceptable performance. Tests must detect when changes slow down the system.

**Example**: A database query refactoring might return correct results but execute 100x slower, causing production timeouts.

### Resource Consumption

Systems can be functionally correct but consume excessive memory, CPU, or network bandwidth.

**Example**: A memory leak might not affect functionality in short tests but crash production systems after hours of operation.

### Scalability

Code that works with small datasets might fail or degrade severely with production-scale data.

**Example**: An algorithm with O(n²) complexity works fine with 100 records but becomes unusable with 10,000.

### Security Vulnerabilities

Functional tests don't catch security issues like injection vulnerabilities, authentication bypasses, or data exposure.

**Example**: An API might return correct data but expose unauthorized information due to missing access controls.

## Challenges of Testing Execution Qualities

### Measurement Overhead

Performance tests require careful measurement infrastructure and can be slower to execute.

**Example**: Capturing detailed performance metrics adds instrumentation overhead that affects test execution time.

### Environmental Sensitivity

Execution quality tests can be sensitive to hardware, operating systems, and environmental conditions.

**Example**: Performance benchmarks on a developer's laptop may not reflect production performance on different hardware.

## Best Practices for Execution Quality Tests

### Set Performance Budgets

**Define acceptable performance thresholds and fail tests that exceed them.**

Performance budgets establish maximum acceptable execution times for operations:

1. **Capture start time** before executing the operation
2. **Execute the operation** being tested (e.g., database query, API call)
3. **Calculate elapsed time** after the operation completes
4. **Assert the duration** is below the performance budget
5. **Include functional assertions** to verify correctness alongside performance

**Example budget**: Database queries should complete within 100 milliseconds. If a query takes longer, the test fails with a message indicating the actual duration and the budget exceeded.

### Monitor Resource Usage

**Track memory, CPU, and other resources during test execution.**

Resource monitoring tests detect excessive consumption that could cause production failures:

1. **Measure baseline resources** before the operation (memory used, CPU state)
2. **Execute the operation** being tested
3. **Measure resources after** the operation completes
4. **Calculate the difference** to determine resources consumed
5. **Assert consumption** is below acceptable thresholds
6. **Verify functional correctness** alongside resource limits

**Example resource budget**: Processing 10,000 records should use less than 50 MB of memory. Tests fail if memory consumption exceeds this limit, indicating potential memory leaks or inefficient data structures.

### Test at Scale

**Include tests that use production-scale data volumes.**

Scalability tests reveal performance problems that only appear with realistic data sizes:

1. **Use production-scale data** (e.g., 100,000+ records instead of 10)
2. **Measure execution time** for operations on large datasets
3. **Set realistic time budgets** based on production requirements
4. **Detect algorithmic complexity issues** (e.g., O(n²) algorithms that work with small data but fail at scale)
5. **Verify correctness** with large datasets, not just small samples

**Example**: A filtering operation that works instantly with 100 records might take minutes with 100,000 records if it has quadratic complexity. Scalability tests with production data volumes catch these issues before they reach production.

### Include Security Tests

**Verify authentication, authorization, and input validation.**

Security quality tests ensure the system resists attacks and protects data:

**Authentication Tests:**
- Verify that protected endpoints reject unauthenticated requests
- Assert that requests without credentials return 401 Unauthorized status
- Test that expired or invalid tokens are rejected

**Authorization Tests:**
- Verify users can only access resources they're permitted to see
- Assert that accessing another user's data returns 403 Forbidden
- Test role-based access control with different permission levels

**Input Validation Tests:**
- Test injection attack prevention (SQL injection, command injection, XSS)
- Provide malicious input patterns (e.g., SQL commands, script tags)
- Assert the system safely handles malicious input without executing it
- Verify critical data structures remain intact after attack attempts

**Example**: A SQL injection test provides input like `'; DROP TABLE users; --` and verifies that the database table still exists after the request, confirming the system properly sanitized the input.

### Use Realistic Load Patterns

**Test under conditions that mirror production usage.**

Load testing reveals bottlenecks and performance degradation under concurrent use:

1. **Simulate concurrent users** making simultaneous requests
2. **Measure response times** for each request under load
3. **Assert performance** doesn't degrade significantly with concurrency
4. **Test typical load** and peak load scenarios
5. **Identify bottlenecks** like database connection limits, lock contention, or resource exhaustion

**Example**: Simulate 50 concurrent API requests and verify that each completes within 1 second. This tests whether the system can handle multiple users without excessive queuing or timeout issues that would only appear in production with real concurrent traffic.

## Practical Example

**Before - Functional Tests Only:**

A test that only verifies functional correctness:

**Test**: search_functionality
- Execute a search with a test query
- Assert results are returned (count greater than zero)
- Assert all results contain the search term

**Limitation**: This test verifies the search returns correct results but misses critical execution quality issues.

**After - Including Execution Quality Tests:**

A comprehensive test suite covering multiple quality dimensions:

**Test 1: Functional Correctness**
- Execute search with test query
- Verify results are returned
- Verify results match the query
- **Purpose**: Baseline functionality works

**Test 2: Performance Quality**
- Capture start time
- Execute search with test query
- Calculate elapsed time
- Assert duration is under 200ms budget
- Verify results are returned
- **Purpose**: Detects performance regressions

**Test 3: Scalability Quality**
- Execute search that returns thousands of results
- Measure execution time
- Assert duration is under 1 second budget
- Verify large result count
- **Purpose**: Ensures performance with large datasets

**Test 4: Resource Usage Quality**
- Start memory tracking
- Execute search
- Measure peak memory consumption
- Stop memory tracking
- Assert memory used is under 100MB budget
- **Purpose**: Detects memory leaks and inefficient algorithms

This comprehensive approach catches issues that functional tests miss: slow queries, memory leaks, and scalability problems that only appear with realistic data volumes.

## Common Pitfalls

### Ignoring Non-Functional Requirements

**Don't assume functional correctness implies acceptable quality.**

A feature that "works" but is too slow, insecure, or resource-intensive will fail in production.

### Unstable Benchmarks

**Avoid performance tests that produce inconsistent results due to environmental factors.**

Run performance tests multiple times, use statistical analysis, and control for environmental variation.

### Testing in Unrealistic Environments

**Don't rely solely on local development environment tests for quality assurance.**

Use staging environments that mirror production for realistic quality testing.

## Conclusion

Sensitive to execution qualities tests are essential for predicting production success. While functional tests verify correctness, execution quality tests ensure performance, scalability, security, and resource efficiency. By incorporating these tests into your suite, you gain confidence that your system will not only work correctly but also perform acceptably under real-world conditions.

## Further Reading

- [Google SRE Book - Performance Testing](https://sre.google/sre-book/testing-reliability/)
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)
