---
layout: post
title: "beyond rails: software development with ruby"
category: code
date: 2012-01-28
---

In case you haven't already figured this out, I am a Ruby programmer. It took me a while before I was really comfortable with calling myself a "programmer" when dealing with Ruby, because I did something most people advise against. I learned Ruby by learning Ruby on Rails. So I learned the framework before I learned the language. Generally, this is frowned upon and causes some very bad habits to develop eearly on. However, learning Ruby this way turned out to not be so bad (even though it took me a bit longer to dive in to Ruby itself), and I continue to make the argument that having quick, tangible results and an emphasis on rapid prototyping allowed me to quickly and easily pick up some of the more advanced concepts of not only Ruby, but HTTP and web development in general. As it is my day job, I do enjoy working in Rails, but sometimes its paradigm just doesn't fit in (well) with what I'm trying to do. Rails isn't for applications which make use of maybe one or two models (though it serves as a great way to prototype such an application...), it's really meant for much larger projects but allows the developer to work quickly and efficiently. Since this blog wasn't for multiple users, and didn't even really need anything but the ability to render Markdown-formatted posts and display them in a nice, mobile-compatible, and simple way.

I tried a [number][sinatra] [of][camping] [alternatives][typo] to simplify the development process, but I wasn't really feeling any of them. Early readers will remember [Typo][typo] as one alternative I used for quite a while because it was the only one that had XML-RPC connectivity. The main way I blogged back then was through [TextMate][mate], so I could simply push the post to the server after I was finished with it, and keep the text copy on my computer as a backup. I gave up attempting to construct an XML-RPC interface to any of the existing blogging platforms, and basically settled on Typo because it already had that in place. Everything else about it sucked though, it still used Rails 2.2 (Rails 3 was out!), Prototype.JS for the JavaScript, and an antiquated themeing framework that just made everything harder to comprehend.

Then, I came across this new thing that Tom Preston-Werner (one of the founders of GitHub) built as the engine that runs GitHub Pages. It's called [Jekyll][jekyll] and it's, well, awesome.

Jekyll takes Markdown-formatted posts and HTML layouts and converts them into an entire blog.

Hacking Jekyll
--------------

I wanted to design [my blog's folder structure][src] in a certain way. For starters, I'm already using 3-character folder names for any custom directories that weren't being preprocessed by Jekyll. I wanted the content rendering engine to be just one part of how the entire app operates, as I have also added Sprockets for asset preprocessing and a Rack app or two for some realtime custom content. For that, I needed to put the whole shebang on Rack, and with [Rack::TryStatic][static], that was made trivial.

[My fork][tubbo/jekyll] now includes [a branch][custom-dirs] called **feature/custom-dirs**, which include support for two new config options, `posts:` and `layouts:`, which define which folders (underneath `source:` that is) you wish to hold Markdown and HTML content, respectively. They replace the formerly forced-upon conventions of using the **_posts/** and **_layouts/** directories with custom defined folders, for ultimate control of the folder structure. In addition, this fork has the added `--config [FILE]` option to the Jekyll binary, which is invoked using the [synth binary][synth] in the [blog repo][src]. I'll be submitting a pull request in due time, but according to [Jekyll's contribution guide][contrib], I must also write Cucumber stories for this shit.

[jekyll]: http://jekyllrb.com
[tubbo/jekyll]: http://github.com/tubbo/jekyll
[custom-dirs]: https://github.com/tubbo/jekyll/tree/feature/custom-dirs
[src]: http://github.com/tubbo/psychedeli.ca
[ass]: https://github.com/sstephenson/sprockets
[static]: https://github.com/gmarik/rack-try_static
[synth]: https://github.com/tubbo/psychedeli.ca/blob/master/bin/synth
