---
layout: post
title: the shape of web uis to come
category: code
date: 2013-08-30
tags: javascript, ember.js, emberscript, emblem, waxpoetic
---

Recently, I've been very interested in the development of the
[Ember.js][ember] framework, which has grown rapidly in the 3 years or
so that I've known it. We've seen [great apps][discourse] being made
with ([most of][eviltrout]) it, and it's gone from something that left
me truly puzzled into an understandable and almost indispensable
tool in my web development arsenal. While developing a Backbone app,
I took a second look at Ember after they released their new
[routing API][ember-routing], and fell in love with how *little* code I
wrote while [developing a simple application][forthcoming]. But the way
that Ember worked flies in the face with one of my other favorite
tools...

## ember and coffeescript

While I have been writing JavaScript for about 14
years as of the date this article was written, I still prefer
CoffeeScript as a DSL for defining my objects. It's cleaner, easier to
read, and generates compliant JavaScript that (without too many
hang-ups) is very close to or exactly what I would have written by hand
anyway. Unfortunately, some of the unusual conventions in Ember,
especially related to adding computed properties and observers to
methods, make working with CoffeeScript quite difficult. Not to mention
that the `class`/`extends` keywords do not work reliably in conjunction
with `Ember.Object.extend()`.

## emberscript to the rescue

Thankfully, [Gordon Hempton][ghempton] has created [EmberScript][emberscript],
a CoffeeScript-style languaage that compiles to JavaScript. It is a
subset of CoffeeScript (you can avoid the special syntax altogether and
it compiles to the exact same code as CoffeeScript), but it compiles
directly to JavaScript so you're not dealing with trans-compiling
issues.

EmberScript adds a number of syntactical features to CoffeeScript that
make it well-suited for writing Ember apps. For example, in Ember.js
you must retrieve data using `Ember.Object.get()` (all Ember objects
are derived from `Ember.Object`, by the way):

```javascript
var App.Person = DS.Model.extend({
  firstName: DS.attr('string'),
  lastName: DS.attr('string'),
});

$(function() { // wouldn't really do this, just pseudocode for "runtime"
  var person = App.Person.find(1);
  alert(person.get('firstName')+ ' ' + person.get('lastName'));
});
```

But in EmberScript, you can write that code like this:

```coffeescript
class App.Person extends DS.Model
  firstName: DS.attr 'string'
  lastName: DS.attr 'string'

$ -> # wouldn't really do this, just pseudocode for "runtime"
  person = App.Person.find(1)
  alert "#{person.firstName} #{person.lastName}"
```

Notice how I used class/extends to describe the model. This is a visible
effect of the fact that EmberScript does not compile to CoffeeScript,
because it defines class/extends in a different way.

You can do even more with EmberScript. Let's say I wanted to make the
text in the alert dialog a method on Person, because I wanted to use it
elsewhere. In JavaScript, I'd have to define it this way:

```javascript
var App.Person = DS.Model.extend({
  firstName: DS.attr('string'),
  lastName: DS.attr('string'),
  name: function() {
    return this.get('firstName') + ' ' + this.get('lastName');
  }.property('firstName', 'lastName')
});

$(function() { // alright i guess i don't have to tell you again..
  var person = App.Person.find(1);
  alert(person.get('name'));
});
```

That's a *little* better, but I feel like we can do a lot more with
less code. It's a pretty verbose way to say "combine firstName and
lastName in the return value of this method", we have to specify all of
the "dependencies" of the method at the bottom and then we still have to
use `this.get` in order to retrieve the attributes. Once again,
EmberScript comes to the rescue:

```coffeescript
class App.Person extends DS.Model
  firstName: DS.attr 'string'
  lastName: DS.attr 'string'
  name: ~> "#{@firstName} #{@lastName}"

$ -> # wouldn't really do this, just pseudocode for "runtime"
  person = App.Person.find(1)
  alert person.name
```

Wow! That's just *two* lines of code to create and display a simple
computed property! Compared to the 3 lines just to define one (in a
readable manner...without having to cache the attributes to local
values for speed purposes). It's 

## moving past handlebars

[ember]: http://emberjs.com
[discourse]: http://discourse.com
[eviltrout]: http://eviltrout.com/2013/03/23/ember-without-data.html
[ember-routing]: http://emberjs.com/guides/routing/
[forthcoming]: http://github.com/tubbo/forthcoming
[ghempton]: https://github.com/ghempton
