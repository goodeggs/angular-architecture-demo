fs = require 'fs'
uglify = require 'uglify-js'
WebChauffeur = require 'web-chauffeur'
protractor = require 'protractor'

chai = require 'chai'
chaiWebdriver = require 'chai-webdriver'
sizzle = require 'webdriver-sizzle'

Deferred = WebChauffeur.Deferred

mixinClearLocalStorage = (webdriver)->

addMixins = (webdriver) ->
  lazy(webdriver)
    .assign
      getPath: ->
        deferred = new Deferred()
        @getCurrentUrl().then (url) => deferred.fulfill url.replace @baseUrl, ''
        deferred
      clearLocalStorage: ->
        @executeScript('window.localStorage.clear();')
    .toObject()

before (done) ->
  @timeout 120000
  @_webChauffeur = new WebChauffeur settings.get('selenium')
  if settings.get('ci')
    @_webChauffeur.capabilities
      .set('platform', 'OS X 10.9')
      .set('version', '33')

  @_webChauffeur.on "log.#{level}", console[level].bind(console) for level in ['info', 'error']
#  @_webChauffeur.on 'log.debug', console.log.bind(console)
  @_webChauffeur.start done

before ->
  @_webChauffeur.capabilities
    .set('name', 'Kale test')

  driver = protractor.wrapDriver @_webChauffeur.webdriver()
  driver.manage().timeouts().setScriptTimeout 120000
  driver.baseUrl = settings.get 'server.url'

  GLOBAL.webdriver = addMixins driver
  GLOBAL.$ = sizzle driver
  GLOBAL.expectModalVisibility = (expectVisible, done) ->
    # this is why: https://github.com/angular-ui/bootstrap/pull/2289
    sleepTime = if settings.get('ci') then 7000 else 800
    webdriver.sleep(sleepTime).then ->
      if expectVisible
        expect('.modal').dom.to.be.visible done
      else
        expect('.modal').dom.not.to.be.visible done

  chai.use chaiWebdriver webdriver

after (done) ->
  @timeout 30000
  webdriver.quit().then =>
    @_webChauffeur.stop done

require '../database'
require '../server'
