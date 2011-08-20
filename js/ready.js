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
	/**
	  * Main application definition.
	  */ 
	var Psychedelica = Backbone.View.extend({
		el: $(document),
		
		/**
		  * Alters the page title and creates an ArticleCarousel which takes all of the <article>s in #posts and turns them into a stepwise carousel that's activated
		  * by click, touch and keyboard. Executed on the DOM ready, when this app is "launched".
		  *
		  * @constructor
		  */
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
			
			// Carousel for browsers that support JavaScript
			if ($('#posts').length > 0) {
				var carousel = new ArticleCarousel({
					el: $('#posts'),
					articles: $('#posts article')
				});
			}
		}
	});
	
	// Load the app on DOM ready
	$(document).ready(function() {
		var app = new Psychedelica();
	});
});