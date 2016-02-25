$(function(){
  if($('div').is('#add_user')){
    team_admin_validation();
    $( ".add_team_member" ).attr('disabled', true);
  }
})

function team_admin_validation() {
  init_first_name_validation();
  init_last_name_validation();
  init_phone_number_validation();
  init_admin_form_validation();
}

function init_first_name_validation() {
  $('#first_name').on("keyup change click", function() {
    var object = $(this)
    var objectVal = $(this).val();
    if (objectVal == "" ) {
      $(this).parent().siblings('.first_name_field').html("<font size='2' color='red'>This field is required.</font>")
    } else if (objectVal.length < 2) {
      $(this).parent().siblings('.first_name_field').html("<font size='2' color='red'>Must be at least 2 characters.</font>")
    } else if (objectVal.length >= 2) {
      $(this).parent().siblings('.first_name_field').html("")
    }
  })
}

function init_last_name_validation() {
  $('#last_name').on("keyup change click", function() {
    var object = $(this)
    var objectVal = $(this).val();
    if (objectVal == "" ) {
      $(this).parent().siblings('.last_name_field').html("<font size='2' color='red'>This field is required.</font>")
    } else if (objectVal.length < 2) {
      $(this).parent().siblings('.last_name_field').html("<font size='2' color='red'>Must be at least 2 characters.</font>")
    } else if (objectVal.length >= 2) {
      $(this).parent().siblings('.last_name_field').html("")
    }
  })
}

function init_phone_number_validation() {
  $('#phone_number').on("keyup change click", function() {
    var object = $(this)
    var objectVal = $(this).val().replace(/[^\d]/g, '');
    $('#mobile_phone_number').val(objectVal)
    $.get('/checkemail?number='+objectVal+'&type=other',function(data){
      if (objectVal == "") {
        object.parent().siblings('.mobile_phone_number_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.charAt(0) == 0) {
        object.parent().siblings('.mobile_phone_number_field').html("<font size='2' color='red'>Mobile Number cannot begin with 0.<b></b> </font>")
      } else if (objectVal.charAt(0) == 1) {
        object.parent().siblings('.mobile_phone_number_field').html("<font size='2' color='red'>Mobile Number cannot begin with 1.<b></b> </font>")
      } else if (objectVal.length >= 1 && objectVal.length < 10) {
        object.parent().siblings('.mobile_phone_number_field').html("<font size='2' color='red'>Must be only 10 digits.</font>")
      } else if (objectVal.length > 10) {
        object.parent().siblings('.mobile_phone_number_field').html("<font size='2' color='red'>Must be only 10 digits.</font>")
      } else if (!$.isNumeric(objectVal)) {
        object.parent().siblings('.mobile_phone_number_field').html("<font size='2' color='red'>Mobile Number is invalid.</font>")
      } else if (data.number_exists) {
        object.parent().siblings('.mobile_phone_number_field').html("<font size='2' color='red'>Mobile Number already in use.</font>")
      } else if (objectVal.length == 10) {
        object.parent().siblings('.mobile_phone_number_field').html("<font size='2' color='green'>Looks good.</font>")
      }
    })
  })
}

function init_admin_form_validation() {
  $('#roster-form').on("keyup change", function() {
    var firstName = $(this).find('#first_name').val()
    var lastName = $(this).find('#last_name').val()
    var mobileNumber = $(this).find('#phone_number').val().replace(/[^\d]/g, '');
    $.get('/checkemail?number='+mobileNumber+'&type=other',function(data){
      if (firstName == "" ) {
        $( ".add_team_member" ).attr('disabled', true);
      } else if (firstName.length < 2) {
        $( ".add_team_member" ).attr('disabled', true);
      } else if (lastName == "" ) {
        $( ".add_team_member" ).attr('disabled', true);
      } else if (lastName.length < 2) {
        $( ".add_team_member" ).attr('disabled', true);
      } else if (mobileNumber == "" ) {
        $( ".add_team_member" ).attr('disabled', true);
      } else if (mobileNumber.charAt(0) == 0) {
        $( ".add_team_member" ).attr('disabled', true);
      } else if (mobileNumber.charAt(0) == 1) {
        $( ".add_team_member" ).attr('disabled', true);
      } else if (mobileNumber.length >= 1 && mobileNumber.length < 10) {
        $( ".add_team_member" ).attr('disabled', true);
      } else if (mobileNumber.length > 10) {
        $( ".add_team_member" ).attr('disabled', true);
      } else if (!$.isNumeric(mobileNumber)) {
        $( ".add_team_member" ).attr('disabled', true);
      } else if (data.number_exists) {
        $( ".add_team_member" ).attr('disabled', true);
      } else {
        $(".add_team_member").removeAttr('disabled');
      }
    })
  })
}
