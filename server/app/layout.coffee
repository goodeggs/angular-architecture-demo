{renderable, raw, tag, text} = require 'teacup'
{a, body, button, doctype, head, html, iframe, li, link, meta, script, span, title, ul} = require 'teacup'
{form, input, p, div} = require 'teacup'

module.exports = renderable ->
  doctype 5

  html lang: 'en', ngApp: 'app', ->
    head ->
      meta charset: 'utf-8'
      meta name: 'viewport', content: 'width=device-width, initial-scale=1, maximum-scale=1'
      title 'Kale'
      script src: 'bundle.js'
      link href: 'bundle.css', rel: 'stylesheet'
    body ->
      tag 'ui-view'
