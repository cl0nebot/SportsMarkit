$ ->
  validate_new_form = ->
    formHasInvalidInputs = $("#new_form input.required").toArray().some (el) ->
      el.value == ""
    $("#new_form input[type=submit]").attr("disabled", formHasInvalidInputs)

  $("#new_form").on "change keyup", ->
    validate_new_form()

  validate_new_form()