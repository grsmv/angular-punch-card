(function() {
  angular.module("punchCard", []);

  angular.module("punchCard").directive("punchCard", function() {
    return {
      restrict: "AE",
      scope: {
        data: "=",
        plural: "@",
        singular: "@"
      },
      link: function($scope) {
        var flatten, max;
        $scope.days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        $scope.hours = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"];
        flatten = [].concat.apply([], $scope.data);
        max = flatten.sort(function(a, b) {
          return a - b;
        })[flatten.length - 1];
        $scope.size = function(n) {
          return Math.floor(100 / max * +n / 10);
        };
        return $scope.description = function(n) {
          if (n === 1) {
            return $scope.singular || "event";
          } else {
            return $scope.plural || "events";
          }
        };
      },
      template: "<div id=\"punch-card\">\n    <div class=\"punch-card-day\" ng-repeat='day in days'>\n        <div class=\"punch-card-day-name\">\n            <div class=\"punch-card-day-name-label\">{{ day }}</div>\n        </div>\n        <div class=\"punch-card-hour\"\n             ng-repeat='hour in hours'\n             ng-init=\"n = data[$parent.$index][$index]\">\n            <div class=\"punch-card-hour-data size-{{ size(n) }}\"></div>\n            <div class=\"punch-card-hour-tooltip\" ng-show=\"n\">\n                <b>{{ n }}</b> {{ description(n) }}\n                <div class=\"arrow\"></div>\n            </div>\n            <div class=\"punch-card-hour-tick\"></div>\n        </div>\n    </div>\n    <div class=\"punch-card-hour-name\">\n        <div class=\"punch-card-hour-name-label\" ng-repeat='hour in hours'>\n            {{ hour }}\n        </div>\n    </div>\n</div>"
    };
  });

}).call(this);
