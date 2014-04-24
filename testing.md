# Testing

- why test?
    - nails down behavior of code
    - lets you be confident that changes to code don't change its behavior
        - also lets other people make changes
        - tests seem like they duplicate knowledge that's encoded in code, but you need to duplicate that knowledge if you want to safely develop over time
    - helps you think about what your code should do
    - forces you to break code down into testable parts which leads to more modular code
    - teammates rely on tests to collaborate on code

- when to write tests
    - always
    - just write tests
    - TDD? if it works for you
    - most important thing is that tests exists
    - some tests is better than no tests
    - so just write tests
    - any change (e.g. bug fix) should be accompanied by a changed/new test encoding new behavior

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

- always run tests before deploying
  - continuous integration
  - do tests block deploys?
    - no, you don't want to be blocked by your tools
- code isnt done until it's tested
