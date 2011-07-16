require(['jquery', 'vendor/underscore', 'vendor/backbone'], function($) {
	$(document).ready(function() {
		// Internet Explorer warning.
		if ($.browser.msie && parseInt($.browser.version) > 9) {
			alert('Update to IE 9 to view this site properly.');
		}
	});
});