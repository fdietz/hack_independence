app.controller("ImportCtrl", ["$scope", "$timeout", "$http", function($scope, $timeout, $http) {

  $scope.progress = 0;
  $scope.loading = true;

  function retrievePlaylist() {
    $http({ method: "get", url: "/imports/spotify", headers: headers }).then(function(response) {
      $scope.loading = false;
      $scope.playlists = response.data;
      console.log("playlists", $scope.playlists);

      $scope.totalPlaylists = $scope.playlists.length;
    });
  }

  retrievePlaylist();

  var height;
  var rotationDegree;

  function rad(num) {
    return num * Math.PI / 180;
  }


  var counter = 0;
  var i, x;
  function updateUI() {
    var $cursor = $(".cursor");
    var $left   = $(".left");
    var $right  = $(".right");

    var positionCursor = $cursor.offset();
    var positionLeft   = $left.offset();
    var positionRight  = $right.offset();

    var stepSize       = (positionRight.left - positionLeft.left)/$scope.totalTracks;

    var positionXWithMaxHeight = (positionRight.left - positionLeft.left)/2;


    var increase = Math.PI;
    height = Math.sin((($scope.progressForPlaylist/$scope.totalTracks)*increase));
    rotationDegree += ($scope.progressForPlaylist/$scope.totalTracks)*20;

    $cursor.show();
    $cursor.css({ left: $scope.progressForPlaylist * stepSize, top: -height*180 });
    var rotateStr = "rotate(" + rotationDegree + "deg)";
    $cursor.css({ transform: rotateStr });

    console.log("pos", $scope.progressForPlaylist)
  }

  function resetUI() {
    var $cursor = $(".cursor");
    $cursor.hide();
    $cursor.css({ left: 0 });
    $cursor.show();

    $scope.progressForPlaylist = 0;
    rotationDegree = -10;
    height = 0;
  }

  var currentPlayListTracks = [];
  function nextTrack() {
    console.log("nextTrack", $scope.progressForPlaylist, $scope.totalTracks);

    if ($scope.progressForPlaylist < $scope.totalTracks) {
      var track = $scope.playlists[$scope.progress].tracks[$scope.progressForPlaylist];
      console.log('track', track)
      searchTrackId(track).then(function(response) {
        if (response.data["track_id"]) {
          currentPlayListTracks.push(response.data["track_id"]);
        }

        $scope.progressForPlaylist += 1;
        updateUI();
        nextTrack();
      });
    } else {
      console.log("last track")

      $scope.createPlaylist({ name: $scope.playlists[$scope.progress].name, track_ids: currentPlayListTracks }).then(function(playlist) {
        console.log("create playlist", playlist)

        $scope.progress += 1;
        currentPlayListTracks = [];
        resetUI();
        nextPlaylist();
      });
    }
  }

  $scope.currentPlaylist = function() {
    return $scope.playlists[$scope.progress].name;
  };

  $scope.currentSong = function() {
    return $scope.playlists[$scope.progress].tracks[$scope.progressForPlaylist].name;
  };

  $scope.currentArtist = function() {
    return $scope.playlists[$scope.progress].tracks[$scope.progressForPlaylist].artists;
  };

  function nextPlaylist() {
    if ($scope.progress < $scope.totalPlaylists) {

      $scope.progressForPlaylist = 0;
      $scope.totalTracks = $scope.playlists[$scope.progress].tracks.length;

      console.log("nextPlaylist", $scope.progress, "total tracks", $scope.totalTracks);
      nextTrack();
    } else {
      console.log("IMPORT DONE")
      $scope.importDone = true;

      $timeout(function() {
        // $(".progress-container").addClass("hide");
        window.location.href = "http://localhost:3000/finals";
      }, 2000);
    }
  }

  function searchTrackId(track) {
    var headers = { 'X-CSRF-Token': $("html").data("authenticity-token") };
    var params = track;
    return $http({ method: "get", url: "/exports/rdio", params: params, headers: headers });
  }

  $scope.startImport = function() {
    $scope.importDone = false;
    $scope.showImportAll = true;
    $scope.progress = 0;

    rotationDegree = -10;
    height = 0;

    $(".progress-container").removeClass("hide");

    nextPlaylist();
  };

  $scope.importAllButtonLabel = function() {
    if (!$scope.showImportAll) {
      if ($scope.loading) {
        return "Loading playlists";
      } else {
        return "Import all " + $scope.totalPlaylists + " playlists";
      }

    } else if ($scope.importDone) {
      return "I'm done!";
    } else {
      return "Importing " + $scope.progress + "/" + $scope.totalPlaylists + " ...";
    }
  };

  // var playlist = { playlist: { name: "test", tracks: [ { artist: "Michael Jackson", song: "Bad" }] } };

  var headers = { 'X-CSRF-Token': $("html").data("authenticity-token") };
  $scope.createPlaylist = function(playlist) {
    return $http({ method: "post", url: "/exports", data: playlist, headers: headers });
  }
}]);