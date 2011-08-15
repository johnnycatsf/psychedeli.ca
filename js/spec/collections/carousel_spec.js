describe('Carousel', function() {
	var subjects = (function() { var i = new Array(); for (var c=0; c <= 3; c++) { i.push(new Post()) } return i; })();
	var carousel = new Carousel(subjects, {
		revolving: 	false
	});
	
	it('should start out at position 1', function() {
		expect(carousel.show()).toBe(subjects[0]);
	});
	
	it('should move to position 3', function() {
		expect(carousel.go(2)).toBe(subjects[2]);
	});
	
	it('should move forward one position', function() {
		expect(carousel.next()).toBe(subjects[3]);
	});
	
	it('should not be able to go forward anymore', function() {
		expect(carousel.next()).toBe(subjects[3]);
	});
		
	it('should go back one position', function() {
		expect(carousel.prev()).toBe(subjects[2]);
	});
	
	it('should fail when trying to move to an off-array position', function() {
		expect(carousel.go(9)).toBeFalsy();
	});
	
	it('should cycle from the first to last position when revolving is turned on', function() {
		carousel.set({
			index: 0, 
			revolving: true
		});
		expect(carousel.prev()).toBe(subjects[subjects.length-1]);
	});
	
	it('should cycle from the last to first position when revolving is turned on', function() {
		carousel.set({
			index: subjects.length-1, 
			revolving: true
		});
		expect(carousel.next()).toBe(subjects[0]);
	});
});