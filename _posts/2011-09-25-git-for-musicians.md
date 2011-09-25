---

layout: post
title: git for cavemen...i mean...musicians
category: composition
date: 2011-09-25
tags: #git, #collaboration

---

## the problem, and how it came about

The Digital Audio Workstation (DAW). It's certainly changed music forever, for better or for worse. The good news is there are a LOT more people making music. The bad news is...you guessed it, **there are a lot more people making music**.So you have more people making music on more DAWs, and the DAW has up until very recently been designed for in-studio, single-user use. You may have one or a whole group of engineers who get to _touch_ the DAW, but my point is there was still just one copy of the software floating around.

We now live in an age where most people do not spend any time in a shared recording studio space to make their music. The music that's coming out of people's bedrooms has greatly surpassed the now-"traditional" idioms of rock, classical, jazz, and even hip-hop in both sophistication and mainstream popularity. In fact, most of the music that's made in those traditional idioms is being collaborated on between producers in separate rooms, possibly even separate localities across the world. Yet each DAW is meant for a single user. So how do these people collaborate on projects?

People who do live in the same locality get the benefit of being able to share a large external hard drive with each other. But what happens if one of the collaborators feels "the urge" to empty his soul onto the track, and does a really awesome breakdown? Now, imagine if the other collaborator also gets an urge to improve the drum quality and puts the breakdown in an entirely different spot in the song? Both collaborators are using the same project folder and project name on separate machines. One brings the hard drive over, and either overwrites the other's changes (if they don't bother to ask if the other did anything..) or just renames the other project and attempts to work on both of them side-by-side. How would a situation like this have to work out? Most of the time, you can create separate project files, but now you're running into the problem of a possible collision of audio files. Data can be lost, projects can become corrupt, and one may need to attempt to re-generate sounds that may no longer be possible to synthesize. 

Collaboration doesn't have to be this hard, guys. What if I told you there was a way to not only keep track of the changes in your project's history after every time you hit the save button (allowing you to easily refer to points in time where the project changed)? What if you could "branch" a project and keep track of both the original project you downloaded and your version of it? And what if you could push back your changes (even in a custom branch) to the server, allowing you to keep a backup of every project you create?

Now what if all of that could be done in the same program?

## git to the rescue!

That's where [Git][1] comes in. Git is a [version control][3] system written by [Linus Torvalds][4] (you know, the Linux guy). It was actually written to control the Linux kernel's source code, a project that has thousands of contributors and one that is moving at quite a fast pace. A version control system is used in programming to keep track of changes to the source code of whatever they're working on. It comes in handy when there are multiple simultaneous contributors (like at an office) who may or may not be directly communicating with one another. This definition, of course, fits the **collaborating musician** as well.

In version control, the folder you're working in is called the "repository". A repository is basically a folder with data in it that a version control system keeps track of. Early version control systems used to store all of the repository's metadata (like configuration or change history) on a remote server, and force all clients to remain in sync with that server. Git, however, is [distributed][2], which means you get all of the repository's extra data when you download it. This is useful because you can make changes, commit and branch from the repository (allowing you to basically work) without communicating with a server at all. So you can do a lot of work offline, like in an airplane or anywhere else you can't get internet access, and still be able to save (or "commit") your changes to the repository. When you do get internet access, you can just "push" your changes to the remote server for backup purposes.

Perhaps the most powerful feature of Git, however, is **branching**. Branching is a concept in version control where you basically take the most current version of a source code and copy all of its contents to a separate folder, forming a new "branch" of the code. This allows you to make changes and do work without affecting the main codebase, which may be at a stable point and your work may interfere with that stability. With high-performance, large applications, this is a major concern and branching must work properly for their applications to maintain stability. In the Git universe, all copies of the repository are a "branch". Except in rare, advanced circumstances, you are always working in a branch of the repository. The default branch is always called "master", it is by default the version of the files downloaded to your computer when you clone a repository. There are ways to configure 

## git and you

So why do you need to know this? 

## get it going

Git is pretty easy to install, but the only requirement is [Xcode][]. You'll have to buy it from the Mac App Store, and it costs $3.99. Most of us developers already have it, so if you are a developer of any language check your **/Developer** folder, you may already have it.

Now that you have Xcode installed, it's time to install the actual programs. First, install **brew**. Brew (or Homebrew) is a [package manager][] for Mac OS, which means with a command-line interface you can update and install new (or old) versions of command line software such as Git. Makes it a lot easier to maintain the software over time. Open up "Terminal" (it's in your Utilities folder) and paste this into the prompt:

`/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"`

This will install Homebrew to the folder **/usr/local**, so you don't need to enter your password every time you install something. Enter your password here when it prompts you, and read [this document][7] to understand more about how Homebrew installs to your computer.

Now that you have Homebrew installed, all you have to do to install git is:

`brew install git`

It will download and install the source package and tell you when it's done. To test it, run:

`git --version`

You should get a response along the lines of `git version 1.7.6`. It definitely _shouldn't_ be an error. 

## put your git to work



[1]: http://git-scm.com
[2]: http://en.wikipedia.org/wiki/Distributed_version_control_system
[3]: http://en.wikipedia.org/wiki/Version_control_system
[4]: http://linustorvalds.com