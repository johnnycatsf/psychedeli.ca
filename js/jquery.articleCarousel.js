/**
  * jQuery.articleCarousel
  *
  * Takes a bunch of <article>s and turns them into a Carousel.
  */
(function($) {	
	/**
	  * jQuery.articleCarousel() applies the PsyCarousel to a block-level element with a series 
	  * of <article> tags within. It turns what would normally be a set of blog articles or news 
	  * articles into an animated carousel-style interface with jQuery.
	  *
	  * @returns {jQuery} the DOM element this was called on.
	  */ 
	$.fn.articleCarousel = function() {
		// ECMAScript 5 shim
		if (typeof Object.create !== 'function') {
			Object.create = function(o) {
				function F() {}
				F.prototype = o;
				return new F();
			};
		}
		
		return this.each(function() {
			// the <section> this is being called in
			var self = $(this);
			
			// the scaffold object of <article>s that we'll store in memory
			var carousel = new Carousel({
				element: self
			})
			
			// animate left arrow: previous <article> in the carousel
			self.find('.left.arrow').click(function(e) {
				e.preventDefault();
				var lastElement = carousel.items.current;
				
				// as long as we're progressing somewhere, perform the animation
				if (carousel.prev()) {
					var previousElement = carousel.items.current;
					
					$(lastElement).animate({ width:'0px' }, function() {
						$(this).css('display', 'none');
						$(previousElement).animate({ width: '800px' });
					});
				}
			});
			
			// animate right arrow: next <article> in the carousel. also, stick it to the left of the screen
			self.find('.right.arrow').click(function(e) {
				e.preventDefault();
				var lastElement = carousel.items.current;
				
				// as long as we're progressing somewhere, perform the animation
				if (carousel.next()) {
					var nextElement = carousel.items.current;
					
					$(lastElement).animate({ width:'0px' }, function() {
						$(this).css({display: 'none'});
						$(nextElement).css({display: 'block'}).animate({ width: '800px' });
					});
				}
			}).css({ right: self.width()-$(window).width() });
		});
	};
})(jQuery)