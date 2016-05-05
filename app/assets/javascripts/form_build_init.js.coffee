$(document).ready ->
  return unless $("#fb-template").length

  initFormBuilder = (data)->
    builder = new Formbuilder(
      selector: '#fb-template'
      bootstrapData:  data
    )

    builder.on 'save', (payload) ->
      if $('label>span:contains("Untitled")').length
        $('label>span:contains("Untitled")').addClass('error')
        alert('Please fill in titles for all fields')
      else
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
    if formId is ''
      formBuilder = initFormBuilder($('#fb-template').data('form'))
      formBuilder.mainView.handleFormUpdate()
    else
      $.ajax
        type: "GET"
        url: "/forms/#{formId}"
        dataType: 'JSON'
        success: (response) ->
          formBuilder = initFormBuilder($.parseJSON(response.data))
          formBuilder.mainView.handleFormUpdate()
