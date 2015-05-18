$(document).on 'click', '.remove-form', ->
    $(@).closest('form').remove()
    false

$(document).on  'click', '.submit-form', ->
  form = $(@).closest('form')
  if form.valid()
    valuesToSubmit = form.serialize()
    $.ajax
      type: form.attr('method'),
      url: form.attr('action'),
      data: valuesToSubmit,
      dataType: "script"

    false
