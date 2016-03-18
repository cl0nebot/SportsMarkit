$ ->
  validate_new_form = ->
    formInvalid = $("#new_form input.required").toArray().some (el) ->
      el.value == ""
    if $("[name=registration_options]").length and !$("[name=registration_options]:checked").val()
      formInvalid = true
    $("#new_form input[type=submit]").attr("disabled", formInvalid)

  $("#new_form").on "change keyup", ->
    validate_new_form()

  validate_new_form()