app = angular.module 'viewWithCustomDirectives', [
  'ui.router'
  'ui.bootstrap'

  'viewWithCustomDirectives.listItem'
]

app.config ($stateProvider) ->

  $stateProvider.state 'viewWithCustomDirectives',
    url: ''
    template: require './template'
    controller: require './controller'
