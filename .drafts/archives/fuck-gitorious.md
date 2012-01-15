---

layout: post
title: "fuck gitorious"
category: programming
tags: "rant, git, visualization, rails"
date: 2011-04-10
---

After several weeks of labor all for nought, I've given up on using [gitorious](http://gitorious.org/) as my web-based git repo visualizer. All I want is [GitHub](http://github.com/) without paying the money, is that so much to ask for?? :)

Anyway, I'm starting work on a gitweb replacement called **repoman** that will serve as the primary way I look at commit history, project information, and other fun data that I need for my daily development activities. It will use the [Grit](http://grit.rubyforge.org/) gem as the primary method of contacting git, but it will also work in and around [gitolite](https://github.com/sitaramc/gitolite) so git repositories can still be committed to safely and securely. It will use a [jQuery](http://jquery.com)-based Ajax-driven user interface, for maximum comfort, and it will basically act as a central control panel for git repositories. Gitolite will still act as the secure median in between git-daemon and repoman, but its configuration files will be structured in such a way that it allows administration by a 3rd-party interface in a non-destructive and unobtrusive manner.

It will, of course, require gitolite to be installed as well as the bundled gems described here.
