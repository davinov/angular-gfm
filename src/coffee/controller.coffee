angular.module 'mw.angular-gfm'
.controller 'gfmController', [
  '$scope', '$http', '$sce', '$element'
  ($scope, $http, $sce, $element) ->
    $http.get 'https://api.github.com/repos/'+$scope.repo+'/readme',
      cache: true
      headers:
       Accept: 'application/vnd.github.v3.html+json'
    .success (response) ->
#      $http.post 'https://api.github.com/markdown',
#        text: response
#      .success (response) ->
       $scope.content = $sce.trustAsHtml response
]
