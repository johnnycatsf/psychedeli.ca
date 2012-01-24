---

layout: post
title: "the time has come: converting Prototype into jQuery"
category: programming
date: 2011-04-17
tags: "`prototype, `jquery, ?JavaScript"

---

Today is the day that I embark on my ugliest mission yet, that of converting the JavaScript framework for [Typo](http://typosphere.org/), the blog engine that I currently employ. Right now, it's using [Prototype.js](http://prototypejs.org/), but I'm going to convert it all to use [jQuery](http://jquery.com) instead. This is obviously something you don't want to do, but it's absolutely necessary if I'm going to continue developing this blog application. As of right now, I'm not happy with ANY of the blog engines out there, but Typo's definitely the lesser of all evils. This post examines the least obtrusive/annoying way to convert an application's JavaScript framework, and why *you* should (or shouldn't) do it.

## what's the big deal?
I've been coding JavaScript for a long time. It was truly my first "programming language", because I don't really consider HTML a programming language since it doesn't really do much except describe data that already exists. I fondly remember the days of perusing [DynamicDrive](http://dynamicdrive.com) and [JavaScript Kit](http://javascriptkit.com) for new snippets of code to make my web sites flashier, more productive, or more functional. By dissecting these code snippets and sometimes reimplementing them, I learned more about what makes a good, concise script (and what doesn't). I was developing in JavaScript when there was no such thing as a "JavaScript framework", and I learned how to code Ajax using pure JavaScript (where you have to instantiate a separate `XmlHttpRequest` for every browser, and each one behaved differently!) So if I can do all that, what's all this hubbub about a stupid framework?

