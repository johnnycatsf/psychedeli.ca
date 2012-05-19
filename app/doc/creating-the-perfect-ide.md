---
published: false
layout: post
title: "creating the perfect IDE"
category: code
tags: productivity, editors, sublime text 2, macvim
---

# Well, for me anyways..

Creating the perfect IDE for everyone is a fool's errand. You'd have better luck creating the perfect treaty between Israel and Palestine. Everyone already has their own "style" and comfort in their editor/IDE of choice, and on top of that, the unique pieces of your project may cause you to alter your IDE.

But I want the perfect IDE **for me**. I have problems with every single multi-file editor I've ever picked up, back to TextPad on Windows. And don't even get me started on that absolute piece of trash I was forced to learn Java on, Eclipse. Seriously, Internet Explorer crashes less than Eclipse in the early days. For an open-source program financed by several huge corporations, that's just a fucking joke.

Right now, I use the lovely [Sublime Text 2][st] editor. With it's extensive [package library][pc] and limited extendability, I've gotten used to the way it works and really began enjoying its look and feel. However,

## The "Integrated" part: Fluid integration with the code, not the documentation.

The *only* reliable source of information is actually getting into the nitty-gritty business of reading source code. I never realized how much I didn't look up the source to see why a method is breaking or not behaving the way I thought it would. That is, until I began [working at my current gig][el], and dealing with the aging [ActiveMerchant][am] docs when creating the billing components for our Rails app.

## "Development" and my project: Project management based on the Finder

I know it's really far from being a "real" UNIX distribution, but I think the Mac OS X Finder is the best window manager ever made. It's consistently updated, easy to navigate, and includes several different views for browsing different kinds of files efficiently. This is one thing I really miss about [TextMate][tm], its project drawer had superior file browsing capabilities. I could use custom context menu items, open files in their default program (Sublime makes you look at an ugly binary representation before prompting you to "Reveal in Finder"...) and it behaved similar to the Finder,

## The "Environment": I should never need to leave my editor

It should be trivial to do everything I need from within the IDE. Launch the server in the background. Run tests. Deploy with Capistrano. Communicate with GitHub and Git in general. This wish has already come true, thankfully, with advanced editors like [Vim][vi], [Emacs][em] and [Sublime][st] offering vast plugin ecosystems. Sublime's key mapping is amazing, but Emacs definitely takes the cake in this department. Since it's all Emacs Lisp, you can write functional code in your key mappings. So your key bindings can internally run functions and, more importantly, *do different stuff based on the environment you're in*. This is the kicker, with Sublime you just can't do that, instead you have to create a plugin with a custom command that a key binding can then execute. This is harder to write, but easier to package, so I guess that's a benefit.

[st]: http://sublimetext.com/2
[el]: http://elocal.com
[am]: http://github.com/Shopify/active_merchant
[pc]: http://wbond.net/sublime_packages/package_control
[tm]: http://macromates.com/
[vi]: http://vim.org
[em]: http://www.gnu.org/software/emacs
