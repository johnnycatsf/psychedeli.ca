/**
 * jQuery.ticker is a plugin that constantly polls various social networks and displays each status message or notification in a ticker-style format.
 *
 * Supported services: Facebook, Twitter, GitHub, SoundCloud
 *
 * @requires Underscore.js <http://documentcloud.github.com/underscore>
 * @author Tom Scott
 */

"use strict";
(function($) {	
	$.fn.ticker = function(params) {
		/**
		 * Blip is the interface for all services to enter the ticker. It is a standard means of accessing status messages.
		 *
		 * @param {options} setup - id (numeric id of msg), service (facebook|twitter|soundcloud), message (content), location (url)
		 */
		var Blip = function(setup) {
			this.id			= (setup.id)		? setup.id			: 0;
			this.service 	= (setup.service) 	? setup.service 	: '';
			this.message 	= (setup.message) 	? setup.message 	: '';
			this.location 	= (setup.location)	? setup.location 	: '';
			this.time 		= (function(time) {
				time;
			})(setup.time)
		};
		
		/**
		 * Ticker is a collection of Blips that operates like a stack.
		 */
		var Ticker = function() {
			var blips = new Array();
			
			this.length = function() {
				return blips.length;
			};
			
			this.add = function(newBlip) {
				var blipNotFound = true;
				
				// make sure this blip isn't already in
				var c = 0;
				while (blipNotFound && c < blips.length) {
					blipNotFound = (blips[c].id == newBlip.id) ? false : blipNotFound;
					c++;
				}
				
				// if not found, push to the end of the array
				return (blipNotFound) ? blips.push(newBlip) : false;
			};
			
			this.next = function() {
				return blips.pop();
			};
		};
		
		/*
		 * Plugin configuration
		 */
		var config = {
			pollEvery: 5000,
			changeEvery: 5000
			twitter: {
				handle: '',
				access: '',
				secret: ''
			},
			facebook: {
				app: {
					id: '',
					secret: ''
				},
				usr: {
					token: ''
				}
			},
			github: {
				api_key: '',
			},
			soundcloud: {
				access: '',
				secret: ''
			}
		};
		$.fn.extend(config, params);
		
		/*
		 * Plugin Runtime
		 */
		return this.each(function() {
			var self = $(this);
			
			// Poll the API
			var polling = setInterval(function() {
				// Facebook 
				$.ajax({
					url: 'http://graph.facebook.com/tubbo/feed',
					type: 'GET',
					data: {
						access_token: config.facebook.usr.token,
						limit: 5
					},
					dataType: 'json',
					success: function(statuses) {
						_.each(statuses.data, function(status) {
							Ticker.add(new Blip({
								service: 	'facebook',
								message: 	(typeof status.story != 'undefined') 	? status.story 	: status.message,
								location: 	(typeof status.link != 'undefined') 	? status.link 	: 'https://www.facebook.com/'+status.type+'.php?id='+status.id
							}));
						});
					}
				});

				// Twitter
				$.ajax({
					url: 'http://api.twitter.com/1/statuses/user_timeline.json',
					type: 'GET',
					data: {
						screen_name: config.twitter.handle,
						include_rts: 1,
						page: 1,
						include_entities: 1,
						callback: '?'
					},
					dataType: 'jsonp',
					success: function(tweets) {
						_.each(tweets, function(tweet) {
							Ticker.add(new Blip({
								service: 'twitter',
								message: tweet.text,
								location: 'https://twitter.com/tubbo/status/'+tweet.id
							}));
						});
					}
				});
			}, config.pollEvery);
			
			var changing = setInterval(function() {
				var nextBlip = $('<div class="blip"></div>');
				$('.blip').slideUp(400, function() {
					$(this).remove();
				});
				
				var blip = Ticker.next();

				// Configure the next Blip to appear
				nextBlip
					.html('<img src="img/icons/'+blip.service+'.png" alt="'+blip.service+'"><p>'+blip.message+'</p><time>'+blip.time+'</time>');


			}, config.changeEvery)
		})
	};
})(jQuery)