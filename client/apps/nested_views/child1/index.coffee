angular.module('app').config ($stateProvider) ->

  $stateProvider.state 'nestedViews.child1',
    url: '/child1'
    template: require './template'
