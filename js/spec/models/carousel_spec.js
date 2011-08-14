describe('Carousel', function() {
	var subjectContainer = $('<section id="posts"></section>').appendTo('body');
	var subjectItems = new Array();
	
	for (var c=0; c <= 3; c++) {
		subjectItems.push($('<article id="article'+c+'"></article>').appendTo('#posts'));
	}
	var subject = new Carousel({
		container: 	subjectContainer,
		items: 		subjectItems,
		revolving: 	true, 
	});
	
	it('should start out at position 1', function() {
		expect(subject.show()).toBeTruthy();
	});
});