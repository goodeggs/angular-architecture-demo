angular.module('app').config ($stateProvider) ->

  $stateProvider.state 'nestedViews.child3',
    url: '/child3'
    template: require './template'
