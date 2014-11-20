---
title: "GitHub Spectacles"
date: 2014-02-14 15:38
tags: web, development, download
style: true
---

At [Terracoding][tc] we regularly review pull requests from each other when working on a project. GitHub's "Commits" and "Files Changed" tabs make it pretty painless but we wanted a way to easily view Ruby implementation files alongside their specs.

<img src="/posts/github-spectacles/octoclark.png" alt="Octoclark Kentocat" width="400" height="400" class="right" />

I created a bookmarklet to arrange the file pairs 2-up for review. With the files side-by-side it's easy to spot code that isn't covered by tests and we get a better idea of what methods are meant to do. It also hides the code of deleted files which I never bother to read during review.

To install, drag this button into your bookmarks bar:

<a id="bookmarklet" href="javascript:!function(){var%20t,e,r=function(t,e){return%20function(){return%20t.apply(e,arguments)}};t=function(){function%20t(){this.stylePairWrappers=r(this.stylePairWrappers,this),this.sorter=r(this.sorter,this);var%20t,e,i,s,a,n,l;for(this.pairClass=%22spectacles-pair%22,t=$(%22%23files%22),i=t.find(%22.file%22).sort(this.sorter),t.empty(),n=0,l=i.length;l%3En;n++)s=i[n],e=$(s),this.deletedFile(s)%26%26this.hideDeletedFile(s),t.append(s),a=e.prev(),a.length%26%26this.filePair(a,s)%26%26this.wrapPair(a,s);this.stylePairFiles(),this.stylePairWrappers(),$(window).resize(this.stylePairWrappers)}return%20t.prototype.deletedFile=function(t){var%20e;return%20e=$(t),e.find(%22.diff-deleted%22).length||e.find(%22.blob-code-hunk%22).text().indexOf(%22+0,0%20%40%40%22)%3E0},t.prototype.hideDeletedFile=function(t){var%20e,r;return%20r=$(t),e=r.find(%22.data%22),e.addClass(%22data%20empty%22).css(%22background-color%22,%22%23fdd%22).html(%22Deleted%20file%20not%20rendered%22)},t.prototype.sorter=function(t,e){return%20t=this.filePath(t),e=this.filePath(e),e%3Et%3F-1:t%3Ee%3F1:0},t.prototype.filePath=function(t){var%20e,r;return%20r=$(t).find(%22.meta%22).data(%22path%22).toLowerCase(),e=r.split(/[\\/]/),e[e.length-2]+%22/%22+e[e.length-1]},t.prototype.filePair=function(t,e){return%20t=this.filePath(t).replace(%22_spec%22,%22%22),e=this.filePath(e).replace(%22_spec%22,%22%22),t===e},t.prototype.wrapPair=function(t,e){var%20r;return%20r=$('%3Cdiv%20class=%22'+this.pairClass+'%22%20/%3E'),$(t).before(r),r.append($(t),$(e))},t.prototype.stylePairFiles=function(){return%20$(%22.%22+this.pairClass+%22%20.file%22).css({width:%2249%25%22,%22float%22:%22left%22,margin:%220%200.5%25%22}).find(%22.data%22).css({maxHeight:%22500px%22,overflow:%22auto%22})},t.prototype.stylePairWrappers=function(){var%20t;return%20t=$(%22.site%20.container%22).offset().left,$(%22.%22+this.pairClass).css({margin:%220%20-%22+(t+60)+%22px%2015px%20-%22+t+%22px%22,overflow:%22hidden%22})},t}(),e=new%20t}();">GitHub Spectacles</a>

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
