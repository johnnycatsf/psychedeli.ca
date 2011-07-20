describe('Post', function() {
	var post;
	var epochDate = new Date(0);
	
	beforeEach(function() {
		post = new Post({
			title: 		'New Beginnings',
			body: 		'blah blah blah', 
			created_on: 'July 2, 2011',
			created_at: '19:00'
		});
	});
	
	it('should have the title "New Beginnings"', function() {
		expect(post.get('title')).toEqual("New Beginnings");
	});
	
	it('should have a body', function() {
		expect(post.get('body')).toBeDefined();
	});
	
	it('should instantiate a Date from Post.created_at and Post.created_on', function() {		
		var created_on = (typeof post.get('created_on') != 'undefined') ? post.get('created_on') : '';
		var created_at = (typeof post.get('created_at') != 'undefined') ? post.get('created_at') : '';
		var daPostDate = new Date(Date.parse(created_on+' '+created_at));
		
		expect(post.get('date')).toEqual(daPostDate);
	});
	
	it('should convert the Date into something suitable for HTML5 datetime', function() {
		var postDate = post.get('date');
		
		var month = ((postDate.getMonth()+1) < 10) ? '0'+(postDate.getMonth()+1) : postDate.getMonth()+1;         
		var day = (postDate.getDate() < 10) ? '0'+postDate.getDate() : postDate.getDate();                  
		var hours = (postDate.getHours() == 0) ? '00' : postDate.getHours();                                 
		var minutes = (postDate.getMinutes() == 0) ? '00' : postDate.getMinutes();                           

		var datetime = postDate.getFullYear()+'-'+month+'-'+day+' '+hours+':'+minutes;      

		expect(post.getDate()).toEqual(datetime);                                                              
	});
	
	it('should render the Date as something readable by humans', function() {
		var postDate = post.get('date');
		var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		
		var daMonth = months[postDate.getMonth()];
		var daDay = postDate.getDate();
		
		expect(post.renderDate()).toEqual(daMonth+" "+daDay);
	});
});