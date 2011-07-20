/**
  * The HTML representation of a Post, using the <article> tag (hence the name). 
  */
var Article = Backbone.View.extend({
	tagName: 'article',
	
	/**
	  * Render this <article> on construction.
	  *
	  * @constructor
	  */
	initialize: function() {
		_.bindAll(this, "render");
	},
	
	/**
	  * Renders an <article> with the data from the Post.
	  *
	  * @returns {Article} jQuery template
	  */
	render: function() {
		$('#posts > '+this.el).html(this.template(this.model.to_json));
		return this;
	}
})