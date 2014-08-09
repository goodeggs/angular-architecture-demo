module.exports = ($scope, $modalInstance, items) ->
  $scope.items = items
  $scope.selected = item: $scope.items[0]
  $scope.ok = ->
    $modalInstance.close $scope.selected.item

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
