var ComingSoon = {

	bgImage: function () {
		$('body').backstretch([
			'http://www.download-hd-wallpapers.com/wp-content/uploads/2014/08/sports-backgrounds-for-pictures.jpg'
		]);
	},

	countDown: function () {
		$('#countdown').countdown('2015/04/13 00:00:00').on('update.countdown', function(event) {
			var $this = $(this).html(event.strftime(''
				+ '<ul class="countdown-container">'
				+ '<li><span>Day%!d<span><div class="number">%-D</div></li>'
				+ '<li><span>Hours</span><div class="number">%H</div></li>'
				+ '<li><span>Minutes</span><div class="number">%M</div></li>'
				+ '<li><span>Seconds</span><div class="number">%S</div></li>'
				+ '</ul>'
			));
		});
	},

	init: function () {
		this.bgImage();
		this.countDown();
	}
}




