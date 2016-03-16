$ ->
  eventId = $(".content").data("eventId")
  $.get "/events/#{eventId}/event_schedules.json", (data) ->
    $("#event-schedules-calendar").calendar
      tmpl_path: "/assets/pleasure/globals/plugins/bootstrap-calendar/tmpls/"
      events_source: data

  $(document).on "click", ".cal-cell", ->
    $("#cal-slide-content .attend-event").on "click", (e) ->
      url = $(this).data("href")
      AUTH_TOKEN = $('meta[name=csrf-token]').attr('content')
      $.post url, ->
        debugger;
