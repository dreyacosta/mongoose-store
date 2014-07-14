'use strict'

gulp  = require 'gulp'
mocha = require 'gulp-mocha'

source =
  specs: 'specs/*'

gulp.task 'watch', ->
  gulp.watch source.specs, ['test']

gulp.task 'test', ->
  gulp.src source.specs
    .pipe mocha
      reporter: 'spec'
      require: 'coffee-script/register'