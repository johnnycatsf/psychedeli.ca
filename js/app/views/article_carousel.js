/**
  * The ArticleCarousel is the view for the Carousel. It renders the left and right arrows, and binds their respective click actions to the Carousel.prev() and Carousel.next()
  * methods, which will actually provide the Post data needed to render each Post in the carousel.
  *
  * @author Tom Scott
  * @package PsyCarousel
  */
var ArticleCarousel = Backbone.View.extend({
	tagName: 'section',
	events: {
		'click .left-arrow': 	'leftArrow',
		'click .right-arrow': 	'rightArrow' 
	},
	
	/**
	  * Creates and positions the right and left arrows. Positions the first <article> in the center of the screen.
	  * Removes all other <articles> and stores them in memory.
	  *
	  * @constructor
	  */
	render: function() {
		var self = $(this.el);
		var posts = new Array();
		
		self.find('article').each(function(i, article) {
			var post = new Post({
				src: article
			});
			
			posts.push(post);
		});
		
			
	},
	
	/**
	  * Left arrow click handler, goes back one step in the carousel.
	  *
	  * @param {DOMEvent} e - The click event in the DOM.
	  */
	leftArrow: function(e) {
		e.preventDefault();
		
		var post = carousel.prev();
		var self = $(this.el);
		
		if (post) {
			var newArticle = $(post.html());
			
			this.$('article').css({overflow:'hidden', position:'absolute', left:0}).animate({width:0}, function() {
				newArticle.css({width: 0})
						  .animate({width: '800px'})
						  .appendTo(self);
			});
		}
	},
	
	/**
	  * Right arrow click handler, goes forward one step in the carousel.
	  *
	  * @param {DOMEvent} e - The click event in the DOM.
	  */
	rightArrow: function(e) {
		e.preventDefault();
		
		var post = carousel.next();
		var self = this.$(this.element);
		
		self.find('article').css({overflow:'hidden', position:'absolute', right:0})
							.animate({width:0}, function() {
								article.css({overflow:'hidden', position:'absolute', right:0});
								self.append(article);
								article.animate({width: '800px'});
							});
	}
});