module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-gh-pages'
  grunt.loadNpmTasks 'grunt-docco'

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    meta:
      banner: '/*!\n' +
        '<%= pkg.name %> plugin\n' +
        '@name <%= pkg.name %>.js\n' +
        '@author Christoph Ono (chri@sto.ph or @gbks)\n' +
        '@author Sebastian Helzle (sebastian@helzle.net or @sebobo)\n' +
        '@version <%= pkg.version %>\n' +
        '@date <%= grunt.template.today("mm/dd/yyyy") %>\n' +
        '@category jQuery plugin\n' +
        '@copyright (c) 2009-<%= grunt.template.today("yyyy") %> Christoph Ono (www.wookmark.com)\n' +
        '@license Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.\n' +
      '*/\n'
    uglify:
      dist:
        options:
          banner: '<%= meta.banner %>'
        files:
          '<%= pkg.name %>.min.js': ['<%= pkg.name %>.js']
    docco:
      dist:
        src: ['<%= pkg.name %>.js']
        options:
          output: 'doc/'
    jshint:
      all: ['<%= pkg.name %>.js']
    'gh-pages':
      options:
        message: 'Generated by grunt deployment'
        user:
          name: process.env.GIT_NAME
          email: process.env.GIT_EMAIL
          repo: 'https://' + process.env.GH_TOKEN + '@github.com/germanysbestkeptsecret/Wookmark-jQuery.git'
          silent: true
      src: [
        'assets/*.png'
        'css/**/*'
        'example*/**/*'
        'doc/**/*'
        'sample-images/**/*'
        'index.html'
        'wookmark.js'
        'vendor/**/*'
        'bower_components/**/*',
        'CNAME',
        'MIT-LICENSE.txt'
      ]


  # Release task to check code, minify js and create the documentation
  grunt.registerTask 'default', ['jshint', 'uglify', 'docco']

  # Deploy everything to github pages
  grunt.registerTask 'deploy', ['gh-pages']
