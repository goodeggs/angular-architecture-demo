wrapStyle = (id, styleString) ->
  selectors = styleString.split('}').map (selector) -> "##{id} #{selector}"
  selectors.join '}'

app = angular.module 'stylish.router', ['ui.router']

app.config ($stateProvider) ->
  $stateProvider.decorator 'views', (state, parent) ->
    result = {}
    views = parent(state)
    angular.forEach views, (config, name) ->
      viewName = name.split('@')[0]
      viewName = if viewName.length then "-#{viewName}" else ''
      templateId = ("#{state.name}#{viewName}-view").replace(/\./g, '-')
      config.template = "<div id=\"#{templateId}\">#{config.template()}</div>"
      if config.style
        style = '<style>' + wrapStyle(templateId, config.style) + '</style>'
        config.template += style
      result[name] = config
    result
