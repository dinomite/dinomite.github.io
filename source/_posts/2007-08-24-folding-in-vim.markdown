--- 
layout: post
comments: true
title: Folding in vim
mt_id: 140
date: 2007-08-24 16:39:12 -07:00
---
If you work with large files, in particular large markup documents vim's folding feature can make your day a whole lot better.  Just like the fancy folding that IDEs like Eclipse and Visual Studio provide, vim can reduce whole sections of text to a single line making it easy to skip around and keep your attention focused on what is important.  There are a number of different methods that vim can automatically figure out where to fold your file but I've found that `indent` does what I want most of the time.  To turn folding on and off easily, I wrote the following function in my `~/.vimrc`

<pre>
set foldmethod=indent
set nofoldenable
function ToggleFolding()
    if &foldenable
        set nofoldenable
    else
        set foldenable
    endif
endfunction
</pre>

I bound this to &#60;F2&#62; with the following:

<pre>
nmap <silent> &#60;F3&#62; :call ToggleFolding()&#60;CR&#62;
</pre>

You can open and close folds using `zo` & `zc` and jump between them with `zk` & `zj`.
