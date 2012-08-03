---
layout: post
title: "beyond rails: blogging from scratch"
category: code
date: 2012-01-28
---

In case you haven't already figured this out, I am a Ruby programmer. It took me a while before I was really comfortable with calling myself a "programmer" when dealing with Ruby, because I did something most people advise against. I learned Ruby by learning Ruby on Rails. So I learned the framework before I learned the language. Generally, this is frowned upon and causes some very bad habits to develop eearly on. However, learning Ruby this way turned out to not be so bad (even though it took me a bit longer to dive in to Ruby itself), and I continue to make the argument that having quick, tangible results and an emphasis on rapid prototyping allowed me to quickly and easily pick up some of the more advanced concepts of not only Ruby, but HTTP and web development in general. As it is my day job, I do enjoy working in Rails, but sometimes its paradigm just doesn't fit in (well) with what I'm trying to do. Rails isn't for applications which make use of maybe one or two models (though it serves as a great way to prototype such an application...), it's really meant for much larger projects but allows the developer to work quickly and efficiently. Since this blog wasn't for multiple users, and didn't even really need anything but the ability to render Markdown-formatted posts and display them in a nice, mobile-compatible, and simple way.

I tried a [number][sinatra] [of][camping] [alternatives][typo] to simplify the development process, but I wasn't really feeling any of them. Early readers will remember [Typo][typo] as one alternative I used for quite a while because it was the only one that had XML-RPC connectivity. The main way I blogged back then was through [TextMate][mate], so I could simply push the post to the server after I was finished with it, and keep the text copy on my computer as a backup. I gave up attempting to construct an XML-RPC interface to any of the existing blogging platforms, and basically settled on Typo because it already had that in place. Everything else about it sucked though, it still used Rails 2.2 (Rails 3 was out!), Prototype.JS for the JavaScript, and an antiquated themeing framework that just made everything harder to comprehend.

Then, I came across this new thing that [Tom Preston-Werner][tpw] (one of the founders of GitHub) built as the engine that runs GitHub Pages. It's called [Jekyll][jekyll] and it's, well, awesome. Jekyll merges HTML layouts with Liquid templates and Markdown text content to build a site that's simple and fast. Since it's just static HTML, there's no waiting around for the database to return with the proper data, nor is there any extra time while the data is parsed to be human readable. Everything is "just there". But Jekyll isn't a complete solution. Designed for GitHub pages, a huge userbase, it's of no surprise that the program isn't all that configurable. For example, you can't change the directory where posts and layouts and plugins are read from, nor can you change the location/filename of the YAML config. Until now, that is.

Hacking Jekyll
--------------

I wanted to design [my blog's folder structure][src] in a certain way. For starters, I'm already using 3-character folder names for any custom directories that weren't being preprocessed by Jekyll. I wanted the content rendering engine to be just one part of how the entire app operates, as I have also added [Sprockets][ass] for asset preprocessing and a Rack app or two for some realtime custom content. Using [TryStatic][static], the static content on <http://psychedeli.ca> can be served on the Rack stack alongside [StatusExchange][sx], my status update feed(s) parser. Rack middleware allows me to handle each request that comes in with a set number of classes. So for example, StatusExchange is only meant to respond on requests to **/status**, and any other requests just gets sent to the next middleware, which in this case is TryStatic. TryStatic will simply read the request and try to find a matching file in the **pub/** directory, which is where Jekyll is storing the site.

[My fork][tubbo/jekyll] now includes [a branch][custom-dirs] called **feature/custom-dirs**, which include support for two new config options, `posts:` and `layouts:`, which define which folders (relatively, underneath `source:` that is) you wish to hold Markdown and HTML content in, respectively. They replace the formerly forced-upon folder naming conventions of **_posts/** and **_layouts/** with custom defined folders, for ultimate control of the folder structure. In addition, this fork has the added `--config [FILE]` option to the Jekyll binary. I'll be submitting a pull request in due time, but according to [Jekyll's contribution guide][contrib], I must also write Cucumber stories for this shit. As I'm not a big fan of Cucumber (I think it's kind-of a waste of time), I'm also learning how to write stories/step definitions without breaking the whole thing as I write this new feature in.

[jekyll]: http://jekyllrb.com
[tubbo/jekyll]: http://github.com/tubbo/jekyll
[custom-dirs]: https://github.com/tubbo/jekyll/tree/feature/custom-dirs
[src]: http://github.com/tubbo/psychedeli.ca
[ass]: https://github.com/sstephenson/sprockets
[static]: https://github.com/gmarik/rack-try_static
[synth]: https://github.com/tubbo/psychedeli.ca/blob/master/bin/synth
[sx]: https://github.com/tubbo/psychedeli.ca/blob/master/lib/status_exchange.rb
[tpw]: http://tom.preston-werner.com/
[contrib]: https://github.com/mojombo/jekyll/wiki/contribute
[sinatra]: http://sinatrarb.com
[camping]: http://camping.rubyforge.org/
[typo]: http://typosphere.org
