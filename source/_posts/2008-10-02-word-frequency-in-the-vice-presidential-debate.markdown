--- 
layout: post
comments: true
title: Word Frequency in the Vice Presidential Debate
mt_id: 223
date: 2008-10-02 22:41:44 -07:00
---
It's always interesting to see what keywords debaters drop to get their points across.  To analyze tonight's debate between Biden &amp; Palin, I grabbed a [transcript from CNN](http://edition.cnn.com/2008/POLITICS/10/02/debate.transcript/?iref=mpstoryview) that was posted shortly after.  The transcript listed each speaker's name (Biden, Ifill or Palin), followed by their first sentence in that statement, with subsequent statements on new lines.  To make it easily `grep`able,  wrote a quick Perl script to join each speaker's full passages into a single line, beginning with their name.  With that done, it's trivial to search for words the candidates spoke.  [The transcript is here](http://dinomite.net/~dinomite/vpdebate.txt).

First up, "change" and "hope", adages of the Obama campaign that McCain and Palin have picked up in recent weeks:<br>
* <span style="color: #0000ff;">Biden (change|hope): 17</span><br>
* <span style="color: #ff0000;">Palin (change|hope): 25</span>

Which presidential candidate got more mentions?<br>
* <span style="color: #0000ff;">Biden (John|McCain): 72</span><br>
* <span style="color: #0000ff;">Biden (Barack|Obama): 45</span><br>
* <span style="color: #ff0000;">Palin (John|McCain): 42</span><br>
* <span style="color: #ff0000;">Palin (Barack|Obama): 24</span>

Palin's state makes a lot of energy and high prices are on the mind of voters:<br>
* <span style="color: #0000ff;">Biden (energy): 9</span><br>
* <span style="color: #ff0000;">Palin (energy): 29</span>

Both talked a lot about the war:<br>
* <span style="color: #0000ff;">Biden (war|iraq|afghanistan): 51</span><br>
* <span style="color: #ff0000;">Palin (war|iraq|afghanistan): 58</span>

Palin cares about her family:<br>
* <span style="color: #0000ff;">Biden (family|child): 8</span><br>
* <span style="color: #ff0000;">Palin (family|child): 15</span>

Biden said "clean coal" a couple of times to Palin's one; they both mentioned "coal" in general more than that:<br>
* <span style="color: #0000ff;">Biden (coal): 7</span><br>
* <span style="color: #ff0000;">Palin (coal): 2</span>

The economy was a talking point:<br>
* <span style="color: #0000ff;">Biden (economy): 4</span><br>
* <span style="color: #ff0000;">Palin (economy): 13</span>

Only one of the candidates knows about deregulation of Wall Street in recent years:<br>
* <span style="color: #0000ff;">Biden (deregulation): 7</span><br>
* <span style="color: #ff0000;">Palin (deregulation): 0</span>

Wall Street or Main Street?<br>
* <span style="color: #0000ff;">Biden (wall street): 3</span><br>
* <span style="color: #0000ff;">Biden (main street): 1</span><br>
* <span style="color: #ff0000;">Palin (wall street): 5</span><br>
* <span style="color: #ff0000;">Palin (main street): 2</span>

Any suggestions?

### See also:
* [Most popular words](http://www.spudart.org/blogs/randomthoughts_comments/4758_0_3_0_C/)
* [Language Log](http://languagelog.ldc.upenn.edu/nll/?p=663)
* [Palin visualizations](http://services.alphaworks.ibm.com/manyeyes/create/SLinXQsOtha62M1yDo9kQ2~)
* [Biden visualizations](http://services.alphaworks.ibm.com/manyeyes/create/SLinXQsOtha60M1y4l9kQ2~)

edit: added link from Karl; added IBM links
