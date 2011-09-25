/**
  * Main JavaScript runtime. Includes the Backbone.js MVC framework, utility libraries jQuery and 
  * Underscore.js, and all external JavaScript plugins. Binds site-wide actions and runs browser-
  * specific initialization code (for IE 6/7/8 and mobile browsers).
  *
  * @author Tom Scott
  */

// Prototypal inheritance
if (typeof Object.create !== 'function') {
	Object.create = function(o) {
		function F() {}
		F.prototype = o;
		return new F();
	};
}

var dependencies = [
						'lib/jquery-ui',
						'lib/underscore', 
						'lib/backbone', 
						'lib/plugins/jquery.facebox', 
						'lib/plugins/jquery.linkifyTags', 
						'lib/plugins/jquery.jScrollPane',
						'lib/plugins/jquery.mousewheel',
						'lib/plugins/pretty',
						'app/models/post.js',
						'app/collections/carousel.js',
						'app/views/article_carousel.js',
						'lib/jasmine',
						'lib/jasmine-html',
						'spec/models/post_spec.js',
						'spec/collections/carousel_spec.js',
						'spec/views/article_carousel_spec.js'
					];
require(dependencies, function($) {
	// Execute Jasmine tests
	var jasmineEnv = jasmine.getEnv();
	jasmineEnv.updateInterval = 1000;

	var trivialReporter = new jasmine.TrivialReporter();

	jasmineEnv.addReporter(trivialReporter);

	jasmineEnv.specFilter = function(spec) {
		return trivialReporter.specFilter(spec);
	};

	var currentWindowOnload = window.onload;

	/*if (currentWindowOnload) {
		currentWindowOnload();
	}*/
	
	jasmineEnv.execute();
	
	/*
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
			el: $('#posts')
		});
	}
	*/
});