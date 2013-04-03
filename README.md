psychedeli.ca is my internet web site
=====================================

This is the complete source code for the Rails app that powers my
personal site and blog. I mostly write about music, programming, or
other geek-related topics based on what I'm working on at the moment and
the things I've learned on that journey.

[![Build Status](https://secure.travis-ci.org/tubbo/psychedeli.ca.png?branch=master)](http://travis-ci.org/tubbo/psychedeli.ca)

History
-------

I began this blog as a Rack app that served a static Jekyll site, and
used Sprockets to package assets on the fly. After cobbling around with
that setup for a year or so, I began to learn more about how to
"minimize" a Rails app's footprint for better performance. So instead of
wrestling with Jekyll to get it to function the way I wanted, I
implemented its concepts directly into the Rails framework.

Content
-------

Content delivery is powered by [ActiveCopy][ac], a [Jekyll][jek]-inspired
library I wrote that allows you to store copy content in [Markdown][md],
and use [YAML front matter][yfm] for basic flat file data storage in those
files. Content is stored in **app/views/<your-model>/content**, and the model
representing each article inherits from `ActiveCopy::Base`, pretty much
enforcing a single data model.

Design
------

I used [Zurb Foundation][zurb] and their boilerplate templates to build out
the latest redesign of the blog, and [Sumatra][sum] to write the [jQuery][jq]
plugins used throughout the blog. Except the tooltips.

Roadmap
-------

- Write tests for ActiveCopy
- Extract ActiveCopy into its own gem

[sass]: http://sass-lang.com
[jq]: http://jquery.com
[jek]: http://github.com/mojombo/jekyll
[fork]: http://github.com/tubbo/jekyll
[liq]: http://github.com/shopify/liquid
[md]: http://daringfireball.net/projects/markdown/
[sprk]: https://github.com/sstephenson/sprockets
[rts]: https://github.com/rack/rack-contrib/pull/13
[cap]: https://github.com/capistrano/capistrano/wiki/Documentation-v2.x
[tckr]: https://github.com/tubbo/psychedeli.ca/blob/master/app/js/jquery.ticker.js
[rake]: http://rake.rubyforge.org
[ac]: http://psychedeli.ca/tag/active_copy
[yfm]: https://github.com/mojombo/jekyll/wiki/YAML-Front-Matter
[sum]: http://www.psychedeli.ca/2013/03/25/writing-jquery-plugins-with-coffeescript
