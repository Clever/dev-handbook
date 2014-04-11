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
    - 

- unit tests vs integration tests
    - need both
    - unit tests
        - many
        - for everything
        - fast
        - test all cases, good and bad and weird
    - integration tests
        - few
        - just test that parts of system fit together correctly
        - slow
        - test only a few "happy paths"

- test workflow (TDD?)
- always run tests before deploying
- code isnt done until it's tested
