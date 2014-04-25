#### Predefine
SOURCE_DIR = './src'
BUILD_DIR = './lib'


#### npm libs
fs = require 'fs'
util = require 'util'
path = require 'path'
coffee = require('coffee-script')._compileFile
wrench = require 'wrench'
glob = require 'glob'


#### Helpers

# Try to write file.  If failed, `mkdir -p` then try again.
writeFile = (filePath, content, tryDir = true) ->
  try
    fs.writeFileSync filePath, content,
      encoding: 'utf8'
  catch e
    if tryDir and e.code is 'ENOENT'
      wrench.mkdirSyncRecursive path.dirname filePath
      writeFile filePath, content, false


# `path` w/o `src/` or `lib/`
compile = (filePath, needMap = false) ->
  filePath = path.join path.dirname(filePath), path.basename(filePath, '.coffee')
  compiled = coffee(path.join(SOURCE_DIR, "#{filePath}.coffee"), needMap)
  if needMap is true
    writeFile path.join(BUILD_DIR, "#{filePath}.js"), compiled.js
    writeFile path.join(BUILD_DIR, "#{filePath}.map"), compiled.v3SourceMap
    compiled.js
  else
    writeFile path.join(BUILD_DIR, "#{filePath}.js"), compiled
    compiled


# wipe the build dir before build
cleanBuildDir = ->
  wrench.rmdirSyncRecursive(BUILD_DIR)


# build all files
buildAll = (needMap = false) ->
  cleanBuildDir()
  matching = new glob.Glob '**/*.coffee',
    cwd: SOURCE_DIR
    nocase: true
  matching.on 'match', (file) -> compile file, needMap


task 'build', 'build the source code (coffee) to js', ->
  buildAll()

task 'build:map', 'build the source code (coffee) to js', ->
  buildAll(true)

task 'test', 'run the test', ->
  util.log 'All tests passed!  Kidding, no test at this moment :)'
