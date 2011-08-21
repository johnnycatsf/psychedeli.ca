describe('Post', function() {
	var post = new Post({
		src: $('<article id="article1">'+"\n"
			  +'	<header>'+"\n"
			  +'		<h1>Post Title</h1>'+"\n"
			  +'	</header>'+"\n"
			  +'	<section>'+"\n"
			  +'		Content of the Post'+"\n"
			  +'	</section>'+"\n"
			  +'	<footer>'+"\n"
			  +'		<p>Posted in <span class="category">general_bullshit</span> <time datetime="2011-07-15 00:00:00 -0400">on 15 Jul 2011</time></p>'+"\n"
			  +'		<p>Tags: <span class="tags"></span> | <a href="comments.html?id=/general_bullshit/2011/07/15/a-new-beginning" rel="modal">Comments</a></p>'+"\n"
			  +'	</footer>'+"\n"
			  +'</article>')
	});
	
	it('should prune its content from the <article>s on the page');
	
	it('should have a title', function() {
		expect(post.get('title')).toBeDefined();
	});
	
	it('should have a body', function() {
		expect(post.get('body')).toBeDefined();
	});
	
	it('should have a category', function() {
		expect(post.get('category')).toBeDefined();
	});
	
	it('should have a date', function() {
		expect(post.get('date')).toBeDefined();
	});
	
	it('should have tags', function() {
		expect(post.get('tags')).toBeDefined();
	});
});