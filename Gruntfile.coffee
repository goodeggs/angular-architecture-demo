module.exports = (grunt) ->
  # load devDependency grunt tasks
  require('matchdep').filterAll(['grunt-*', '!grunt-cli']).forEach(grunt.loadNpmTasks)

  # all apps as they appear in the directory name
  apps = [
    'single_view'
    'multiple_named_views'
    'nested_views'
    'view_with_custom_directives'
  ]

  grunt.initConfig
    browserify: do ->
      config =
        options:
          transform: ['coffeeify', 'jadeify', 'stylify']
          browserifyOptions: extensions: ['.coffee', '.jade', '.styl']
          bundleOptions: debug: true
        thirdparty:
          files:
            'server/app/public/thirdparty_bundle.js': [
              'client/modules/thirdparty/angular.js'
              'client/modules/thirdparty/*'
            ]
      for app in apps
        config[app] =
          files: do ->
            task = {}
            task["server/app/public/#{app}_bundle.js"] = ["client/apps/#{app}/**/index.coffee"]
            task
      config

    clean:
      public: ['server/app/public']
      stylus: ['client/modules/styles/bundle.styl']

    concat: do ->
      config = {}
      for app in apps
        config[app] =
          src: ['client/modules/styles/index.styl', "client/apps/#{app}/**/*.styl"],
          dest: 'client/modules/styles/bundle.styl'
      config

    concurrent:
      options: logConcurrentOutput: true
      dev: ['watch', 'nodemon:dev']

    copy:
      main:
        files: [
          expand: true, cwd: 'client', src: ['assets/**/*.!(js|coffee|html|styl|css)'], dest: 'public'
        ]

    stylus: do ->
      config = {}
      for app in apps
        config[app] =
          files: do ->
            task = {}
            task["server/app/public/#{app}_bundle.css"] = 'client/modules/styles/bundle.styl'
            task
        # config[app].files = {}
        # config[app].files
      config

    karma:
      options:
        configFile: 'config/karma.conf.coffee',
      browser:
        autoWatch: true
        singleRun: false
        browsers: ['Chrome', 'Firefox']
      continuous:
        singleRun: true
      coverage:
        reporters: ['coverage']
      watch:
        autoWatch: true
        singleRun: false
      debug:
        autoWatch: true
        singleRun: false
        browsers: ['Chrome']

    nodemon:
      dev: script: 'bin/www'

    shell:
      'npm-start': command: 'npm start'

    watch: do ->
      watchTasks = {}
      for app in apps
        watchTasks[app] =
          files: ["client/apps/#{app}/**"]
          tasks: ["build:#{app}"]
      watchTasks

  grunt.registerTask 'buildlog', (appName) ->
    grunt.log.writeln ""
    grunt.log.writeln "============== Building #{appName} =============="

  for app in apps
    grunt.registerTask "styles:#{app}", ["concat:#{app}", "stylus:#{app}", 'clean:stylus']
    grunt.registerTask "build:#{app}", ["buildlog:#{app}", "styles:#{app}", "browserify:#{app}"]

  grunt.registerTask 'build', do ->
    tasks = ['browserify:thirdparty']
    for app in apps
      tasks.push "build:#{app}"
    tasks

  grunt.registerTask 'dev', ['npm-install', 'clean:public', 'build', 'concurrent:dev']
