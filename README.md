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
implemented its concepts directly into the Rails framework

Content
-------

Content delivery is powered by [ActiveCopy][ac], a library I wrote to
sort-of emulate [Jekyll][jek] in the Rails ecosystem. Basically, you
generate models called "documents" that behave just like `ActiveRecord`
models, but instead of looking up information from the database, they
read [Markdown][md] and [YAML front matter][yfm] from the **app/documents** 
folder of your application. Just like with Jekyll, a simple `git push &&
cap deploy` will post a new article to the server *and* precompile each
page. `ActiveCopy` controllers use a custom `ActionView` handler to generate
HTML from Markdown using the powerful Redcarpet engine, and since the
controller is by design caching every page in production, the pages or
articles you generate using ActiveCopy are precompiled into HTML on
deployment. With just a little server-side configuration, you can mix
the power of Jekyll's static site generation with the amazing
server-side capabilities of the Rails stack.

Roadmap
-------

- Fix `GET /status.json`
- Add `jQuery.ticker` plugin for reading JSON data.

[sass]: http://sass-lang.com
[jq]: http://jquery.com
[jek]: http://github.com/mojombo/jekyll
[fork]: http://github.com/tubbo/jekyll
[liq]: http://github.com/shopify/liquid
[ku]: http://heroku.com
[pow]: http://pow.cx
[md]: http://daringfireball.net/projects/markdown/
[sprk]: https://github.com/sstephenson/sprockets
[rts]: https://github.com/rack/rack-contrib/pull/13
[cap]: https://github.com/capistrano/capistrano/wiki/Documentation-v2.x
[tckr]: https://github.com/tubbo/psychedeli.ca/blob/master/app/js/jquery.ticker.js
[rake]: http://rake.rubyforge.org
