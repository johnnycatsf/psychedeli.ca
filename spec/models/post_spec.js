describe('Post', function() {
	var post;
	
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
		var daPostDate = new Date(Date.parse(post.get('created_on')+' '+post.get('created_at')));
		expect(post.date()).toEqual(daPostDate);
	});
	
	it('should convert the Date into something suitable for HTML5 datetime', function() {
		var daPostDate = post.date();
		
		var daPostMonth = ((daPostDate.getMonth()+1) < 10) ? '0'+(daPostDate.getMonth()+1) : daPostDate.getMonth()+1;
		var daPostDay = (daPostDate.getDate() < 10) ? '0'+daPostDate.getDate() : daPostDate.getDate();
		var daPostHours = (daPostDate.getHours() == 0) ? '00' : daPostDate.getHours();
		var daPostMinutes = (daPostDate.getMinutes() == 0) ? '00' : daPostDate.getMinutes();
		
		var daPostDatetime = daPostDate.getFullYear()+'-'+daPostMonth+'-'+daPostDay+' '+daPostHours+':'+daPostMinutes;
		
		expect(post.dateTime()).toEqual(daPostDatetime);
	});
	
	it('should render the Date as something readable', function() {
		var postDate = post.date();
		
		var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		
		var daMonth = months[postDate.getMonth()];
		var daDay = postDate.getDate();
		
		expect(post.renderDate()).toEqual(daMonth+" "+daDay);
	});
});