remoteSubmit = (form)->
  if form.valid()
    $.ajax
      type: form.attr('method'),
      url: form.attr('action'),
      data: form.serialize(),
      dataType: "script"

$(document).on 'click', '.remove-form', ->
    $(@).closest('form').remove()
    false

$(document).on  'click', '.submit-form', ->
  remoteSubmit($(@).closest('form'))

$(document).ready ->
  $(".best_in_place").best_in_place();

  $('a[data-toggle="tab"]').on 'shown.bs.tab', (e)->
    if $('#youtube1').length
      WidgetVideo.responsiveVideo()

  $('[name="photo[image]"]').change ->
    $('#crop-image').hide()
    $(  '.preview-container').hide()
    $('#f_x, #f_y, #f_w, #f_h').val('')
  pictureCropping()

$(document).on 'click', '.no-action', ->
  false

$(document).on 'click', '#crop-image', ->
  $('#preview-pane').show()
#  FormsJCrop.init();
  false

pictureCropping = ->
  $('#edit-background').click ->
    self = $(@)
    if self.data('edit') is 'edit'
      $('.crop-ui').show()
      self.html('Close')
      self.data('edit', 'close')
      $('.bg-overlay').hide()
    else
      $('.crop-ui').hide()
      self.html('Edit')
      self.data('edit', 'edit')
      $('.bg-overlay').show()

  img = $('#image-cropper')
  src = img.attr('src')
  settings = img.data('settings')
  $('.select-image-btn').click ->
    $('.cropit-image-input').click()

  img.cropit
    imageState:
      src: src
    exportZoom: 0.1

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

$(document).ready ->
  $('.autosubmit').change ->
    remoteSubmit($(@).closest('form'))
