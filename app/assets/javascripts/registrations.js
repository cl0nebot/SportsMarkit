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
      var registration = {
        setupForm: function() {
          return $('.registration_card_form').submit(function() {
            $('input[type=submit]').prop('disabled', true);
            if ($('#card_number').length) {
              registration.processCard();
              return false;
            } else {
              return true;
            }
          });
        },
        processCard: function() {
          var card;
          card = {
            name: $('#name_on_card').val(),
            number: $('#card_number').val(),
            cvc: $('#card_code').val(),
            expMonth: $('#card_month').val(),
            expYear: $('#card_year').val()
          };
          return Stripe.createToken(card, registration.handleStripeResponse);
        },
        handleStripeResponse: function(status, response) {
          if (response.error === undefined) {
            $('#stripe_token').val(response.id);
            $('.registration_card_form')[0].submit();
          } else {
            window.notifyError(response.error.message);
            return $('input[type=submit]').prop('disabled', false);
          }
        }
      };
      return registration.setupForm();
  });
});