describe('Carousel', function() {
	var posts = (function() { var a=new Array(); for(var i=0; i <= 3; i++) { var p=new Post({src:$('<article id="article'+i+'"></article>')}); a.push(p); } return a; })();
	
	var carousel = new Carousel(posts, {
		position: 3
	});
	
	it('should not be revolving by default', function() {
		expect(carousel.revolving).toBeFalsy();
	});
	
	it('should be able to move backward one step', function() {
		expect(carousel.prev()).toEqual(posts[1]);
	});
	
	it('should be able to move forward one step', function() {
		expect(carousel.next()).toEqual(posts[2]);
	});
	
	it('should not be able to move backward past the first article when not revolving', function() {
		carousel.position = 0;
		expect(carousel.prev()).toBeFalsy();
	});
	
	it('should not be able to move forward past the last article when not revolving', function() {
		carousel.position = 4;
		expect(carousel.next()).toBeFalsy();
	});
	
	it('should go back to the first article when it reaches the end, and is revolving', function() {
		carousel.position = 4;
		expect(carousel.next()).toEqual(posts[0]);
	});
	
	it('should keep track of the current index', function() {
		carousel.next();
		expect(carousel.position).toEqual(4);
	});
});