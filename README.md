psychedeli.ca is my internet web site
=====================================

This is the complete source code for my blog, which is (usually) up and running on <http://psychedeli.ca>. I mostly post music, programming or some other geek related articles based on what I'm doing at the moment and what I've learned along the way. The blog itself is completely custom-made, but uses a number of engines and libraries made by others which do some pretty awesome stuff.

Engine
------

Content delivery is powered [Jekyll][jek], a static HTML page generator currently in use on GitHub Pages as well as on countless blogs on the web. I like it because it can use [Markdown][md] (my humane markup language of choice), and it's easy to understand and extend.

I wanted a bit more customization out of Jekyll to design my own folder structure, and to just learn how it works. [My fork][fork] of the Jekyll project is an embodiment of these wishes. Changes to Jekyll include two extra configuration options, `posts:` and `layouts:`, which can override the **_posts/** and **_layouts/** directory locations, as well as a custom YAML config location (**cfg/jekyll.yml**).

Middleware
----------

Aside from the static blog engine, the site also employs a number of other Rack middlewares for serving dynamic data and assets.

### Sprockets

[Sprockets][sprk] serves stylesheets and JavaScript assets, compiling them in the background on new requests. Compilation can be disabled on the server side as the Capistrano script will pre-compile assets when it deploys. Sprockets serves in two places, `css/` and `js/` (as I don't use very many images)

### StatusExchange

Responding to an HTTP request of `GET http://psychedeli.ca/status.json`, this little Rack app aggregates status update feeds from places like Twitter, Facebook, GitHub and Last.FM. It coalesces all of your various feeds together, sorts them by time, then outputs it to a JSON file in a standard fashion. This allows [a jQuery plugin][ticker] to easily read and display the status messages as if they all came from the same place.

### Rack::TryStatic

The Jekyll site is pre-compiled by [Capistrano][cap] on deployment, so [Rack::TryStatic][rts] is used to serve the static files from the `pub/` directory with ease. It comes bundled in the `Rack::Contrib` library, which is required in the Gemfile.

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
