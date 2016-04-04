window.notifySuccess = (message)->
  $.notify({
    message: message
  },{
    type: 'success'
  });