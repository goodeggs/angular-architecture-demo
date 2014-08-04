angular.module('app').config ($stateProvider) ->

  $stateProvider.state 'main.singleView',
    url: '/single-view'
    template: require './template'
    controller: require './controller'
