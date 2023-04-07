"use strict";
exports.__esModule = true;
var axe = require("../../axe");
var context = document;
var $fixture = {};
axe.run(context, {}, function (error, results) {
    if (error) {
        console.log(error);
    }
    console.log(results.passes.length);
    console.log(results.incomplete.length);
    console.log(results.inapplicable.length);
    console.log(results.violations.length);
    console.log(results.violations[0].nodes[0].failureSummary);
});
axe.run().then(function (done) {
    done();
});
// additional configuration options
axe.run(context, { iframes: false, selectors: false, elementRef: false }, function (error, results) {
    console.log(error || results.passes.length);
});
// axe.run include/exclude
axe.run({ include: [['#id1'], ['#id2']] }, {}, function (error, results) {
    console.log(error || results);
});
axe.run({ exclude: [$fixture[0]] }, {}, function (error, results) {
    console.log(error || results);
});
// additional configuration options
axe.run(context, { iframes: false, selectors: false, elementRef: false }, function (error, results) {
    console.log(error || results.passes.length);
});
var tagConfigRunOnly = {
    type: 'tag',
    values: ['wcag2a']
};
var tagConfig = {
    runOnly: tagConfigRunOnly
};
axe.run(context, tagConfig, function (error, results) {
    console.log(error || results);
});
axe.run(context, {
    runOnly: {
        type: 'tags',
        values: {
            include: ['wcag2a', 'wcag2aa'],
            exclude: ['experimental']
        }
    }
}, function (error, results) {
    console.log(error || results);
});
axe.run(context, {
    runOnly: {
        type: 'tags',
        values: ['wcag2a', 'wcag2aa']
    }
}, function (error, results) {
    console.log(error || results);
});
var someRulesConfig = {
    rules: {
        'color-contrast': { enabled: 'false' },
        'heading-order': { enabled: 'true' }
    }
};
axe.run(context, someRulesConfig, function (error, results) {
    console.log(error || results);
});
// axe.configure
var spec = {
    branding: {
        brand: 'foo',
        application: 'bar'
    },
    reporter: 'v1',
    checks: [
        {
            id: 'custom-check',
            evaluate: function () {
                return true;
            }
        }
    ],
    rules: [
        {
            id: 'custom-rule',
            any: ['custom-check']
        }
    ]
};
axe.configure(spec);
var source = axe.source;
axe.reset();
axe.getRules(['wcag2aa']);
typeof axe.getRules() === 'object';
// Plugins
var pluginSrc = {
    id: 'doStuff',
    run: function (data, callback) {
        callback();
    },
    commands: [
        {
            id: 'run-doStuff',
            callback: function (data, callback) {
                axe.plugins['doStuff'].run(data, callback);
            }
        }
    ]
};
axe.registerPlugin(pluginSrc);
axe.cleanup();
axe.configure({
    locale: {
        checks: {
            foo: {
                fail: 'failure',
                pass: 'success',
                incomplete: {
                    foo: 'nar'
                }
            }
        }
    }
});
axe.configure({
    locale: {
        lang: 'foo',
        rules: {
            foo: {
                description: 'desc',
                help: 'help'
            }
        },
        checks: {
            foo: {
                pass: 'pass',
                fail: 'fail',
                incomplete: {
                    foo: 'bar'
                }
            }
        }
    }
});
