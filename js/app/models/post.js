var Post = Backbone.Model.extend({
	/**
	  * This Post's creation date, parsed into ms and returned as a Date object.
	  *
	  * @returns {Date} the time at which this Post was created.
	  */ 
	date: function() { return new Date(Date.parse(this.get('created_on')+' '+this.get('created_at'))) },
	
	/**
	  * Post date reformatted to be the datetime="" parameter in <time>.
	  *
	  * @returns {String} the Date expressed in an HTML5 datetime. `<time datetime="Post.dateTime()"></time>`
	  */
	dateTime: function() {
		var daPostDate = this.date();
		
		var daPostMonth = ((daPostDate.getMonth()+1) < 10) ? '0'+(daPostDate.getMonth()+1) : daPostDate.getMonth()+1;
		var daPostDay = (daPostDate.getDate() < 10) ? '0'+daPostDate.getDate() : daPostDate.getDate();
		var daPostHours = (daPostDate.getHours() == 0) ? '00' : daPostDate.getHours();
		var daPostMinutes = (daPostDate.getMinutes() == 0) ? '00' : daPostDate.getMinutes();
		
		return daPostDate.getFullYear()+'-'+daPostMonth+'-'+daPostDay+' '+daPostHours+':'+daPostMinutes;
	},
	
	/**
	  * Human-readable post date. ex. "July 2"
	  *
	  * @returns {String} the Date expressed in a human-readable String. `<time>Post.renderDate()</time>`
	  */
	renderDate: function() {
		var postDate = this.date();
		
		var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		
		var daMonth = months[postDate.getMonth()];
		var daDay = postDate.getDate();
		
		return daMonth+" "+daDay;
	}
});