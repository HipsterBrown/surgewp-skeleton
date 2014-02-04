'use strict';
module.exports = function(grunt) {

  grunt.initConfig({
    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },
      all: [
        'Gruntfile.js',
        'content/themes/roots/assets/js/*.js',
        'content/themes/roots/!assets/js/scripts.min.js'
      ]
    },
    sass: {
      dist: {
        files: {
          'content/themes/roots/assets/css/main.min.css': [
            'content/themes/roots/assets/sass/app.scss'
          ]
        },
        options: {
          style: 'compressed',
          // Sass source map
          // To enable, set sourceMap to true and update sourceMapRootpath based on your install
          sourcemap: false,
        }
      }
    },
    uglify: {
      dist: {
        files: {
          'content/themes/roots/assets/js/scripts.min.js': [
            'content/themes/roots/assets/js/plugins/*.js',
            'content/themes/roots/assets/js/_*.js'
          ]
        },
        options: {
          // JS source map: to enable, uncomment the lines below and update sourceMappingURL based on your install
          // sourceMap: 'assets/js/scripts.min.js.map',
          // sourceMappingURL: '/app/themes/roots/assets/js/scripts.min.js.map'
        }
      }
    },
    version: {
      options: {
        file: 'content/themes/roots/lib/scripts.php',
        css: 'content/themes/roots/assets/css/main.min.css',
        cssHandle: 'roots_main',
        js: 'content/themes/roots/assets/js/scripts.min.js',
        jsHandle: 'content/themes/roots/roots_scripts'
      }
    },
    watch: {
      sass: {
        files: [
          'content/themes/roots/assets/sass/*.scss'
        ],
        tasks: ['sass', 'version']
      },
      js: {
        files: [
          '<%= jshint.all %>'
        ],
        tasks: ['jshint', 'uglify', 'version']
      },
      livereload: {
        // Browser live reloading
        // https://github.com/gruntjs/grunt-contrib-watch#live-reloading
        options: {
          livereload: false
        },
        files: [
          'content/themes/roots/assets/css/main.min.css',
          'content/themes/roots/assets/js/scripts.min.js',
          'content/themes/roots/templates/*.php',
          'content/themes/roots/*.php'
        ]
      }
    },
    clean: {
      dist: [
        'content/themes/roots/assets/css/main.min.css',
        'content/themes/roots/assets/js/scripts.min.js'
      ]
    }
  });

  // Load tasks
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-wp-version');

  // Register tasks
  grunt.registerTask('default', [
    'clean',
    'sass',
    'uglify',
    'version'
  ]);
  grunt.registerTask('dev', [
    'watch'
  ]);

};
