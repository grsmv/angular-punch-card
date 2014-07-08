# Copyright (C) 2014 Sergey Gerasimov
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished
# to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
                    <div class="punch-card-hour-tick"></div>
                </div>
            </div>
            <div class="punch-card-hour-name">
                <div class="punch-card-hour-name-label" ng-repeat='hour in hours'>
                    {{ hour }}
                </div>
            </div>
        </div>
    """
