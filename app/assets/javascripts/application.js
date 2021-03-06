// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require jquery-ui
//= require validation
//= require jquery.remotipart
//= require validator
//= require moment
//= require bootstrap-notify


// <!-- BEGIN GLOBAL AND THEME VENDORS -->
//= require pleasure/globals/js/global-vendors

// <!-- BEGIN PLUGINS AREA -->
//= require pleasure/globals/plugins/masonry/dist/masonry.pkgd.min
//= require pleasure/globals/plugins/blueimp-gallery/js/jquery.blueimp-gallery.min
//= require pleasure/globals/plugins/blueimp-bootstrap-image-gallery/js/bootstrap-image-gallery.min

//= require pleasure/globals/plugins/datatables/media/js/jquery.dataTables.min
//= require pleasure/globals/plugins/datatables/themes/bootstrap/dataTables.bootstrap


//= require pleasure/globals/plugins/bootstrap-maxlength/bootstrap-maxlength.js

//= require pleasure/globals/plugins/selectize/dist/js/standalone/selectize.js

//= require pleasure/globals/plugins/strength/strength.min
//= require pleasure/globals/plugins/Jcrop/js/jquery.Jcrop.js
//= require pleasure/globals/scripts/forms-jcrop
//= require pleasure/globals/plugins/indicator/indicator
//= require pleasure/globals/plugins/pwstrength-bootstrap/dist/pwstrength-bootstrap-1.2.2.min
//= require pleasure/globals/plugins/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min
//= require pleasure/globals/plugins/jquery.inputmask/dist/jquery.inputmask.bundle
//= require pleasure/globals/plugins/ipmask/jquery.input-ip-address-control.min

//= require pleasure/globals/plugins/jquery.payment/lib/jquery.payment

//= require pleasure/globals/plugins/typehead.js/dist/typeahead.bundle.min
//= require pleasure/globals/plugins/overlay/jquery.overlay
//= require pleasure/globals/plugins/jquery-textcomplete/dist/jquery.textcomplete.min


//= require pleasure/globals/plugins/ubilabs-geocomplete/jquery.geocomplete.min


//= require pleasure/globals/plugins/minicolors/jquery.minicolors.min
//= require pleasure/globals/plugins/bootstrap-daterangepicker/daterangepicker


//= require pleasure/globals/plugins/chosen/chosen.jquery.min
//= require pleasure/globals/plugins/selectize/dist/js/standalone/selectize.min
//= require pleasure/globals/plugins/multiselect/js/jquery.multi-select
//= require pleasure/globals/plugins/quicksearch/dist/jquery.quicksearch.min
//= require pleasure/globals/plugins/bootstrap-select/dist/js/bootstrap-select.min


//= require pleasure/globals/plugins/jquery-backstretch/jquery.backstretch.min
//= require pleasure/globals/plugins/jquery.countdown/dist/jquery.countdown.min

//= require pleasure/globals/plugins/jasny-bootstrap/dist/js/jasny-bootstrap.min

//= require pleasure/globals/plugins/jquery-validation/dist/jquery.validate.min
//= require pleasure/globals/plugins/twitter-bootstrap-wizard/jquery.bootstrap.wizard.min

//= require pleasure/globals/plugins/handlebars/handlebars.min

//= require pleasure/globals/plugins/strength/strength.min
//= require pleasure/globals/plugins/indicator/indicator
//= require pleasure/globals/plugins/pwstrength-bootstrap/dist/pwstrength-bootstrap-1.2.2.min
//= require pleasure/globals/plugins/bootstrap-maxlength/bootstrap-maxlength.min
//= require pleasure/globals/plugins/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min
//= require pleasure/globals/plugins/jquery.inputmask/dist/jquery.inputmask.bundle
//= require pleasure/globals/plugins/ipmask/jquery.input-ip-address-control.min

//= require pleasure/globals/plugins/jquery.payment/lib/jquery.payment

//= require pleasure/globals/plugins/typehead.js/dist/typeahead.bundle.min
//= require pleasure/globals/plugins/overlay/jquery.overlay
//= require pleasure/globals/plugins/jquery-textcomplete/dist/jquery.textcomplete.min
//= require pleasure/globals/plugins/ubilabs-geocomplete/jquery.geocomplete.min

//= require pleasure/globals/plugins/isotope.pkgd.min
//= require pleasure/globals/plugins/isotope-docs.min

//= require pleasure/globals/plugins/jquery.flexselect-0.7.0/jquery.flexselect
//= require pleasure/globals/plugins/jquery.flexselect-0.7.0/liquidmetal




//= require imagesloaded.pkgd.js

// <!-- PLUGINS INITIALIZATION AND SETTINGS -->
//= require pleasure/globals/scripts/user-pages
//= require pleasure/globals/scripts/tables-datatables
//= require pleasure/globals/scripts/forms-tools
//= require pleasure/globals/scripts/forms-pickers
//= require pleasure/globals/scripts/forms-select
//= require pleasure/globals/scripts/coming-soon
//= require pleasure/globals/scripts/forms-wizard
//= require pleasure/globals/scripts/widget-video


// <!-- PLEASURE -->
//= require pleasure/globals/js/pleasure

// <!-- ADMIN 1 -->
//= require pleasure/admin/js/layout

//= require pleasure/globals/plugins/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min
//= require pleasure/globals/plugins/underscore/underscore-min
//= require pleasure/globals/plugins/bootstrap-calendar/js/calendar
//= require fullcalendar
//= require ./full_calendar
//= require gmaps4rails/gmaps4rails.base
//= require gmaps4rails/gmaps4rails.googlemaps
//= require best_in_place
//= require parsley
//= require jquery.cropit
//= require schools
//= require forms
//= require ./ready
//= require registrations
//= require hamlcoffee
//= require event_form
//= require bank_account
//= require events_calendar
//= require_tree ./templates
//= require ./notify
//= require ./formbuilder1/1vendor
//= require ./formbuilder1/src/scripts/main
//= require_directory ./formbuilder1/src/scripts/fields

//= require form_build_init

$(document).click(function(event) {
  var ClickedVariable = $.trim($(event.target).text());
  if (ClickedVariable == "Media") {
    $('#load-masonry').load(document.URL +  ' #load-masonry');
  }
  if (ClickedVariable == "Upload Media") {
    $('#media-page').load(document.URL +  ' #media-page');
  }
  if (ClickedVariable == "About") {
    $('#masonry-about-tab').load(document.URL +  ' #masonry-about-tab');
  }
});


window.FileValidation = function () {
  $('.file-field, #file-field').on('change.bs.fileinput', function() {
    var whitelist = $(this).data('whitelist');
    var ext = $(this).val().split('.').pop().toLowerCase();
    var extensionisgood = (whitelist.indexOf(ext) > -1);
    if (extensionisgood) {
      $(this).parents('form').find('input[type="submit"]').removeAttr('disabled');
      $(this).parents('form').find('#invalid-message').hide();

    } else {
      $(this).parents('form').find('input[type="submit"]').attr('disabled', true);
      $(this).val("")
      $(this).parents('form').find('#invalid-message').css({ display: "block" });
    }
  });
};

$(document).ready(function() {
  window.FileValidation();
});

$(function() {
  return $('#school-pricings-search-box').keyup(function() {
    $.get($(this).attr("action"), $(this).serialize(), null, "script");
    return false;
  });
});

$(function(){
  $(".bootstrap-datepicker").datetimepicker({
    format: 'MM/DD/YYYY',
    pickTime: false,
    minDate: moment(),
    maxDate: moment().add(1, "year").toDate()
  });
});



