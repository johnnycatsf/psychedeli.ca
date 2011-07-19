var ArticleTag = Backbone.View.extend({
	tagName: 'article',
	
	events: {
		"click .comments.icon": 	'comments'
	},
	
	initialize: function() {
		_.bindAll(this, "render");
	},
	
	render: function() {
		
	}
})