module.exports = (grunt) ->
  # load devDependency grunt tasks
  require('matchdep').filterAll(['grunt-*', '!grunt-cli']).forEach(grunt.loadNpmTasks)

  grunt.initConfig
    browserify:
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
      single_view:
        files:
          'server/app/public/single_view_bundle.js': [
            'client/apps/single_view/**/index.coffee'
          ]
      multiple_named_views:
        files:
          'server/app/public/multiple_named_views_bundle.js': [
            'client/apps/multiple_named_views/**/index.coffee'
          ]
      nested_views:
        files:
          'server/app/public/nested_views_bundle.js': [
            'client/apps/nested_views/**/index.coffee'
          ]
      view_with_custom_directives:
        files:
          'server/app/public/view_with_custom_directives_bundle.js': [
            'client/apps/view_with_custom_directives/**/index.coffee'
          ]

    clean:
      public: ['server/app/public']
      stylus: ['<%= concat.stylus.dest %>']

    concat:
      stylus:
        src: ['client/modules/styles/index.styl', 'client/apps/**/*.styl'],
        dest: 'client/modules/styles/bundle.styl'

    concurrent:
      options: logConcurrentOutput: true
      dev: ['watch:build', 'shell:npm-start']

    copy:
      main:
        files: [
          expand: true, cwd: 'client', src: ['assets/**/*.!(js|coffee|html|styl|css)'], dest: 'public'
        ]

    stylus:
      compile:
        files:
          'server/app/public/bundle.css': ['<%= concat.stylus.dest %>']

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

    shell:
      'npm-start': command: 'npm start'

    watch:
      build:
        options: livereload: true
        files: ['{client,lib}/**', 'Gruntfile.js']
        tasks: ['build']

  grunt.registerTask 'styles', ['concat', 'stylus', 'clean:stylus']
  grunt.registerTask 'build', ['clean:public', 'styles', 'browserify']
  grunt.registerTask 'dev', ['npm-install', 'build', 'concurrent:dev']
