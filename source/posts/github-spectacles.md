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

<a id="bookmarklet" href='javascript:(function()%7Bvar%20Spectacles%2Cspectacles%2C__bind%3Dfunction(e%2Ct)%7Breturn%20function()%7Breturn%20e.apply(t%2Carguments)%7D%7D%3BSpectacles%3Dfunction()%7Bfunction%20e()%7Bthis.stylePairWrappers%3D__bind(this.stylePairWrappers%2Cthis)%3Bthis.sorter%3D__bind(this.sorter%2Cthis)%3Bvar%20e%2Ct%2Cn%2Cr%2Ci%2Cs%2Co%3Bthis.pairClass%3D%22spectacles-pair%22%3Be%3D%24(%22%23files%22)%3Bn%3De.find(%22.file%22).sort(this.sorter)%3Be.empty()%3Bfor(s%3D0%2Co%3Dn.length%3Bs%3Co%3Bs%2B%2B)%7Br%3Dn%5Bs%5D%3Bt%3D%24(r)%3Bthis.deletedFile(r)%26%26this.hideDeletedFile(r)%3Be.append(r)%3Bi%3Dt.prev()%3Bi.length%26%26this.filePair(i%2Cr)%26%26this.wrapPair(i%2Cr)%7Dthis.stylePairFiles()%3Bthis.stylePairWrappers()%3B%24(window).resize(this.stylePairWrappers)%7De.prototype.deletedFile%3Dfunction(e)%7Bvar%20t%3Bt%3D%24(e)%3Breturn%20t.find(%22.diff-deleted%22).length%7C%7Ct.find(%22.gc%22).text().indexOf(%22%2B0%2C0%20%40%40%22)%3E0%7D%3Be.prototype.hideDeletedFile%3Dfunction(e)%7Bvar%20t%2Cn%3Bn%3D%24(e)%3Bt%3Dn.find(%22.data%22).add(n.find(%22.image%22))%3Breturn%20t.removeClass(%22image%22).addClass(%22data%20empty%22).css(%22background-color%22%2C%22%23fdd%22).html(%22File%20deleted.%22)%7D%3Be.prototype.sorter%3Dfunction(e%2Ct)%7Be%3Dthis.filePath(e)%3Bt%3Dthis.filePath(t)%3Breturn%20e%3Ct%3F-1%3Ae%3Et%3F1%3A0%7D%3Be.prototype.filePath%3Dfunction(e)%7Bvar%20t%2Cn%3Bn%3D%24(e).find(%22.meta%22).data(%22path%22).toLowerCase()%3Bt%3Dn.split(%2F%5B%5C%5C%2F%5D%2F)%3Breturn%20t%5Bt.length-2%5D%2B%22%2F%22%2Bt%5Bt.length-1%5D%7D%3Be.prototype.filePair%3Dfunction(e%2Ct)%7Be%3Dthis.filePath(e).replace(%22_spec%22%2C%22%22)%3Bt%3Dthis.filePath(t).replace(%22_spec%22%2C%22%22)%3Breturn%20e%3D%3D%3Dt%7D%3Be.prototype.wrapPair%3Dfunction(e%2Ct)%7Bvar%20n%3Bn%3D%24(%27%3Cdiv%20class%3D%22%27%2Bthis.pairClass%2B%27%22%20%2F%3E%27)%3B%24(e).before(n)%3Breturn%20n.append(%24(e)%2C%24(t))%7D%3Be.prototype.stylePairFiles%3Dfunction()%7Breturn%20%24(%22.%22%2Bthis.pairClass%2B%22%20.file%22).css(%7Bwidth%3A%2249%25%22%2C%22float%22%3A%22left%22%2Cmargin%3A%220%200.5%25%22%7D).find(%22.data%22).css(%7BmaxHeight%3A%22500px%22%2Coverflow%3A%22auto%22%7D)%7D%3Be.prototype.stylePairWrappers%3Dfunction()%7Bvar%20e%3Be%3D%24(%22.site%20.container%22).offset().left%3Breturn%20%24(%22.%22%2Bthis.pairClass).css(%7Bmargin%3A%220%20-%22%2B(e%2B60)%2B%22px%2015px%20-%22%2Be%2B%22px%22%2Coverflow%3A%22hidden%22%7D)%7D%3Breturn%20e%7D()%3Bspectacles%3Dnew%20Spectacles%3B%7D)()%3B'>GitHub Spectacles</a>

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
