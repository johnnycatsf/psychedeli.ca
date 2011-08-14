describe('Carousel', function() {
	var subject = Object.create(PsyCarousel);
	
	it('should instantiate properly', function() {
		expect(subject.init()).toBeTruthy();
	});
	
	it('should be revolving', function() {
		expect(subject.config.revolving).toBeTruthy();
	});
	
	it('should proceed to the next element', function() {
		var lastElement = subject.items.current;
		expect(subject.next()).toBeTruthy();
		expect(subject.items.current).toNotEqual(lastElement);
	});
	
	it('should go back to the last element', function() {
		var lastElement = subject.items.current;
		expect(subject.prev()).toBeTruthy();
		expect(subject.items.current).toNotEqual(lastElement);
	});
});