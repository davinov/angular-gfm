angular.module('mw.angular-gfm', ['ng']);

angular.module('mw.angular-gfm').controller('gfmController', [
  '$scope', '$http', '$sce', '$element', function($scope, $http, $sce, $element) {
    return $http.get('https://api.github.com/repos/' + $scope.repo + '/readme', {
      cache: true,
      headers: {
        Accept: 'application/vnd.github.v3.html+json'
      }
    }).success(function(response) {
      return $scope.content = $sce.trustAsHtml(response);
    });
  }
]);

angular.module('mw.angular-gfm').directive('githubReadme', function() {
  return {
    restrict: 'EAC',
    controller: 'gfmController',
    templateUrl: 'jade/view.html',
    scope: {
      repo: '=',
      showTitle: '='
    }
  };
});

angular.module("mw.angular-gfm").run(["$templateCache", function($templateCache) {$templateCache.put("jade/view.html","<div ng-show=\"showTitle\" class=\"title\">{{ repo }}\'s README</div><div ng-bind-html=\"content\" class=\"content\"></div>");}]);