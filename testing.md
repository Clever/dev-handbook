# Testing

## Why write tests?

> "Testing shows the presence, not the absence of bugs" - Edsger Dijkstra

Even if testing can't prove that your code is completely correct, there are still a few important motivations for writing automated tests for your code.

First, tests nail down the behavior of a program. You can think of tests like a specification of how a program should behave when given different inputs. But, better than a written spec, tests can also check whether or not a program meets that specification.

Having a spec that can be checked allows you to be confident that changes to a program don't change its behavior. If a program's tests pass before you make changes and pass after you make changes, then you haven't changed the external behavior of the program - only its internal workings. Thus, tests allow you to safely refactor and optimize a program.

It may seem like a waste of time to encode all the behavior of a program twice: once in the program itself and once in the tests. However, this duplication of information is one of the key factors that makes testing useful. Having the behavior written down twice ensures you can't change the behavior in one without changing the other. Since tests and code express a program's behavior in different ways, unintentional or mistaken changes to code will be flagged in the tests. Expressing a program's behavior twice and requiring that both versions agree helps ensure that the behavior expressed correctly - as the author intended.

These benefits of tests manifest most strongly when developing software collaboratively or developing software over time. When working with a team, tests allow you to communicate the expected behavior of your code to your teammates so they too can safely make changes. When working on a project over time, tests allow you to communicate in the same way with your future self.

Testing is also a helpful design tool. Since tests are another way to express a program's behavior, writing tests can be a good way to think about what you want a program to do. Testing also forces you to design your code in a way that makes the individual parts testable, which leads to simpler, more modular code.

Lastly, testing is unavoidable. You will always need to confirm that a program behaves as expected after writing it or changing it. Automated testing applies the main insight of programming - making the computer do the repetitive work - to testing. Instead of manually running a program and confirming that it behaves correctly each time you change it, automated tests offload this repetitive task to the computer.

## When should you write tests?

The short answer is **always**.

Building a new feature? Write some tests so you can be sure it works! Fix a bug in some existing code? Add a test so it will never happen again! Scared to modify some legacy code? Assuage your fear with tests! They say there's a fine line between bravery and stupidity. That line is made of tests.

"But, what if my tests are hard to maintain?" That's better than no tests. "But, what if my tests take a long time to run?" Still better than no tests. Some tests are strictly better than no tests.

So just write tests always.

It doesn't matter if you write your tests before your code, at the same time as your code, or after, as long as you are writing tests. If you like [test-driven development](http://en.wikipedia.org/wiki/Test-driven_development), go for it! If you think test-driven development is only for brainwashed zealots, that's fine too... as long as you still write tests.

A piece of code is not done until it's tested.

So just write tests. Always.

## Testing Principles

Things you should keep in mind while writing tests for a codebase.

### Write complete testing suites

Testing suites should attempt to be exhaustive in verifying the code does what is expected. None of
these tests should require any manual work, other than executing the initial command to run the
tests.

An exhaustive test suite implies that you should be confident of merging and deploying your changes
once all your tests pass in your continuous integration environment. Any manual steps that are needed
to verify code changes should be encoded as automated tests that run in your continuous integration
environment.  As an example, if to test your code, you bring up an instance of your service and
manually send it an example request, then this flow should be encoded as an integration test.

### Test deterministically

Tests should be deterministic. That means that if you run a test multiple times without changing the
code, it should produce the same results. A test that sometimes fails and sometimes passes is not
consistent, and therefore can't be relied on to give you confidence about the correctness of a
program.

Concretely, this means you should avoid relying on factors like randomness, time, or external
services in the structure of your tests. For instance, if you are testing a button that changes a
piece of UI, you shouldn't wait for an arbitrary number of seconds to check that the UI refreshes,
since the time that it takes to refresh is not deterministic. Instead, you can emit some sort of
event when the UI is finished refreshing, and make the test listen for this event.

