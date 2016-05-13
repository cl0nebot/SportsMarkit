$('document').ready(function() {

  jQuery.externalScript = function(url, options) {
    options = $.extend(options || {}, {
      dataType: "script",
      cache: true,
      url: url
    });
    return jQuery.ajax(options);
  };
  $.externalScript('https://js.stripe.com/v2/').done(function(script, textStatus) {
      Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
      var account = {
        setupForm: function() {
          return $('.bank_account_form').submit(function() {
            $('input[type=submit]').prop('disabled', true);
            if ($('#account_number').length) {
              account.processBankAccount();
              return false;
            } else {
              return true;
            }
          });
        },
        processBankAccount: function() {
          var details;
          details = {
            country: $('#country').val(),
            routingNumber: $('#routing_number').val(),
            accountNumber: $('#account_number').val()
          };
          return Stripe.bankAccount.createToken(details, account.handleStripeResponse);
        },
        handleStripeResponse: function(status, response) {
          if (response.error === undefined) {
            $('#stripe_token').val(response.id)
            $('.bank_account_form')[0].submit()
          } else {
            $('#stripe_error').text(response.error.message).removeClass('hidden').show();
            window.notifyError(response.error.message);
            return $('input[type=submit]').prop('disabled', false);
          }
        }
      };
      return account.setupForm();
  });
});