## the problem with classical design in JavaScript
Don't get me wrong, I'm all for organized, object-oriented programming. I learned programming mostly on [Java](http://java.sun.com) and [C++](). Especially with Java you just can't write it without objects. But the fundamental difference between these languages and JavaScript (which may be central to its speed) is that JavaScript is not only object-oriented, it's functional and prototype, not class, based. If you notice, there's no syntax in JavaScript to say a specific object extends another. There's no such thing as that, an object can't immediately just take on the properties of another. In addition, JavaScript was written to be lightweight and fast. It 



Yes, I'm aware that JavaScript *does* employ [Objects](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Object), and [most "experts" agree](http://en.wikipedia.org/wiki/JavaScript) that JavaScript is (at least functionally) object-oriented, but there's a big between the way JavaScript is written and the way other object-oriented languages are written: **everything in JavaScript has to be a variable**. So when you create the definition for a class of some sort, you have to create a `var` and set its value to the instantiation of the `Object` you're trying to create. On this first line alone, we've already created a level of redundancy that is simply unnecessary in other object-oriented languages. In addition, for every method and property in this `Object`, we have to prefix the oh-so-lovable JavaScript keyword `this` to everything we expect to use outside of this class definition. Oh and methods? They have to be written as properties with the value of a `function` definition, **because every function is already a variable**. The fact is, you *can't* create class definitions without the use of a `var`, and I feel that this fundamental difference is what makes JavaScript so unique and so misunderstood. Especially by the creators of Prototype.js... 

## jQuery just does JavaScript better
I used to be a Prototype user, and I loved its ability to work just as well on all browsers. With the addition of [script.aculo.us](http://script.aculo.us), it was so much easier to create beautiful web sites using the same framework that was allowing me to write JavaScript (and Ajax) that worked on all browsers, so it took 1/3 of the time. But when jQuery was released, it was so much easier to understand and get involved with. **Why?**

Instead of attempting to change the way JavaScript is written by using classes, inheritance, and other concepts found in traditional object-oriented languages, jQuery embraces the event-based use case that JavaScript is frequently applied to: 

1.	Get something from the DOM
2.	Do something with it
3.	Output the result to the DOM (a lot of the time, right back into the same element)

So instead of [Prototype's class-based](http://alternateidea.com/blog/articles/2006/08/23/jquery-mis-leading-the-pack) approach to JavaScript, which ends up having to be `.invoke()`d into an event loop anyway, [jQuery simply embraces the event loop](http://blog.jquery.com/2006/08/20/why-jquerys-philosophy-is-better/) as a construct of JavaScript development. And realistically, *it is*. Even though JavaScript is an object-oriented language, in the browser it's basic construct is still responding to events that happen to a DOM document.

## when NOT to switch
So let's say you have a web application that's already tied to Prototype. Let's just face the facts now: **You're gonna have to do a LOT of re-coding and testing. If you go too far without testing, you risk breaking functionality and not being able to effectively repair it.** If your application is simply too big, like if every part of your site is dependent on Ajax and that Ajax's been implemented with Prototype, it might get a little tricky. In my case, I was fortunate. Typo only employs Prototype on a *serious* level in the administration panel. In fact, most of the "conversion" I had to manually do involved `administration.js`. So as I worked, I kept the old code commented out and basically just looked up what certain Prototype classes did that I wasn't sure about. Since Prototype requires you to define what the action does *before it's actually bound to a DOM element* (an extremely confusing and poorly-executed "feature" of this framework), there was actually a lot of extra code I was able to remove. In fact, by using jQuery rather than Prototype.js, I was able to reduce the size of `administration.js` **by about 75%**. The new `administration.js` is only 4KB, while the old was about 16KB!

## plug it in, plug it in
Another way I was able to reduce my work load, and code bloat at the same time (AND potential future problems!), I was able to employ a number of [jQuery Plugins](http://plugins.jquery.com) to do a lot of the hard work for me. Here are some of the plugins I've used in the conversion of Typo's admin interface from Prototype to jQuery:

### jQuery.cookie
Typo's developers graciously wrote a number of cookie handling functions in pure JavaScript. Well done, but [jQuery.cookie](https://github.com/carhartl/jquery-cookie) allowed me to remove a lot of that extra code, no need to reinvent the wheel. Since we *are* using the jQuery framework, using it to access cookies and the DOM is a much cleaner and much faster way to get cookies. So far, I've noticed significant performance increases (but haven't run any benchmarks yet, so don't quote me on that!)

### Facebox
I like lightbox, but we must face facts: it's a Prototype plugin. Sure, there's a lightbox plugin floating around for jQuery, but this one's just way better. The UI, the customization, the usability, it's all there. [Facebox](http://defunkt.io/facebox/) is based on the popups you experience on [Facebook](http://facebook.com), and who doesn't like Facebook's clean, sexy, blue UI? Did I mention it's extremely easy to skin? Oh yeah, I did. Well, it excites me..

### jQuery.tokenInput
A plugin I actually learned about through a recent [Railscast](http://railscasts.com/episodes/258-token-fields) posted by the man who actually taught me Rails, [Ryan Bates](http://github.com/ryanb). This is a much better alternative to [jQuery UI's autocomplete plugin](http://jqueryui.com/demos/autocomplete). While [jQuery.tokenInput](http://loopj.com/jquery-tokeninput/) seems less customizable, I find that it's actually quite useful for a specific purpose. Much like Rails, it favors "convention over configuration". With jQuery.tokenInput, a new way of creating an autocompleter is explored. It boils down autocompletion to a basic JSON format, and if your GET action can serve up data in that format, it can then be manipulated using markup and stylesheets. The JavaScript remains lightweight, yet very powerful. Oh and look at this, it can be skinned to look just like [Facebook](http://facebook.com)'s autocompleter!

### jQuery.Growl
There was a plugin bundled with Typo called [Growler](http://examples.kevinandre.com/growler1.0.0/index.html), but obviously it was for Prototype. The [jQuery Growl](http://projects.zoulcreations.com/jquery/growl/) plugin substitutes for it nicely, and works perfectly out of the box...no styling needed!

### jCarousel
The Typo devs (actually, some guy named [Victor Stanciu](http://www.victorstanciu.ro)) built a nice Carousel plugin for Prototype. This was actually designed quite well, but unfortunately I am no longer using Prototype. So I replaced it with [jCarousel](http://sorgalla.com/jcarousel/), and so far, so good. The look of the carousel is a little different, but I may re-design it so it looks more like the admin panel soon.

## pics or it didn't happen
Well, it's not quite ready for release. I'm working a few bugs out, but you'll see it here first before I release the code to [github](http://github.com/tubbo/psycho). I'd also like to make a few other changes before releasing my first major upgrade of Typo's somewhat antiquated backend. Disclaimer: I'm still *very* grateful that Typo exists because they did a lot of synchronization and basic "structural" work that I didn't have to do. Thanks, guys!