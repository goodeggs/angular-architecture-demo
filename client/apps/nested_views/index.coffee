app = angular.module 'nestedViews', [
  'ui.router'
  'ui.bootstrap'

  'nestedViews.child1'
  'nestedViews.child2'
  'nestedViews.child3'
]


app.config ($stateProvider) ->

  $stateProvider.state 'nestedViews',
    url: ''
    abstract: true
    template: require './template'
