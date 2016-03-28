$(document).ready ->
  $('.repeat-until').hide()
  $('#event_repeat_type').on 'change', ->
    if @value == 'single'
      $('.repeat-until').hide 'fast'
    else
      $('.repeat-until').show 'fast'

  eventTypeTrigger()

eventTypeTrigger = ->

  triggerFields = ->
    type = $('#event_event_type').val()
    if type is 'Game' or type is 'Scrimmage'
      $('.opponent-row').removeClass('hide')
      $('.repeat-type-row').toggleClass('hide')
      $('#event_repeat_type').val('single')
    else
      $('.repeat-type-row').removeClass('hide')
      $('.opponent-row').addClass('hide')

  triggerFields()

  $('#event_event_type').change -> triggerFields()