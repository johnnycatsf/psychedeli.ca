// DOM ready events
$(document).ready(function() {
	$('a[rel=modal]').facebox({
		closeImage: 'img/closelabel.png',
		loadingImage: 'img/loading.gif'
	});
	
	$('#ticker').ticker({
		twitter: {
			handle: '', 
			access: '',
			secret: ''
		},
		facebook: {
			app: {
				id: '312961995386557',
				secret: '53bdfdf81b47b9a96f0d9f123a5bf643'
			},
			usr: {
				token: 'AAAEcoySQLr0BAP1aiOmPw1dFAwRlZA8B9oMVCF6KT2FZAGmbnJRHcfjPNDgRfU0xgdVKOBoviREvJYGyBace4ZCZA49jsXxpYgLCCWNjgDhYfZAHfw5xz'
			}
		},
		github: {
			api_key: ''
		},
		soundcloud: {
			access: '44ff5475533b191d5e556e90a5445ced',
			secret: '8fd5add2d75e5bb461567b8b4bf7b4ff'
		}
	});
	
	$('.tags a').linkifyTags();
});