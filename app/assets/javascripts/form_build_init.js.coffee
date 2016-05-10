$(document).ready ->
  return unless $("#fb-template").length

  initFormBuilder = (data)->

    builder = new Formbuilder(
      selector: '#fb-template'
      bootstrapData:  data
    )

    form = $('#new_registration_form')
    form.find('input').change ->
      builder.mainView.handleFormUpdate()

    builder.on 'save', (payload) ->

      form.validator('validate')
      if $('#form_start_date ').val() isnt "" and $('#form_end_date').val() isnt ""
        startDate = new Date($('#form_start_date ').val())
        endDate = new Date($('#form_end_date').val())
        if startDate > endDate
          form.find('.start-date-error').text('Start date should be before End Date')
          form.find('.start-date-error').parent().addClass('has-error has-danger')
          false
        else
          form.find('.start-date-error').parent().removeClass('has-error has-danger')
          form.find('.start-date-error').text('')

      if $('label>span:contains("Untitled")').length
            $('label>span:contains("Untitled")').addClass('error')
            alert('Please fill in titles for all fields')
          else if $('#new_registration_form > .form-group.has-error').length
            false
          else
            $.ajax
              type: "POST",
              url: $('#fb-template').data('url'),
              data:
                data: $.parseJSON(payload)
                name: $('#form_name').val()
                start_date: $('#form_start_date').val()
                end_date: $('#form_end_date').val()
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
