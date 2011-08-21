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
						'jquery',
						'vendor/jquery-ui', 
						'vendor/plugins/jquery.facebox', 
						'vendor/plugins/jquery.linkifyTags', 
						'vendor/plugins/jquery.jScrollPane',
						'vendor/plugins/jquery.mousewheel',
						'vendor/plugins/mwheelIntent',
						'vendor/plugins/pretty'
					];
require(dependencies, function($) {
	var backbone = [
		'vendor/underscore', 
		'vendor/backbone'
	];
	
	require(backbone, function() {
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
	});
});