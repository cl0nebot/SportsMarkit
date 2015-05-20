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

$(document).ready ->
  $(".best_in_place").best_in_place();
  $('[name="photo[image]"]').change ->
    $('#crop-image').hide()
    $('.preview-container').hide()
    $('#f_x, #f_y, #f_w, #f_h').val('')

$(document).on 'click', '.no-action', ->
  false

$(document).on 'click', '#crop-image', ->
  $('#preview-pane').show()
  FormsJCrop.init();
  false

