// DOM ready events
$(document).ready(function() {
	/*$('a[rel=modal]').facebox({
		closeImage: 'assets/closelabel.png',
		loadingImage: 'assets/loading.gif'
	});*/

	$('article .tags').linkifyTags();
});
