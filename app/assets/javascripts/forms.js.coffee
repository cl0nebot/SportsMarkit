$ ->
  $("#notify_about_registration").on "change", ->
    $this = $(this)
    $.post("/forms/#{$this.data('formId')}/toggle_notification", { notify: this.checked })