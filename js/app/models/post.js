/**
  * Posts are JavaScript bindings to the Markdown posts provided by Jekyll.
  */
var Post = Backbone.Model.extend({
	/*
	 * Post default values
	 */
	defaults: {
		date: Date.now()
	},
	
	/**
	  * Initializes a new Date object based on properties Post.created_on and Post.created_at. Parses a Date from these two Strings, so the Date can be reformatted
	  * and evaluated with ease.
	  */ 
	initialize: function() {
		if ((typeof this.get('created_on') != 'undefined') || (typeof this.get('created_at') != 'undefined')) {
			var created_on = this.get('created_on');
			var created_at = this.get('created_at');
			var createdOnDate = new Date(created_on);
			var timezone = createdOnDate.getTimezoneOffset()/60;
			
			var postString = created_on+' '+created_at+' GMT-0'+timezone+'00';
			
			var postDate = new Date(postString);
		} else {
			throw 'Error: Properties Not Set';
		}
		
		this.set({date: postDate});
	},
	
	/**
	  * Post date reformatted to be the datetime="" parameter in <time>.
	  *
	  * @returns {String} the Date expressed in an HTML5 datetime. `<time datetime="Post.dateTime()"></time>`
	  */
	dateTime: function() {
		var postDate = this.get('date');
		
		var month = ((postDate.getMonth()+1) < 10) ? '0'+(postDate.getMonth()+1) : postDate.getMonth()+1;         
		var day = (postDate.getDate() < 10) ? '0'+postDate.getDate() : postDate.getDate();                  
		var hours = (postDate.getHours() == 0) ? '00' : postDate.getHours();                                 
		var minutes = (postDate.getMinutes() == 0) ? '00' : postDate.getMinutes();                           

		return datetime = postDate.getFullYear()+'-'+month+'-'+day+' '+hours+':'+minutes;
	},
	
	/**
	  * Human-readable post date. ex. "July 2"
	  *
	  * @returns {String} the Date expressed in a human-readable String. `<time>Post.renderDate()</time>`
	  */
	renderDate: function() {
		var postDate = this.get('date');
		
		var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		
		var daMonth = months[postDate.getMonth()];
		var daDay = postDate.getDate();
		
		return daMonth+" "+daDay;
	},
});