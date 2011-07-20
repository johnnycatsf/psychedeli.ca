(function($) {
	/**
	  * Takes a comma-separated list of tags and determines what search engine to place them under based on the tag symbol, then optionally removes that symbol (`clean:true`).
	  * Tags with spaces in them must have spaces replaced to "_".
	  *
	  * Defaults to Google, or the value of `defaultEngine:`.
	  *
	  * # - Twitter
	  * $ - Stock symbol, searches on Google Finance
	  * ` - GitHub
	  * ! - Facebook
	  * ? - Stack Overflow
	  */
	$.fn.linkifyTags = function(params) {
		// Configuration
		var config = {
			defaultEngine: 'http://www.google.com/search?ie=UTF-8&q=',
			clean: false
		};
		$.fn.extend(config, params);
		
		// Runtime
		return this.each(function() {
			var self = $(this);
			
			var rawTags = self.html();
			var tagArray = rawTags.split(',');
			var tags = '';
			
			_.each(tagArray, function(tag) {
				var symbol = tag.substr(0,1);
				var tagHTML = '';
				var cleanTag = tag.substr(1);
				var cleanTagURL = cleanTag.split(' ').join('+');
				tag = (config.clean) cleanTag : tag;
				
				switch(symbol) {
					case '#': // Twitter
						tagHTML = '<a href="http://twitter.com/#!/search/'+cleanTagURL+'" class="twitter">'+tag+'</a>';
						break;
					case '$': // Google Finance
						tagHTML = '<a href="http://finance.google.com/?q='+cleanTagURL+'" class="finance">'+tag+'</a>';
						break;
					case '`': // GitHub
						tagHTML = '<a href="http://github.com/search/?q='+cleanTagURL+'" class="github">'+tag+'</a>';
						break;
					case '!': // Facebook
						tagHTML = '<a href="http://facebook.com/search.php?q='+cleanTagUR:+'" class="facebook">'+tag+'</a>';
						break;
					default:
						tagHTML = '<a href="'+config.defaultEngine+cleanTagURL+'" class="google">'+tag+'</a>';
						break;
				}
				
				tags += tagHTML;
			});
			
			self.html(tags);
		});
	};
})(jQuery)