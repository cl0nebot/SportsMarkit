$(function(){
  if($('div').is('#pane-login')){
    login_validation();
    $("input[value='Login']").attr('disabled', true);
  }
})

function login_validation() {
  init_user_password_validation();
  init_user_identifier_validation();
  init_login_form_validation();
}

function init_user_password_validation() {
  $('#password').on("keyup change click", function() {
    var objectVal = $(this).val();
    if (objectVal == "") {
      $(this).parent().siblings('.password_field').html("<font size='2' color='red'>This field is required.</font>")
    } else if (objectVal.length < 6) {
      $(this).parent().siblings('.password_field').html("<font size='2' color='red'>Must be at least 6 characters.</font>")
    } else if (objectVal.length >= 6) {
      $(this).parent().siblings('.password_field').html("")
    }
  })
}

function init_user_identifier_validation() {
  $('#identifier').on("keyup change click", function() {
    var object = $(this)
    var objectVal = $(this).val();
    var pattern = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/i
    if (objectVal == "") {
      object.parent().siblings('.identifier_field').html("<font size='2' color='red'>This field is required.</font>")
    } else if (!(pattern.test(objectVal) || objectVal.match(/^\d{10}$/))) {
      object.parent().siblings('.identifier_field').html("<font size='2' color='red'>" + objectVal +  " is not valid.</font>")
    } else {
      object.parent().siblings('.identifier_field').html("<font size='2' color='green'>Looks good.<b>✓</b> </font>")
    }
  })
}

function init_login_form_validation() {
  $('#login-form').on("keyup change", function() {
    var userPassword = $(this).find('#password').val();
    var userIdentifier = $(this).find('#identifier').val();
    var pattern = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/i
    if (userPassword == "") {
      $("input[value='Login']").attr('disabled', true);
    } else if (userPassword.length < 6) {
      $("input[value='Login']").attr('disabled', true);
    } else if (userIdentifier == "") {
      $("input[value='Login']").attr('disabled', true);
    } else if (!(pattern.test(userIdentifier) || userIdentifier.match(/^\d{10}$/))) {
      $("input[value='Login']").attr('disabled', true);
    } else {
      $("input[value='Login']").attr('disabled', false);
    }
  })
}