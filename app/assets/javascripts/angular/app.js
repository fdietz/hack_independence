var app = angular.module("PlaylistApp", ["ngAnimate"])
  .config(["$httpProvider", function($httpProvider) {
    $httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";
  }])