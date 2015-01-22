fs     = require 'fs'
{exec} = require 'child_process'

ClosureCompiler = require("closurecompiler");

appFiles  = ['GND']

task 'build', 'Build single application file from source files', ->
  appContents = new Array remaining = appFiles.length
  for file, index in appFiles then do (file, index) ->
    fs.readFile "src/#{file}.coffee", 'utf8', (err, fileContents) ->
      throw err if err
      appContents[index] = fileContents
      process() if --remaining is 0
  for f,i in ['de','en', 'header'] then do (f) ->
    exec 'coffee -c -b src/'+f+'.coffee && cat src/'+f+'.js > '+f+'.js && mv '+f+'.js src/', (err, stdout, stderr) ->
        throw err if err
        console.log(stdout + stderr) if (stderr)
        console.log 'src/'+f+' Done.'
  process = ->
    fs.writeFile 'app.coffee', appContents.join('\n\n'), 'utf8', (err) ->
      throw err if err
      exec 'coffee -b -c app.coffee &&  cat app.js > src/GND.js ', (err, stdout, stderr) ->
        throw err if err
        console.log(stdout + stderr) if (stderr)
        fs.unlink 'app.coffee', (err) ->
          throw err if err
          console.log 'Del app.coffee done.'
        fs.unlink 'app.js', (err) ->
          throw err if err
          console.log 'Del app.js done.'
task 'compact', 'Compile JS for more efficency and low bandwith usage', ->
  ClosureCompiler.compile ['src/GND.js'], {compilation_level: "WHITESPACE_ONLY"}, (error, result) ->
    if result
      fs.writeFile 'GND.min.js', result, 'utf8', (err) ->
        throw err if err
      exec 'cat src/header.js GND.min.js >> src/GND.min.js && rm GND.min.js', (err, stdout, stderr) ->
        throw err if err
    else
      console.log error
