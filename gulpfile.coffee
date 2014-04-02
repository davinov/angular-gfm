fs   = require 'fs'
gulp = require 'gulp'
path = require 'path'

# Gulp Plugins
clean         = require 'gulp-clean'
coffee        = require 'gulp-coffee'
concat        = require 'gulp-concat'
filesize      = require 'gulp-filesize'
gutil         = require 'gulp-util'
jade          = require 'gulp-jade'
less          = require 'gulp-less'
runSequence   = require 'run-sequence'
templateCache = require 'gulp-angular-templatecache'
uglify        = require 'gulp-uglify'

# Paths
SRC_PATH    = 'src/'
DIST_PATH    = 'dist/'
VENDOR_PATH = 'vendor/'
ASSETS_PATH = 'assets/'

# Files
APP_MAIN_FILE    = 'mw.angular-gfm.js'
APP_AND_TEMPLATES_MAIN_FILE    = 'mw.angular-gfm-tpls.js'
CSS_MAIN_FILE    = 'mw.angular-gfm.css'
MINIFIED_FILE    = 'mw.angular-gfm.min.js'
LESS_MAIN_FILE   = SRC_PATH + 'less/angular-gfm.less'
TEMPLATES_FILE   = 'templates.js'
TEMPLATES_MODULE = 'mw.angular-gfm'
VENDOR_MAIN_FILE = 'vendor.js'

gulp.task 'build', (done) ->
  runSequence 'clean', 'compile', done

gulp.task 'build-production', (done) ->
  runSequence 'clean', 'compile', 'minify', done

gulp.task 'vendors', ->
  gulp.src VENDOR_PATH+'/*.js'
  .pipe concat VENDOR_MAIN_FILE
  .pipe filesize()
  .pipe gulp.dest DIST_PATH+'/js'
  .on 'error', gutil.log

gulp.task 'coffee', ->
  gulp.src SRC_PATH+'/coffee/*.coffee'
  .pipe coffee bare: true
  .pipe concat APP_MAIN_FILE
  .pipe gulp.dest DIST_PATH
  .pipe filesize()
  .on "error", gutil.log

gulp.task 'less', ->
  gulp.src LESS_MAIN_FILE
  .pipe less
    paths: [ path.join(__dirname) ]
  .pipe gulp.dest DIST_PATH
  .pipe filesize()
  .on 'error', gutil.log

gulp.task 'templates', ->
  gulp.src SRC_PATH+'/*/**/*.jade'
  .pipe jade doctype: 'html'
  .pipe templateCache
    filename: TEMPLATES_FILE
    module: TEMPLATES_MODULE
  .pipe gulp.dest DIST_PATH
  .pipe filesize()
  .on 'error', gutil.log

gulp.task 'assets', ->
  gulp.src ASSETS_PATH+'/**'
  .pipe gulp.dest DIST_PATH

gulp.task 'compile', (done) ->
  runSequence 'assets', 'vendors', 'coffee', 'templates', 'less', 'concat', done

gulp.task 'concat', (done) ->
  gulp.src DIST_PATH+'/*.js'
  .pipe concat APP_AND_TEMPLATES_MAIN_FILE
  .pipe filesize()
  .pipe gulp.dest DIST_PATH
  .on 'error', gutil.log

gulp.task 'minify', ->
  gulp.src DIST_PATH+'/**/*.js'
  .pipe concat()
  .pipe rename MINIFIED_FILE
  .pipe uglify()
  .pipe filesize()
  .on "error", gutil.log

gulp.task 'clean', ->
  gulp.src DIST_PATH, read: false
  .pipe clean()
