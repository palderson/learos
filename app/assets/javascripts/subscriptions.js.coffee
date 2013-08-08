jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  subscription.setupForm()

subscription =
  setupForm: ->
    if $('.different_card').length
      $('.card_fields :input').attr('disabled', true)
      $('.different_card').on 'click', ->
        if $('.card_fields :input').is(':disabled')
          $('.card_fields :input').attr('disabled', false)
        else
          $('.card_fields :input').attr('disabled', true)
    $('.card_form').submit ->
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        $('#stripe_error').text("Processing...").show()
        subscription.processCard()
        false
      else
        true

  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, subscription.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200 or ($('.different_card').length and !$('.different_card').is(':checked'))
      $('#subscription_stripe_card_token').val(response.id)
      $('.card_form')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)
