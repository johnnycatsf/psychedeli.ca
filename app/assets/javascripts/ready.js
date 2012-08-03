// DOM ready events
$(document).ready(function() {
  // TODO: Add Modernizr check for IE6, if so don't load Facebox.
  $('a[rel=modal]').facebox({
		closeImage: 'assets/closelabel.png',
		loadingImage: 'assets/loading.gif'
	});

	$('article .tags').linkifyTags();
});
