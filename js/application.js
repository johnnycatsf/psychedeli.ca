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

// grab a variable from GET params
function GET(name) {
	name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
	var regexS = "[\\?&]"+name+"=([^&#]*)";
	var regex = new RegExp( regexS );
	var results = regex.exec( window.location.href );

	if (results == null) {
		return "";
	} else {
		return results[1];
	}
}

var dependencies = [
						'jquery',
						'lib/jquery-ui',
						'lib/plugins/pretty'
					];
require(dependencies, function($) {
	// // Page title helper
	// var pageTitle = $('title').html();
	// if (pageTitle != 'psychedeli.ca') {
	// 	$('title').html(pageTitle+' | psychedeli.ca');
	// }

	// Tags helper
	//$('.tags').linkifyTags();

	// Modal dialog helper (comments)
	$('a[rel=modal]').facebox({
		closeImage: 'img/closelabel.png',
		loadingImage: 'img/loading.gif'
	});
});