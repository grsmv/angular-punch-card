angular.module "punchCard", []

angular.module("punchCard").directive "punchCard" , ->
    restrict: "AE"

    scope:
        data: "="
        plural: "@"
        singular: "@"

    link: ($scope) ->
        $scope.days = [
            "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
        ]
        $scope.hours = [
            "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11",
            "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"
        ]

        $scope.isOdd = (index) -> not index % 2 == 0
        $scope.isEven = (index) -> index % 2 == 0

        flatten = [].concat.apply([], $scope.data)
        max = flatten.sort((a, b) -> a - b)[flatten.length - 1]
        $scope.size = (n) -> Math.floor(100 / max * +n / 10)

        $scope.description = (n) ->
            if n == 1
                $scope.singular || "event"
            else
                $scope.plural || "events"

    template: """
        <div id="punch-card">
            <div class="punch-card-day" ng-repeat='day in days'>
                <div class="punch-card-day-name">
                    <div class="punch-card-day-name-label">{{ day }}</div>
                </div>
                <div class="punch-card-hour"
                     ng-repeat='hour in hours'
                     ng-init="n = data[$parent.$index][$index]">
                    <div class="punch-card-hour-data size-{{ size(n) }}"></div>
                    <div class="punch-card-hour-tooltip" ng-show="n">
                        <b>{{ n }}</b> {{ description(n) }}
                        <div class="arrow"></div>
                    </div>
                    <div class="punch-card-hour-tick"
                         ng-class="{ 'odd': isOdd($index+1), 'even': isEven($index+1)}">
                    </div>
                </div>
            </div>
            <div class="punch-card-hour-name">
                <div class="punch-card-hour-name-label" ng-repeat='hour in hours'>
                    {{ hour }}
                </div>
            </div>
        </div>
    """