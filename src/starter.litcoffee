This file is the main file of the starter.

Let's think about what do we need, step by step.

Entry Point
-----

First we need a main entry point.
There shouldn't have many things to do in the entry point.
Just get the configuration, then invoke the core function accordingly.

If neither start nor stop is allowed, print a help text instead.

    main = ->
      configs = getConfigs()
      binName = if configs.server then 'ssserver' else 'sslocal'
      if configs.help
        printHelp()
      else if configs.stop
        stopService binName, configs.pid
      else if configs.start
        startService binName, configs.pid, configs.daemon
      else
        printHelp()

Core Functions
-----

Stop the running service.
Since the only to find any running ones is look by PID,
so if the PID file is unreadable,
it will be skipped directly.

    stopService = (binName, pidFile) ->
      pidFile = "./#{binName}.pid" unless pidFile?
      try
        pid = fs.readFileSync pidFile,
          encoding: 'utf8'
      catch e
        if e.code is 'ENOENT'
          console.warn "PID file #{pidFile} not found, skip stopping!".yellow
        else
          throw e



Start a new service.

    startService = (binName, pidFile, isDaemon) ->

Helpers
-----

Get / Set the PID from / to a PID file.

    getPid = (pidFile, content) ->
      try
        pid = fs.readFileSync pidFile,
          encoding: 'utf8'
      catch e
        if e.code is 'ENOENT'
          console.warn "PID file #{pidFile} not found, skip stopping!".yellow
        else
          throw e

We need to let the end user know about how to use our application.
Printing a `--help` text is necessary.

    printHelp = ->
      yargs.showHelp()

Initialize & Configuration
-----

Not many things need to configure.
Just get a map of arguments is enough.

    getConfigs = ->
      argv = yargs.argv
      server: argv.server
      stop: argv.stop or argv.restart
      start: !argv.stop or argv.restart
      daemon: argv.daemon
      pid: if argv.noPid is true then false else argv.pid
      help: argv.help

Dependencies
-----
One more important thing to do - check which libraries have we used

Firstly get the arguments from [argv.litcoffee](argv.html)

    yargs = require './argv'

Then there are some external dependencies...

    _ = require 'lodash'
    util = require 'util'
    colors = require 'colors'
    fs = require 'fs'

Public API
-----

Now we can publish the main entry point.

    module.exports = main
