module.exports = (grunt) ->
  # load devDependency grunt tasks
  require('matchdep').filterAll(['grunt-*', '!grunt-cli']).forEach(grunt.loadNpmTasks)
  apps = ['single_view', 'multiple_named_views', 'nested_views', 'view_with_custom_directives']

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

      # single_view:
      #   files:
      #     'server/app/public/single_view_bundle.js': [
      #       'client/apps/single_view/**/index.coffee'
      #     ]
      # multiple_named_views:
      #   files:
      #     'server/app/public/multiple_named_views_bundle.js': [
      #       'client/apps/multiple_named_views/**/index.coffee'
      #     ]
      # nested_views:
      #   files:
      #     'server/app/public/nested_views_bundle.js': [
      #       'client/apps/nested_views/**/index.coffee'
      #     ]
      # view_with_custom_directives:
      #   files:
      #     'server/app/public/view_with_custom_directives_bundle.js': [
      #       'client/apps/view_with_custom_directives/**/index.coffee'
      #     ]

    clean:
      public: ['server/app/public']
      stylus: ['client/modules/styles/bundle.styl']

    concat: do ->
      tasks = {}
      for app in apps
        tasks[app] =
          src: ['client/modules/styles/index.styl', "client/apps/#{app}/**/*.styl"],
          dest: 'client/modules/styles/bundle.styl'
      tasks

    concurrent:
      options: logConcurrentOutput: true
      dev: ['watch', 'nodemon:dev']

    copy:
      main:
        files: [
          expand: true, cwd: 'client', src: ['assets/**/*.!(js|coffee|html|styl|css)'], dest: 'public'
        ]

    stylus:
      compile:
        files: 'server/app/public/bundle.css': ['client/modules/styles/bundle.styl']

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
    grunt.log.writeln "----------- Building #{appName} -----------"

  for app in apps
    grunt.registerTask "styles:#{app}", ["concat:#{app}", 'stylus', 'clean:stylus']
    grunt.registerTask "build:#{app}", ["buildlog:#{app}", "styles:#{app}", "browserify:#{app}"]

  grunt.registerTask 'build', do ->
    tasks = ['browserify:thirdparty']
    for app in apps
      tasks.push "build:#{app}"
    tasks

  grunt.registerTask 'dev', ['npm-install', 'clean:public', 'build', 'concurrent:dev']
