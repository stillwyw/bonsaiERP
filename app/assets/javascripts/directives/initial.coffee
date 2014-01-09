myApp.directive('ngInitial', ->
  {
    restrict: 'A',
    controller: [
      '$scope', '$element', '$attrs', '$parse', ($scope, $element, $attrs, $parse) ->
        val = $attrs.value or $attrs.ngInitial
        getter = $parse($attrs.ngModel)
        setter = getter.assign
        setter($scope, val)
    ]
  }
)
.directive('ngMovementAccounts', ->
  {
    restrict: 'A',
    controller: ['$scope', '$element', '$attrs', ($scope, $element, $attrs) ->
      $scope.accounts = $('#accounts').data('accounts')

      # Set select2
      $element.select2(
        data: $scope.accounts
        formatResult: Plugin.paymentOptions
        formatSelection: Plugin.paymentOptions
        escapeMarkup: (m) -> m
        dropdownCssClass: 'hide-select2-search'
        placeholder: 'Seleccione la cuenta'
      )
      .on('change', (event) ->
        data = $element.select2('data')
        $scope.currency = data.currency
      )

      $scope.$watch 'account_to_id', (ac_id) ->
        $element.select2('val', ac_id)

    ]
  }
)

