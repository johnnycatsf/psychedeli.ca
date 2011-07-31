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
			
			posts.collection.css({display:'none'});
			posts.collection.first().show().animate({left: '0px'});
			
			posts.active = posts.collection.first();
		};
		
		/**
		  * Goes to a specific index in the carousel array.
		  *
		  * @private
		  */
		function goTo(newIndex) {
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
			
			nextPost.show();
			
			/*currPost.animate({left:'-810px'}, function() {
				currPost.hide();
			});*/
			
			//nextPost.show().animate({left: '64px'});
			
			//posts.active = nextPost;
			
			event.preventDefault();
		};
		
		/**
		  * Backtracks to the previous item in the carousel.
		  */
		this.prev = function(event) {
			var nextIndex = posts.index-1;
			
			var prevPost = goTo(nextIndex);
			var currPost = posts.active;
			
			prevPost.hide('slide');
			currPost.show('slide');
			
			posts.active = prevPost;
			
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
			
			$('body > section').css('height', '640px');
			
			// enable the arrows if JS is enabled
			$('.left.arrow, .right.arrow').show();
			
			// bind events
			self.find('.left.arrow').click(carousel.prev);
			self.find('.right.arrow').click(carousel.next);
		});
	};
})(jQuery)