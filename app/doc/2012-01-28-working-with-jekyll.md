---
layout: post
title: "ruby sans rails: software development with ruby"
category: code
date: 2012-01-28
---

In case you haven't already figured this out, I am a Ruby programmer. It took me a while before I was really comfortable with calling myself a "programmer", when dealing with Ruby, because I committed geek treason. I learned the framework before I learned the language. Learning this way turned out to not be so bad (even though it took me a bit longer to dive in to Ruby itself), and I continue to make the argument that having quick, tangible results and an emphasis on rapid prototyping allowed me to quickly and easily create apps that

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
