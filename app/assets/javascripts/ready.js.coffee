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
  pictureCropping()

$(document).on 'click', '.no-action', ->
  false

$(document).on 'click', '#crop-image', ->
  $('#preview-pane').show()
#  FormsJCrop.init();
  false

pictureCropping = ->
  img = $('#image-cropper')
  src = img.attr('src')
  settings = img.data('settings')
  $('.select-image-btn').click ->
    $('.cropit-image-input').click()

  img.cropit
    imageState:
      src: src
    onImageLoaded: ->
      if settings.offset_x? and settings.offset_y?
        img.cropit('offset', {x: parseFloat(settings.offset_x), y: parseFloat(settings.offset_y)})

      img.cropit('zoom', parseFloat(settings.zoom)) if settings.zoom?


  $('#bg_image').submit ->
    offset = $('#image-cropper').cropit('offset')
    zoom = $('#image-cropper').cropit('zoom')
    $('#offset_x').val(offset.x)
    $('#offset_y').val(offset.y)
    $('#zoom').val(zoom)
