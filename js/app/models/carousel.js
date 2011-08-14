var Carousel = Backbone.Model.extend({
	/**
	  * Configuration.
	  */
	defaults: {
		container: 		$(),
		items: 			new Array(),
		index: 			0,
		currentItem: 	null,
		revolving: 		true,
		scrollSpeed: 	400
	},
	
	/**
	  * Instantiates the PsyCarousel with a block-level "container" element and an array of block-level "item" elements.
	  */
	initialize: function() {
		var items = this.get('items');
		var index = this.get('index');
		this.set('currentItem', items[index]);
	},
	
	/**
	  * Attempts to set the current index to a specific item in the collection. If PsyCarousel's **config.revolving** property is set, this will 
	  * set the index to the first or last element in the collection depending on if the given new index was larger or smaller than the capacity
	  * of the collection.
	  *
	  * @param {int} newIndex - The new current index in the array.
	  * 
	  * @returns {DOMElement} the current 
	  */
	go: function(newIndex) {
		var items = this.get('items');
		
		if (newIndex > 0 && newIndex <= items.collection.length-1 && items.collection[newIndex].length > -1) {	
			items.index = newIndex;									// if the element is in the collection and exists, return `true`
		} else {
			if (this.get('revolving')) {	// when config.revolving is set, 
				if (newIndex < 0) {			// set to first position if under
					this.items.index = 0;
				} else {					// set to last position if over
					this.items.index = this.items.collection.length-1;
				}
			}
		}

		// if we get here, the function was successful, set the current element and return it!
		this.items.current = this.items.collection[this.items.index];
		return this.items.current;
	},
	
	/**
	  * Set the current element to the previous item in the collection and save the results of 
	  * the go() action, then return the evaluation of whether the previous and next elements 
	  * are the same. If they are, the go() failed.
	  *
	  * @returns `true` if items.current changed, and `false` otherwise.
	  */
	prev: function() {
		var currentElement = carousel.items.current;
		var nextElement = carousel.go(carousel.items.index++);
		return (currentElement != nextElement) ? true : false;
	},
	
	/**
	  * Set the current element to the next item in the collection and save the results of the 
	  * go() action, then return the evaluation of whether the previous and next elements are 
	  * the same. If they are, the go() failed.
	  *
	  * @returns `true` if items.current changed, and `false` otherwise.
	  */
	next: function() {
		var currentElement = carousel.items.current;
		var nextElement = carousel.go(carousel.items.index++);
		return (currentElement != nextElement) ? true : false;
	}
});