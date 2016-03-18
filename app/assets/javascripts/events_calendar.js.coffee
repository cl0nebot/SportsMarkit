$ ->
  if $("#event-schedules-calendar").length
    eventId = $(".content").data("eventId")
    $.get "/events/#{eventId}/event_schedules.json", (data) ->
      $("#event-schedules-calendar").calendar
        tmpl_path: "/assets/pleasure/globals/plugins/bootstrap-calendar/tmpls/"
        events_source: data

    $(document).on "click", ".cal-cell", ->
      $('.cal-cell.active').removeClass('active')
      $(@).addClass('active')
      setTimeout ->
          $("#cal-slide-content .attend-event").on "click", (e) ->
            url = $(this).data("href")
            auth_token = $('meta[name=csrf-token]').attr('content')
            $.get "#{url}&authenticity_token=#{auth_token}", (response)=>
              $(@).parent().find('a').removeAttr('disabled')
              $(@).attr('disabled', 'disabled')
              id = parseInt(response.id)
              gon.visiting_ids.yes = _.without(gon.visiting_ids.yes, id)
              gon.visiting_ids.no = _.without(gon.visiting_ids.no, id)
              gon.visiting_ids.maybe = _.without(gon.visiting_ids.maybe, id)
              gon.visiting_ids[response.type].push(id)
              icon = switch response.type
                when 'yes' then 'ion-checkmark-circled text-green'
                when 'no' then 'ion-close-circled text-danger'
                else 'ion-minus-circled text-amber'
              $("[data-event-id=#{id}] i").attr('class', icon)
        , 500
