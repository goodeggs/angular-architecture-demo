module.exports = ($scope, $modal) ->
  $scope.items = ['test1', 'test2', 'test3']

  $scope.openModal = ->
    modalInstance = $modal.open
      resolve:
        items: -> $scope.items
      template: require('./modal/template')()
      controller: require './modal/controller'

    modalInstance.result.then (selectedItem) ->
      $scope.selected = selectedItem
    , ->
      $log.info 'Modal dismissed at: ' + new Date()
