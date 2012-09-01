---
published: false
layout: post
title: "creating the perfect IDE"
category: code
tags: productivity, editors, sublime text 2, macvim, dreams
---

# Well, for me anyways..

Creating the perfect IDE for everyone is a fool's errand. You'd have better luck creating the perfect treaty between Israel and Palestine. Everyone already has their own "style" and comfort in their editor/IDE of choice, and on top of that, the unique pieces of your project may cause you to alter your IDE.

But I want the perfect IDE **for me**. I have problems with every single multi-file editor I've ever picked up, back to TextPad on Windows. And don't even get me started on that absolute piece of trash I was forced to learn Java on, Eclipse. Seriously, Internet Explorer crashes less than Eclipse in the early days. For an open-source program financed by several huge corporations, that's just a fucking joke.

Right now, I use the lovely [Sublime Text 2][st] editor. With it's extensive [package library][pc] and limited extendability, I've gotten used to the way it works and really began enjoying its look and feel. However,

## Total fluid integration

The *only* reliable source of information is actually getting into the nitty-gritty business of reading source code. I never realized how much I didn't look up the source to see why a method is breaking or not behaving the way I thought it would. That is, until I began working at my current gig, and dealing with the aging [ActiveMerchant][am] docs when creating the billing components for our Rails app. The [Light Table][lt] project has been attacking this issue specifically. In fact, Light Table was part of the inspiration for this article, and [they just got accepted into YC 2012][yc]. Congrats to them!

While I believe documentation is a vital source of information, I also find that I learn so much more about the way an API works from actually reading its code. So if I have the ability to read code, read it. Otherwise, check the docs. Documentation should be easy to find and configure for different file types, and each project should be configurable seperately while paying attention to a global configuration. So I believe I should have the option, at all times, to look up the documentation for any method or class, or just view its source code. Including my own.

I don't hold myself at a higher or lower plane than those who create libraries, frameworks or even programming languages. [And you shouldn't either][sj]. So I don't think my code should be in a sandbox while my libraries are off in magicland working behind the scenes. Therefore, I should be able to look up any method, at any time, and see what class it came from (and perhaps what it's overriding!), where the code is, and what its documentation says.

## Project management based on the Finder

I know it's really far from being a "real" UNIX distribution, and I'll probably get a lot of flack for saying this...But I think the [Mac OS X Finder][fi] is the best window manager ever made. It's consistently updated, easy to navigate, and includes several different views for browsing different kinds of files efficiently. This is one thing I really miss about [TextMate][tm], its project drawer had superior file browsing capabilities. I could use custom context menu items, open files in their default program (Sublime makes you look at an ugly binary representation before prompting you to "Reveal in Finder"...) and it behaved similar to the Finder. However, it was still a "drawer", which means it had some serious limitations. Wouldn't it be great if I didn't even have to open the Finder? Like if I could optionally browse files horizontally?

## I should never need to leave my editor

It should be trivial to do everything I need from within the IDE. Launch the server in the background. Run tests. Deploy with Capistrano. Communicate with GitHub and Git in general. This wish has already come true, thankfully, with advanced editors like [Vim][vi], [Emacs][em] and [Sublime][st] offering vast plugin ecosystems. Sublime's key mapping is amazing, but Emacs definitely takes the cake in this department. Since it's all [Emacs Lisp][el], you can write functional code in your key mappings. So your key bindings can internally run functions and, more importantly, *do different stuff based on the environment you're in*. This is the kicker, with Sublime you just can't do that, instead you have to create a plugin with a custom command that a key binding can then execute.

I use Git for my version control needs, so when I create new files I'd like them to be auto-added to Git. It is only in rare circumstances that I don't want a file tracked in the repo. So when I create a file in my editor, why is it so hard to then add it to Git? I feel like if I'm going so far as to save a file, I definitely want that in my repo. And if I don't, there should be a context menu item to unstage or add the file to the commit. And while we're on commits, I should be able to commit to Git from within the editor in another buffer. It should have the files I wanted to commit already added. This type of integrated behavior would make working with Git seamless and allow for an unchallenged level of control of your history.

[st]: http://sublimetext.com/2
[el]: http://elocal.com
[am]: http://github.com/Shopify/active_merchant
[pc]: http://wbond.net/sublime_packages/package_control
[tm]: http://macromates.com/
[vi]: http://vim.org
[em]: http://www.gnu.org/software/emacs
[el]: http://www.gnu.org/software/emacs/emacs-lisp-intro/
[lt]: http://www.kickstarter.com/projects/ibdknox/light-table?ref=live
[yc]: http://www.chris-granger.com/2012/05/17/light-table-is-in-yc/
[fi]: https://en.wikipedia.org/wiki/Finder_(software)
[sj]: http://www.youtube.com/watch?v=8Iw_G4O8THA
