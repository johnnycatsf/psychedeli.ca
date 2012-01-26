psychedeli.ca is my internet web site
=====================================

This is the source code of my blog, which is (usually) up and running on <http://psychedeli.ca>. I created the user interface in [Sass SCSS][sass] and mostly [jQuery][jq]. The content is compiled by [Jekyll][jekyll]. Included in this repo is a binary I made with [Thor][thor] called `synth` which can be run to both compress/minify the JavaScript code and generate the Jekyll site.

Jekyll Modifications
--------------------

I wanted a bit more customization out of Jekyll to design my own folder structure, and to just learn how it works. [My fork][fork] of the Jekyll project is an embodiment of these wishes. Changes to Jekyll include two extra configuration options, `posts:` and `layouts:`, which can override the **_posts/** and **_layouts/** directory locations.

Jekyll is also working with the `GenerateSitemap` and `SassConverter` 3rd-party plugins, as well as a custom plugin I wrote called `Enclosure`, which extends [Liquid][liq] to

Middleware
----------

There are a couple Rack apps on the stack as well, for serving little bits of dynamic content

[sass]: http://sass-lang.com
[jq]: http://jquery.com
[jek]: http://github.com/mojombo/jekyll
[thor]: http://github.com/wycats/thor
[fork]: http://github.com/tubbo/jekyll
[liq]: http://github.com/shopify/liquid
