var Carousel = Backbone.Model.extend({
	defaults: {
		container: {},
		index: 0,
		items: new Array(),
		revolving: false
	},
	
	show: function() {
		var items = this.get('items');
		var index = this.get('index');
		
		console.log(items);
		
		if (items[index].length) {
			return items[index];
		} else {
			return false;
		}
	}
});