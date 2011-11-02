/**
 * jQuery.ticker is a plugin that constantly polls various social networks and displays each status message or notification in a ticker-style format.
 *
 * Supported services: Facebook, Twitter, GitHub, SoundCloud
 *
 * @author Tom Scott
 */

"use strict";
(function($) {	
	$.fn.ticker = function(params) {
		// Blip is the interface for all services to enter the ticker. It is a standard means of accessing status messages.
		var Blip = function(setup) {
			this.id			= (setup.id)		? setup.id			: 0;
			this.service 	= (setup.service) 	? setup.service 	: '';
			this.message 	= (setup.message) 	? setup.message 	: '';
			this.location 	= (setup.location)	? setup.location 	: '';
		};
		
		// Ticker is a collection of Blips.
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
			
			this.pop = function() {
				return blips.pop();
			};
		};
		
		// Plugin configuration
		var config = {
			pollEvery: 5000,
			changeEvery: 5000
			twitter: {
				handle: ''
				access: ''
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
		
		// Poll the API and transition Blips
		var polling = setInterval(function() {
			// Facebook 
			$.ajax({
				url: 'https://graph.facebook.com/tubbo/feed',
				type: 'GET',
				data: {
					access_token: config.facebook.usr.token,
					limit: 5
				},
				dataType: 'json',
				success: function(response) {
					_.each(response.data, function(status) {
						var blip = new Blip({
							service: "facebook",
							message: (typeof status.story != 'undefined') ? status.story : status.message,
							location: (typeof status.link != 'undefined') ? status.link : "https://www.facebook.com/"+status.type+".php?id="+status.id
						});
						Ticker.add(blip);
					})
				}
			});
			
			// Twitter
			$.ajax({
				url: 'https://api.twitter.com/'
			})
		}, config.pollEvery);
		
		var changing = setInterval(function() {
			
		}, config.changeEvery)
	};
})(jQuery)