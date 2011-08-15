var Carousel = Backbone.Collection.extend({
	model: Post,
	defaults: {
		index: 0,
		currentItem: null,
		revolving: false
	},
	
	/**
	  * Show the current item.
	  *
	  * @returns {DOMElement} the currently visible item
	  */
	show: function() {
		var items = this.get('items');
		var index = this.get('index');
		
		if (items[index].length) {
			return items[index];
		} else {
			return false;
		}
	},
	
	/**
	  * Jumps to a specific point in the array.
	  *
	  * @returns the new currently visible DOMElement, or `false` if it doesn't exist.
	  */
	go: function(newIndex) {
		var currIndex = this.get('index');
		var items = this.get('items');

		if (typeof items[newIndex] != 'undefined') {
			this.set({ index: newIndex });
			return this.show();
		} else {
			return false;
		}
	},
	
	/**
	  * Goes back one step.
	  *
	  * @returns the item previous to the current item
	  */
	prev: function() {
		var currIndex = this.get('index');
		var prevIndex = this.get('index') - 1;
		 
		if (this.get('revolving') == true) {
			return (prevIndex > 0) ? this.go(prevIndex) : this.go(this.get('items').length-1);
		} else {
			return (prevIndex > 0) ? this.go(prevIndex) : this.show();
		}
	},
	
	/**
	  * Goes forward one step.
	  *
	  * @returns the next item up from the current item
	  */
	next: function() {
		var currIndex = this.get('index');
		var nextIndex = this.get('index') + 1;
		
		if (this.get('revolving') == true) {
			return (nextIndex <= this.get('items').length-1) ? this.go(nextIndex) : this.go(0);
		} else {
			return (nextIndex <= this.get('items').length-1) ? this.go(nextIndex) : this.show();
		}
	}
});