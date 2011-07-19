var Article = Backbone.Model.extend({
	/**
	  * This Article's creation date, parsed into ms and returned as a Date object.
	  *
	  * @returns {Date} the time at which this Article was created.
	  */ 
	date: function() { 
		var created_on = (typeof this.get('created_on') != 'undefined') ? this.get('created_on') : '';
		var created_at = (typeof this.get('created_at') != 'undefined') ? this.get('created_at') : '';
		return new Date(Date.parse(created_on+' '+created_at)); 
	},
	
	/**
	  * Article date reformatted to be the datetime="" parameter in <time>.
	  *
	  * @returns {String} the Date expressed in an HTML5 datetime. `<time datetime="Article.dateTime()"></time>`
	  */
	dateTime: function() {
		var postDate = this.date();
		
		try {
			var year = postDate.getFullYear();
			var month = ((postDate.getMonth()+1) < 10) ? '0'+(postDate.getMonth()+1) : postDate.getMonth()+1;
			var day = (postDate.getDate() < 10) ? '0'+postDate.getDate() : postDate.getDate();
			var hours = (postDate.getHours() == 0) ? '00' : postDate.getHours();
			var minutes = (postDate.getMinutes() == 0) ? '00' : postDate.getMinutes();

			var datetime = year+'-'+month+'-'+day+' '+hours+':'+minutes;

			return datetime;
		} catch(e) {
			console.log(e);
		}
	},
	
	/**
	  * Human-readable post date. ex. "July 2"
	  *
	  * @returns {String} the Date expressed in a human-readable String. `<time>Article.renderDate()</time>`
	  */
	renderDate: function() {
		var postDate = this.date();
		
		var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		
		var daMonth = months[postDate.getMonth()];
		var daDay = postDate.getDate();
		
		return daMonth+" "+daDay;
	}
});