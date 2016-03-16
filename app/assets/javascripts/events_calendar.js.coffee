$ ->
  eventId = $(".content").data("eventId")
  $.get "/events/#{eventId}/event_schedules.json", (data) ->
    $("#event-schedules-calendar").calendar
      tmpl_path: "/assets/pleasure/globals/plugins/bootstrap-calendar/tmpls/"
      events_source: data

  $(document).on "click", "#cal-slide-content .attend-event", (e) ->
    debugger;
