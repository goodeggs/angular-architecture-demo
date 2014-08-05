angular.module('app').directive 'listItem', ->
  restrict: 'E'
  template: require './template'
  link: require './link'
