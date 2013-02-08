---
layout: post
title: use assertions in rspec
category: code
date: 2013-02-08
tags: rspec, ruby, testing, test_unit, bdd, tdd
---

# tl;dr -- you can do MiniTest::Assertions inside RSpec examples.

A few years ago, [RSpec][spec] was extracted from the [Cucumber][cuke]
project as a separate entity for BDD and testing with natural language
in Ruby apps which may not need all of the weight of Cucumber. It gained
traction pretty much everywhere, but it's primary evangelists were
Rails developers (well, [except DHH][drama]), and in the Rails community
it was commonly used. Two years ago, DHH lit the spark that would become
a major debate and one that "divides" Rails developers all over the map.

# philosophical differences

[Minitest][test], and it's predecessor **Test::Unit**, were designed
primarily as a unit testing framework, meant to be used in conjunction
with other helpers and libraries to "roll-your-own" full-stack testing
framework. All it does is unit tests, and assertions.

RSpec, on the other hand, was really concieved of as a "full-stack" test
framework, complete with built-in support for mocking and stubbing, a
nicer "natural language" assertion syntax, and support for front-end
acceptance testing using Cucumber. With this foundation in place, RSpec
was able to explore new avenues of testing, and


# why rspec?

I personally believe RSpec is the best testing framework for Ruby. But that's
just my opinion. Generally I'm a fan of not loading in code unless you
absolutely need it, but if you're doing something beyond basic unit testing
(and you should be), you *need* RSpec.

## it cares about my stress levels

I have a strong distaste for straight Test::Unit. To be honest, I feel
that we, as programmers, should not have to subject ourselves to setting
up a bunch of boilerplate crap every time we want to run tests.

You can find the analogy in deciding what Ruby web framework to use when building
your app. Let's look at two choices: Rails or Sinatra (chosen because I've
tried both of them out). In my experience, unless you're absolutely sure your
Sinatra app is going to stay just as small, and just as simple, there's a
distinct possibility that your Sinatra app will, eventually, look very
much like a Rails app except without the whole community of developers
supporting you.

Eventually, you realize Rails is easier to scale down than Sinatra is to scale up.

## if rspec isn't omakase, i don't know what is

RSpec is kinda like Rails in this analogy. It takes care of everything.
Want colors? No problem. Hate colors? Awesome, get rid of them. Think
that "dot" reporting syntax is hard to read? Change it to 'documentation'
or 'progress'! The choice is yours. You don't need to use the (albeit
very sensible) defaults, but you can if you want. It couldn't possibly
be easier to retrofit RSpec onto a new app, or even an existing app with
`spec_converter`.

# but...i want my assertions!!1

This is totally a matter of preference. Some people really like assertions,
while others are gung-ho about expectations. Both of these ideas are really
means to the same end, so why can't they play nice together? Turns out,
they can!  Just do any of your `MiniTest::Assertions` in an RSpec block
You'll be able to run assertions when syntax calls for it, and expect or
should expectations by default.

[spec]: http://github.com/rspec/rspec
[cuke]: http://cukes.info
[drama]: http://www.rubyinside.com/dhh-offended-by-rspec-debate-4610.html
[test]: https://github.com/seattlerb/minitest
