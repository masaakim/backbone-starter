module.exports = (grunt) ->
  grunt.initConfig
    bower_concat:
      all:
        dest: './build/js/vendor.js'
        dependencies:
          'backbone': ['jquery', 'underscore']
        bowerOptions:
          relative: false

    connect:
      app:
        options:
          port: 2000
          base: "build/"
          open: "http://localhost:2000"

    compass:
      dist:
        options:
          sassDir: "src/stylesheets"
          cssDir: "build/css"
          specify: "src/stylesheets/**/*.scss"
          bundleExec: true
          environment: "development"

    csso:
      dist:
        files:
          "build/css/app.min.css": ["build/css/app-uncss.css"]

    concat:
      'build/js/app.js': [
        'src/javascripts/hogehoge.js',
        'src/javascripts/piyopiyo.js'
      ]

    jshint:
      options:
        jshintrc: true


    uglify:
      target:
        files:
          'build/js/app.min.js': ['build/js/app.js']
      vendor:
        files:
          'build/js/vendor.min.js': ['build/js/vendor.js']

  uncss:
    dist:
      files:
        'build/css/app-uncss.css': ['index.html']

    watch:
      options:
        livereload: true

      stylesheets:
        files: ["src/stylesheets/**/*.scss"]
        tasks: ["stylesheet"]

      javascript:
        files: ["src/javascripts/**/*.js"]
        tasks: ["jshint"]

  grunt.loadNpmTasks "grunt-bower-concat"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-csso"
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-uncss"

  grunt.registerTask "default", ["develop"]
  grunt.registerTask "develop", [
    "bower_concat"
    "uglify:vendor"
    "compass"
    "connect:app"
    "watch"
  ]
  grunt.registerTask "build", [
    "compass"
    "uncss"
    "csso"
    "concat"
    "bower_concat"
    "uglify"
  ]
