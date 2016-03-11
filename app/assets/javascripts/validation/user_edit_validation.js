$(function(){
  if($('div').is('#general')){
    user_edit_validation();
    $( "input[value='Update Profile']" ).attr('disabled', false);
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
  $('#mobile_phone_number').on("keyup change", function() {
    var object = $(this)
    var objectVal = $(this).val().replace(/[^\d]/g, '');
    $('#user_mobile_phone_number').val(objectVal)
    $.get('/checkemail?number='+objectVal,function(data){
      if (objectVal == "") {
        object.parent().siblings('.user_mobile_phone_number_field').html("");
      } else if (objectVal.charAt(0) == 0) {
        object.parent().siblings('.user_mobile_phone_number_field').html("<font size='2' color='red'>Mobile Number cannot begin with 0.<b></b> </font>")
      } else if (objectVal.charAt(0) == 1) {
        object.parent().siblings('.user_mobile_phone_number_field').html("<font size='2' color='red'>Mobile Number cannot begin with 1.<b></b> </font>")
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
    var pattern = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/i
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
  $('.edit-user-form').on("keyup change", function(e) {
    var userFirstName = $(this).find('#user_first_name').val();
    var userLastName = $(this).find('#user_last_name').val();
    var userNumber = $(this).find('#mobile_phone_number').val().replace(/[^\d]/g, '');
    var userEmail = $(this).find('#user_email').val();
    var pattern = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/i;
    var disableUpdate = function(){
      $( "input[value='Update Profile']" ).attr('disabled', true);
    };

    var enableUpdate = function(){
      $( "input[value='Update Profile']" ).attr('disabled', false);
    };
    
    if (e.target.getAttribute('id') == 'user_email'){
      disableUpdate();
      $.get('/checkemail?email='+userEmail+'&number='+userNumber,function(data){
        if (!data.user_exists) {enableUpdate();}
      })
    }
    if (userFirstName == "") {
      disableUpdate();
    } else if (userFirstName.length < 2) {
      disableUpdate();
    } else if (userLastName == "") {
      disableUpdate();
    } else if (userLastName.length < 2) {
      disableUpdate();
    } else if (userNumber.charAt(0) == 0) {
      disableUpdate();
    } else if (userNumber.charAt(0) == 1) {
      disableUpdate();
    } else if (userNumber.length >= 1 && userNumber.length < 10) {
      disableUpdate();
    } else if (userNumber.length > 10 ) {
      disableUpdate();
    } else if (!$.isNumeric(userNumber)) {
      disableUpdate();
    } else if (userEmail == "") {
      disableUpdate();
    } else if (!(pattern.test(userEmail))) {
      disableUpdate();
    } else {
      enableUpdate();
    }
  });
}
