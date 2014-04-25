(function() {
  var yargs;

  yargs = require('./argv');

  module.exports = function() {
    return yargs.showHelp();
  };

}).call(this);
