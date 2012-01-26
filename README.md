psychedeli.ca is my internet web site
=====================================

This is the source code of my blog, which is (usually) up and running on <http://psychedeli.ca>. I created the user interface in [Sass SCSS][sass] and mostly [jQuery][jq]. The content is compiled by [Jekyll][jekyll]. Included in this repo is a binary I made with [Thor][thor] called `synth` which can be run to both compress/minify the JavaScript code and generate the Jekyll site.

Jekyll Modifications
--------------------

I wanted a bit more customization out of Jekyll to design my own folder structure, and to just learn how it works. [My fork][fork] of the Jekyll project is an embodiment of these wishes. Changes to Jekyll include two extra configuration options, `posts:` and `layouts:`, which can override the **_posts/** and **_layouts/** directory locations.

Jekyll is also working with the `GenerateSitemap` and `SassConverter` 3rd-party plugins, as well as a custom plugin I wrote called `Enclosure`, which extends [Liquid][liq] to

StatusExchange
--------------

An aggregator of status update feeds from places like Twitter, Facebook, GitHub and Last.FM. This app coalesces all of your various feeds together, sorts them by time, then outputs it to a JSON file in a standard fashion. This allows [a jQuery plugin][ticker] to easily read and display the status messages as if they all came from the same place.

StatusExchange lives in the Rack middleware stack, and responds when a client requests `GET http://psychedeli.ca/status.json`.

[sass]: http://sass-lang.com
[jq]: http://jquery.com
[jek]: http://github.com/mojombo/jekyll
[thor]: http://github.com/wycats/thor
[fork]: http://github.com/tubbo/jekyll
[liq]: http://github.com/shopify/liquid
