module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    
    coffeelint:
      app:
        files:
          src: [
            'Gruntfile.coffee'
            'scripts/**/*.coffee'
            'test/**/*.coffee'
          ]
    
    simplemocha:
      all:
        src: ['test/**/*.coffee']
      options:
        reporter: 'nyan'
        ui: 'bdd'

    watch:
      scripts:
        files: [
          'Gruntfile.coffee'
          'scripts/**/*.coffee'
          'test/**/*.coffee'
        ]
        tasks: [
          'coffeelint'
          'simplemocha'
        ]
        options:
          interrupt: yes

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', [
    'coffeelint'
    'simplemocha'
  ]