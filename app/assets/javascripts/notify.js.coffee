window.notifySuccess = (message)->
  $.notify({
    message: message
  },{
    type: 'success'

    offset:
      y: 50
  });

window.notifyError = (message)->
  $.notify({
    message: message
  },{
    type: 'danger'

    offset:
      y: 50
  });