/**
  * psyCarousel
  *
  * A carousel plugin for `<article>`s. Expects barebones markup, a block-level element with a series of `<article>` elements as children. It adds left and right arrows that 
  * stick to either side of the page and cycle through each `<article>` left-to-right or right-to-left, endlessly. When JavaScript is disabled, the `<article>`s should be 
  * displayed like normal block elements, but if psyCarousel() is invoked on the container and JavaScript is available, it will change the styles of each object to fit its
  * needs. Some styles have been hard-set in the app/models/_post.scss stylesheet.
  *
  * @author Tom Scott <http://psychedeli.ca/>
  */
(function($) {
	var PsyCarousel = function(element) {
		var self, posts;
		
		/**
		  * Sets up the carousel
		  *
		  * @param {jQuery} obj - the jQuery object that this carousel is being applied to.
		  */
		this.init = function(obj) {
			self = obj;
			self.data('carousel', this);
			
			posts = {
				collection: self.find('article'),
				index: 0,
				active: false
			};
			
			posts.collection.css({
				display:'none',
				height: '660px'
			});
			
			posts.collection.find('section').css({
				minHeight: '0',
				height: '529px',
				margin: '0'
			});
			
			// active post is the only one shown
			posts.active = posts.collection.first();
			posts.active.css({
				display: 'block',
				marginLeft: ($(window).width()-posts.active.width()-(posts.active.width()/2))-10
			}).addClass('active');
			
			var leftMargin = parseInt(posts.active.css('margin-left').split('px').join(''));
			
			if (leftMargin < 0) {
				posts.active.css('margin-left', '64px');
			}
			
			$('body').css('overflow', 'hidden');
		};
		
		/**
		  * Retrieves the active post.
		  */
		this.getActivePost = function() {
			return posts.active;
		};
		
		/**
		  * Retrieves all posts.
		  */
		this.getAllPosts = function() {
			return posts;
		};
		
		/**
		  * Goes to a specific index in the carousel array.
		  *
		  * @private
		  */
		function goTo(newIndex) {
			posts.collection = self.find('article');
			
			if (newIndex >= posts.collection.length) {
				posts.index = 0;
			} else if (newIndex < 0) {
				posts.index = posts.collection.length;
			} else {
				posts.index = newIndex;
			}
			
			return $(posts.collection[posts.index]);
		};
		
		/**
		  * Iterates to the next item in the carousel.
		  *
		  * @param {Object} event - passed through by jQuery.click
		  * @returns the <article> for the next post in the carousel
		  */
		this.next = function(event) {	
			var nextIndex = posts.index+1;
			
			var nextPost = goTo(nextIndex);
			var currPost = posts.active;
			var currMargin = parseInt(currPost.css('margin-left').split('px').join(''));
			var currWidth = posts.active.width();
			
			nextPost.show();
			
			nextPost.animate({marginLeft: currMargin});
			currPost.animate({marginLeft: Math.abs(currMargin+currWidth+$(window).width()) }, function() {
				currPost.css({display:'none'});
			});
			
			posts.collection.removeClass('active');
			posts.active = nextPost;
			posts.active.css({
				display: 'block',
				marginLeft: $(window).width()-posts.active.width()-(posts.active.width()/2)
			}).addClass('active');
			
			event.preventDefault();
		};
		
		/**
		  * Backtracks to the previous item in the carousel.
		  */
		this.prev = function(event) {
			var nextIndex = posts.index-1;
			
			var prevPost = goTo(nextIndex);
			var currPost = posts.active;
			var currMargin = parseInt(currPost.css('margin-left').split('px').join(''));
			var currWidth = currPost.width();
			
			currPost.animate({marginLeft: currMargin+currWidth+$(window).width() });
			prevPost.animate({marginLeft: '64px'});
			
			event.preventDefault();
		};
		
		this.init(element);
	};
	
	/*
	 * Runtime, jQuery binding.
	 */
	$.fn.psyCarousel = function() {
		return this.each(function() {
			var self = $(this);
			
			// instantiate the PsyCarousel
			var carousel = new PsyCarousel(self);
			
			// cache it in HTML
			self.data('carousel', carousel);
			
			// make style changes
			self.css({ width: '2000px', height: '650px' })
				.find('article').css({ float: 'left', display: 'inline-block' });
			
			// enable the arrows if JS is enabled
			$('<div class="left arrow">&laquo;</div>, <div class="right arrow">&raquo;</div>').prependTo('#posts').show();
			
			// bind events
			self.find('.left.arrow').click(carousel.prev);
			self.find('.right.arrow').click(carousel.next)
									 .css({ right: self.width()-$(window).width() });
			
			$(window).resize(function() {
				self.find('.right.arrow').css({
					right: self.width()-$(window).width()
				});
				
				carousel.activePost = carousel.getActivePost();
				
				var pos = ($(window).width()-carousel.activePost.width())/2;
				carousel.activePost.css({ margin: '0px 0px 0px '+pos+'px' });
			});
			
			self;
		});
	};
})(jQuery)