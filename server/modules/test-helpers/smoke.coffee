require './index'
WebChauffeur = require 'web-chauffeur'

before fibrous ->
  @timeout 120000
  @_webChauffeur = new WebChauffeur settings.get('selenium')
  @_webChauffeur.on "log.#{level}", console[level].bind(console) for level in ['info', 'error']
  #@_webChauffeur.on 'log.debug', console.log.bind(console)
  @_webChauffeur.capabilities
    .set('name', 'Kale test')

  @_webChauffeur.sync.start()

  GLOBAL.webdriver = @_webChauffeur.webdriver()
  webdriver.manage().timeouts().setScriptTimeout 30000

  GLOBAL.By = require('selenium-webdriver').By

after (done) ->
  @timeout 30000
  webdriver.quit().then =>
    @_webChauffeur.stop done

