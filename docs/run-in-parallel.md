---
layout: default
---
# Run in Parallel

## Table of Contents

- [Definition](#definition)
- [Part of a Larger Framework](#part-of-a-larger-framework)
- [Why Running in Parallel Matters](#why-running-in-parallel-matters)
- [Challenges of Parallel Execution](#challenges-of-parallel-execution)
- [Best Practices for Parallel Tests](#best-practices-for-parallel-tests)
- [Practical Example](#practical-example)
- [Common Pitfalls](#common-pitfalls)
- [Conclusion](#conclusion)
- [Further Reading](#further-reading)

## Definition

Tests that run in parallel can execute simultaneously with other tests, or even multiple copies of themselves, without that influencing the result. This is a higher bar than simply running tests in any order - parallel execution requires absolute independence from shared resources and state.

## Part of a Larger Framework

This principle contributes to the macro goal of **Fast to Get Feedback**. Tests that can run in parallel leverage modern multi-core processors and distributed CI/CD systems, dramatically reducing total test suite runtime.

**Related Properties**:
- [Isolated](isolated.md) - Parallel execution builds on test isolation
- [Fast](fast.md) - Parallelization is a key strategy for achieving fast feedback
- [Minimal Data](minimal-data.md) - Minimal setup enables faster parallel execution

*Learn more about how test properties work together in our [framework overview](framework.md).*

## Why Running in Parallel Matters

### Dramatic Speed Improvements

Parallel execution can reduce test suite runtime by orders of magnitude.

**Example**: A test suite with 1000 tests taking 1 second each runs in 1000 seconds sequentially, but only 100 seconds on a 10-core machine running tests in parallel.

### Scalability

As codebases grow, parallel execution prevents test suites from becoming bottlenecks.

**Example**: A suite that grows from 100 to 1000 tests doesn't need 10x more time if it can parallelize across available cores.

### CI/CD Efficiency

Modern CI/CD systems can distribute tests across multiple machines, but only if tests support parallel execution.

**Example**: Modern CI/CD platforms offer parallel execution capabilities that require parallelizable tests to utilize effectively.

### Developer Productivity

Faster feedback loops enable more frequent testing and quicker iteration.

**Example**: Developers can run the full suite before every commit instead of waiting for CI, catching issues earlier.

## Challenges of Parallel Execution

### Shared Resources

Tests sharing databases, files, or network resources can interfere with each other when run in parallel.

**Example**: Two tests writing to the same database table simultaneously might cause deadlocks or data corruption.

### Non-Deterministic Failures

Parallel execution can expose race conditions and timing issues that don't appear in sequential runs.

**Example**: Tests that pass individually might fail when run together due to resource contention or timing assumptions.

## Best Practices for Parallel Tests

### Eliminate Shared State

**Ensure each test has its own isolated resources and doesn't share mutable state.**

Shared mutable state causes tests to interfere with each other during parallel execution:

**Bad Pattern - Shared Global State**:
- Define a global counter variable
- Test modifies the global counter
- Assert counter equals 1
- **Problem**: When two tests run simultaneously, they both modify the same counter, causing assertion failures

**Good Pattern - Isolated State**:
- Define counter as a local variable within the test
- Test modifies its own counter
- Assert counter equals 1
- **Benefit**: Each test has its own counter, no interference possible, safe for parallel execution

### Use Unique Identifiers

**Generate unique identifiers for resources to avoid conflicts.**

Hard-coded resource names cause conflicts when tests run in parallel:

**Bad Pattern - Fixed Filename**:
- Save report to `report.pdf`
- Check that `report.pdf` exists
- **Problem**: Two tests running simultaneously both try to write `report.pdf`, causing file conflicts or one test reading another's file

**Good Pattern - Unique Filename**:
- Generate unique filename using UUID: `report-{uuid}.pdf`
- Save report to the unique filename
- Check that the specific file exists
- Clean up the unique file after test
- **Benefit**: Each test has its own file, no conflicts, safe to run many tests simultaneously

### Use Test-Specific Databases

**Provide each test with its own database instance or schema.**

Each test gets its own isolated database to prevent data conflicts:

**Setup (Before Each Test)**:
- Generate unique database name using UUID: `test_db_{uuid}`
- Create a new database with that name
- Store reference to this test's database

**Cleanup (After Each Test)**:
- Drop the test-specific database
- Release database resources

**Benefit**: Multiple tests can run simultaneously, each working with its own database. No data corruption, no lock contention, no interference. Tests can safely create, modify, and delete data without affecting other tests.

### Avoid File System Conflicts

**Use in-memory filesystems or unique directories for each test.**

Tests working with files need isolated directories to avoid conflicts:

**Pattern**:
- Create a unique temporary directory for each test
- Place all test files within that directory
- Process files from the isolated directory
- Automatically clean up the directory when test completes

**Example**:
- Test processes an uploaded file
- Create temporary directory (unique to this test)
- Create file at: `{temp_dir}/upload.txt`
- Write test content to the file
- Process the file and verify success
- Directory automatically deleted after test

**Benefit**: Each test has its own filesystem space. Multiple tests can create `upload.txt` simultaneously without conflicts because they're in different directories.

### Leverage Test Framework Features

**Use your test framework's built-in parallel execution support.**

Modern test frameworks provide built-in parallel execution capabilities:

**Configuration Approaches**:

**Command Line**:
- Enable parallel execution with a flag (e.g., use all available CPU cores)
- Specify number of workers or percentage of cores to use

**Configuration File**:
- Set parallel execution options in framework config
- Define worker count or let framework auto-detect cores
- Some frameworks parallelize by default, others require explicit configuration

**Common Options**:
- **Auto**: Automatically use all available CPU cores
- **Fixed number**: Specify exact worker count (e.g., 4 workers)
- **Percentage**: Use percentage of available cores (e.g., 50% to leave resources for other tasks)

**Example**: Configure test runner to automatically distribute tests across all CPU cores, reducing total suite runtime from minutes to seconds on modern multi-core hardware.

## Practical Example

**Before - Sequential-Only Tests:**

Tests that cannot run in parallel:

**Shared Resources**:
- All tests use the same database: `test_database`
- All tests use the same user ID: `1`

**Test 1: User Creation**:
- Connect to shared database
- Insert user with ID 1, name "Alice"
- Find user with ID 1
- Assert name is "Alice"
- Delete all users (cleanup)

**Test 2: User Update**:
- Connect to shared database
- Insert user with ID 1, name "Bob"
- Update user ID 1 to name "Charlie"
- Find user with ID 1
- Assert name is "Charlie"
- Delete all users (cleanup)

**Problem**: If both tests run simultaneously:
- Both try to insert user ID 1, causing conflicts
- Test 1 might find Test 2's user or vice versa
- Deletion cleanup can remove data the other test is using
- Tests fail randomly depending on timing

**After - Parallel-Safe Tests:**

Tests redesigned for safe parallel execution:

**Isolation Strategy**:
- Each test gets its own database (using unique UUID in name)
- Each test uses unique user IDs (generated with UUID)
- Automatic cleanup via test fixture

**Database Fixture**:
- Create database with unique name: `test_db_{uuid}`
- Provide database to test
- Automatically drop database after test completes

**Test 1: User Creation**:
- Receive isolated database from fixture
- Generate unique user ID
- Insert user with unique ID, name "Alice"
- Find user by unique ID
- Assert name is "Alice"
- Database automatically cleaned up

**Test 2: User Update**:
- Receive isolated database from fixture
- Generate unique user ID
- Insert user with unique ID, name "Bob"
- Update user by unique ID to name "Charlie"
- Find user by unique ID
- Assert name is "Charlie"
- Database automatically cleaned up

**Benefit**: Tests can run simultaneously without any interference. Each test works in complete isolation with its own database and unique identifiers.

## Common Pitfalls

### Assuming Sequential Execution

**Don't write tests that depend on execution order.**

Tests like "test_01_create_user" and "test_02_update_user" that depend on sequential execution will fail when parallelized.

### Shared Test Fixtures

**Avoid fixtures that create shared global state.**

Fixtures like "load_test_data_once" that populate a shared database for all tests prevent parallel execution.

### Insufficient Resource Isolation

**Don't assume exclusive access to resources.**

Tests that bind to fixed ports, use hardcoded filenames, or access singleton resources will conflict in parallel execution.

### Ignoring Cleanup

**Always clean up resources, even when tests fail.**

Use try/finally blocks or framework cleanup hooks to ensure resources are released.

## Conclusion

Running tests in parallel is essential for maintaining fast feedback as test suites grow. While it requires discipline to eliminate shared state and resource conflicts, the dramatic speedup makes it worthwhile. By following best practices for isolation and using unique identifiers, tests can achieve true parallel execution, leveraging modern hardware and CI/CD systems for maximum efficiency.

## Further Reading

- [Martin Fowler - Eradicating Non-Determinism in Tests](https://martinfowler.com/articles/nonDeterminism.html)
