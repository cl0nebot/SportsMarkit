$ ->
  if $("#event-schedules-calendar").length
    eventId = $(".content").data("eventId")
    $.get "/events/#{eventId}/event_schedules.json", (data) ->
      calendar = $("#event-schedules-calendar").calendar
        tmpl_path: "/assets/pleasure/globals/plugins/bootstrap-calendar/tmpls/"
        events_source: data
        display_week_numbers: false
        weekbox: false
        onAfterViewLoad: (view) ->
          $("#event-schedules-calendar").prev().text(this.getTitle())
          $('.btn-group button').removeClass('active')
          $('button[data-calendar-view="' + view + '"]').addClass('active')

      $('.btn-group button[data-calendar-nav]').each ->
        $this = $(this)
        $this.click ->
          calendar.navigate $this.data('calendar-nav')

    $(document).on "click", ".cal-cell", ->
      $('.cal-cell.active').removeClass('active')
      $(@).addClass('active')
      setTimeout ->
          $("#cal-slide-content .attend-event").on "click", (e) ->
            url = $(this).data("href")
            auth_token = $('meta[name=csrf-token]').attr('content')
            $.get "#{url}&authenticity_token=#{auth_token}", (response)=>
              if response.status is 'payment_required'
                $('#payment-modal').find('.event-name').text(response.event_name)
                $('#payment-modal').find('.event-link').attr('href', response.link)
                $('#payment-modal > #payment-required-modal').modal('show')
              else
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
