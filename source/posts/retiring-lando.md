---
title: "Retiring Lando"
date: 2013-11-12 12:24
tags: project, development, web
---

Yesterday I finished porting this site to [Middleman][mm], a static blog generator written in Ruby. Since [releasing Lando][la], I've barely written a line of PHP and, short of rewriting it in Ruby (which I unfortunately don't have time to do), I've been put off working on Lando because of that.

I am very proud of how Lando turned out and have genuinely enjoyed using it to power my own site but it felt like it was time to switch to something written in the language I use day-to-day. If you use Lando, I am sorry I won't be continuing its development. Rest assured it will stay [open-sourced on GitHub][gh] and if anyone wants to take over managing it please [get in touch][email].

If you're looking for a replacement, translating my Lando templates to Middleman was remarkably simple, with the majority of helper functions and content properties matching across the two systems. I recommend it over [Jekyll][j]/[Octopress][o] which I found to be less flexible and hampered by their [Liquid][li] templates.

<img src="/posts/retiring-lando/lando-and-han.jpg" alt="Lando and Han" class="shadow" />

Thanks to everyone who tried Lando out and gave feedback. I learned a lot building it.

[mm]: http://middlemanapp.com/
[la]: /posts/lando/
[gh]: http://github.com/samrayner/Lando
[email]: mailto:&#115;&#97;&#109;&#64;&#115;&#97;&#109;&#114;&#97;&#121;&#110;&#101;&#114;&#46;&#99;&#111;&#109;
[j]: http://jekyllrb.com/
[o]: http://octopress.org/
[li]: http://liquidmarkup.org/
