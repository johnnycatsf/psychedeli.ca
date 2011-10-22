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

// DOM ready events
$(document).ready(function() {
	$('a[rel=modal]').facebox({
		closeImage: 'img/closelabel.png',
		loadingImage: 'img/loading.gif'
	});
})