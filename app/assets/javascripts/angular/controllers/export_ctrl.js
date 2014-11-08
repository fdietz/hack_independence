app.controller("ExportCtrl", ["$scope", "$timeout", function($scope, $timeout) {

  $scope.progress = 0;

  function next() {
    $timeout(function() {
      console.log("next")
      $scope.progress += 10;

      if ($scope.progress !== 100) next();
    }, 100);
  }

  next();

}]);