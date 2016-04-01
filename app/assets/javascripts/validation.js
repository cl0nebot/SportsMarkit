//= require ./validation/multiple_events_validation

$(function() {
  $('.open-modal').on("click", function() {
    $("input[type='submit']").attr('disabled', true);
    $.getScript("/assets/validation.js", function() {});
  })
});

$(function() {
  if ($('div').is('#panel-new-team-setup')) {
    $("<div id='team_name_field'></div>").insertAfter($("#team_name").parent());
    $('#team_name').on("keyup", function() {
      var object = $('#team_name')
      var objectVal = $('#team_name').val();
      if (objectVal == "") {
        $('#team_name_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length < 2) {
        $('#team_name_field').html("<font size='2' color='red'>Must be at least 2 characters.</font>")
      } else if (objectVal.length >= 2) {
        $('#team_name_field').html("<font size='2' color='green'>" + objectVal + " is an excellent team name.<b></b> </font>")
      }
    })

    $("<div id='team_sport_field'></div>").insertAfter($("#team_sport").parent());
    $('#team_sport').on("change", function() {
      var object = $('#team_sport')
      var objectVal = $('#team_sport').val();
      if (objectVal == "") {
        $('#team_sport_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length < 2) {
        $('#team_sport_field').html("<font size='2' color='red'>Must be at least 2 characters.</font>")
      } else if (objectVal.length >= 2) {
        $('#team_sport_field').html("<font size='2' color='green'>")
      }
    })

    $("<div id='team_address_attributes_street_1_field'></div>").insertAfter($("#team_address_attributes_street_1").parent());
    $('#team_address_attributes_street_1').on("keyup", function() {
      var object = $('#team_address_attributes_street_1')
      var objectVal = $('#team_address_attributes_street_1').val();
      if (objectVal == "") {
        $('#team_address_attributes_street_1_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length >= 1) {
        $('#team_address_attributes_street_1_field').html("<font size='2' color='green'>" + objectVal + " <b>✓</b> </font>")
      }
    })

    $("<div id='team_address_attributes_city_field'></div>").insertAfter($("#team_address_attributes_city").parent());
    $('#team_address_attributes_city').on("keyup", function() {
      var object = $('#team_address_attributes_city')
      var objectVal = $('#team_address_attributes_city').val();
      if (objectVal == "") {
        $('#team_address_attributes_city_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length >= 1) {
        $('#team_address_attributes_city_field').html("<font size='2' color='green'>" + objectVal + " <b>✓</b> </font>")
      }
    })

    $("<div id='team_address_attributes_state_field'></div>").insertAfter($("#team_address_attributes_state").parent());
    $('#team_address_attributes_state').on("keyup", function() {
      var object = $('#team_address_attributes_state')
      var objectVal = $('#team_address_attributes_state').val();
      if (objectVal == "") {
        $('#team_address_attributes_state_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length >= 1) {
        $('#team_address_attributes_state_field').html("<font size='2' color='green'>" + objectVal + " <b>✓</b> </font>")
      }
    })

    $('#new-team-setup-form').on("keyup change", function() {
      var teamname = $('#team_name')
      var teamnameVal = $('#team_name').val();
      var teamsport = $('#team_sport')
      var teamsportVal = $('#team_sport').val();
      var street = $('#team_address_attributes_street_1')
      var streetVal = $('#team_address_attributes_street_1').val();
      var city = $('#team_address_attributes_city')
      var cityVal = $('#team_address_attributes_city').val();
      var state = $('#team_address_attributes_state')
      var stateVal = $('#team_address_attributes_state').val();
      if (teamnameVal < 2) {
        $("input[type='submit']").attr('disabled', true);
      } else if (teamsportVal == "") {
        $("input[type='submit']").attr('disabled', true);
      } else if (streetVal == "") {
        $("input[type='submit']").attr('disabled', true);
      } else if (cityVal == "") {
        $("input[type='submit']").attr('disabled', true);
      } else if (stateVal == "") {
        $("input[type='submit']").attr('disabled', true);
      } else {
        $("input[type='submit']").removeAttr('disabled');
      }
    });

  }
});

$(function() {
  if ($('div').is('#panel-new-school-setup')) {
    $("<div id='school_name_field'></div>").insertAfter($("#school_name").parent());
    $('#school_name').on("keyup", function() {
      var object = $('#school_name')
      var objectVal = $('#school_name').val();
      if (objectVal == "") {
        $('#school_name_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length < 2) {
        $('#school_name_field').html("<font size='2' color='red'>Must be at least 2 characters.</font>")
      } else if (objectVal.length >= 2) {
        $('#school_name_field').html("<font size='2' color='green'>" + objectVal + " is an excellent school name.<b></b> </font>")
      }
    })

    $("<div id='school_classification_field'></div>").insertAfter($("#school_classification").parent());
    $('#school_classification').on("change", function() {
      var object = $('#school_classification')
      var objectVal = $('#school_classification').val();
      if (objectVal == "") {
        $('#school_classification_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length < 2) {
        $('#school_classification_field').html("<font size='2' color='red'>Must be at least 2 characters.</font>")
      } else if (objectVal.length >= 2) {
        $('#school_classification_field').html("<font size='2' color='green'>")
      }
    })

    $("<div id='school_address_attributes_street_1_field'></div>").insertAfter($("#school_address_attributes_street_1").parent());
    $('#school_address_attributes_street_1').on("keyup", function() {
      var object = $('#school_address_attributes_street_1')
      var objectVal = $('#school_address_attributes_street_1').val();
      if (objectVal == "") {
        $('#school_address_attributes_street_1_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length >= 1) {
        $('#school_address_attributes_street_1_field').html("<font size='2' color='green'>" + objectVal + " <b>✓</b> </font>")
      }
    })

    $("<div id='school_address_attributes_city_field'></div>").insertAfter($("#school_address_attributes_city").parent());
    $('#school_address_attributes_city').on("keyup", function() {
      var object = $('#school_address_attributes_city')
      var objectVal = $('#school_address_attributes_city').val();
      if (objectVal == "") {
        $('#school_address_attributes_city_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length >= 1) {
        $('#school_address_attributes_city_field').html("<font size='2' color='green'>" + objectVal + " <b>✓</b> </font>")
      }
    })

    $("<div id='school_address_attributes_state_field'></div>").insertAfter($("#school_address_attributes_state").parent());
    $('#school_address_attributes_state').on("keyup", function() {
      var object = $('#school_address_attributes_state')
      var objectVal = $('#school_address_attributes_state').val();
      if (objectVal == "") {
        $('#school_address_attributes_state_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length >= 1) {
        $('#school_address_attributes_state_field').html("<font size='2' color='green'>" + objectVal + " <b>✓</b> </font>")
      }
    })

    $('#new-school-setup-form').on("keyup change", function() {
      var schoolname = $('#school_name')
      var schoolnameVal = $('#school_name').val();
      var schoolclassification = $('#school_classification')
      var schoolclassificationVal = $('#school_classification').val();
      var street = $('#school_address_attributes_street_1')
      var streetVal = $('#school_address_attributes_street_1').val();
      var city = $('#school_address_attributes_city')
      var cityVal = $('#school_address_attributes_city').val();
      var state = $('#school_address_attributes_state')
      var stateVal = $('#school_address_attributes_state').val();
      if (schoolnameVal < 2) {
        $("input[type='submit']").attr('disabled', true);
      } else if (schoolclassificationVal == "") {
        $("input[type='submit']").attr('disabled', true);
      } else if (streetVal == "") {
        $("input[type='submit']").attr('disabled', true);
      } else if (cityVal == "") {
        $("input[type='submit']").attr('disabled', true);
      } else if (stateVal == "") {
        $("input[type='submit']").attr('disabled', true);
      } else {
        $("input[type='submit']").removeAttr('disabled');
      }
    });

  }
});


$(function() {
  if ($('div').is('#panel-new-club-setup')) {
    $("<div id='club_name_field'></div>").insertAfter($("#club_name").parent());
    $('#club_name').on("keyup", function() {
      var object = $('#club_name')
      var objectVal = $('#club_name').val();
      if (objectVal == "") {
        $('#club_name_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length < 2) {
        $('#club_name_field').html("<font size='2' color='red'>Must be at least 2 characters.</font>")
      } else if (objectVal.length >= 2) {
        $('#club_name_field').html("<font size='2' color='green'>" + objectVal + " is an excellent club name.<b></b> </font>")
      }
    })

    $("<div id='club_category_field'></div>").insertAfter($("#club_category").parent());
    $('#club_category').on("change", function() {
      var object = $('#club_category')
      var objectVal = $('#club_category').val();
      if (objectVal == "") {
        $('#club_category_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length < 2) {
        $('#club_category_field').html("<font size='2' color='red'>Must be at least 2 characters.</font>")
      } else if (objectVal.length >= 2) {
        $('#club_category_field').html("<font size='2' color='green'>")
      }
    })

    $("<div id='club_address_attributes_street_1_field'></div>").insertAfter($("#club_address_attributes_street_1").parent());
    $('#club_address_attributes_street_1').on("keyup", function() {
      var object = $('#club_address_attributes_street_1')
      var objectVal = $('#club_address_attributes_street_1').val();
      if (objectVal == "") {
        $('#club_address_attributes_street_1_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length >= 1) {
        $('#club_address_attributes_street_1_field').html("<font size='2' color='green'>" + objectVal + " <b>✓</b> </font>")
      }
    })

    $("<div id='club_address_attributes_city_field'></div>").insertAfter($("#club_address_attributes_city").parent());
    $('#club_address_attributes_city').on("keyup", function() {
      var object = $('#club_address_attributes_city')
      var objectVal = $('#club_address_attributes_city').val();
      if (objectVal == "") {
        $('#club_address_attributes_city_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length >= 1) {
        $('#club_address_attributes_city_field').html("<font size='2' color='green'>" + objectVal + " <b>✓</b> </font>")
      }
    })

    $("<div id='club_address_attributes_state_field'></div>").insertAfter($("#club_address_attributes_state").parent());
    $('#club_address_attributes_state').on("keyup", function() {
      var object = $('#club_address_attributes_state')
      var objectVal = $('#club_address_attributes_state').val();
      if (objectVal == "") {
        $('#club_address_attributes_state_field').html("<font size='2' color='red'>This field is required.</font>")
      } else if (objectVal.length >= 1) {
        $('#club_address_attributes_state_field').html("<font size='2' color='green'>" + objectVal + " <b>✓</b> </font>")
      }
    })

    $('#new-club-setup-form').on("keyup change", function() {
      var clubname = $('#club_name')
      var clubnameVal = $('#club_name').val();
      var clubcategory = $('#club_category')
      var clubcategoryVal = $('#club_category').val();
      var street = $('#club_address_attributes_street_1')
      var streetVal = $('#club_address_attributes_street_1').val();
      var city = $('#club_address_attributes_city')
      var cityVal = $('#club_address_attributes_city').val();
      var state = $('#club_address_attributes_state')
      var stateVal = $('#club_address_attributes_state').val();
      if (clubnameVal < 2) {
        $("input[type='submit']").attr('disabled', true);
      } else if (clubcategoryVal == "") {
        $("input[type='submit']").attr('disabled', true);
      } else if (streetVal == "") {
        $("input[type='submit']").attr('disabled', true);
      } else if (cityVal == "") {
        $("input[type='submit']").attr('disabled', true);
      } else if (stateVal == "") {
        $("input[type='submit']").attr('disabled', true);
      } else {
        $("input[type='submit']").removeAttr('disabled');
      }
    });
  }
});