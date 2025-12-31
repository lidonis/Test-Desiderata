# Understanding the Test Desiderata Framework

## Table of Contents

- [Introduction to Test Desiderata 2.0](#introduction-to-test-desiderata-20)
- [The Four Macro Properties](#the-four-macro-properties)
  - [Predict Success in Production](#predict-success-in-production)
  - [Fast to Get Feedback](#fast-to-get-feedback)
  - [Support Ongoing Code Design Change](#support-ongoing-code-design-change)
  - [Minimize Total Cost of Ownership](#minimize-total-cost-of-ownership)
- [How Individual Properties Support Macro Goals](#how-individual-properties-support-macro-goals)
- [Evolution from Beck to Bache](#evolution-from-beck-to-bache)
- [Using This Framework](#using-this-framework)
- [Further Reading](#further-reading)

## Introduction to Test Desiderata 2.0

In 2019, Kent Beck published his influential [Test Desiderata](https://testdesiderata.com), outlining 12 properties that characterize good tests. In December 2025, Emily Bache proposed [Test Desiderata 2.0](https://coding-is-like-cooking.info/2025/12/test-desiderata-2-0/), a reorganization that addresses what she found confusing and incomplete in Beck's original framework.

Bache's key insight: **Beck's list mixed properties of individual tests with properties of entire test suites**, making it harder to understand which properties matter when and why. Through research analyzing over 20 testing experts' perspectives, Bache identified a clearer organization: **4 macro properties of test suites**, each supported by specific individual test properties.

Additionally, Bache was surprised that Beck, with all his work on Test-Driven Development, didn't explicitly mention a critical benefit: **tests as active partners in design work**. This became one of the four macro properties.

## The Four Macro Properties

These macro properties represent the fundamental goals of a test suite. Understanding them helps developers make informed trade-offs when designing tests.

### Predict Success in Production

**Goal**: Ensure tests give confidence that code will work correctly in production.

Tests should be sensitive to problems that will occur in the real world. This goes beyond functional correctness to include performance, security, scalability, and other qualities that affect production success.

**Supporting Properties**:

- **[Behavioral](behavioral.html)** (Beck) - Tests reflect the expected functional behavior of the system
- **Sensitive to Execution Qualities** (NEW) - Tests detect performance degradation, security issues, and other non-functional problems

**Why This Matters**: Tests that pass but don't predict production success create false confidence. Teams deploy broken code because their tests didn't capture realistic failure modes.

**Example**: A test that validates an API returns correct data but ignores response time won't catch the performance regression that causes production timeouts.

### Fast to Get Feedback

**Goal**: Enable rapid iteration by providing immediate feedback on code changes.

Fast feedback keeps developers in flow, catches mistakes early when context is fresh, and supports continuous integration workflows. This is achieved through both fast individual tests and the ability to run tests in parallel.

**Supporting Properties**:

- **Minimal Data** (NEW) - Use only essential data to reduce setup time and improve clarity
- **[Isolated](isolated.html)** (Beck, "Run in any Order") - Tests run independently, enabling any execution order
- **Run in Parallel** (NEW) - Tests can run simultaneously without interference, leveraging modern hardware

**Why This Matters**: Slow test suites discourage frequent testing. Developers skip running tests, commit untested code, and catch bugs later when they're harder to fix.

**Example**: A test suite that runs in 30 seconds encourages developers to run it after every change. A suite that takes 10 minutes discourages testing and slows down development.

### Support Ongoing Code Design Change

**Goal**: Tests actively support and encourage good design practices throughout development.

This macro property captures the TDD benefit Beck didn't explicitly mention: tests as partners in design work. Good tests enable refactoring, guide design decisions, and remain valuable as the codebase evolves.

**Supporting Properties**:

- **[Composable](composable.html)** (Beck) - Tests focus on components that combine seamlessly
- **Documents Intent** (Shore) - Tests clearly express what the code should do
- **Durable** (Cunningham) - Tests remain valuable throughout the product lifetime
- **Necessary** (Farley) - Tests guide development choices rather than just checking correctness
- **Organized** (Bazuzi, Rainsberger) - Easy to locate corresponding test and code
- **Positive Design Pressure** (NEW) - Writing tests pushes developers toward better design

**Why This Matters**: Code design evolves constantly. Tests that support design change enable fearless refactoring. Tests that resist change become obstacles, slowing down improvement.

**Example**: Tests written against public interfaces survive refactoring. Tests coupled to implementation details break with every internal change, creating maintenance burden.

### Minimize Total Cost of Ownership

**Goal**: Keep tests maintainable and cost-effective over the lifetime of the project.

Tests have costs: time to write, time to run, time to maintain. Minimizing total cost means tests are easy to write, read, update, and diagnose when they fail.

**Supporting Properties**:

- **[Automated](automated.html)** (Beck) - Tests run automatically without manual intervention
- **[Deterministic](deterministic.html)** (Beck) - Tests produce consistent results
- **[Specific](specific.html)** (Beck, "Diagnosable" per Bazuzi) - Tests pinpoint issues precisely
- **[Readable](readable.html)** (Beck, "Easy to Read") - Tests are easy to understand
- **Easy to Update** (NEW) - When requirements change, tests are easy to modify
- **[Writable](writable.html)** (Beck, "Easy to Write") - Tests are easy to create
- **[Structure-Insensitive](structure-insensitive.html)** (Beck) - Tests remain valid despite code refactoring

**Why This Matters**: Tests with high maintenance costs eventually get abandoned. Flaky tests get ignored. Unreadable tests don't communicate intent. Expensive test suites undermine their own value.

**Example**: A test suite with clear failures pointing to specific problems gets fixed quickly. Cryptic failures in hard-to-read tests waste debugging time and erode confidence.

## How Individual Properties Support Macro Goals

This table shows the complete mapping of individual properties to macro goals:

| Individual Property | Macro Goal | Beck's Original? |
|---------------------|------------|------------------|
| [Behavioral](behavioral.html) | Predict Success in Production | Yes |
| Sensitive to Execution Qualities | Predict Success in Production | **No - NEW** |
| Minimal Data | Fast to Get Feedback | **No - NEW** |
| [Isolated](isolated.html) | Fast to Get Feedback | Yes (as "Isolated") |
| Run in Parallel | Fast to Get Feedback | **No - NEW** |
| [Composable](composable.html) | Support Ongoing Code Design Change | Yes |
| Documents Intent | Support Ongoing Code Design Change | No (Shore) |
| Durable | Support Ongoing Code Design Change | No (Cunningham) |
| Necessary | Support Ongoing Code Design Change | No (Farley) |
| Organized | Support Ongoing Code Design Change | No (Bazuzi, Rainsberger) |
| Positive Design Pressure | Support Ongoing Code Design Change | **No - NEW** |
| [Automated](automated.html) | Minimize Total Cost of Ownership | Yes |
| [Deterministic](deterministic.html) | Minimize Total Cost of Ownership | Yes |
| [Specific](specific.html) | Minimize Total Cost of Ownership | Yes (as "Specific") |
| [Readable](readable.html) | Minimize Total Cost of Ownership | Yes (as "Readable") |
| Easy to Update | Minimize Total Cost of Ownership | **No - NEW** |
| [Writable](writable.html) | Minimize Total Cost of Ownership | Yes (as "Writable") |
| [Structure-Insensitive](structure-insensitive.html) | Minimize Total Cost of Ownership | Yes |

### What About Fast and Predictive?

In Beck's framework, **Fast** and **Predictive** were individual properties. In Bache's 2.0 framework, these map directly to macro goals:

- **Fast** → Maps to the macro property "Fast to Get Feedback"
- **Predictive** → Maps to the macro property "Predict Success in Production"

Both remain fundamental, but are better understood as test suite goals rather than individual test properties.

### What About Inspiring?

Beck listed **Inspiring** as a property: tests that inspire confidence in the system's quality. Bache argues this isn't a separate macro property - inspiring confidence depends on tests being predictive of production success. If tests accurately predict production behavior, they naturally inspire confidence. If they don't, no amount of other properties will make them inspiring.

Therefore, "Inspiring" is an outcome of achieving "Predict Success in Production" rather than an independent goal.

## Evolution from Beck to Bache

### What Changed?

1. **Organizational Clarity**: Properties are now organized by the macro goal they support, making it clear WHY each property matters

2. **Suite vs. Individual**: Separation of test suite properties (macro) from individual test properties (micro) eliminates confusion

3. **Explicit Design Support**: Recognition that tests actively support ongoing design work, not just verification

4. **Additional Properties**: Incorporation of 5 new properties (Minimal Data, Run in Parallel, Sensitive to Execution Qualities, Easy to Update, Positive Design Pressure) and 4 properties from other experts (Documents Intent, Durable, Necessary, Organized)

5. **Improved Names**: Some properties renamed for clarity ("Specific" → "Diagnosable" emphasizes diagnostic value)

6. **Movement**: "Structure-Insensitive" moved from "Support design change" to "Minimize cost" after further reflection (updated Dec 9, 2025)

### What Stayed the Same?

- Beck's 12 original properties remain valid and valuable
- The fundamental trade-offs between properties still exist
- Not every test needs all properties
- The goal is still creating effective, maintainable test suites

### Research Foundation

Bache's framework is based on studying lists from over 20 testing experts, including:

- Arlo Belshee, Jay Bazuzi, Ward Cunningham, Kent C. Dodds
- David Farley, Michael Feathers, Steve Freeman, Kevlin Henney
- Vladimir Khorikov, Lasse Koskela, Roy Osherove
- J.B. Rainsberger, James Shore, and many others

This research revealed overlapping insights and identified gaps in Beck's original framework.

## Using This Framework

### For Understanding Trade-offs

When you face conflicts between properties, use the macro goals to understand what you're trading off:

**Example**: Should this test use real database or in-memory mock?
- Real database → Better **Predict Success** (realistic)
- In-memory mock → Better **Fast Feedback** (faster)
- Decision depends on which macro goal matters more for this test

### For Designing Test Suites

Different types of tests emphasize different macro properties:

- **Unit tests**: Prioritize Fast Feedback and Low Cost (fast, isolated, easy to write)
- **Integration tests**: Balance Fast Feedback with Predict Success (realistic but reasonably fast)
- **End-to-end tests**: Prioritize Predict Success (comprehensive, realistic scenarios)
- **Performance tests**: Emphasize Sensitive to Execution Qualities (non-functional requirements)

### For Test Reviews

When reviewing tests, ask which macro goals they serve:

- Does this test predict production problems? (Behavioral, Execution Qualities)
- Does it provide fast feedback? (Minimal Data, Isolated, Parallel)
- Does it support design evolution? (Composable, Structure-Insensitive, Design Pressure)
- Is it cost-effective to maintain? (Readable, Writable, Deterministic, Diagnosable)

### For Team Discussions

Use the framework as a shared vocabulary for test quality discussions:

"This test isn't diagnosable - when it fails, we can't tell what's wrong. Let's improve it to minimize cost of ownership."

"We need better execution quality tests. Our unit tests are fast but don't catch performance regressions."

## Further Reading

- [Emily Bache - Test Desiderata 2.0](https://coding-is-like-cooking.info/2025/12/test-desiderata-2-0/) - The 2.0 framework proposal
- [Kent Beck - Test Desiderata](https://testdesiderata.com) - The original 12 properties
- [Martin Fowler - Testing](https://martinfowler.com/testing/) - Comprehensive testing resources
- [Google Testing Blog](https://testing.googleblog.com/) - Industry perspectives on testing
- Individual property pages on this site for detailed guidance on each property
