angular.module('app').config ($stateProvider) ->

  $stateProvider.state 'main.viewWithCustomDirectives',
    url: '/single-view'
    template: require './template'
    controller: require './controller'
