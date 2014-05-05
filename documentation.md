# Documentation

- why write docs
    - you have teammates that need to be able to use your code
    - you will have to use your code in the future
    - helps improve your code design by making you think about how to write it down

- what goes in a readme
    - overview
        - what the software is for
        - why it's a good choice vs competitors
    - how to install
        - the software
        - deps
    - how to run tests
    - how to run (usage)
    - how to run locally if a service
        - commands
        - env vars
    - small code examples if a library
        - biggest indicator of if you will be able to use a piece of code!
    - well defined i/o spec
    - changelog or link to changelog
    - api docs
        - all args documented
        - type info
        - what the function does
        - how it works with other functions
        - examples
        - runtime info
    - troubleshooting/gotchas

- when to write docs/when to leave comments
    - should overlap as little as possible
    - comments
        - for when somebody is reading the code
        - explain potentially confusing/non-obvious code
    - docs
        - for anyone who wants to use your project
        - should be oblivious to internals of code
    - some api docs may be generated from comments

- repetition
    - ideally each piece of information is only written in one place (makes it easy to keep up to date)
    - can dynamically move information where it's needed
    - ex: type spec for complex object inlined in docs for multiple functions

- tests vs docs
    - tests should capture full behavior of code on all inputs
    - docs should communicate most common behavior of code
    - can point to tests for examples of uncommon cases (e.g. unexpected types of input)
    - docs shouldnt drown reader in a huge list of cases/minutiae

- how to write good docs
    - make minimal assumptions about what your readers know
        - might not know the language
        - might not know tools (e.g. package manager)
        - might not know meaning of env vars
    - keep docs up to date and consistent
        - worse than missing docs, because they mislead
        - might need to change docs every time you change your code
    - guide vs reference
        - guide should be about conceptual examples
        - reference/api docs should have all arguments/options documented in full
