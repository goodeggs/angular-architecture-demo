app = angular.module 'singleView', [
  'ui.router'
  'ui.bootstrap'
]

app.config ($stateProvider) ->

  $stateProvider.state 'singleView',
    url: '/single-view'
    template: require './template'
    controller: require './controller'
