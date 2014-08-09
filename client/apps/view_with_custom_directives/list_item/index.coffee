angular.module 'viewWithCustomDirectives.listItem', []

.directive 'listItem', ->
  restrict: 'E'
  template: require './template'
  link: require './link'
