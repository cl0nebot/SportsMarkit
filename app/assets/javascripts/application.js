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
//= require jquery-ui

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

//= require pleasure/globals/plugins/video.js/dist/video-js/video
//= require pleasure/globals/plugins/video.js/plugins/playlist/videojs-playlists.min
//= require pleasure/globals/plugins/video.js/plugins/youtube/youtube


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

//= require moment
//= require fullcalendar
//= require ./full_calendar
//= require gmaps4rails/gmaps4rails.base
//= require gmaps4rails/gmaps4rails.googlemaps
//= require best_in_place
//= require ./ready
//= require parsley
//= require jquery.cropit
//= require schools
//= require hamlcoffee
//= require_tree ./templates
	

	

	$(document).click(function(event) {
		var ClickedVariable = $(event.target).text();
		if (ClickedVariable == "Upload Media") {
			$('#media-page').load(document.URL +  ' #media-page');
		}		
	});
	
	$(document).click(function(event) {
		var ClickedVariable = $(event.target).text();
		if (ClickedVariable == "Media") {
			$('#load-masonry').load(document.URL +  ' #load-masonry');
		}		
	});
	
	$(document).click(function(event) {
		var ClickedVariable = $(event.target).text();
		if (ClickedVariable == "About") {
			$('#masonry-about-tab').load(document.URL +  ' #masonry-about-tab');
		}		
	});
	

