angular.module('app').config ($stateProvider) ->

  $stateProvider.state 'nestedViews.child2',
    url: '/child2'
    template: require './template'
