---
layout: post
title: "weaning off oh my zsh"
category: code
date: 2012-03-08
tags: shell, zsh, git, gitflow, productivity
---

Since December 2011, I've been working with [ZSH][zsh], an alternate shell for *NIX-based operating systems which has conventions similar to [BASH][bash], ZSH adds a number of more modern features to the standard shell fare, such as more customization options for your prompt and extendable autocompletion. To get started on it, I've employed the lovely [Oh My ZSH][omz] framework which helps to organize your ZSH settings (`.zshrc`) and use functionality developed by others so you can explore the wonderful possibilities of this awesome shell.

Oh My ZSH was designed for new users, and is meant to be replaced at some point in the future by a `.zshrc` that handles everything. This was also my eventual goal, but after getting more comfortable with Oh My ZSH, I began realizing that I would be missing out on a number of enhancements it gives my shell experience:

- **Plugins:** A big part of my love for Oh My ZSH is its plugin architecture. With a shitload of premade plugins and the ability to easily add your own, incorporating new programs/functionality into my current shell workflow is trivial. For example, I began using [git flow][flow] yesterday, a plugin based on [Nvie's "A successful git branching model" blog post][nvie] and after enabling the plugin found that it was incredibly easy to work with. Through subsequent trial and error, this same functionality would have taken days to implement (making small changes/additions here and there), but with the plugin I was able to just start using git-flow using conventional 3-character aliases, just like my interface to git, with the same level of autocompletion I've come to expect from ZSH's powerful engine.

- **Concurrency:** Oh My ZSH has an update function that it fires each week to keep the plugins directory up to date. When new technologies are made available, it doesn't take very long before a plugin for that software is added to the Oh My ZSH repo.

- **Built-in functionality:** In addition to its massive plugin library, Oh My ZSH also comes with a collection of aliases, functions and variables for use in your scripts and everyday use. This useful built-in functionality is stuff I use on an everyday basis for prompt display, general hackery, and other fun shell tasks.

These features of Oh My ZSH make it a possibility to use as a power user of ZSH. But the aim of the project is to help newer users get acquainted with the shell, so I've decided to start my own project which is based off of Oh My ZSH (it was originally [my fork of oh-my-zsh][fork]), but removes some newbie sugar such as themes and installation management. I figure everyone can figure that out on their own, plus it goes against the concept of the framework entirely. The idea behind this framework is for you to fork it, and maintain that fork with your own "dot files", scripts and other home-dir tools you need for general hackery. Once again, it's meant as a starting point but it strips away unnecessary shit that you're never, ever going to use. I'll post more about this upcoming framework as I make it, but you can [follow the progress][fork] yourself and who knows, maybe even contribute! ;)

I have no idea what I'm naming it yet.

[zsh]: http://www.zsh.org/
[bash]: http://www.gnu.org/software/bash/
[omz]: https://github.com/robbyrussell/oh-my-zsh
[flow]: https://github.com/nvie/gitflow
[nvie]: http://nvie.com/posts/a-successful-git-branching-model/
[fork]: http://github.com/tubbo/oh-my-zsh
