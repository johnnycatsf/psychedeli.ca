---

layout: post
title: "back to school: why i'm brushing up on postgres and coffeescript"
category: code
date: 2011-12-18
tags: "`coffeescript, PostgreSQL, #rails, #work"

---

This past week, I put in my two weeks notice at [A + L DESIGN][apl]. It was a tough decision, but after seeing the demand for Rails developers increase in Philadelphia I decided to branch out and see what was out there. Turns out the demand is pretty high, and the supply is a bit low. That's good for people like me! I enjoyed working with my friends at A + L and building remarkably beautiful websites that had a consistent UX in every browser. I'm going to miss the flexible schedule, as well as Honey, our office dog, but I feel like right now is as good of a time as ever to move on and see how developing in Rails for a living will work out. To prepare for the new gig, I've been brushing up on my Rails-fu and learning some new technologies along the way, so I'll be sure to blog about what I've learned.

Here are just some of the new technologies I've been diving into this past week:

## postgres is the only database you'll ever need

[PostgreSQL][pg] is everything you'll ever need in a database. Geolocation? Got it. Full text searching? Built the fuck in. Want to perform a database action when someone invokes a specific SQL command? PostgreSQL makes it _easy_, not just possible. This is big. PostgreSQL essentially eliminates the need to juggle two types of databases (which may be following different paradigms) to achieve complicated database query patterns. I've been silently following Postgres since it picked up steam around version 4 or 5, but never had the chance to use it until Rails came along and I got a [VPS which gave me the Postgres option][webbynode]. Since moving from MySQL and it's awful CLI (or worse, a GUI like phpMyAdmin or Sequel Pro), I've found Postgres to be more secure (by default, it doesn't accept outside connections eliminating the need for a password), more user-friendly (just try typing \d in the CLI!), and quite faster than any other database I've ever worked with. They're doing something right.

## sass isn't just a nickname for my cat

Since the big jump to [Rails 3.0][ror], I've been learning more and more about Sass, specifically the SCSS dialect. I really like SCSS for a number of reasons:

- **Readability:** Looks just like CSS, so it's easy for me to read. As someone who's worked with CSS for a long time, this is refreshing
- **Future-proof:** When WebKit or the Gecko team releases new experimental CSS rules, or the CSS3 standard changes randomly, I don't have to wait for the Sass developers to release an update, or have to make sure my Sass gem is up to date (even though I do anyway). I can just use it. SCSS *is* CSS, that's why I like it...because it's so simple.

## coffee-script so i never have to make it again

And the big one... *takes a deep breath*

I think I'm going to develop future JavaScript code in CoffeeScript. Not sure if I need this for my job, but I look at the JavaScript it produces and it really does look like a human wrote it. I had my doubts about Coffee in the beginning, for the most part being concerned about the code it generates and how that interacts with the sometimes chaotic world of cross-browser development. I'm happy to say, however, that I'm a humbled convert to the zen that is CoffeeScript. 

My reasons for adopting Coffee in a Rails environment is simple. The [Sprockets asset manager][sprockets] is performing a compilation step before a full load of the HTML takes place anyway, right? What's the difference if it's minifying and concatenating my JavaScript files together or if it's compiling Coffee into JS then minifying? Sure, there's an extra step that takes place in that sense, but there's already an "extra step" taking place between request and response regardless of whether or not I use CoffeeScript. And when the code is in production, compilations can be cached and assets can only be compiled when the server launches. Serving "syntactic sugar" languages like CoffeeScript or Sass is just as straightforward as serving CSS or JavaScript in Rails and Sprockets.

## jekyll and sprockets: the answer is rack

I'm trying to spruce up this blog a bit more, and I'd like to use the same technologies I've been using with Rails: [Sprockets][sprockets], [Sass/SCSS][sass] and [CoffeeScript][coffee]. I've created a rudimentary `generate` script which compiles the Sass stylesheets, [uglifies my JavaScript][uglify], and finally generates the [Jekyll site][jrb], but I'd like to do all of this on the fly, using [Rack][rack]. Once I figure that out, I'll get back to you. For now, it's still statically driven and will probably be for a few weeks here...

[apl]: http://aplusldesign.com
[pg]: http://postgresql.org
[webbynode]: http://webbynode.com
[ror]: http://rubyonrails.org
[sprockets]: https://github.com/sstephenson/sprockets
[coffee]: http://jashkenas.github.com/coffee-script/
[sass]: http://sass-lang.com/
[uglify]: https://github.com/mishoo/UglifyJS
[jrb]: http://jekyllrb.com
[rack]: http://rack.rubyforge.org/