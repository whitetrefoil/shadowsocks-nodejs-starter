(function() {
  var colors, fs, getConfigs, main, printHelp, startService, stopService, util, yargs, _;

  main = function() {
    var binName, configs;
    configs = getConfigs();
    binName = configs.server ? 'ssserver' : 'sslocal';
    if (configs.help) {
      return printHelp();
    } else if (configs.stop) {
      return stopService(binName, configs.pid);
    } else if (configs.start) {
      return startService(binName, configs.pid, configs.daemon);
    } else {
      return printHelp();
    }
  };

  stopService = function(binName, pidFile) {
    var e, pid;
    if (pidFile == null) {
      pidFile = "./" + binName + ".pid";
    }
    try {
      pid = fs.readFileSync(pidFile, {
        encoding: 'utf8'
      });
    } catch (_error) {
      e = _error;
      if (e.code === 'ENOENT') {
        console.warn(("PID file " + pidFile + " not found, skip stopping!").yellow);
      } else {
        throw e;
      }
    }
    return console.log('killed!'.green);
  };

  startService = function(binName, pidFile, isDaemon) {};

  printHelp = function() {
    return yargs.showHelp();
  };

  getConfigs = function() {
    var argv;
    argv = yargs.argv;
    return {
      server: argv.server,
      stop: argv.stop || argv.restart,
      start: !argv.stop || argv.restart,
      daemon: argv.daemon,
      pid: argv.noPid === true ? false : argv.pid,
      help: argv.help
    };
  };

  yargs = require('./argv');

  _ = require('lodash');

  util = require('util');

  colors = require('colors');

  fs = require('fs');

  module.exports = main;

}).call(this);
