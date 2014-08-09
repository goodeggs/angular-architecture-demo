app = angular.module 'nestedViews', [
  'ui.router'
  'ui.bootstrap'
]

app.config ($stateProvider) ->

  $stateProvider.state 'nestedViews',
    url: ''
    template: require './template'
