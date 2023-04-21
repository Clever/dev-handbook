module.exports = {
  env: {
    browser: true,
    jasmine: true,
    jest: true,
    mocha: true,
    node: true,
  },
  extends: [
    // https://github.com/eslint/eslint
    "eslint:recommended",
    // https://github.com/yannickcr/eslint-plugin-react
    "plugin:react/recommended",
    // https://github.com/facebook/react/tree/master/packages/eslint-plugin-react-hooks
    "plugin:react-hooks/recommended",
    // https: //github.com/typescript-eslint/typescript-eslint/tree/master/packages/eslint-plugin
    "plugin:@typescript-eslint/eslint-recommended",
    "plugin:@typescript-eslint/recommended",
    // https://github.com/prettier/eslint-config-prettier
    "prettier",
    "prettier/@typescript-eslint",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 13,
    sourceType: "module",
    project: "./tsconfig.json",
  },
  plugins: ["react", "react-hooks", "@typescript-eslint", "@clever"],
  rules: {
    camelcase: "off",
    "comma-dangle": ["error", "always-multiline"],
    eqeqeq: ["error", "smart"],
    "global-require": "off",
    "import/no-unresolved": "off",
    indent: "off",
    "key-spacing": ["error", { mode: "minimum" }],
    "max-len": [
      "error",
      {
        code: 115,
        ignorePattern: "^import",
        ignoreRegExpLiterals: true,
        ignoreStrings: true,
        ignoreTemplateLiterals: true,
        ignoreUrls: true,
      },
    ],
    "new-cap": [
      "error",
      {
        capIsNewExceptions: ["immutable.OrderedMap", "OrderedMap"],
        newIsCapExceptions: ["kayvee.logger"],
      },
    ],
    "newline-per-chained-call": "off",
    "no-console": "off",
    "no-multi-spaces": [
      "error",
      {
        exceptions: {
          ImportDeclaration: true,
          VariableDeclarator: true,
        },
      },
    ],
    "no-param-reassign": [
      "error",
      {
        props: false,
      },
    ],
    "no-restricted-syntax": [
      "error",
      {
        message: "Prefer useTypedDispatch to get a typed version of dispatch.",
        selector: "CallExpression[callee.name='useDispatch']",
      },
    ],
    "no-underscore-dangle": "off",
    "no-unused-vars": "off",
    "no-var": "off",
    quotes: ["error", "double", "avoid-escape"],
    "react/display-name": "off",
    "react/jsx-indent": "off",
    "react/no-did-update-set-state": "off",
    "react/prop-types": "off",
    "react/sort-comp": "off",
    "vars-on-top": "off",
    "@typescript-eslint/ban-ts-comment": [
      "error",
      {
        "ts-ignore": false,
      },
    ],
    "@typescript-eslint/ban-types": "off",
    "@typescript-eslint/explicit-function-return-type": "off",
    "@typescript-eslint/no-empty-function": ["error", { allow: ["arrowFunctions"] }],
    "@typescript-eslint/no-empty-interface": "off",
    "@typescript-eslint/no-explicit-any": "off",
    "@typescript-eslint/no-floating-promises": "off",
    "@typescript-eslint/no-non-null-assertion": "off",
    "@typescript-eslint/no-unused-vars": ["error", { args: "none" }],
    "@typescript-eslint/no-use-before-define": "off",
    "@typescript-eslint/no-var-requires": "off",
    "@clever/no-app-listen-without-localhost": "error",
    "@clever/no-catch-without-default-handling": "error",
    "@clever/no-functions-in-map-state-to-props": "error",
    // TODO: rewrite sending error status code to throwing an exception
    // "@clever/no-send-status-error": "error",
  },
  overrides: [
    {
      files: ["*.ts", "*.tsx"],
      rules: {
        "no-undef": "off",
      },
    },
  ],
  settings: {
    "import/resolver": "webpack",
    react: {
      version: "detect",
    },
  },
};