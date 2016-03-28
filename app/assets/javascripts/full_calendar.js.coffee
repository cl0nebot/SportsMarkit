$(document).ready ->
  root = $('#calendar').data('root')
  currentSource = root + "/calendar/events"
  $('#calendar').fullCalendar
    editable: true,
    header:
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    defaultView: 'month',
    height: 500,
    slotMinutes: 30,
    eventSources: (start, end, timezone, callback) ->
      $.ajax
        url: currentSource
        dataType: 'json'
        data:
          start: start.toDate()
          end: end.toDate()
        success: (data) ->
          callback data.calendars
    timeFormat: 'h:mmt',
    dragOpacity: "0.5"

    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) ->
      updateEvent(event);

    eventResize: (event, dayDelta, minuteDelta, revertFunc) ->
      updateEvent(event);

  refetchCalendar = ->
    source = root + "/calendar/events?" + $('#calendar_filter').serialize()
    $('#calendar').fullCalendar('removeEventSource', currentSource)
    $('#calendar').fullCalendar('addEventSource', source)
    $('#calendar').fullCalendar('refetchEvents')
    currentSource = source

  $('#calendar_filter').find('input').change ->
    refetchCalendar()

  $('#reset_filters').click ->
    $('#calendar_filter').find('input').attr('checked', false)
    refetchCalendar()
    false

  $('a[data-toggle="tab"]').on 'shown.bs.tab', (e)->
    $('#calendar').fullCalendar('render')  if $(e.target).attr('href') == '#calendar-tab'

updateEvent = (the_event) ->
  $.update "/events/" + the_event.id,
    event:
      title: the_event.title,
      starts_at: "" + the_event.start,
      ends_at: "" + the_event.end,
      description: the_event.description