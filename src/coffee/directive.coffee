angular.module 'mw.angular-gfm'
.directive 'githubReadme', ->
  restrict: 'EAC'
  controller: 'gfmController'
  templateUrl: 'jade/view.html'
  scope:
    repo: '='
    showTitle: '='
