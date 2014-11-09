app.controller("ImportCtrl", ["$scope", "$timeout", function($scope, $timeout) {

  $scope.progress = 0;

  $scope.total = 10;

  var height;
  var rotationDegree;

  function next() {
    $timeout(function() {
      console.log("next")
      $scope.progress += 1;

      var $cursor = $(".cursor");
      var $left   = $(".left");
      var $right  = $(".right");

      var positionCursor = $cursor.offset();
      var positionLeft   = $left.offset();
      var positionRight  = $right.offset();

      var stepSize       = (positionRight.left - positionLeft.left)/10;

      var positionXWithMaxHeight = (positionRight.left - positionLeft.left)/2;

      if ($scope.progress < $scope.total/2) {
        height -= $scope.progress * 10;
        rotationDegree += 2;
      } else {
        height += ($scope.progress-6) * 10;
        rotationDegree += 2;
      }

      $cursor.show();
      $cursor.css({ left: $scope.progress * stepSize, top: height });
      var rotateStr = "rotate(" + rotationDegree + "deg)";
      $cursor.css({ transform: rotateStr });

      console.log("pos", $scope.progress, height, "degree", rotationDegree, rotateStr)

      if ($scope.progress !== 10) {
        next();
      } else {
        $cursor.css({ transform: "rotate(" + 0 + "deg)" });
        $cursor.hide();

        $scope.importDone = true;

        $timeout(function() {
          $(".progress-container").addClass("hide");
        }, 1000);

      }
    }, 500);
  }

  $scope.startImport = function() {
    $scope.importDone = false;
    $scope.showImportAll = true;
    $scope.progress = 0;

    rotationDegree = -10;
    height = 0;

    $(".progress-container").removeClass("hide");

    next();
  };

  $scope.importAllButtonLabel = function() {
    if (!$scope.showImportAll) {
      return "Import all";
    } else if ($scope.importDone) {
      return "I'm done!";
    } else {
      return "Importing...";
    }
  };

}]);