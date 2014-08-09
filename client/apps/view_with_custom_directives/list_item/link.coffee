module.exports = (scope, element, attrs) ->
  scope.number = 1
  scope.incrementNumber = ->
    scope.number++
