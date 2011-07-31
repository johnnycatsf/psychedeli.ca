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
				display:'none'
			});
			
			posts.active = posts.collection.first();
			posts.active.css({
				display: 'block',
				marginLeft: $(window).width()-posts.active.width()-(posts.active.width()/2)
			}).addClass('active');
			
			var leftMargin = parseInt(posts.active.css('margin-left').split('px').join(''));
			
			if (leftMargin < 0) {
				posts.active.css('margin-left', '64px');
			}
			
			$('body').css('overflow', 'hidden');
		};
		
		/**
		  * Retrieves the active Post
		  */
		this.activePost = function() {
			return posts.active;
		}
		
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
			var currMargin = currPost.css('margin-left');
			
			nextPost.show();
			
			nextPost.animate({marginLeft: currMargin});
			currPost.animate({marginLeft: '-786px'}, function() {
				currPost.css({display:'none'});
				var currClone = currPost.clone();
				console.log(currClone);
				currPost.remove();
				self.append(currClone);
				posts.collection = self.find('article');
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
			
			self.css({
				width: '2000px',
				height: '650px'
			});
			
			// enable the arrows if JS is enabled
			$('.left.arrow, .right.arrow').show();
			
			// bind events
			self.find('.left.arrow').click(carousel.prev);
			self.find('.right.arrow').click(carousel.next).css({
				right: self.width()-$(window).width()
			});
			
			$(window).resize(function() {
				self.find('.right.arrow').css({
					right: self.width()-$(window).width()
				});
				var pos = $(window).width()-carousel.activePost().width()-(carousel.activePost().width()/2);
				carousel.activePost().css({ margin: '0px 0px 0px '+pos+'px' });
			});
			
			self.find('article').css({
				float: 'left',
				display: 'inline-block'
			});
		});
	};
})(jQuery)