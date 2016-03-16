$ ->
  eventId = $(".content").data("eventId")
  $.get "/events/#{eventId}/event_schedules.json", (data) ->
    $("#event-schedules-calendar").calendar
      tmpl_path: "/assets/pleasure/globals/plugins/bootstrap-calendar/tmpls/"
      events_source: data

  $(document).on "click", ".cal-cell", ->
    $("#cal-slide-content .attend-event").on "click", (e) ->
      url = $(this).data("href")
      auth_token = $('meta[name=csrf-token]').attr('content')
      $.post "#{url}&authenticity_token=#{auth_token}", (response)=>
        $(@).parent().find('a').removeAttr('disabled')
        $(@).attr('disabled', 'disabled')
        gon.visiting_ids.yes = _.without(gon.visiting_ids.yes, response.id)
        gon.visiting_ids.no = _.without(gon.visiting_ids.no, response.id)
        gon.visiting_ids.maybe = _.without(gon.visiting_ids.maybe, response.id)
        gon.visiting_ids[response.type].push(response.id)

