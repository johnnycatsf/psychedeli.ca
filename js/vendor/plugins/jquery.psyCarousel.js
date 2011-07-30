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
				active: $('article:first')
			};
		};
		
		/**
		  * Goes to a specific index in the carousel array.
		  *
		  * @private
		  */
		function goTo(newIndex) {
			posts.index = newIndex;
			return posts.collection[posts.index];
		};
		
		/**
		  * Iterates to the next item in the carousel.
		  *
		  * @param {Object} event - passed through by jQuery.click
		  * @returns the <article> for the next post in the carousel
		  */
		this.next = function(event) {
			console.log('next');
			return goTo(posts.index++);
		};
		
		/**
		  * Backtracks to the previous item in the carousel.
		  */
		this.prev = function(event) {
			console.log('prev');
			return goTo(posts.index--);
		};
		
		this.init(element);
	};
	
	/*
	 * Runtime, jQuery binding.
	 */
	$.fn.psyCarousel = function() {
		return this.each(function() {
			var self = $(this);
			
			console.log(self);
			
			// instantiate the PsyCarousel
			var carousel = new PsyCarousel(self);
			
			// cache it in HTML
			self.data('carousel', carousel);
			
			// enable the arrows if JS is enabled
			$('.left.arrow, .right.arrow').show();
			
			// bind events
			self.find('.left.arrow').click(carousel.prev);
			self.find('.right.arrow').click(carousel.next);
		});
	};
})(jQuery)