---
layout: post
title: "working with jekyll: a crash course in writing a real ruby program"
category: code
date: 2012-01-28
---

Well it's a new year, and I got a [new job][elocal]. Been wearing some new clothes, working on new music, and generally trying to step into the next phase of my life. [My band][bars] should be releasing its debut album in a couple months, and there are several major gigs coming up that we'll be playing which should prove to be a seriously good time.

But I didn't come here to wax poetic about my life. I came here to talk about a doctor.

That doctor, of course, is [Dr. Jekyll][jekyll]. Jekyll, in case you don't already know is the engine that powers this blog. It's a Ruby program that takes HTML layouts in one directory and Markdown-formatted posts in another and combines them together to create static HTML pages that make the most sense when used with a blog or some sort of frequently-updated web site. It's not quite a web framework, more like a template rendering engine, but it does make some decisions as to where you should put your content, what the folders are called, and what the names of some of the content is called. I'm okay with some of that, but I really like to design my own folder structure. I follow my own standards based on my own work habits and how I navigate my computer, or how I edit text or view a project. For example, I like to keep my directory names at 3-4 characters maximum, because I frequently type 3 characters and then hit tab to autocomplete. Depending on where I am in the shell, sometimes that autocompletion takes a while. With these folder names, I don't have to autocomplete because I can type the whole path out very fast.

So I tasked myself to make Jekyll a little more configurable. After [forking the project][tubbo/jekyll], I found it pretty easy to navigate and figure out what was going on in each method, even without reading the documentation. It was one of the first times I poked around a large-scale Ruby application that wasn't Rails, and certainly the first time that I ever contributed code back into the project. But after beginning my new job, I've become more and more confident in my programming skills that I'll know what to do if something crazy happens. Or alternatively, I can roll back to a point where that won't be an issue anymore. It's quite an empowering feeling.

Hacking Jekyll
--------------

I wanted to design my app's folder structure in a certain way. For starters, I'm already using 3-character folder names for every one of my

[elocal]: http://elocal.com
[bars]: http://soundcloud.com/wonderbars
[jekyll]: http://jekyllrb.com
[tubbo/jekyll]: http://github.com/tubbo/jekyll
