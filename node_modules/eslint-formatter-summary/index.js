const format = require('./dist/format-results');

module.exports = function formatter(results) {
  console.log(format(results, process.env));
};
