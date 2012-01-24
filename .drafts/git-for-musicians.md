---

layout: post
title: "git for cavemen...i mean...musicians"
category: music
date: 2011-10-16
tags: "#git,#collaboration"

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

Perhaps the most powerful feature of Git, however, is **branching**. Branching is a concept in version control where you basically take the most current version of a source code and copy all of its contents to a separate folder, forming a new "branch" of the code. This allows you to make changes and do work without affecting the main codebase, which may be at a stable point and your work may interfere with that stability. With high-performance, large applications, this is a major concern and branching must work properly for their applications to maintain stability. In the Git universe, all copies of the repository are a "branch". Except in rare, advanced circumstances, you are always working in a branch of the repository. The default branch is always called "master", it is by default the version of the files downloaded to your computer when you clone a repository.

With Git, two collaborating musicians working independently on the same project can create personal branches of the track and push them to the main remote server. Then, when they meet for a live collaboration, they can download each other's branches and with a single command switch between the two to see which sounds better. Deleting the branch is just as easy as creating it, so you can save disk space by deleting old branches you don't work with anymore. 

## git going

Git is pretty easy to install, but the only requirement is [Xcode][5]. You'll have to buy it from the [Mac App Store][6], and it costs $3.99. Most of us developers already have it, so if you are a developer of any language check your **/Developer** folder, you may already have it.

Now that you have Xcode installed, you can install git as a package. This is the easiest and cleanest way of installing command-line *NIX programs for Mac. First, install **brew**. Brew (or Homebrew) is a [package manager][7] for Mac OS, which means with a command-line interface you can update and install new (or old) versions of command line software such as Git. Makes it a lot easier to maintain the software over time. Open up "Terminal" (it's in your Utilities folder) and paste this into the prompt:

> `/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"`

This will install Homebrew to the folder **/usr/local**, so you don't need to enter your password every time you install something. Enter your password here when it prompts you, and read [this document][8] to understand more about how Homebrew installs to your computer.

Now that you have Homebrew installed, all you have to do to install git is:

`brew install git`

It will download and install the source package and tell you when it's done. To test it, run:

`git --version`

You should get a response along the lines of:

`git version 1.7.6`

## put your git to work

Now that you have Git installed, you need to start creating repositories. Which means you need to change the directory you're working in. To do this, type `cd "&lt;path&gt;"`. The way I have my music organized, I have to type `cd "~/Music/Logic/Wonder Bars/Life Comes Around/"`. There will be no response if this worked. If it didn't, you probably spelled the path wrong. 

###If you'd like to follow along, I would advise you to create a new Logic project with nothing in it. It will prevent anything from getting corrupted or lost in the process of doing the actions in this tutorial.

Now that you're in the proper directory, you have to set up the repo. To do this, type:

	git init

That's it. You should get a response that looks like `Initialized new git repository in /Users/tubbo/Music/Logic/Wonder Bars/Life Comes Around/.git/`.

Now that you created the repository, you need to add all of your files to it. Git assumes nothing by default (except default settings you lay out in `~/.gitconfig`), so you need to tell it which files to track and which ones to ignore (optionally). Right now, you're gonna add 'em all! Type:

	git add *

This may take a minute, there are a lot of big files! Type the following to "commit" these files into the repository

	git commit -am "initial commit"

This may also take a minute. But now, your changes have been saved in the repo forever. And as long as you don't delete the .git/ folder inside your repo, these changes will be accessible by simply "checking out" this first commit. Isn't that lovely? Don't close out of the Terminal just yet, you'll be needing it this whole time.

## committing your changes

After doing some work in your project, you may want to save your place. What I like to do is commit every time I save changes in my project. So after you save, open the Terminal again and type

	git commit -am "added drums"
	
See how fast that was? Git doesn't have to communicate with the outside world at all to save a history of your changes in Logic.

## back that thang up

Git can also be used to back up your music to a remote server. The best way to do this (and to foster collaboration) is to use a remote server management tool like [Gitolite][9]. However, this can be somewhat challenging to maintain and get started with if you're not already a hacker, so I propose that you sign up for a shared git hosting account (such as [GitHub][10] or [Bitbucket][11], both free) to make that part of your life easier. You can purchase private repository space on both of those sites, wherein you can configure access to the repository for other account holders. However, if you keep all of your repositories public, they will be hosted for free. This was obviously designed with free software in mind, and while I believe music producers should be taking cues from the open source movement, I also know that it's very easy to steal an idea and release it quickly. This is why I suggested in the last section to use an empty project, as this tutorial is more about the personal use of Git rather than its remote server administration. I'll get to that in the future.

In any case, let's assume that you signed up for a [GitHub][10] account. Create a new repository and copy down the `Git URL` from the new page (click the "Clipboard" icon next to the input field to copy its contents to the clipboard). This follows the following syntax: `git@github.com:<your-username>/<your-project>.git`. **Make sure it follows that syntax, or else you won't be able to push your updates.**

Next, open up your Terminal and type
	
	git remote add origin <your-git-url>
	
Which should look something like

	git remote add origin git@github.com:tubbo/a-very-nice-banger.git
	
So now you have a "remote" set up. This is a place that git can securely copy your local repository's history and files, and maintain a relationship with it that 

## updates

I will update this article with sequels and stuff, in the meantime if you have anything you want to learn more about, post it in the comments and I'll be happy to write something about it. 

[1]: http://git-scm.com
[2]: http://en.wikipedia.org/wiki/Distributed_version_control_system
[3]: http://en.wikipedia.org/wiki/Version_control_system
[4]: http://linustorvalds.com
[5]: http://developer.apple.com/xcode/
[6]: http://itunes.apple.com/us/app/xcode/id448457090?mt=12
[7]: http://en.wikipedia.org/wiki/Package_management_system
[8]: https://github.com/mxcl/homebrew/wiki/installation
[9]: http://sitaramc.github.com/gitolite/
[10]: http://github.com/
[11]: http://bitbucket.com/