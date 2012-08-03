psychedeli.ca is my internet web site
=====================================

This is the complete source code for my blog, which is (usually) up and running on <http://psychedeli.ca>. I mostly post music, programming or some other geek related articles based on what I'm doing at the moment and what I've learned along the way. Originally made by cobbling together Sprockets, my fork of Jekyll, and a little Rack app I made to serve a JSON feed of my status updates across the various social networking sites, it has now been rebooted as a Rails app.

[![Build Status](https://secure.travis-ci.org/tubbo/psychedeli.ca.png?branch=master)](http://travis-ci.org/tubbo/psychedeli.ca)

Why Rails?
----------

Ironically enough, speed. Sprockets isn't aware of the `RACK_ENV` shell variable, and compiles assets on-the-fly in production. In Rails, this is disabled by default and a nice Capistrano task does the precompilation step for you. But when you're making everything from scratch, you can't take advantage of these features without serious modification to the codebase and some really hacky behavior.

Content
-------

Content delivery is powered by [Jekyll][jek], a static HTML page generator currently in use on GitHub Pages as well as on countless blogs on the web. I like it because it can use [Markdown][md] (my humane markup language of choice), and it's easy to understand and extend.

I wanted a bit more customization out of Jekyll to design my own folder structure, and to just learn how it works. [My fork][fork] of the Jekyll project is an embodiment of these wishes. Changes to Jekyll include two extra configuration options, `posts:` and `layouts:`, which can override the **_posts/** and **_layouts/** directory locations, as well as a custom YAML config location (**cfg/jekyll.yml**).

Development
-----------

If you'd like to fork this for your own uses, I have included a number of development tools that have aided me in my progress on this project. I develop locally with [Pow][pow], but you can use anything that runs Rack apps. As such, most of the dev tools I've created come in the form of [Rake][rake] tasks.

### rake compile

This simply runs `bundle exec jekyll` to compile the static site. It will compile to the `pub/` directory, or whatever you set it to in `cfg/jekyll.yml`.

### rake restart

As is the convention with most Rack servers, this runs `touch tmp/restart.txt`. It is in the form of a Rake task so it would be easier for `rake compile` to call it.

### rake test

An extension of `Rake::TestTask`, this runs the [MiniTest][mt] suite in `test/` which runs the currently developed tests for StatusExchange.

### rake configure

This task copies the server configuration such as `.htaccess` and `robots.txt` from the **cfg/** directory and places it in **pub/**. It is normally invoked immediately after `rake compile` has completed.

### rake install {path}

This monolithic task "installs" the static app to `{path}` by copying the entire **lib/** directory, **config.ru**, and compiling the app to its child **pub/** directory. It then copies over all relevant files from **cfg/** that are needed for the daily operations of the web server. If left blank, it installs the app into **build/**.

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
