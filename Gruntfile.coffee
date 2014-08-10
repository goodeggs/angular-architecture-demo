module.exports = (grunt) ->
  # load devDependency grunt tasks
  require("matchdep").filterAll(["grunt-*", "!grunt-cli"]).forEach(grunt.loadNpmTasks)

  # all apps as they appear in the directory name
  apps = [
    "single_view"
    "multiple_named_views"
    "nested_views"
    "view_with_custom_directives"
  ]

  dest = "server/app/public"
  modules = "client/modules"

  grunt.initConfig
    browserify: do ->
      config =
        options:
          transform: ["coffeeify", "jadeify"]
          browserifyOptions: extensions: [".coffee", ".jade"]
          bundleOptions: debug: true
        thirdparty:
          src: [ "#{modules}/thirdparty/angular.js", "#{modules}/thirdparty/*"]
          dest: "#{dest}/thirdparty_bundle.js"
      for app in apps
        config[app] =
          src: "client/apps/#{app}/**/index.coffee"
          dest: "#{dest}/#{app}_bundle.js"
      config

    clean:
      public: ["#{dest}"]
      stylus: ["#{modules}/styles/bundle.styl"]

    concat: do ->
      config = {}
      for app in apps
        config[app] =
          src: ["#{modules}/styles/index.styl", "client/apps/#{app}/**/*.styl"],
          dest: "#{modules}/styles/bundle.styl"
      config

    concurrent:
      options: logConcurrentOutput: true
      dev: ["watch", "nodemon:dev"]

    copy:
      main:
        files: [
          expand: true, cwd: "client", src: ["assets/**/*.!(js|coffee|html|styl|css)"], dest: "public"
        ]

    stylus: do ->
      config = {}
      for app in apps
        config[app] =
          src: "#{modules}/styles/bundle.styl"
          dest: "#{dest}/#{app}_bundle.css"
      config

    karma:
      options:
        configFile: "config/karma.conf.coffee",
      browser:
        autoWatch: true
        singleRun: false
        browsers: ["Chrome", "Firefox"]
      continuous:
        singleRun: true
      coverage:
        reporters: ["coverage"]
      watch:
        autoWatch: true
        singleRun: false
      debug:
        autoWatch: true
        singleRun: false
        browsers: ["Chrome"]

    ngAnnotate: do ->
      config = {}
      for app in apps
        config[app] =
          src: "#{dest}/#{app}_bundle.js"
          dest: "#{dest}/#{app}_bundle.js"
      config

    nodemon:
      dev: script: "bin/www"

    shell:
      "npm-start": command: "npm start"

    uglify: do ->
      config = {}
      for app in apps
        config[app] =
          src: "#{dest}/#{app}_bundle.js"
          dest: "#{dest}/#{app}_bundle.js"
      config

    watch: do ->
      config = {}
      for app in apps
        config[app] =
          files: ["client/apps/#{app}/**"]
          tasks: ["build:#{app}"]
      config

  grunt.registerTask "buildlog", (appName) ->
    grunt.log.writeln ""
    grunt.log.writeln "============== Building #{appName} =============="

  for app in apps
    grunt.registerTask "styles:#{app}", ["concat:#{app}", "stylus:#{app}", "clean:stylus"]
    grunt.registerTask "build:#{app}", ["buildlog:#{app}", "styles:#{app}", "browserify:#{app}"]

  grunt.registerTask "build", do ->
    tasks = ["browserify:thirdparty"]
    tasks.push "build:#{app}" for app in apps
    tasks

  grunt.registerTask "build:prod", do ->
    tasks = ["browserify:thirdparty"]
    tasks.push "build:#{app}", "ngAnnotate:#{app}" for app in apps
    tasks

  grunt.registerTask "dev", ["npm-install", "clean:public", "build", "concurrent:dev"]
  grunt.registerTask "prod", ["npm-install", "clean:public", "build:prod", "concurrent:dev"]
