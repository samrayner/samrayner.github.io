---
title: "Discographer"
date: 2015-07-23 11:54
tags: development, web, music, project
banner_image: banner.png
banner_height: 250
banner_color: "#4B7780"
banner_link: http://samrayner.com/discographer/
banner_size: "2260px 325px"
---

As a fun little project over the last few weeks, I've built a Web app that helps you discover more music by artists in your iTunes library. It's called [Discographer][d], and uses the [Spotify API][sapi] to fetch albums, ticking off the ones you own so you can see what you might have missed.

<img src="/posts/discographer/file.png" alt="iTunes Music Library.xml" class="right" />

It was a nice opportunity to play with some new web APIs ([Drag and Drop][dnd], [File][fr] and [Flexbox][fb]), the main benefit being your library is never uploaded but parsed locally in your browser. The only thing transmitted is the name of any artist you click.

It was [linked on Lifehacker][lh] a couple of days ago and I've since received some great feedback. Please give it a go and let me know what you think!

[d]: http://www.samrayner.com/discographer/
[fr]: http://www.w3.org/TR/FileAPI/
[dnd]: http://www.w3.org/TR/2010/WD-html5-20101019/dnd.htm
[fb]: http://www.w3.org/TR/css-flexbox-1/
[sapi]: https://developer.spotify.com/web-api/
[lh]: http://lifehacker.com/discographer-scans-your-itunes-library-for-artists-miss-1719274310
