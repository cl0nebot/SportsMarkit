
$(window).load(function(){
  jQuery.validator.addMethod("uniqueEmail", function(value, element, params) {
  var return_value = true;
  $.ajax({
    url: $(element).data('url'),
    data: {
      email: $(element).val()
    },
    async: false,
    success: function(data) {
      if ((data != null) && (data.available != null) && !data.available) {
        return_value =  false;
      }
    }
  });
  return return_value;
  });
  
  jQuery.validator.addMethod("uniqueUsername", function(value, element, params) {
  var return_value = true;
  $.ajax({
    url: $(element).data('url'),
    data: {
      email: $(element).val()
    },
    async: false,
    success: function(data) {
      if ((data != null) && (data.available != null) && !data.available) {
        return_value =  false;
      }
    }
  });
  return return_value;
  });

  jQuery.validator.addMethod("exactLength", function(value, element, params) {
    return this.optional(element) || value.length == params;
  }, jQuery.format("Please enter exactly {0} digits."));

  jQuery.validator.addMethod("phoneNumber", function(value, element, params) {
    return $(element).val().match(/^\(\d{3}\)\s\d{3}-\d{4}$/) != null
  }, jQuery.format("Please enter exactly 10 digits."));


  if($('#signup-form').size()){
    validateSignup($('#signup-form'));
  }
  if($('.registration').size()){
    validateSignup($('.registration'));
  }
  if($('.login_widget').size()){
    validateSignIn($('.login_widget'));
  }
  
  if($('#login-form').size()){
    validateLogin($('#login-form'));
  }
  
  if($('#user-edit-form').size()){
    validateUserEditForm($('#user-edit-form'));
  }
  if($('#user-password-form').size()){
    validateUserPasswprdForm($('#user-password-form'));
  }
  
  if($('#new-school-form').size()){
    validateNewSchoolForm($('#new-school-form'));
  }
  
  if($('#new-team-form').size()){
    validateNewTeamForm($('#new-team-form'));
  }
  
  if($('#new-facility-form').size()){
    validateNewFacilityForm($('#new-facility-form'));
  }
  
  if($('#new-league-form').size()){
    validateNewLeagueForm($('#new-league-form'));
  }
  
  if($('#certification-form').size()){
    validateCertificationForm($('#certification-form'));
  }
  
  if($('#event-form').size()){
    validateNewEventForm($('#event-form'));
  }
  
  if($('#add-media-form').size()){
    validateAddMediaForm($('#add-media-form'));
  }
  
  if($('#roster-form').size()){
    validateRosterForm($('#roster-form'));
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  if($('.login_widget').size()){
    validateSignIn($('.login_widget'));
  }
  if($('#sign-in-form').size()){
    validateSignIn($('#sign-in-form'));
  }


  if($('#message-form').size()){
    validateSpaContactMessage($('#message-form'));
  }



  if($('#message-reply').size()){
    validateSpaContactMessageReply($('#message-reply'));
  }

  if($('#contact-message-form').size()){
    validateContactMessageForm($('#contact-message-form'));
  }
  if($('#partner-signup-form').size()){
    validatePartnerSignupForm($('#partner-signup-form'));
  }

  if($('#spa-offer-form').size()){
    validateSpaOfferForm($('#spa-offer-form'));
  }

  if($('.deal-and-package-form').size()){
    validateDealForm($('.deal-and-package-form'));
  }

  if($('.spa-review-form').size()){
    validateSpaReviewForm($('.spa-review-form'));
  }



  if($('#edit-coupon-code-form').size()){
    validateCouponCodeForm($('#edit-coupon-code-form'));
  }
  
  if($('#contest-form').size()){
    validateContestForm($('#contest-form'));
  }

  if($('#treatment-form').size()){
    validateTreatmentForm($('#treatment-form'));
  }
  $('.edit_spa, .new_spa').each(function(i,el){
    validateSpaEditForm($(el));
  });

  if($('#comment-form').size()){
    validateCommentForm($('#comment-form'));
  }

  if($('.user-verification').size()){
    $('.user-verification').validate();
  }
  if($('#new_invitation').size()){
    $('#new_invitation').validate();
  }
});


validateSignup = function(el){
  $(el).validate({
    rules: {
      "user[first_name]": {
        required: true,
        minlength: 2,
        maxlength: 20
      },
      "user[last_name]": {
        required: true,
        minlength: 2,
        maxlength: 20
      },
      "user[email]": {
        required: true,
        email: true,
        uniqueEmail: true
      },
      "user[mobile_phone_number]": {
        required: true,
        number: true
      },
      "user[password]": {
        required: true
      },
      "user[password_confirmation]": {
        required: true,
        equalTo: "#user_password"
      }
    },
    messages: {
      "user[password_confirmation]": {
        equalTo: "Password doesn't match"
      },
      "user[email]": {
        uniqueEmail: "This email has been already been registered."
      },
      "user[firstname]": {
        minlength: "First Name must be at least 2 characters.",
        maxlength: "First Name must not exceed 20 characters."
      },
      "user[lastname]": {
        minlength: "Last Name must be at least 2 characters.",
        maxlength: "Last Name must not exceed 20 characters."
      }
    }
  });
};

validateLogin = function(el){
  $(el).validate({
    rules: {
      "identifier": {
        required: true
      },
      "password": {
        required: true
      }
    }
  });
};

validateUserPasswordForm = function(el){
  $(el).validate({
    rules: {
      "user[current_password]": {
        required: true,
        minlength: 5,
        maxlength: 20
      },
      "user[password]": {
        required: true,
        minlength: 5,
        maxlength: 20
      },
      "user[password_confirmation]": {
        required: true,
        minlength: 5,
        maxlength: 20
      }
    },
    messages: {
      "user[password_confirmation]": {
        equalTo: "Password doesn't match"
      }
    }
  });
};

validateUserEditForm = function(el){
  $(el).validate({
    rules: {
      "user[first_name]": {
        required: true,
        minlength: 2,
        maxlength: 20
      },
      "user[last_name]": {
        required: true,
        minlength: 2,
        maxlength: 20
      },
      "user[mobile_phone_number]": {
        required: true,
        number: true,
        exactLength: 10
      },
      "user[username]": {
        uniqueUsername: true
      },
      "height": {
        number: true,
		  max: 7,
		  min: 2
      },
      "inches": {
        number: true,
		  max: 11,
		  min: 0
      },
      "weight": {
        number: true,
		  max: 500,
		  min: 30
      },
	  
      "user[email]": {
        required: true,
        email: true,
        uniqueEmail: true
      }
    },
    messages: {
      "user[password_confirmation]": {
        equalTo: "Password doesn't match"
      },
      "user[email]": {
        uniqueEmail: "This email has been already been registered."
      },
      "user[firstname]": {
        minlength: "First Name must be at least 2 characters.",
        maxlength: "First Name must not exceed 20 characters."
      },
      "user[lastname]": {
        minlength: "Last Name must be at least 2 characters.",
        maxlength: "Last Name must not exceed 20 characters."
      }
    }
  });
};

validateNewSchoolForm = function(el){
  $(el).validate({
    rules: {
      "school[name]": {
        required: true,
        minlength: 3,
        maxlength: 50
      },
      "school[classification]": {
        required: true,
      },
      "school[abbreviation]": {
        required: true
      },
      "school[address_1]": {
        required: true
      },
      "school[city]": {
        required: true
      },
      "school[state]": {
        required: true
      },
      "school[zip]": {
        required: true
      },
      "school[website]": {
        required: true
      }
    },
    messages: {
      "school[name]": {
        minlength: "Name must be at least 3 characters.",
        maxlength: "Name must not exceed 50 characters."
      }
    }
  });
};

validateNewTeamForm = function(el){
  $(el).validate({
    rules: {
      "team[name]": {
        required: true,
        minlength: 3,
        maxlength: 50
      },
      "team[sport]": {
        required: true
      },
      "team[address_1]": {
        required: true
      },
      "team[city]": {
        required: true
      },
      "team[state]": {
        required: true
      },
      "team[zip]": {
        required: true,
		number: true
      }
    },
    messages: {
      "team[name]": {
        minlength: "Name must be at least 3 characters.",
        maxlength: "Name must not exceed 50 characters."
      }
    }
  });
};


validateAddMediaForm = function(el){
  $(el).validate({
    rules: {},
  });
  addMediaValidation();
};

addMediaValidation = function(){
  $('.media-field:not(.init-validate)').each(function(){
    $(this).find('.media-title').rules("add", {required: true});
	$(this).find('.media-url').rules("add", {required: true});
	$(this).find('.media-publication-date').rules("add", {required: true});
    $(this).addClass('init-validate');
  });
};




validateNewFacilityForm = function(el){
  $(el).validate({
    rules: {
      "facility[name]": {
        required: true,
        minlength: 3,
        maxlength: 50
      }
    },
    messages: {
      "facility[name]": {
        minlength: "Name must be at least 3 characters.",
        maxlength: "Name must not exceed 50 characters."
      }
    }
  });
};

validateRosterForm = function(el){
  $(el).validate({
    rules: {
      "first_name": {
        required: true,
        minlength: 3,
        maxlength: 50
      },

      "last_name": {
        required: true,
        minlength: 2,
        maxlength: 50
      },
	  
      "participant_classification": {
        required: true,
        minlength: 3,
        maxlength: 50
      },
	  
      "position": {
        required: true,
      },
	  // "selection[]": {
	  //         required: true,
	  //         minlength: 1
	  //         }
	  
    },
    messages: {
      "first_name": {
        minlength: "Name must be at least 3 characters.",
        maxlength: "Name must not exceed 50 characters."
      }
    }
  });
};

validateNewLeagueForm = function(el){
  $(el).validate({
    rules: {
      "league[name]": {
        required: true,
        minlength: 3,
        maxlength: 50
      },
	  
      "league[sport]": {
        required: true,
        minlength: 3,
        maxlength: 50
      },
	  
      "league[state]": {
        required: true,
        minlength: 3,
        maxlength: 50
      },
	  
      "league[description]": {
        required: true,
        minlength: 3,
        maxlength: 50
      },
    messages: {
      "league[name]": {
        minlength: "Name must be at least 3 characters.",
        maxlength: "Name must not exceed 50 characters."
      }
    }
  }
 });
};

validateCertificationForm = function(el){
  $(el).validate({
    rules: {
      "certification[name]": {
        required: true,
        minlength: 3,
        maxlength: 50
      },

      "certification[issuer]": {
        required: true,
        minlength: 3,
        maxlength: 50
      }
    },
    messages: {
      "certification[name]": {
        minlength: "Name must be at least 3 characters.",
        maxlength: "Name must not exceed 50 characters."
      }
    }
  });
};


validateNewSchoolForm = function(el){
  $(el).validate({
    rules: {
      "school[name]": {
        required: true,
        minlength: 3,
        maxlength: 50
      },
      "school[classification]": {
        required: true,
      },
      "school[abbreviation]": {
        required: true
      },
      "school[address_1]": {
        required: true
      },
      "school[city]": {
        required: true
      },
      "school[state]": {
        required: true
      },
      "school[zip]": {
        required: true
      },
      "school[website]": {
        required: true
      }
    },
    messages: {
      "school[name]": {
        minlength: "Name must be at least 3 characters.",
        maxlength: "Name must not exceed 50 characters."
      }
    }
  });
};

validateNewEventForm = function(el){
  $(el).validate({
    rules: {
      "event[title]": {
        required: true,
        minlength: 3,
        maxlength: 50
      },
      "event[event_type]": {
        required: true,
      },
      "event[description]": {
        required: true
      },
      "event[start_date]": {
        required: true
      },
      "event[end_date]": {
        required: true
      },
      "event[facility_ids]": {
        required: true
      }
    },
    messages: {
      "event[title]": {
        minlength: "Name must be at least 3 characters.",
        maxlength: "Name must not exceed 50 characters."
      }
    }
  });
};

























validateContactMessageForm = function(el){
  $(el).validate({
    rules: {
      "contact_message[name]": {
        required: true,
        minlength: 2,
		  maxlength: 50
      },
      "contact_message[email]": {
        required: true,
        minlength: 2,
		  maxlength: 50
      },
      "contact_message[message]": {
        required: true,
        minlength: 2,
		  maxlength: 1000
      }
    }
  });
};

validateContestForm = function(el){
  $(el).validate({
    rules: {
      "contest[title]": {
        required: true,
        minlength: 10
      },
      "contest[description]": {
        required: true,
        minlength: 20
      },
      "contest[prize]": {
        required: true,
		  minlength: 5
      },
      "contest[slug]": {
        required: true,
		minlength: 10
      },
      "contest[start_date]": {
        required: true
      },
      "contest[end_date]": {
        required: true
      }
    }
  });
};

validateSpaOfferForm = function(el){
  $(el).validate({
    rules: {
      "spa_offer[title]": {
        required: true,
        minlength: 10,
        maxlength: 100
      },
      "spa_offer[offer]": {
        required: true,
        minlength: 10,
        maxlength: 255
      }
    }
  });
};

validateSpaContactMessageReply = function(el){
  $(el).validate({
    rules: {
      "comment[comment]": {
        required: true,
        minlength: 2,
        maxlength: 20
      }
    }
  });
};


validatePartnerSignupForm = function(el){
  $(el).validate({
    rules: {
      "user[first_name]": {
        required: true,
        minlength: 2,
        maxlength: 20
      },
      "user[last_name]": {
        required: true,
        minlength: 2,
        maxlength: 20
      },
      "user[email]": {
        required: true,
        email: true,
        uniqueEmail: true
      },
      "user[password]": {
        required: true
      },
      "user[password_confirmation]": {
        required: true,
        equalTo: "#user_password"
      },
      "user[spa_ids]": {
        required: true
      },
      "user[business_email]": {
        required: true,
        email: true
      },
      "user[title]": {
        required: true
      },
      "user[business_phone]": {
        required: true,
        number: true,
        exactLength: 10
      }
    },
    messages: {
      "user[password_confirmation]": {
        equalTo: "Password doesn't match"
      },
      "user[email]": {
        uniqueEmail: "This email has been already been registered."
      },
      "user[firstname]": {
        minlength: "First Name must be at least 2 characters.",
        maxlength: "First Name must not exceed 20 characters."
      },
      "user[lastname]": {
        minlength: "Last Name must be at least 2 characters.",
        maxlength: "Last Name must not exceed 20 characters."
      }
    }
  });
};


validateCommentForm = function(el){
  $(el).validate({
    rules: {
      "comment[comment]": {
        required: true,
        minlength: 10
      }
    },
    messages: {
      "comment[comment]": {
        minlength: "Comment must be at least 10 characters."
      }
    }
  });
};

validateTreatmentForm = function(el){
  $(el).validate({
    rules: {}
  });
  addTreatmentValidation();
};

addTreatmentValidation = function(){
  $('.treatment-field:not(.init-validate)').each(function(){
    $(this).find('.treatment-name').rules("add", {required: true});
    $(this).addClass('init-validate');
  });
};

validateDealForm = function(el){
  $(el).validate({
    ignore: [],
    rules: {
      "option_count": {
        min: 1
      },
      "spa_deal[name]": {
        required: true
      },
      "spa_package[name]": {
        required: true
      },
      "spa_deal[number_available]": {
        required: true,
        number: true,
        min: 6
      },
      "spa_deal[start_date]": {
        required: true
      },
      "spa_deal[end_date]": {
        required: true,
        greaterThan: [".start_date input","spa_deal[start_date]"],
        limitDateRange: [".start_date input", 10]
      },
      "overnight_deal[name]": {
        required: true
      },
      "overnight_package[name]": {
        required: true
      },
      "overnight_deal[number_available]": {
        required: true,
        number: true,
        min: 6
      },
      "overnight_deal[start_date]": {
        required: true
      },
      "overnight_deal[end_date]": {
        required: true,
        greaterThan: [".start_date input","overnight_deal[start_date]"],
        limitDateRange: [".start_date input", 10]
      },
      "spa_deal[pitch]": {
        maxlength: 255
      },
      "spa_package[pitch]": {
        maxlength: 255
      },
      "overnight_deal[pitch]": {
        maxlength: 255
      },
      "overnight_package[pitch]": {
        maxlength: 255
      }
    },
    messages: {
      "option_count": {
        min: "Option can't be blank"
      },
      "spa_deal[start_date]": {
        required: "Start date field must be filled in."
      },
      "spa_deal[end_date]": {
        required: "End date field must be filled in.",
        greaterThan: "End date must be after start date",
        limitDateRange: "Maximum deal length is 10 days."
      },
      "overnight_deal[start_date]": {
        required: "Start date field must be filled in."
      },
      "overnight_deal[end_date]": {
        required: "End date field must be filled in.",
        greaterThan: "End date must be after start date",
        limitDateRange: "Maximum deal length is 10 days."
      }
    },
    errorPlacement: function(error, el){
      if(el.attr("name") == "spa_deal[start_date]" || el.attr("name") == "overnight_deal[start_date]"){
        $('#start-date-error-div').empty();
        $('#start-date-error-div').append(error);
      }else
      if(el.attr("name") == "spa_deal[end_date]" || el.attr("name") == "overnight_deal[end_date]"){
        $('#end-date-error-div').empty();
        $('#end-date-error-div').append(error);
      }else {
        error.insertAfter(el);
      }
    }
  });
  addOptionValidation();
};

addOptionValidation = function(){
  $('.option-field:not(.init-validate)').each(function(){
    $(this).find('.option-price').rules("add", {required: true});
    $(this).find('.original-price').rules("add", {required: true});
    $(this).find('.option-option').rules("add", {required: true});
    $(this).addClass('init-validate');
  });
};

addWhyGreatValidation = function(){
  $('.why-its-great-field:not(.init-validate)').each(function(){
    $(this).find('.why-its-great-content').rules("add", {required: true});
    $(this).addClass('init-validate');
  });
};

validateSpaReviewForm = function(el){
  $(el).validate({
    ignore: '[name="score"]',
    rules: {
      "spa_review[overall_review]": {
        required: true
      },
      "spa_review[star_rating]": {
        required: true
      },
      "spa_review[guestrooms_rating]": {
        required: true
      },
      "spa_review[customer_service_rating]": {
        required: true
      },
      "spa_review[location_and_setting_rating]": {
        required: true
      },
      "spa_review[cleanliness_rating]": {
        required: true
      },
      "spa_review[food_and_dining_rating]": {
        required: true
      },
      "spa_review[amenities_rating]": {
        required: true
      },
      "spa_review[gym_and_fitness_facilities_rating]": {
        required: true
      },
      "spa_review[spa_facilities_rating]": {
        required: true
      },
      "spa_review[spa_menu_rating]": {
        required: true
      },
      "spa_review[knowledge_of_staff_rating]": {
        required: true
      },
      "spa_review[quality_of_service_rating]": {
        required: true
      },
      "spa_review[spa_products_rating]": {
        required: true
      },
      "spa_review[date_of_trip(2i)]": {
        required: true
      },
      "spa_review[date_of_trip(1i)]": {
        required: true
      },
      "spa_review[length_of_trip]": {
        required: true
      },
      "spa_review[reason_for_trip]": {
        required: true
      },
      "spa_review[highlight]": {
        required: true
      },
      "spa_review[tips_for_room_selection]": {
        required: true
      },
      "spa_review[additional_comments]": {
        required: true
      },
      "spa_review[review_title]": {
        required: true
      }    },
    errorPlacement: function(error, el){
      if(el.attr("name") == "spa_review[date_of_trip(2i)]" || el.attr("name") == "spa_review[date_of_trip(1i)]"){
        $('#date-of-trip-error-div').empty();
        $('#date-of-trip-error-div').append(error);
      }else
      if(el.attr("name") == "spa_review[companions_for_trip]"){
        $('#companions-for-trip-error-div').empty();
        $('#companions-for-trip-error-div').append(error);
      }else
      if(el.attr("name") == "spa_review[weather_during_trip][]"){
        $('#weather_during_trip-error-div').empty();
        $('#weather_during_trip-error-div').append(error);
      }else
      if(el.attr("name") == "spa_review[venue_value_evaluation]"){
        $('#venue_value_evaluation_error_div').empty();
        $('#venue_value_evaluation_error_div').append(error);
      }else
      if(el.attr("name") == "spa_review[spa_value_evaluation]") {
        $('#spa_value_evaluation_error_div').empty();
        $('#spa_value_evaluation_error_div').append(error);
      }else
      if(el.attr("name") == "spa_review[estimated_spend]") {
        $('#estimated_spend_error_div').empty();
        $('#estimated_spend_error_div').append(error);
      }else
      if(el.attr("name") == "spa_review[would_recommend]") {
        $('#would_recommend_error_div').empty();
        $('#would_recommend_error_div').append(error);
      }else
      if(el.attr("name") == "spa_review[would_return]") {
        $('#would_return_error_div').empty();
        $('#would_return_error_div').append(error);
      }else{
        error.insertAfter(el);
      }
    }
  });
  $(el).find('input').each(function(){
    $(this).rules("add", {required: true});
  });
};


validateSpaEditForm = function(el){
  $(el).validate({
    rules: {
      "spa[venue_name]": {
        required: true
      },
      "spa[spa_name]": {
        required: true
      },
      "spa[street_address]": {
        required: true
      },
      "spa[city]": {
        required: true
      },
      "spa[state]": {
        required: true
      },
      "spa[zip_code]": {
        required: true,
        number: true,
		exactLength: 5
      },
      "spa[country]": {
        required: true
      },
      "spa[spa_phone_number]": {
        required: true,
        number: true,
        exactLength: 10
      },
      "spa[venue_phone_number]": {
        required: true,
        number: true,
        exactLength: 10
      },
      "spa[numberof_overnight_guestrooms]": {
        number: true,
      },
      "spa[numberof_suites]": {
        number: true,
      },
      "spa[numberof_spa_packages]": {
        number: true,
      },
      "spa[lowest_cost_accommodation]": {
        number: true,
      },
      "spa[estimated_costfor7_day_stay]": {
        number: true,
      },
      "spa[estimated_costfor5_day_stay]": {
        number: true,
      },
      "spa[estimated_costfora_weekend_stay]": {
        number: true,
      },
      "spa[numberof_spa_treatment_rooms]": {
        number: true,
      },
      "spa[maximum_spa_occupancy]": {
        number: true,
      },
      "spa[sizeof_spa_sqft]": {
        number: true,
      },
      "spa[no_of_spa_staff]": {
        number: true,
      }
	}

  });
};