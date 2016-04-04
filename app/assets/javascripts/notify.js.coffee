window.notifySuccess = (message)->
  $.notify({
    message: message
  },{
    type: 'success'

    offset:
      y: 50
  });