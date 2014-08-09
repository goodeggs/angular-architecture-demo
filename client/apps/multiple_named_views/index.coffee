angular.module 'multipleNamedViews', [
  'ui.router'
  'ui.bootstrap'
]

.config ($stateProvider) ->
  $stateProvider.state 'multipleNamedViews',
    url: ''
    views:
      '':
        template: require './template'
      'view1@multipleNamedViews':
        template: require './view1/template'
        controller: require './view1/controller'
      'view2@multipleNamedViews':
        template: require './view2/template'
        controller: require './view2/controller'
