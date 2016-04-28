$(document).ready ->
  return unless $("#fb-template").length

  initFormBuilder = (data)->
    builder = new Formbuilder(
      selector: '#fb-template'
      bootstrapData:  data
    )

    builder.on 'save', (payload) ->
      $.ajax
        type: "POST",
        url: $('#fb-template').data('url'),
        data:
          data: $.parseJSON(payload)
          name: $('#form_name').val()
        dataType: "script"

    builder

  initFormBuilder($('#fb-template').data('form'))

  $('#master_form').change ->
    formId = $(@).val()
    return if formId is ''
    
    $.ajax
      type: "GET"
      url: "/forms/#{formId}"
      dataType: 'JSON'
      success: (response) ->
        formBuilder = initFormBuilder($.parseJSON(response.data))
        formBuilder.mainView.handleFormUpdate()
