psychedeli.ca is my internet web site
=====================================

This is the complete source code for my blog, which is (usually) up and running on <http://psychedeli.ca>. I mostly post music, programming or some other geek related articles based on what I'm doing at the moment and what I've learned along the way. Originally made by cobbling together Sprockets, my fork of Jekyll, and a little Rack app I made to serve a JSON feed of my status updates across the various social networking sites, it has now been rebooted as a lightweight Rails app that wraps the original Jekyll site.

[![Build Status](https://secure.travis-ci.org/tubbo/psychedeli.ca.png?branch=master)](http://travis-ci.org/tubbo/psychedeli.ca)

Content
-------

Content delivery is powered by [Jekyll][jek], a static HTML page generator currently in use on GitHub Pages as well as on countless blogs on the web. I like it because it can use [Markdown][md] (my humane markup language of choice), and it's easy to understand and extend.

I wanted a bit more customization out of Jekyll to design my own folder structure, and to just learn how it works. [My fork][fork] of the Jekyll project is an embodiment of these wishes. Changes to Jekyll include two extra configuration options, `posts:` and `layouts:`, which can override the **_posts/** and **_layouts/** directory locations, as well as a custom YAML config location (**cfg/jekyll.yml**).

Development
-----------

I develop with Thin and my Mac's Apache server. It's the closest thing to my actual production configuration, which uses Apache and Unicorn.
I've written a number of Rake tasks to make developing easier, though these days I just keep Guard running 

### rake server

Automatically runs Thin on port 4000, and if you add the contents of `config/vhost.conf` to your Apache vhosts configuration, you'll be able to access
the local site on `dev.psychedeli.ca`. Thin is run in the background with this command.

There are three subcommands: **server:start**, **server:stop** and **server:restart**. The main task automatically determines which of the subtasks to
invoke.

### rake test

Extended to also compile the site with Jekyll and copy configuration files if you have not already done so. The latter of these extensions is
used primarily on CI, since Travis creates a new VM each time you build, so all configuration in YAML files must be stubbed out for the test
environment.

Roadmap
-------

- Move all Markdown source files to **app/documents/articles**
- Create the `Article` model for representing a single article. Use the
  newly-created source directory to look up articles "by ID", which is
  actually their filename without the extension.
- Create the `MarkdownHandler` module for using Markdown in the Rails
  view layer. This enables the rendering of Markdown files on-the-fly
  using our custom `Redcarpet::Renderer` which allows for automatic
  syntax highlighting via [Pygments.rb][pyg]

- Move articles directory to `app/documents/articles`
- Create Article model to represent an Article in `app/documents/articles`. It will not use a database. Rather, it will utilize the filesystem to look up source files and compile their Markdown source code to HTML.

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
