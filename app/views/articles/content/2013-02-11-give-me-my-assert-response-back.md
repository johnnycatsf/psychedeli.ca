---
layout: post
title: give me my assert_response back!
category: code
date: 2013-02-11
tags: rails, upgrade, assert_block, deprecations
---

Did you [just upgrade Ruby on Rails][cve] and now all of your `assert_response()`
tests are failing? Simply add the following code to **test/test_helper.rb**
and everything will work again!

```ruby
ActionDispatch::Assertions::ResponseAssertions.instance_eval do
  # Override so deprecation warnings stop popping up. This uses a proper
  # +assert+ method but retains the functionality of +assert_response+.
  define_method(:assert_response_test) do |expected_status|
    response_status = response.send :status
    assert_equal response_status, expected_status, "Expected response to be <#{expected_status}>, but was <#{response_status}>"
  end
end
```

Major shout-outs to [Rob Di Marco][iotr] who actually wrote this and
figured out that `instance_eval` was the proper method to use here,
not `class_eval`... :D

[cve]: https://groups.google.com/forum/?fromgroups=#!topic/rubyonrails-security/AFBKNY7VSH8
[iotr]: http://innovationontherun.com
