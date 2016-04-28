#!/usr/bin/env bash
set -e

#FILES=`find . -name "*.jsx" -not -path "./node_modules/*"`
untouched.sh
FILES=$(cat /tmp/jsx-files-to-lint)
JSCODESHIFT_OPTS="--printOptions='{\"quote\":\"double\"}'"
npm install -g jscodeshift eslint babel-eslint eslint-config-airbnb eslint-plugin-react eslint-plugin-import eslint-plugin-jsx-a11y
npm update -g jscodeshift eslint babel-eslint eslint-config-airbnb eslint-plugin-react eslint-plugin-import eslint-plugin-jsx-a11y

if [ ! -d "f3266c3915b0e45dac78" ]; then
    git clone git@gist.github.com:f3266c3915b0e45dac78.git
else
    (cd f3266c3915b0e45dac78 && git pull)
fi
if [ ! -d "js-codemod" ]; then
    git clone git@github.com:cpojer/js-codemod.git
else
    (cd js-codemod && git pull)
fi
if [ ! -d "react-codemod" ]; then
    git clone git@github.com:reactjs/react-codemod.git
else
    (cd react-codemod && git pull)
fi

jscodeshift -t "f3266c3915b0e45dac78/requiresToImports.js" $FILES $JSCODESHIFT_OPTS
git commit -am "codemod: requires to imports" || true

REACTCODEMOD_TRANSFORMS="class sort-comp pure-component"
for transform in $REACTCODEMOD_TRANSFORMS; do
    jscodeshift -t "react-codemod/transforms/$transform.js" $FILES $JSCODESHIFT_OPTS
    git commit -am "react-codemod: $transform" || true
done

JSCODEMOD_TRANSFORMS="trailing-commas object-shorthand arrow-function template-literals no-vars invalid-requires unquote-properties"
for transform in $JSCODEMOD_TRANSFORMS; do
    jscodeshift -t "js-codemod/transforms/$transform.js" $FILES $JSCODESHIFT_OPTS
    git commit -am "js-codemod: $transform" || true
done

# run eslint --fix a few times, since it's not idempotent
for i in $(seq 5); do
    ./node_modules/.bin/eslint --fix $FILES || true
done
git commit -am "eslint --fix" || true
