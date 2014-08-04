process.env.NODE_ENV ?= 'test'
process.env.PORT ?= 8001

require 'server/modules/globals'

chai = require 'chai'

GLOBAL.expect = chai.expect

sinon = require 'sinon'
sinonPatches = require 'shared/monkey_patches/sinon'
GLOBAL.sinon = sinonPatches sinon

GLOBAL.request = require 'request'
GLOBAL.databases = require 'server/modules/databases'
GLOBAL.models = require 'server/modules/models'

chai.use require 'sinon-chai'

GLOBAL.given = (description, callback) ->
  describe "given #{description}", callback
