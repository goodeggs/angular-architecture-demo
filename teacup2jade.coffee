html2jade = require("html2jade")
fs = require 'fs'
pathToFile = process.argv[2]

template = require('./' + pathToFile)

if typeof template is 'function'
  template = template()

html2jade.convertHtml template, {}, (err, jade) ->
  fileName = pathToFile.replace('.coffee', '.jade')
  fs.writeFileSync fileName, jade
