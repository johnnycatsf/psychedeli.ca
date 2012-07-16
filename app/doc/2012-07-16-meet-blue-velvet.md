---
layout: post
title: blue_velvet: use the Facebook platform as your database
category: code
date: 2012-07-16
---

In more than one case as a freelancer, I've been given the problem of
pulling down data from a client's Facebook page and displaying it in a
nice way. In every one of these cases, the content used to develop the
Facebook page is copied out from the local database that the client
enters their copy in. In order to get this content available, [my former
employer][al] and I would design and develop the basic site with [lorem
ipsum][sli] text, then hand the work off to the client so they can add
in their real content *and* give us a solid test of our CMS deployment.
Most clients are also interested in connecting their page to the
Facebook Open Graph, meaning extra metadata at the top of the page as
well as some of the same content on their Facebook page. In doing so,
they improve ther categorization abilities, as well as SEO on the Facebook platform.

But there's something wrong with this picture...

## the problem of duplicate data

The process by which we create basic client sites had an inherent flaw.
Duplicate and stale data had many avenues to cross into and disrupt our
workflow. If we are of the belief that [content is king][cik], we can
deduce that the design and copy are the most important parts of the
site, and thus must be thoroughly maintained in order to keep customers
coming back. This was especially true in our line of work, since [the
sites][611] [we typically create][itt] have a relatively smaller scale
and shorter update cycles, and thus emphasize an inviting design and
interesting content to drive in traffic. Therefore, stale data is
a much bigger problem than it would be on, say, the about page of a
social network, where the data is crowdsourced and always updating.

## the lack of a better choice

The [Facebook Platform][fbd] and [Open Graph][ogp] are a ubiquitous
presence on the internet. Its primary currency, the [Facebook
Page][fbp], is growing to be one of the largest databases of
information, and perhaps the largest database of current, trusted
crowd-source information, on the internet. Today's developers are
interesting in doing less, not more, so they can focus on building and
maintaining applications. Your client doesn't care how your database is
structured, they care about how the site looks, feels, and operates.
So why do we waste time reinventing the wheel every deployment and
maintaining up-to-date versions of our database? Because there really
isn't any other choice.

[al]: http://aplusldesign.com
[sli]: http://samuelipsum.com
[cik]: http://www.craigbailey.net/content-is-king-by-bill-gates/
[611]: http://611lifestyle.com
[itt]: https://trauma101.com/
[fbd]: https://developers.facebook.com/
[ogp]: http://opengraphprotocol.org/
[fbp]: https://www.facebook.com/pages/create.php
[koa]: http://rubygems.org/gems/koala
[twb]: http://thewonderbars.com
