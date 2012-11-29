---
title: pivotal tracker in your shell
date: 2012-11-29
tags: shell, pivotal-tracker
---

At [my company][el], we use the incredible [Pivotal Tracker][pt] to
manage our various projects. The web-based app is fast, and definitely
nice if you're managing the project, but it can be quite confusing
for regular developers to look at. Additionally, being a web app, you
must use a web browser to access it, wrap the site in [fluid][fl], or
use [a native app][pb] that hasn't been updated in a long time (and
has a few outstanding bugs). When you work in the shell 90% of the time,
it can be a little tedious to constantly be switching over to the browser.

So I made a program called [pv](http://github.com/tubbo/pv), designed for regular ol' developers like
myself. It connects to Pivotal Tracker and primarily views your "My Work"
pane in the shell, using sensible formatting defaults based on [git lol][gl].
In fact, much of **pv**'s syntax and formatting are based on my [gitconfig][gc]
and what looked good alongside the output from my `git` commands.

The gem can also view each story separately, using your `$PAGER` (default
is `less`), this view shows more information including the activity and
current state. This extended information can then be observed to run further
editing commands, like `pv start`, `pv stop`, `pv finish` and `pv deliver`. Pass
the **story_id** into each command and the call will be sent to Pivotal that edits
the status of that story. Using `pv log` and these commands, it's not only to view
the status of your part of the project, it's also possible to manipulate your own
stories and let your team know what you're working on. This makes it easy to follow
the progress of the features you've assigned or are working on.

## how elocal uses pivotal tracker

At eLocal, we use "finished" to declare when a given feature or bug fix has been
pushed into the master branch, and ready for deployment to stage. "Delivered" stories
are marked as such when such code, being on the master branch, has been deployed to stage.
Our open-source deployment tool, [rain][rn], looks for finished stories that belong
to the app, and marks them as "delivered" after a successful deploy to stage. Finally,
a story is marked as either "accepted" or "rejected" by a code reviewer (usually our COO
or CTO), based on whether or not the fix actually worked. By keeping to this strict use
of Pivotal's various states, we can know exactly what code is in master and deployed out
to stage, which means we can deploy better code to production, faster.

## viewing the log

You can view your "My Work" pane by typing `pv` or `pv log`:

![pv log]()

As you can see, special mention is given to stories that have been "pinned" at the top of
the list with their status. Any story past the "started" point is pinned to the top until
it is "delivered", at which point it will not show up unless the code reviewer rejects it.

When a rejected story appears, it is pushed to the top of the list and is essentially made
priority 1 in your log.

## what's next?

The next thing down the pipeline is definitely commenting and activity tracking.
It's important to know what the current state of a project is, but typically
comments and the activity feed tell much more about a given story's state when
it's in development for quite some time. I'm also open to suggestions and hopefully pull
requests.

[pt]: http://pivotaltracker.com
[el]: http://elocal.com
[pb]: http://pivotalbooster.com
[fl]: http://fluidapp.com
[ide]: http://blog.sanctum.geek.nz/series/unix-as-ide/
[gl]: http://blog.kfish.org/2010/04/git-lola.html
[gc]: https://github.com/tubbo/dots/blob/master/config/gitconfig
[rn]: http://github.com/eLocal/rain
[pv]: http://github.com/tubbo/pv
