psychedeli.ca is my internet web site
=====================================

This is the complete source code for my blog, which is (usually) up and running on <http://psychedeli.ca>. I mostly post music, programming or some other geek related articles based on what I'm doing at the moment and what I've learned along the way. The blog itself is completely custom-made, but uses a number of engines and libraries made by others which do some pretty awesome stuff.

Engine
------

The blog is powered by [Jekyll][jek], a

I wanted a bit more customization out of Jekyll to design my own folder structure, and to just learn how it works. [My fork][fork] of the Jekyll project is an embodiment of these wishes. Changes to Jekyll include two extra configuration options, `posts:` and `layouts:`, which can override the **_posts/** and **_layouts/** directory locations, as well as a custom YAML config location (**cfg/jekyll.yml**).

Middleware
----------

Aside from the static blog engine, the site also employs a number of other Rack middlewares for serving dynamic data and assets.

### Sprockets

[Sprockets][sprock] serves stylesheets and JavaScript assets, compiling them in the background on new requests. Compilation can be disabled on the server side as the Capistrano script will pre-compile assets when it deploys. Sprockets serves in two places, `css/` and `js/` (as I don't use very many images)

### StatusExchange

Responding to an HTTP request of `GET http://psychedeli.ca/status.json`, this little Rack app aggregates status update feeds from places like Twitter, Facebook, GitHub and Last.FM. It coalesces all of your various feeds together, sorts them by time, then outputs it to a JSON file in a standard fashion. This allows [a jQuery plugin][ticker] to easily read and display the status messages as if they all came from the same place.

### Rack::TryStatic

The Jekyll site is pre-compiled by [Capistrano][cap] on deployment, so [Rack::TryStatic][rts] can be used to serve the static files from the `pub/` directory with ease. It comes bundled in the `Rack::Contrib` library.

### Autocorrect

When the request can't be properly served by Sprockets, StatusExchange, or Rack::TryStatus

Development
-----------

If you'd like to fork this for your own uses, I have included a number of development tools that have aided me in my progress on this project. I personally run my staging server on [Heroku][ku] and develop locally with [Pow][pow], but you can use anything that runs Rack apps. As such, most of the dev tools I've created come in the form of [Rake][rake] tasks.

### rake compile

This simply runs `bundle exec jekyll` to compile the static site. It will compile to the `pub/` directory, or whatever you set it to in `cfg/jekyll.yml`.

### rake restart

As is the convention with most Rack servers, this runs `touch tmp/restart.txt`. It is in the form of a Rake task so it would be easier for `rake compile` to call it.

### rake test

An extension of `Rake::TestTask`, this runs the [MiniTest][mt] suite in `test/` which runs the specs for Autocorrect and StatusExchange.

[sass]: http://sass-lang.com
[jq]: http://jquery.com
[jek]: http://github.com/mojombo/jekyll
[fork]: http://github.com/tubbo/jekyll
[liq]: http://github.com/shopify/liquid
[ku]: http://heroku.com
[pow]: http://pow.cx
