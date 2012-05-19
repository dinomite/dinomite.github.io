--- 
layout: post
comments: true
title: "Quick Tip: Python's noop Equivalent"
mt_id: 164
date: 2007-11-30 06:52:45 -08:00
---
Python can't deal with empty code blocks, which may arise if you want to stub out a block but leave the implementation for later.  If you have one in your code, the interpreter will give the following error:

<pre class="brush: python;">
  File "foo.py", line 1
    if (foo == bar):
     ^
IndentationError: expected an indented block
</pre>

In this case, you can use the `pass` operator which will do nothing but take up a line, resulting in the following code:

<pre class="brush: python;">
if (foo == bar):
    pass #TODO
else:
    print "nothing to do!"
</pre>
