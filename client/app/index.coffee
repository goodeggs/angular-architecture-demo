app = angular.module 'app', [
  'ui.router'
  'ui.bootstrap'
]

app.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state 'main',
    url: ''
    template: require './template'

  $urlRouterProvider.otherwise '/single-view'
