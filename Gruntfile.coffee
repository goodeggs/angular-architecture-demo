module.exports = (grunt) ->
  # load devDependency grunt tasks
  require('matchdep').filterAll(['grunt-*', '!grunt-cli']).forEach(grunt.loadNpmTasks)

  grunt.initConfig
    browserify:
      dist:
        files:
          'server/app/public/bundle.js': [
            'client/modules/thirdparty/angular.js'
            'client/modules/thirdparty/*'
            'client/**/index.coffee'
          ]
        options:
          transform: ['coffeeify', 'jadeify', 'stylify']
          browserifyOptions: extensions: ['.coffee', '.jade', '.styl']
          bundleOptions: debug: true

    clean:
      public: ['server/app/public']
      stylus: ['<%= concat.stylus.dest %>']

    concat:
      stylus:
        src: ['client/modules/styles/index.styl', 'client/app/**/*.styl'],
        dest: 'client/modules/styles/bundle.styl'

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

    watch:
      build:
        options: livereload: true
        files: ['{client,lib}/**', 'Gruntfile.js']
        tasks: ['build']

  grunt.registerTask 'styles', ['concat', 'stylus', 'clean:stylus']

  grunt.registerTask 'build', [
    'clean:public'
    'styles'
    'browserify'
  ]
