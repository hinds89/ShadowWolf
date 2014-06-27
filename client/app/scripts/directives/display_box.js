"use strict";
angular.module('ShadowWolf')
.directive("displayBox", function() {
    return {
        transclude: true,
        restrict: "E",
        replace: true,
        templateUrl: 'scripts/directives/display_box.html',
        scope: {
          titleText: "@",
          bodyText:  "@",
          imgSrc:    "@",
          moreLink:  "@",
          isCurrentUser: "@",
          condition: "@"
        },
        link: function (scope, element, attrs) {},
        controller: function($scope) {
            $scope.state = "drawer-in";
            $scope.setDrawerState=function(state){
              if(state!='click'){
                $scope.state = state;
              }
              else if($scope.state == 'drawer-in'){
                $scope.state = 'drawer-out';
              }
              else if($scope.state == 'drawer-out'){
                 $scope.state = 'drawer-in';
              }
            };
        }
    };
});
