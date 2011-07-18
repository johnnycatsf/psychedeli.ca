describe('Post', function() {
	beforeEach(function() {
		this.post = new Post({
			title: 		'New Beginnings',
			body: 		"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse pharetra mauris vel dolor commodo consequat. Nulla tempus sagittis orci, et auctor erat ornare et. Sed sodales faucibus est aliquet consectetur. Maecenas quam lacus, sodales in rhoncus nec, elementum sit amet quam. Pellentesque condimentum sollicitudin arcu a semper. Praesent condimentum suscipit ipsum id interdum. Suspendisse aliquet interdum augue, ac euismod diam pharetra ut. Donec id magna lorem, vitae blandit dui. Suspendisse consequat fermentum placerat. Duis non odio odio. Curabitur augue sem, condimentum vel tristique nec, cursus sit amet enim. Curabitur tincidunt commodo lectus, at laoreet turpis dictum nec. Proin varius aliquet justo eu feugiat. Integer placerat libero in dolor ornare non rhoncus lorem porttitor. Curabitur dolor purus, facilisis in blandit ac, accumsan vel purus.",
			category: 	'general bullshit',
			created_at: '2011-04-10',
			tags: 		'psychedelica, jekyll, jquery, backbone, javascript, ajax, movement'
		})
	});
	
	it('should have a non-empty title', function() {
		expect(model.get('title')).toBeDefined();
		expect(model.get('title')).not.toEqual('');
	});
	
	it('should have a non-empty body', function() {
		expect(model.get('body')).toBeDefined();
		expect(model.get('body')).not.toEqual('');
	});
	
	it('should have a non-empty category', function() {
		expect(model.get('category')).toBeDefined();
		expect(model.get('category')).not.toEqual('');
	});
	
	it('should have a non-empty date string', function() {
		expect(model.get('created_at')).toBeDefined();
		expect(model.get('created_at')).not.toEqual('');
	});
	
	it('should convert the created_at string to a Date object');
})