Testing non-deterministic code can also be very difficult. If you can, avoid non-deterministic
behavior in your code. If you must have it, try to isolate it so it can be deterministically mocked
in tests.

One type of non-determinism that *is* useful for testing is generating random inputs.
[Generative testing](http://blog.8thlight.com/connor-mendenhall/2013/10/31/check-your-work.html), in
which a program generates different test inputs each time the tests are run, can help describe
properties of your program that should hold for all inputs. They can make a stronger assertion about
correctness, since, if they pass, it means your program works for many random inputs, not just a few
representative ones. Generative tests can also come up with edge cases that you may not have thought
of.

### Prefer readability and ease of code

Tests should be written in a manner that prioritizes readability and ease of writing new tests and
modifying existing ones. In particular, these should be prioritized over other typical concerns like
abstraction and removing code duplication. If abstractions are needed, they should be created in a
manner that preserves the logic in the test functions code without requiring many hops. Another way
of saying this is that it should be apparent what the test is doing by just looking at the test
code.

As an example, we had a testing library called which populated a bunch of fake data in the database
specified by the test. A lot of our tests used with a single statement of the form
`db_test_helpers.set_up_test_data`. This single function populated a bunch of state within the
database including creating students, teachers, districts, apps. However, it also hid away all the
details of the state being created. This meant that it became very hard to reason about tests or
modify your tests if the current state was not appropriate for them.

Instead, a better approach is to provide easy abstractions for creating individual pieces of data
like `add_student`, `add_district` and use them as needed in different tests.

### Ensure tests are independent

Each test should be written in a manner that makes it independent of other tests. If there is any
state needed for a test, the test should be responsible for getting to the state before running it
and resetting it after execution. That is, the state before and after the test should be identical
whether the test passes or fails. If your tests are independent, then running the tests in any order
should not affect the outcome of the tests.

A stronger version of independence could mean that there is no shared state between different tests.
As an example, if the test involves talking to a database, then different tests should talk to
different logical databases. Another example, if you are testing the behavior of a particular class,
different tests should create their own instances of the class object. In this scenario, you could
run all your tests in parallel keeping the outcome invariant. This becomes increasingly important
as your code grows and your tests start to take longer. Retroactively making tests parallelizable
can be hard while it's usually very little work to program them as such from the start.

## How do you write tests?

You'll probably want to use some sort of testing framework to help you write tests. Most languages support testing either with language constructs or with libraries. For example, we use [Mocha](http://visionmedia.github.io/mocha/) for node.js and [nose](https://nose.readthedocs.org/en/latest/) for Python.

### Test interfaces

The first thing to keep in mind when writing tests is that tests should describe the behavior of the program with respect to its interface, not its implementation. When testing a program (or function or module), the tests should be written with respect to the expected behavior of the program, not the internal details of its implementation. If a test relies on internal implementation details, then the test will not be useful in preserving the behavior of the program if the internal implementation needs to change. This technique of testing against interfaces as opposed to implementations is known as black-box testing.

### Test small components (unit tests)

Tests that are responsible for testing small pieces of code in isolation are generally referred to as *unit tests*. A unit test generally concerns itself with a single function. It tests the function on a representative sample of the full range of inputs, ensuring that the function produces the expected output in all cases. That means a unit test should be sure to cover weird edge cases.

A unit test should test a function independently from the context in which the function is called. This is easiest to achieve if your functions are pure (i.e. have no external side-effects). Pure functions can often be tested simply by specifying a list of pairs of inputs and their expected outputs (often called *table tests*).

If a function has external dependencies (e.g. a database, remote service, or file system) or creates side-effects (e.g. mutates shared state, creates threads), then the externalities should be mocked or stubbed. It's best to isolate side-effects as much as possible in the code so that business logic can be tested with simple unit tests.

Since unit tests have no external dependencies, they should be very fast. You should be able to run a large number of unit tests in seconds. (And since you are testing all the time, you will probably have a lot of tests!)

### Test integration of components (integration tests)

If you have a system composed of many small pieces, which are all independently unit tested, you will also want to test that the composition works correctly. These kinds of tests are generally referred to as *integration tests* (or *end-to-end tests* or *system tests*). Integration tests ensure that the different pieces of your system fit together as expected - they test components in context.

In order to test that different components are properly linked together, you should only need to test a small number of paths through the code. Most of the cases your program handles should be handled by the individual components and tested by unit tests. The integration tests need only test a few "happy paths" to ensure that data flows through the program as expected.

For example, if a program has 5 sequential true/false decision points, that means there are 2^5 paths through the code. It's better to use multiple unit tests to test the decision points and one integration test to ensure the decision happen sequentially than to write 2^5 integration tests to cover all the cases.

To test that individual components are linked together properly, you will probably want to use mocks to ensure that the components communicate with each other as expected. For instance, when testing an API, this could mean mocking the database and ensuring that the proper queries are made for certain API calls.

To test that the system as a whole functions correctly, you'll want to run the entire system at once with no mocks. For instance, when testing an API, this could mean spinning up a web server and database and serving actual requests.

Since integration tests are concerned with the communication between components, they often need to perform I/O, which can be very slow (compared to unit tests). Because they are slow (and, as mentioned above, you should only test a few paths), you should have many fewer integration tests than unit tests.

### Test large inputs (load tests)

If your want your program to perform well at scale, you'll want to test how it handles large inputs. These type of tests are generally referred to as *load tests*.

We don't do enough load testing currently to have conventions, but it's generally a good idea to keep these tests separate from unit and integration tests since they may take a long time.

### Test untested code

The harsh reality of real-world software development is that sometimes you come across code without tests (a.k.a. legacy code). Fixing bugs or changing the behavior of untested code can be daunting, if not downright terrifying.

Since the code was not written with tests originally, it will probably not be designed in a way that makes it amenable to unit testing. Thus, you'll have to test the code from the outside in.

First, write integration tests to cover as much of the behavior as possible. Once you have adequately covered the behavior, you can start refactoring the code into smaller, less-tightly-coupled modules that can be unit tested. As you add unit tests, you can start removing integration tests.

### Test using fake data

When testing your code, you should provide it data that is similar to what it will encounter in production. This can become tricky when the data the code needs is sensitive - e.g API keys, email address, passwords. In these cases, you must ensure that the data is obviously fake. You should never use real world keys or user information in tests, even in private repos.

#### Emails
Recommended: `test@example.com`. This is a good choice as [example.com](http://www.example.com/) is reserved. 

Avoid: `<some-silly-name>@gmail.com`. While this is tempting, someone probably uses it and so we do not want to.

#### Passwords
Recommended: `password`. If you want to make it more realistic use a variation on this theme such as `th!s!sth3p@55w0rd!`.

Avoid: Anything that looks like it could actually be the password.

#### Long, random looking keys, ids or secrets
Recommended: Match the length and style (number, hex, alphanumeric) of the real key and use obviously fake keys such as `12345`, `123abc`, `123xyz` respectively.

Avoid: Generating a pseudorandom key by closing your eyes and hitting your keyboard. This fails the "obviously fake" test and readers will not know whether it is real or not.

#### Keys or ids for consecutive tests
Recommended: Match the style and length of the key or id. Choose some function to increment the key between tests.

Avoid: Relying on properties that may not hold true in production such as the keys being consecutive, not changing, or being monotonic. Of course, if these are true in production then you should follow them!

## When should you run tests?

Tests can provide a lot of value as you write code. You can run unit tests repeatedly as you write code to provide a tight feedback loop. In the ideal case where your tests fully cover the behavior of the program, you should never have to manually test your code as you write it.

You should also always run tests before deploying. Code that causes test failures should not be deployed. [Continuous integration](http://en.wikipedia.org/wiki/Continuous_integration) tools like [Travis](https://travis-ci.org/) and [Drone](https://drone.io/) will automatically run your tests whenever you commit changes to your code.
