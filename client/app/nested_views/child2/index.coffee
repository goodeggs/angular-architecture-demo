angular.module('app').config ($stateProvider) ->

  $stateProvider.state 'main.nestedViews.child2',
    url: '/child2'
    template: require './template'
