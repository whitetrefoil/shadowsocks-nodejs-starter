#### Predefine
SOURCE_DIR = './src'
BUILD_DIR = './lib'
DOC_DIR = './doc'


#### npm libs
_ = require 'lodash'
fs = require 'fs'
util = require 'util'
path = require 'path'
coffee = require('coffee-script')._compileFile
docco = require 'docco'
wrench = require 'wrench'
glob = require 'glob'


#### Helpers

# Wipe a whole dir
cleanDir = (path) ->
  try
    # the exception of wrench's rmdir is missing `errno` & `code`
    # try original rmdir first.
    fs.rmdirSync path
  catch e
    switch e.code
      when 'ENOTEMPTY'
        wrench.rmdirSyncRecursive path
      when 'ENOENT'
        # Do nothing if there's no such dir
      else
        throw e


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
  basePath = path.join path.dirname(filePath), path.basename(filePath, path.extname(filePath))
  compiled = coffee(path.join(SOURCE_DIR, filePath), needMap)
  if needMap is true
    writeFile path.join(BUILD_DIR, "#{basePath}.js"), compiled.js
    writeFile path.join(BUILD_DIR, "#{basePath}.map"), compiled.v3SourceMap
    compiled.js
  else
    writeFile path.join(BUILD_DIR, "#{basePath}.js"), compiled
    compiled


# wipe the build dir before build
cleanBuildDir = -> cleanDir BUILD_DIR

# build all files
buildAll = (needMap = false) ->
  cleanBuildDir()
  matching = new glob.Glob '**/*.+(coffee|litcoffee)',
    cwd: SOURCE_DIR
    nocase: true
  matching.on 'match', (file) -> compile file, needMap


# wipe the document dir before generating documents
cleanDocDir = -> cleanDir DOC_DIR


# scan for all source files in js & coffee & litcoffee, then generate documents for them
generateDocuments = ->
  cleanDocDir()
  files = glob.sync '**/*.+(coffee|litcoffee|js)',
    cwd: SOURCE_DIR
    nocase: true
  .map (match) -> path.join SOURCE_DIR, match
  docco.document
    args: files
    output: DOC_DIR
    layout: 'linear'

#### Tasks

task 'build', 'build the source code (coffee) to js', ->
  buildAll()

task 'build:map', 'build the source code (coffee) to js', ->
  buildAll(true)

task 'doc', 'generate documents', ->
  generateDocuments()

task 'test', 'run the test', ->
  util.log 'All tests passed!  Kidding, no test at this moment :)'
