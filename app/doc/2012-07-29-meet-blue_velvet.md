---
layout: post
title: "meet blue_velvet: a facebook cms"
category: code
date: 2012-07-29
tags: "#facebook, #open_graph, `blue_velvet, ruby"
---

It's certainly been a while, hasn't it? I've been busy with gigs and
Transformus, so there's been little time to blog. I have been working on
stuff, including the foundation of a record label (which I'll talk about
in a future post) and maintaining the Wonder Bars' official website.

In the time it's taken me to maintain that site, I've been quietly
developing a solution to a problem I think most small-scale developers
have, **content duplication**. In other words, we've all run into the
problem of a company's Facebook page saying one thing and their website
another. Who wants to log into 2 different accounts just to paste the
same paragraph of text? Furthermore, what if each CMS has its own input
format...say one lets you do Markdown but the others force you to be
either text-only or HTML-only. Now you're looking at converting content,
and for non-programmers this may just not be a reality, or if it is it's
a nightmare at best.

Something needs to be done. This is the 21st century, after all. With the 
power of [Ruby on Rails][ror] and [Rails engines][ren], however, there
*is* a solution.

## introducing blue_velvet

[blue_velvet][bvg] is a gem I created to solve this problem. It's
extracted from working code that's live on [TheWonderBars.com][twb], and
recently I converted the code that's live to just use the gem without
overrides. You probably didn't notice, which was the whole point. The
gem code is an exact duplicate of the code that powered this
functionality on the site, so you're getting what I was working with; a
powerful engine for displaying Facebook attributes.

## making it work

Sound fun? It's real easy to get started, just add `gem 'blue_velvet'`
to your Gemfile, run `bundle` and generate the configuration using
`rails g facebook:config`. Generate a new Facebook app on
<http://developers.facebook.com> and enter in your app data, as well as
the page ID you're looking to access.

Now that you're set up to access a Facebook page, you can build routes
to your Facebook page's attributes like so:

(in `routes.rb`)
```ruby
    get "/about" => 'facebook/page#description'
```
Now type `rails server` and visit <http://localhost:3000/about>, and you
should see the content of your page's "Description" field.

## advanced usage

You can also do some cool stuff on the Ruby side to create better views
of your Facebook content. For example, The Wonder Bars' `/about` page
uses the following Facebook page information to get all of its content
together:
```ruby
    class FacebookController < Facebook::PageController
      # Accesses 'about', 'description' and 'bio' for a complete "About Us" page.
      def about_us
        @tagline = facebook.about
        @elevator_pitch = facebook.description
        @long_form_bio = facebook.bio
        render layout: false if request.xhr?
      end
    end
```
You can have any controller access that `facebook` object by simply
inheriting from `Facebook::PageController`. You must cache values from
the Facebook page into instance variables for them to become available
in the view layer.

## missing something?

Did you expect **blue_velvet** to do something that I missed? If so, let
me know in the [GitHub Issues][bvi] tracker. Or, you can fork the code
and contribute a pull request, I welcome all kinds!

[twb]: http://thewonderbars.com
[ror]: http://rubyonrails.org
[ren]: http://edgeguides.rubyonrails.org/engines.html
[bvg]: http://github.com/tubbo/blue_velvet
[bvi]: https://github.com/tubbo/blue_velvet/issues

