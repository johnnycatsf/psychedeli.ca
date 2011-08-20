/**
  * A Carousel is a collection of Posts. It can move back and forward stepwise, and keeps track of the current position and Post.
  *
  * @author Tom Scott
  * @package PsyCarousel
  */ 
var Carousel = Backbone.Collection.extend({
	model: Post,
	revolving: false,
	position: 0,
	
	/**
	  * Goes backward one step.
	  *
	  * @returns the next Post in the Carousel, or `false` if not `revolving`
	  */
	prev: function() {
		if (this.revolving) {
			this.position = (this.position + 1) <= this.length) ? this.position + 1 : 0; 
			return this.models[this.position];
		} else {
			if ((this.position + 1) <= this.length) {
				this.position++;
				return this.models[this.position];
			} else {
				return false;
			}
		}
	},
	
	/**
	  * Goes forward one step.
	  *
	  * @returns the next Post in the Carousel, or `false` if not `revolving`
	  */
	next: function() {
		if (this.revolving) {
			this.position = (this.position - 1) >= 0) ? this.position - 1 : this.length;
		} else {
			if ((this.position - 1) >= 0) {
				this.position--;
				return this.models[this.position];
			} else {
				return false;
			}
		}
	}
});