express = require 'express'
path = require 'path'
favicon = require 'static-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
jade = require 'jade'

app = express()

app.use favicon()
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()
app.use express.static(path.join(__dirname, 'public'))

app.get '/:appName', (req, res) ->
  {appName} = req.params
  console.log appName
  ngAppName = appName.replace(/(\_\w)/g, (m) -> m[1].toUpperCase())
  console.log ngAppName

  layout = jade.renderFile './server/app/layout.jade', {appName, ngAppName}
  res.send layout

module.exports = app
