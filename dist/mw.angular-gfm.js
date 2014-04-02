angular.module('mw.angular-gfm', ['ng']);

angular.module('mw.angular-gfm').controller('gfmController', [
  '$scope', '$http', '$sce', '$element', function($scope, $http, $sce, $element) {
    return $http.get('https://api.github.com/repos/' + $scope.repo + '/readme', {
      headers: {
        Accept: 'application/vnd.github.v3.raw+json'
      }
    }).success(function(response) {
      return $http.post('https://api.github.com/markdown', {
        text: response
      }).success(function(response) {
        return $scope.content = $sce.trustAsHtml(response);
      });
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
