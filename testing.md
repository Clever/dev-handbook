# Testing

# Why write tests?

There are a few main motivations for writing automated tests for your code.

First, tests nail down the behavior of a program. You can think of tests like a specification of how a program should behave when given different inputs. But, better than a written spec, tests can also check whether or not a program meets that specification.

Having a spec that can be checked allows you to be confident that changes to a program don't change its behavior. If a program's tests pass before you make changes and pass after you make changes, then you haven't changed the external behavior of the program - only its internal workings. Thus, tests allow you to safely refactor and optimize a program.

It may seem like a waste of time to encode all the behavior of a program twice: once in the program itself and once in the tests. However, this duplication of information is one of the key factors that makes testing useful. Having the behavior written down twice ensures you can't change the behavior in one without changing the other. Since tests and code express a program's behavior in different ways, unintentional or mistaken changes to code will be flagged in the tests. Expressing a program's behavior twice and requiring that both versions agree helps ensure that the behavior expressed correctly - as the author intended.

These benefits of tests manifest most strongly when developing software collaboratively or developing software over time. When working with a team, tests allow you to communicate the expected behavior of your code to your teammates so they too can safely make changes. When working on a project over time, tests allow you to communicate in the same way with your future self.

Testing is also a helpful design tool. Since tests are another way to express a program's behavior, writing tests can be a good way to think about what you want a program to do. Testing also forces you to design your code in a way that makes the individual parts testable, which leads to simpler, more modular code.

Lastly, testing is unavoidable. You will always need to confirm that a program behaves as expected after writing it or changing it. Automated testing applies the main insight of programming - making the computer do the repetitive work - to testing. Instead of manually running a program and confirming that it behaves correctly each time you change it, automated tests offload this repetitive task to the computer.

# When should you write tests?

The short answer is **always**. Just write tests all the time.

Building a new feature? Write some tests so you can be sure it works! Fix a bug in some existing code? Add a test so it will never happen again! Scared to modify some legacy code? Assuage your fear with tests! They say there's a fine line between bravery and stupidity. That line is made of tests.

"But, what if my tests are hard to maintain?" That's better than no tests.
"But, what if my tests take a long time to run?" Still better than no tests.
Some tests are strictly better than no tests.

So just write tests all the time.

It doesn't matter if you write your tests before your code, at the same time as your code, or after, as long as you are writing tests. If you like [test-driven development](http://en.wikipedia.org/wiki/Test-driven_development), go for it! If you think test-driven development is only for brainwashed zealots, that's fine too... as long as you still write tests.

A piece of code is not done until it's tested.

So just write tests. All the time.

# How do you write tests?

- how to write tests
  - two main types of tests:
    - unit tests
      - test small, isolated pieces of code
      - fast
      - test all cases, good and bad and weird
    - everything else (commonly integration, end-to-end, system tests)
      - test the linkages between code and system behavior as a whole
      - slow
      - test "happy cases"
  - focus on unit tests primarily
    - stub/mock to keep them light, fast
      - code under test shouldn't:
        - call out into (non-trivial) collaborators
        - access the network
        - hit a database
        - use the file system
        - spin up a thread
    - functions should have as few side effects as possible to make them easy to test/reason about
    - when there are side effects, isolate those, and test the side effects with mocks and stubs
    - the only thing tests should know about implementation is what dependencies need to be mocked - tests respect interfaces
  - still need some integration tests
    - why do you only need a few integration tests
      - logic should be covered in unit tests
    - two types of tests here
      - testing that your unit-tested functions are linked together properly
        - basically entirely mocks
      - testing that the system as a whole performs as expected
        - probably involve starting a web server and throwing requests at it

- load testing
  - TBD, still not enough of this to have conventions

- how to start testing un-tested, legacy code
  1. start with integration tests that cover all the behavior
    - usually can't start with unit tests, because the code probably isn't modular enough to test
  2. refactor, modularize
  3. unit tests
  4. can probably do away with most integration tests

# When should you run tests?
- always run tests before deploying
  - continuous integration
  - do tests block deploys?
    - no, you don't want to be blocked by your tools
