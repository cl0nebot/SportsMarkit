$(function(){
  if($('div').is('#pane-create-account')){
    signup_validation();
    $( "input[type='submit']" ).attr('disabled', true);
  }
})

function signup_validation() {
  init_user_mobile_phone_number_validation();
  init_user_email_validation();
  init_signup_form();
}

function init_user_mobile_phone_number_validation() {
  $('#user_mobile_phone_number').on("keyup change click", function() {
    var object = $(this)
    var objectVal = $(this).val();
    $.get('/checkemail?number='+objectVal,function(data){
      if (objectVal == "") {
        object.parent().siblings('.user_mobile_phone_number_field').html("");
      } else if (objectVal.length >= 1 && objectVal.length < 10) {
        object.parent().siblings('.user_mobile_phone_number_field').html("<font size='2' color='red'>Must be at least 10 digits.</font>")
      } else if (data.number_exists) {
        object.parent().siblings('.user_mobile_phone_number_field').html("<font size='2' color='red'>Mobile Number already in use.</font>")
      } else if (objectVal.length >= 10) {
        object.parent().siblings('.user_mobile_phone_number_field').html("<font size='2' color='green'>Looks good.</font>")
      }
    })
  })
}

function init_user_email_validation() {
  $('#user_email').on("keyup change click", function() {
    var object = $(this)
    var objectVal = $(this).val();
    var pattern = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    $.get('/checkemail?email='+objectVal,function(data){
      if (objectVal == "" ) {
        object.parent().siblings('.user_email_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (!(pattern.test(objectVal))) {
        object.parent().siblings('.user_email_field').html("<font size='2' color='red'>" + objectVal +  " is not valid.</font>")
      } else if (data.email_exists) {
        object.parent().siblings('.user_email_field').html("<font size='2' color='red'>" + objectVal +  " is not available.</font>")
      } else {
        object.parent().siblings('.user_email_field').html("<font size='2' color='green'>Looks good.<b>✓</b> </font>")
      }
    })
  })
}

function init_signup_form() {
  $('#signup-form').on("keyup change click", function() {
    var userNumber = $(this).find('#user_mobile_phone_number').val();
    var userEmail = $(this).find('#user_email').val();
    var pattern = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    $.get('/checkemail?email='+userEmail+'&number='+userNumber,function(data){
      if (userNumber.length >= 1 && userNumber.length < 10) {
        $( "input[type='submit']" ).attr('disabled', true);
      } else if (userEmail == "") {
        $( "input[type='submit']" ).attr('disabled', true);
      } else if (!(pattern.test(userEmail))) {
        $( "input[type='submit']" ).attr('disabled', true);
      } else if (data.user_exists) {
        $( "input[type='submit']" ).attr('disabled', true);
      } else {
        $( "input[type='submit']" ).attr('disabled', false);
      }
    })
  });
}
