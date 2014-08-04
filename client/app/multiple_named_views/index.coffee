app = angular.module 'app'

app.config ($stateProvider) ->
  $stateProvider.state 'main.multipleNamedViews',
    url: '/multiple-named-views'
    views:
      '':
        template: require './template'
      'view1@main.multipleNamedViews':
        template: require './view1/template'
        controller: require './view1/controller'
      'view2@main.multipleNamedViews':
        template: require './view2/template'
        controller: require './view2/controller'
