"use strict";

(function($) {
	var Ticker = function(self, config) {
		var currentStatus, auth, feed, feedIndex;
		
		this.init = function() {
			// instantiate current status message
			currentStatus = {
				provider: 'none',
				message: ''
			};
			
			// instantiate authentication details
			auth.accessToken = config.access;
			auth.secretToken = config.secret;
			auth.accountName = config.handle;
			
			// instantiate feed and feed index
			feed = [];
			feedIndex = 0;
			
			// cache the jQuery DOM object in memory
			this.element = self;
			
			// pull the whole feed into var feed
			
			// sort var feed
			feed.sort(function(a,b) {
				return a.date - b.date;
			});
		};
		
		/**
		  * Updates the #ticker element with the next status in the feed.
		  */
		this.update = function() {
			this.element.find('ul').append('<li><img src="ticker/'+currentStatus.provider+'.png" alt="'+currentStatus.provider+'"> '+currentStatus.message+'</li>');
		};
		
		/**
		  * Returns the current status, or `false` if there are none.
		  */
		this.status = function() {
			if (currentStatus.message != '') {
				return currentStatus;
			} else {
				return false;
			}
		};
		
		/**
		  * Goes to a specific index in the feed. This is an absolute array index, so +1 to find the actual position of the ticker message.
		  */
		this.to = function(index) {
			feedIndex = index;
			currentStatus = feed[index];
			return this.status();
		}
		
		/**
		  * Iterates to the next status in the feed, and saves it in memory. Also runs this.status() to return the current status.
		  */
		this.next = function() {
			return this.to(feedIndex++);
		};
		
		/**
		  * Backtracks to the previous status in the feed, and saves it in memory. Also runs this.status() to return the current status.
		  */
		this.prev = function() {
			return this.to(feedIndex--);
		};
		
		
		this.init();
	};
	
	$.fn.ticker = function(params) {
		var config = {
			twitter: {
				handle: ''
				access: ''
				secret: ''
			},
			facebook: {
				access: ''
				secret: ''
			},
			github: {
				access: '',
				secret: ''
			},
			soundcloud: {
				access: '',
				secret: ''
			}
		};
		
		$.fn.extend(config, params);
		
		var ticker = new Ticker(this, config.twitter);
		
		// poll for changes
		var interval = setInterval(function() {
			
		}, 5000);
	};
})(jQuery)