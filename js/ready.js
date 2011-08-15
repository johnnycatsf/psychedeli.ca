// Prototypal inheritance
if (typeof Object.create !== 'function') {
	Object.create = function(o) {
		function F() {}
		F.prototype = o;
		return new F();
	};
}

/**
  * Main JavaScript runtime. Includes the Backbone.js MVC framework, utility libraries jQuery and Underscore.js, and all external JavaScript plugins. Binds site-wide
  * actions and runs browser-specific initialization code (for IE 6/7/8 and mobile browsers).
  */
var dependencies = [
						'jquery', 
						'vendor/jquery-ui',
						'vendor/underscore', 
						'vendor/backbone', 
						'vendor/plugins/jquery.facebox', 
						'vendor/plugins/jquery.linkifyTags', 
						'vendor/plugins/jquery.jScrollPane',
						'vendor/plugins/jquery.mousewheel',
						'vendor/plugins/jquery.articleCarousel',
						'vendor/plugins/pretty'
					];
require(dependencies, function($) {
	var AppView = Backbone.View.extend({
		el: $(document),
		
		initialize: function() {
			// Page title helper
			var pageTitle = $('title').html();
			if (pageTitle != 'psychedeli.ca') {
				$('title').html(pageTitle+' | psychedeli.ca');
			}

			// Tags helper
			$('.tags').linkifyTags();

			// Modal dialog helper (comments)
			$('a[rel=modal]').facebox({
				closeImage: 'img/closelabel.png',
				loadingImage: 'img/loading.gif'
			});

			// Custom scrollbars
			$('article section').jScrollPane();

			// Special browser handling
			var page = $('body');
			switch (true) {
				// Anyone under IE 9 gets a warning
				case (page.hasClass('ie') && !page.hasClass('ie9')):
					alert('Update to IE 9 to view this site properly.');
					break;

				// Mobile devices get special touch actions (like swiping)
				case (page.hasClass('ios') || page.hasClass('android')):
					require(['vendor/jquery-mobile'], function($) {
						var postsCarousel = $('#posts').data('carousel');

						$('#posts').bind('swipeleft', postsCarousel.next)
								   .bind('swiperight', postsCarousel.prev);
					});
					break;
			}
		}
	});
});