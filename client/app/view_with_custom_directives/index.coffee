app = angular.module 'viewWithCustomDirectives', [
  'ui.router'
  'ui.bootstrap'
]

app.config ($stateProvider) ->

  $stateProvider.state 'viewWithCustomDirectives',
    url: '/single-view'
    template: require './template'
    controller: require './controller'
