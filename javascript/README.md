# JavaScript

## Style

The style guide we use is the [AirBnB Style Guide](https://github.com/airbnb/javascript).
We also follow the [React/JSX](https://github.com/airbnb/javascript/tree/master/react) portion of that guide.
We use both [`eslint`](http://eslint.org/) and [`tslint`](https://github.com/palantir/tslint).
The config files we use for both of these linters can be found in this directory.

Additionally, we recommend the use of [jscodeshift](https://github.com/facebook/jscodeshift) to automatically refactor and improve code that is failing lint.
The `scripts` directory contains helper scripts for applying jscodeshift and eslint across many files.
