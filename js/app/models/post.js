/**
  * A Post is the Backbone representation of an <article> on the page. It generally makes the Carousel easier to work with when dealing solely with Backbone models rather than
  * actual HTML elements. You can create a Post programatically, or you can pass in a jQuery object to 
  *
  * @author Tom Scott
  * @package PsyCarousel
  */
var Post = Backbone.Model.extend({
	defaults: {
		src: $(),
		title: '',
		body: '',
		date: '',
		category: '',
		tags: ''
	},
	
	/**
	  * Allows for setup of the Post using a source <article> element which assumes the following HTML syntax:
	  *
	  * <article id="{Relative Post URL}">
	  *		<header>
	  *			<h1>{Post Title}</h1>
	  *		</header>
	  *
	  *		<section>
	  *			{Post Content}
	  *		</section>
	  *
	  *		<footer>
	  *			<span class="category">{post_category}</span>
	  *			<span class="tags">{Post, Tags}</span>
	  *			<time datetime="{Post Date in GMT format}"></time>
	  *		</footer>
	  * </article>
	  *
	  * @constructor
	  */
	initialize: function() {
		var self = this.get('src');
		
		// if src isn't an empty jQuery object, set up the Post from an <article> object
		if (element != $()) {
			this.set({
				title: self.find('header > h1').text(),
				body: self.find('section').html(),
				date: self.find('footer > time').attr('datetime')
				category: self.find('footer > .category').text(),
				tags: self.find('footer > .tags').text()
			});
		}
	},
	
	/**
	  * Renders this Post as HTML.
	  */
	html: function() {
		
	}
});