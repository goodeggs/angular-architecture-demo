# Angular Demo App

A place to throw around ideas about Angular best practice architecture patterns. This is inspired by the [Angular best practice architecture recommendations](http://blog.angularjs.org/2014/02/an-angularjs-style-guide-and-best.html), as well as some of the popular Angular seeds:

- [Generator Angular Fullstack](https://www.npmjs.org/package/generator-angular-fullstack)
- [ngbp](https://github.com/ngbp/ngbp)
- [Angular App](https://github.com/angular-app/angular-app)

## Project Setup

- `grunt dev`
- open localhost:4000

## Advantages

This architecture has several advantages over our current organization

1. **More Modular** - styles and specs are grouped directly with their related views/module files. This makes modules easier to understand, update, and maintain
2. **Fewer Duplicate Require Statements** - Angular already has a great module management system. The build compiles the index.coffee of each module/view, and lets angular take care of the rest. This means fewer 'requires' to maintain.
3. **More intuitive view hierarchy** - we can tell which views are nested inside other views by looking at the directory hierarchy
4. **Concise Jade Templates** - Jade is more concise than HTML or teacup. Also, compared to teacup, we don't have to require all the tags at the top of every file
5. **Expressive stylus** - the stylus build gives each file access to the bootstrap variables and classes

## Basic View Structure

- **index.coffee** - top level entry point for each Angular module
- **controller.coffee**
- **template.jade**
- **e2e.coffee** - e2e tests that run using selenium webdriver
- **unit.coffee** - unit tests that run using karma

## TODO

- Figure out a way to do ngmin effectively (maybe with custom webpack loaders)
- create node_module for custom ngmining
- create examples
