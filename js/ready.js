/**
  * Main JavaScript runtime. Includes the Backbone.js MVC framework, utility libraries jQuery and Underscore.js, and all external JavaScript plugins. Binds site-wide
  * actions and runs browser-specific initialization code (for IE 6/7/8 and mobile browsers).
  */
require(['jquery', 'vendor/underscore', 'vendor/backbone'], function($) {
	//'app/models/post'
	$(document).ready(function() {
		// Page title helper
		var pageTitle = $('title').html();
		if (pageTitle != 'psychedeli.ca') {
			$('title').html(pageTitle+' | psychedeli.ca');
		}
		
		// Tags helper
		$('.tags').each(function() {
			var tagsArr = $(this).html().split(',');
			
			var tags='';
			
			_.each(tagsArr, function(tag) {
				tags += '<a href="http://twitter.com/#!/search/'+tag+'">#'+tag+'</a>';
			});
			
			$(this).html(tags);
		});
		
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
		
		/*
		// instantiate each <article> as a Post
		_.each($('#posts > article'), function(article) {
			var p = new Post({
				title: article.find('header > h1').text(),
				category: article.find('footer > .category').text(),
				body: article.find('section').html(),
				created_on: article.find('footer > p > time').data('ymd'),
				created_at: article.find('footer > p > time').data('hms'),
				element: article
			});
		});
		*/
	});
});