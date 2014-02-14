---
title: "GitHub Spectacles"
date: 2014-02-14 15:38
tags: web, development, download
style: true
---

At [Terracoding][tc] we regularly review pull requests from each other when working on a project. GitHub's "Commits" and "Files Changed" tabs make it pretty painless but we wanted a way to easily view Ruby implementation files alongside their specs.

<img src="/posts/github-spectacles/octoclark.png" alt="Octoclark Kentocat" width="400" height="400" class="right" />

I created a bookmarklet to arrange the file pairs 2-up for review. With the files side-by-side it's easy to spot code that isn't covered by tests and we get a better idea of what methods are meant to do.

To install, drag this button into your bookmarks bar:

<a id='bookmarklet' href='javascript:(function(){var Spectacles,spectacles,__bind=function(e,t){return function(){return e.apply(t,arguments)}};Spectacles=function(){function e(){this.stylePairWrappers=__bind(this.stylePairWrappers,this);this.sorter=__bind(this.sorter,this);var e,t,n,r,i,s;this.pairClass="spectacles-pair";e=$("#files");t=e.find(".file").sort(this.sorter);e.empty();for(i=0,s=t.length;i<s;i++){n=t[i];e.append(n);r=$(n).prev();r.length&&this.filePair(n,r)&&this.wrapPair(n,r)}this.stylePairFiles();this.stylePairWrappers();$(window).resize(this.stylePairWrappers)}e.prototype.sorter=function(e,t){e=this.filePath(e);t=this.filePath(t);return e<t?-1:e>t?1:0};e.prototype.filePath=function(e){var t,n;n=$(e).find(".meta").data("path").toLowerCase();t=n.split(/[\\/]/);return t[t.length-2]+"/"+t[t.length-1]};e.prototype.filePair=function(e,t){e=this.filePath(e).replace("_spec","");t=this.filePath(t).replace("_spec","");return e===t};e.prototype.wrapPair=function(e,t){return $(e).add($(t)).wrapAll(&quot;<div class="&quot;+this.pairClass+&quot;" />&quot;)};e.prototype.stylePairFiles=function(){return $("."+this.pairClass+" .file").css({width:"49%","float":"left",margin:"0 0.5%"}).find(".data").css({maxHeight:"500px",overflow:"auto"})};e.prototype.stylePairWrappers=function(){var e;e=$(".site .container").offset().left;return $("."+this.pairClass).css({margin:"0 -"+(e+60)+"px 15px -"+e+"px",overflow:"hidden"})};return e}();spectacles=new Spectacles;})();'>GitHub Spectacles</a>

Try it out [on this commit][com]. Just click the bookmark when viewing the file changes.

The CoffeeScript for the bookmarklet is [opensourced on GitHub][repo].

<div class="footnotes" markdown="1">
  - [Octoclark Kentocat][ok] by [Cameron McEfee][cm]
</div>

[repo]: https://github.com/samrayner/spectacles
[cm]: https://github.com/cameronmcefee
[ok]: http://octodex.github.com/octoclarkkentocat/
[tc]: http://terracoding.com
[com]: https://github.com/samrayner/sheffield-ultimate/commit/92aae555fd52db20418e387f49dceca9ff6f4fd8
