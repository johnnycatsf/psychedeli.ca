var ArticleCarousel = Backbone.View.extend({
	/**
	  * Configuration
	  */
	tagName: 'section',
	events: {
		'click .left-arrow': 	"leftArrow",
		'click .right-arrow': 	"rightArrow" 
	},
	
	/**
	  * Creates and positions the right and left arrows. Positions the first <article> in the center of the screen.
	  * Removes all other <articles> and stores them in memory.
	  *
	  * @constructor
	  */
	render: function() {
		var self = this.el;
		self.append('<div class="left arrow"></div>, <div class="right arrow"></div>');
		
		// remove all articles but the top story
		var topStory = self.find('article').first();
		self.find('article').not(topStory).remove();
		
		topStory.css({margin: '0 auto'});
	},
	
	/**
	  * Left arrow action, goes back one step in the carousel.
	  */
	leftArrow: function(e) {
		e.preventDefault();
	},
	
	rightArrow: function(e) {
		e.preventDefault();
	}
});