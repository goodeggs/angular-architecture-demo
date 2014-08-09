app = angular.module 'nestedViews', [
  # global requires that apply throughout the app:
  'ui.router'
  'ui.bootstrap'

  'nestedViews.child1'
  'nestedViews.child2'
  'nestedViews.child3'
]

app.config ($stateProvider, $urlRouterProvider) ->

  $stateProvider.state 'nestedViews',
    url: ''
    abstract: true
    template: require './template'

  # default state allows us to navigate directly to parent view:
  $urlRouterProvider.when '', '/child1'
