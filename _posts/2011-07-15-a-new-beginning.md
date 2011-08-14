---

layout: post
title: a new beginning
category: general_bullshit
date: 2011-07-15

---

So here we go, another new layout and another re-hash of this blog's content. I threw away the last two iterations (still have the data, though) of this blog, because I was unsatisfied with the poor content on it. So let's start again.

This will be a blog about programming, music, philosophy, and everything in between. So let's start off with a little information about how this blog was put together.

# how it's made

## back-end. giggity.

This blog marks a departure from Rails-based or PHP-based systems. I just didn't feel like dealing with the web-based admin interface (that I never use, I usually push my posts as Markdown files directly to the blog using XML-RPC), and wasting my time testing/working around a web app framework that was really overkill for what I was trying to do. I'm using [Jekyll][1] now, which is a Ruby app that takes the contents of my Markdown posts and injects them into HTML layouts. It's allowed me to focus much more on gett [JavaScript skills][2] and playing with [a new CSS framework][3]

### more naughty bits: assets and packaging

With this blog, I've been experimenting with different ways of delivering static linked assets to my HTML pages. So I've taken a couple well-known frameworks that already exist and applied them to my blog to test it out on a real site. The results have been spectacular. My assets are equipped at any time to be compressed, minified, and delivered to the user at lightning-fast speeds, even though I have TONS of files in my javascript/stylesheet directories!

This is the first time I've used [Compass][3] and [Sass][4] SCSS for styling. I'd been using Sass on [some Rails projects][5] in the past, but never to this degree. Sass has really allowed me to roll my own organizational framework for my stylesheets. Normally, linking too many CSS files slows down page load times, because the browser has to download all of the styles before applying them to the markup and rendering the page. Sass solves this problem by using `@import`, a normal CSS2.1+ directive that Sass overrides when you
pass it a `String` instead of a `url()`. If it encounters a Sass "partial" (designated by a "_" in front of the filename), it will actually load that partial into the CSS file being compiled. If you use the SCSS syntax, you can literally mix in plugin stylesheets, `@font-face` declarations, extra classes, [jQuery UI][6] themes, and everything else right into your main CSS file, and load *one* file with every style on your page in it. Since I'm using [Jekyll][1], I'm already "compiling" a website together, so I just wrote a little script that compiles my stylesheets and then generates my Jekyll website:

	compass compile css/app/screen.scss && jekyll
	
This simple command's order is very important. The CSS needs to be generated before Jekyll compiles the site into the public directory, or else the CSS changes won't be observed until you generate the Jekyll site again. Sass/Compass can even minify and compress this stylesheet so it uses the least bandwidth possible in transfer.

Well that should cover my stylesheets, but what about the corresponding JavaScript assets? As an everyday [jQuery][7] user, I'm familiar with its vast array of plugins in every shape & size for almost any JavaScript functionality you can think of. I also enjoy extracting functionality I'm using repetitively into a jQuery plugin either so my DOM ready function stays short and sweet. To make matters worse for the HTTP server, every plugin is in its own file, so if your page loads 20 JavaScript plugins...well...it can be a little much. Thankfully, [RequireJS][8] has come to save the day. By [combining jQuery with the RequireJS code][9], the developers of Require.JS made it super-easy to get started if you're using jQuery. Require.JS is basically a function called `require()` that takes an array of filenames and a callback as parameters. The array of filenames is loaded (in order) onto the DOM, and the callback function is executed once every file has been found and loaded properly. It allows you to have one `<script src>` tag in the `<head>` of your pages, which links to the `require.js` file and the "main" file, which is loaded first and includes the calls to `require()`. If you use `require-jquery.js`, you can pass a `$` into the callback function's arguments and you'll get a jQuery object you can use in the callback. This is similar to [writing jQuery plugins][10] where you map `$` to the jQuery object in a closure, except we're doing it in a callback instead of a closure. Using the [Google Closure][11] compiler, I can minify and compress all of my JavaScript code into a single file, which I then call from the `<head>` of my page.
	
I don't do this kind of optimization for most of my sites, because usually it doesn't matter. But in this case, I felt it was necessary. Here's why... 

## a marxist user interface: where content is premier

I designed the user interface of this blog so it would not only be accessible on all platforms & devices, but would also be pleasurable to navigate in the process. It needed to be animated, slick, and intuitive...but it also needed to fall back to an equally presentable straight HTML layout in the event of failure. Deciding on a "carousel" style layout, I proceeded to make the JS that would eventually control the user interface. The plugin, `jQuery.articleCarousel`, can be invoked on a block-level HTML element (like `<section>`), and
used to maneuver between `<article>`s scrolling left or right. Moving left & right can be done with the arrows, but can also be 


[1]: http://jekyllrb.com/
[2]: http://eloquentjavascript.com/
[3]: http://compass-style.org/
[4]: http://sass-lang.com/
[5]: https://github.com/tubbo/diaspora/
[6]: http://jqueryui.com/
[7]: http://jquery.com/
[8]: http://requirejs.org/
[9]: http://requirejs.org/docs/jquery.html
[10]: http://docs.jquery.com/Plugins/Authoring#Getting_Started
[11]: http://code.google.com/closure/compiler/