# JavaScript

## Editor
See the [editor setup guide](https://clever.atlassian.net/wiki/display/ENG/How+to+configure+your+editor+for+Typescript+magic) for instructions on how to configure your editor for typescript.


## Style

We use [eslint](https://eslint.org/) for linting and automatic formatting of JavaScript, TypeScript, JSX, and TSX files.


We use [prettier](https://github.com/prettier/prettier) to automatically format JavaScript, TypeScript, JSX, TSX, and Less files. Our code mostly conforms to Prettier's preferred styles, with a couple of tweaks.


### Set Up Code Linting and Formatting

This section describes how to convert a repo with eslint to use prettier and our newer eslint configuration instead.

1. Upgrade eslint:
	- Update the `.eslintrc.js` and `tsconfig.json` to the versions from this directory.
	- Update `eslint` to major version 5+. For example,`npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin`.
	- `npm install --save-dev eslint-config-prettier@6.12 eslint-plugin-jsx-a11y@6.3 eslint-plugin-react@7.21 eslint-plugin-react-hooks@4.1` for additional react eslint rule definitions

2. Install prettier and [Clever's shared configuration](https://github.com/Clever/prettier-config).
 	- Add the `.prettierrc.json` prettier config file from this dev-handbook directory.
 	- `npm install --save-dev --exact prettier @clever/prettier-config`

3. In the Makefile, define a make target to run prettier autoformatting. We like `format`:

	```make

	# remember to define TS_FILES, JSX_FILES, etc as needed and
	# pass them to format and lint commands
	TS_FILES := $(shell find . -name "*.ts" -not -path "./node_modules/*")
	FORMATTED_FILES := $(TS_FILES)
	MODIFIED_FORMATTED_FILES := $(shell git diff --name-only master $(FORMATTED_FILES))
	PRETTIER := ./node_modules/.bin/prettier

	format:
		@echo "Formatting modified files..."
		@$(PRETTIER) --write $(MODIFIED_FORMATTED_FILES)

	format-all:
		@echo "Formatting all files..."
		@$(PRETTIER) --write $(FORMATTED_FILES)

	format-check:
		@echo "Running format check..."
		@$(PRETTIER) --list-different $(FORMATTED_FILES) || \
			(echo -e "❌ \033[0;31m Prettier found discrepancies in the above files. Run 'make format' to fix.\033[0m" && false)

	```

	> Note that the `--write` flag means prettier will make changes to files. \
	> The `--list-different` flag will only *list* files where the current format does not match prettier formatting.

4.  In the Makefile, update the `lint` make target to include prettier linting:


	```make
	lint: format-check
		./node_modules/.bin/eslint $(TS_FILES)
 	```

5. Update code based on new linting.
	- run `make format-all`
	- run `make eslint`
	- fix any remaining errors




### Legacy Style Guides and Tools

Prior to Q4 2017, the style guide we used is the [AirBnB Style Guide](https://github.com/airbnb/javascript).
We also followed the [React/JSX](https://github.com/airbnb/javascript/tree/master/react) portion of that guide.
We used [`tslint`](https://github.com/palantir/tslint).
The config files we used for both of these linters can be found in the `legacy` subdirectory.

Additionally, we recommended the use of [`jscodeshift`](https://github.com/facebook/jscodeshift) to automatically refactor and improve code that failed linting.
The `legacy/scripts` directory contains helper scripts for applying `jscodeshift` and `eslint` across many files.
