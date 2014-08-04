userMethods =
  chooseFoodhub: (foodhub, done) ->
    webdriver.get('/#/').then ->
      webdriver.executeScript((foodhub) ->
        window.localStorage.setItem 'ngStorage-foodhub',angular.toJson(foodhub)
      , foodhub
      ).then ->
        done()
      , (err) ->
        done(err)

before ->
  webdriver.user = userMethods
