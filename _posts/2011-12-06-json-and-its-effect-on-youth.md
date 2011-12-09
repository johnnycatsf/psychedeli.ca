---

layout: post
title: "JSON and its effect on youth"
category: code
date: 2011-12-06
tags: "#json, #javascript, `jquery"

---

[JSON][1] has rapidly become the world's prominent data transfer format, used everywhere from the web to iOS/Android applications, and even in the software on your computer. This lightweight means of describing passed data has exposed one of my favorite parts of JavaScript, its hash syntax for objects.

At one firm (name has been left out to protect the innocent), their internal CMS was plagued with JavaScript errors and strange indicators everywhere, probably left over from previous development/troubleshooting sessions. Because the application was built on an as-needed basis, paid for by clients who wanted additional features, there was no framework to describe how future enhancements to the CMS were going to be implemented. So when tasked to create additional features for the CMS, I also took it upon myself to solve these numerous errors.

There was one in particular that caused a LOT of confusion amongst the team:

## $ is not defined 

So what does this mean? Didn't we load [jQuery][2] in the `<head>` tag?!? What happened?

In most of the GET responses returned by the server, I noticed that there were inline JavaScript calls being made towards the end of the file. This makes sense, the server returns an HTML document and the HTML gets parsed as well as the JavaScript, which should be executed. The problem is, because jQuery wasn't loaded in a `<script src>` on the GET request, it doesn't know that the library has already been included, and the browser returns an error. In other words, **the JavaScript executed inline from an Ajax call doesn't know about the libraries included with the rest of the application**. All is not lost, however. There is a simple workaround solution that has really helped my productivity here at work.
	
## It's all about placement

Instead of executing JavaScript code inline, in another Ajax HTML request, just put the JavaScript code in your `success:` callback. Your code will be executed after the new HTML loads in, and you'll even have access to the DOM elements that were created. You can literally copy code out of a `<script>` tag and drop it into the callback, and with some minor adjustments your code should work the same. But now, it's much cleaner and easier to work with. This also gives you the freedom to put all or most of your JS code in an external file, which is much easier to debug in the future.
	
## JSON to the Rescue!

That's all well and good, but what if you need to pass data between HTML and JavaScript? In this CMS, we've solved that problem already:

	<input id="selectedInput_11" type="hidden" extensions="gif+jpg+png" maxheight="0" maxwidth="0" forceheight="0" forcewidth="0" myid="11" datype="selectImage" fileid="-1" value="" name="LargeImg4ID">
	
Those non-standard attributes represent data from PHP that needs to be passed into the subsequent JavaScript action. Realistically, this won't cause problems with browsers, but it will prevent your code from being 100% W3C valid HTML. If you have too many non-standard attributes in your HTML code, it will be very difficult to find the real errors with a validator.

[1]: http://json.org
[2]: http://jquery.com