require './index'
express = require 'express'
mainServer = require 'server/apps/main'

settings = require 'server/modules/settings'
server = null

before (done) ->
  app = express()
  app.use mainServer(done)
  server = app.listen settings.get 'server.port'

after (done) ->
  @timeout 0
  console.log 'closing server...'
  server.close ->
    console.log 'server closed.'
    done()
