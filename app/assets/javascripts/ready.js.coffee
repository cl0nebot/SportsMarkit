$(document).on 'click', '.remove-form', ->
    $(@).closest('form').remove()
    false