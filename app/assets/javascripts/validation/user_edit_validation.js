$(function(){
  if($('div').is('#general')){
    user_edit_validation();
    $( "input[value='Update Profile']" ).attr('disabled', true);
  }
})

function user_edit_validation() {
  init_user_first_name_validation()
  init_user_last_name_validation()
  init_user_mobile_phone_number_validation();
  init_user_email_validation();
  init_user_edit_form();
}

function init_user_first_name_validation() {
  $('#user_first_name').on("keyup change click", function() {
    var object = $(this)
    var objectVal = $(this).val();
    if (objectVal == "" ) {
      $(this).parent().siblings('.user_first_name_field').html("<font size='2' color='red'>This field is required.</font>")
    } else if (objectVal.length < 2) {
      $(this).parent().siblings('.user_first_name_field').html("<font size='2' color='red'>Must be at least 2 characters.</font>")
    } else if (objectVal.length >= 2) {
      $(this).parent().siblings('.user_first_name_field').html("")
    }
  })
}

function init_user_last_name_validation() {
  $('#user_last_name').on("keyup change", function() {
    var object = $(this)
    var objectVal = $(this).val();
    if (objectVal == "" ) {
      $(this).parent().siblings('.user_last_name_field').html("<font size='2' color='red'>This field is required.</font>")
    } else if (objectVal.length < 2) {
      $(this).parent().siblings('.user_last_name_field').html("<font size='2' color='red'>Must be at least 2 characters.</font>")
    } else if (objectVal.length >= 2) {
      $(this).parent().siblings('.user_last_name_field').html("")
    }
  })
}

function init_user_mobile_phone_number_validation() {
  $('#user_mobile_phone_number').on("keyup change", function() {
    var object = $(this)
    var objectVal = $(this).val();
    $.get('/checkemail?number='+objectVal,function(data){
      if (objectVal == "") {
        object.parent().siblings('.user_mobile_phone_number_field').html("");
      } else if (objectVal.length >= 1 && objectVal.length < 10) {
        object.parent().siblings('.user_mobile_phone_number_field').html("<font size='2' color='red'>Must be only 10 digits.</font>")
      } else if (objectVal.length > 10) {
        object.parent().siblings('.user_mobile_phone_number_field').html("<font size='2' color='red'>Must be only 10 digits.</font>")
      } else if (!$.isNumeric(objectVal)) {
        object.parent().siblings('.user_mobile_phone_number_field').html("<font size='2' color='red'>Mobile Number is invalid.</font>")
      } else if (data.number_exists) {
        object.parent().siblings('.user_mobile_phone_number_field').html("<font size='2' color='red'>Mobile Number already in use.</font>")
      } else if (objectVal.length == 10) {
        object.parent().siblings('.user_mobile_phone_number_field').html("<font size='2' color='green'>Looks good.</font>")
      }
    })
  })
}

function init_user_email_validation() {
  $('#user_email').on("keyup change", function() {
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

function init_user_edit_form() {
  $('.edit-user-form').on("keyup change", function() {
    var userFirstName = $(this).find('#user_first_name').val()
    var userLastName = $(this).find('#user_last_name').val()
    var userNumber = $(this).find('#user_mobile_phone_number').val();
    var userEmail = $(this).find('#user_email').val();
    var pattern = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    $.get('/checkemail?email='+userEmail+'&number='+userNumber,function(data){
      if (userFirstName == "") {
        $( "input[value='Update Profile']" ).attr('disabled', true);
      } else if (userFirstName.length < 2) {
        $( "input[value='Update Profile']" ).attr('disabled', true);
      } else if (userLastName == "") {
        $( "input[value='Update Profile']" ).attr('disabled', true);
      } else if (userLastName.length < 2) {
        $( "input[value='Update Profile']" ).attr('disabled', true);
      } else if (userNumber.length >= 1 && userNumber.length < 10) {
        $( "input[value='Update Profile']" ).attr('disabled', true);
      } else if (userNumber.length > 10 ) {
        $( "input[value='Update Profile']" ).attr('disabled', true);
      } else if (!$.isNumeric(userNumber)) {
        $( "input[value='Update Profile']" ).attr('disabled', true);
      } else if (userEmail == "") {
        $( "input[value='Update Profile']" ).attr('disabled', true);
      } else if (!(pattern.test(userEmail))) {
        $( "input[value='Update Profile']" ).attr('disabled', true);
      } else if (data.user_exists) {
        $( "input[value='Update Profile']" ).attr('disabled', true);
      } else {
        $( "input[value='Update Profile']" ).attr('disabled', false);
      }
    })
  });
}
