'use strict'

gulp  = require 'gulp'
mocha = require 'gulp-mocha'

gulp.task 'test', ->
  gulp.src 'specs/*'
    .pipe mocha
      reporter: 'spec'
      require: 'coffee-script/register'