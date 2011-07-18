var Post = Backbone.Model.extend({
	date: function() { return new Date(Date.parse(this.get('created_on')+' '+this.get('created_at'))) },
	dateTime: function() {
		var daPostDate = this.date();
		
		var daPostMonth = ((daPostDate.getMonth()+1) < 10) ? '0'+(daPostDate.getMonth()+1) : daPostDate.getMonth()+1;
		var daPostDay = (daPostDate.getDate() < 10) ? '0'+daPostDate.getDate() : daPostDate.getDate();
		var daPostHours = (daPostDate.getHours() == 0) ? '00' : daPostDate.getHours();
		var daPostMinutes = (daPostDate.getMinutes() == 0) ? '00' : daPostDate.getMinutes();
		
		return daPostDate.getFullYear()+'-'+daPostMonth+'-'+daPostDay+' '+daPostHours+':'+daPostMinutes;
	},
	renderDate: function() {
		var post = this;	// makes code easier to update
		
		var postDate = post.date();
		
		var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		
		var daMonth = months[postDate.getMonth()];
		var daDay = postDate.getDate();
		
		return daMonth+" "+daDay;
	}
});