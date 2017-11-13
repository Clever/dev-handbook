# JavaScript

## Editor
See the [editor setup guide](https://clever.atlassian.net/wiki/display/ENG/How+to+configure+your+editor+for+Typescript+magic) for instructions on how to configure your editor for typescript.


## Style

We use [tslint](https://github.com/palantir/tslint) for linting and automatic formatting of JavaScript, TypeScript, JSX, and TSX files.


We use [prettier](https://github.com/prettier/prettier) to automatically format JavaScript, TypeScript, JSX, and TSX files. Our code conforms to Prettier's preferred styles.


### Set Up Code Linting and Formatting

This section describes how to convert a repo with eslint and tslint to use prettier and our newer tslint configuration instead.

1. Remove eslint:

	- Remove the `.eslintrc.yml` file
	- Remove any `eslint` packages from package.json
	- In the Makefile, remove any `eslint` lines from the `lint` command

2. Upgrade tslint:
	- Update the `tslint.json` and `tsconfig.json` to the versions from this directory.
	- Update tslint to major version 5+. For example,`npm install --save-dev tslint@5.4`.
	- `npm install --save-dev tslint-eslint-rules` to get additional tslint rule definitions that replace some from eslint
	- `npm install --save-dev tslint-react` for additional react tslint rule definitions

3. Install and configure prettier.
 	- Add the `.prettierrc.json` prettier config file from this dev-handbook directory.
 	- `npm install --save-dev prettier`

4. In the Makefile, define a make target to run prettier autoformatting. We like `format`:

	```make

	# remember to define TS_FILES, JSX_FILES, etc as needed and
	# pass them to format and lint commands
	format:
	 	./node_modules/.bin/prettier --write $(TS_FILES)

	```

	> Note that the `--write` flag means prettier will make changes to files.

5.  In the Makefile, update the `lint` make target to include prettier linting:


	```make
	lint: ./node_modules/.bin/tslint -t verbose $(TS_FILES)
 		./node_modules/.bin/prettier -l $(TS_FILES)
 	```

 	> The `-l` flag for prettier means prettier will only *list* files where the current format does not match prettier formatting.

6. Update code based on new linting.
	- run `make format`
	- run `make tslint`
	- fix any remaining errors




### Legacy Style Guides and Tools

Prior to Q4 2017, the style guide we used is the [AirBnB Style Guide](https://github.com/airbnb/javascript).
We also followed the [React/JSX](https://github.com/airbnb/javascript/tree/master/react) portion of that guide.
We used both [`eslint`](http://eslint.org/) and [`tslint`](https://github.com/palantir/tslint).
The config files we used for both of these linters can be found in the `legacy` subdirectory.

Additionally, we recommended the use of [`jscodeshift`](https://github.com/facebook/jscodeshift) to automatically refactor and improve code that failed linting.
The `legacy/scripts` directory contains helper scripts for applying `jscodeshift` and `eslint` across many files.
