angular.module('app').config ($stateProvider) ->

  $stateProvider.state 'main.nestedViews',
    url: '/nested-views'
    template: require './template'
