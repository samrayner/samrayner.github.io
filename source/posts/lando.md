---
title: "Introducing Lando"
date: 2012-08-30 12:59
tags: project, development, web
banner_image: banner.jpg
banner_height: 250
banner_color: "#c7d5da"
banner_link: http://landocms.com
---

Managing the content of websites has always felt like a bit of a chore. Things like editing pages, posting blog entries and importing media should be simple but the Web-based admin interfaces of most CMSs make it fiddley. Form inputs and textareas weren't designed for authoring content and, while WYSIWYG editors help, I dread looking at the HTML produced.

Up until a few months ago, I worked around the problem by editing content locally and pasting changes across but live and local versions quickly got out of sync. It was time to knuckle down and come up with something better.

A New Hope
----------

Meet [Lando][l]: a new kind of CMS that lets you manage your website in the cloud. Lando lets you save plain-text files and media in special Dropbox folders and have them appear on your site. No forms, no fuss. You can create things like galleries and slideshows automatically from a folder of images and, with everything in the cloud, you can update your website from anywhere.

<img src="/posts/lando/lando.jpg" alt="Lando Calrissian" class="right shadow" />

Lando is written in PHP and comes in a package to upload to your own server. There's a simple installation wizard to guide you through connecting to your Dropbox account. Lando then communicates with the [Dropbox API][api] every so often to check for changes to your website content files or you can force a refresh by logging in as an admin on your website and clicking _update_.

Lando installs 5 folders in your Dropbox: _Pages_, _Posts_, _Drafts_, _Collections_ and _Snippets_. Pages, blog posts and drafts are created as folders containing a main text file and any supporting media files. Content can be formatted as [Markdown][md], [Textile][tt] or HTML. Collections are folders of files that can be included anywhere in your site as a list of links, a gallery or a slideshow. Snippets are text files that can be included anywhere too, useful for content that appears on multiple pages.

Having your content as files on your hard drive is great:

- You can rename, delete and move stuff easily.
- You can make local backups of your website.
- You can enjoy the comfort and efficiency of editing in a familiar desktop or mobile environment rather than filling in forms in a browser.

Having content automatically sync to Dropbox is awesome too:

- You can update your website from any connected device, even on the go with [Dropbox-powered Android and iOS text editors][edit].
- You can edit offline and your changes will be applied next time you connect.
- You can use [Dropbox's Share feature][sh] to easily collaborate with people on a single blog post or your entire website!
- Your files are automatically versioned online so you can roll-back your content if something gets lost or mistakenly changed.

I've developed Lando as my third-year dissertation project over the past 18 months. Since then, I really have enjoyed using it to manage sites. This new version of [samrayner.com][sr] is powered by Lando and it's been a blast getting up and running so quickly with a system I know will make maintenaining it a breeze.

[Lando][l] is available free and [open-source on GitHub][gh]. Documentation can be found at [landocms.com/docs][docs]. Please give it a go and [let me know what you think][email]!

[l]: http://landocms.com
[api]: https://www.dropbox.com/developers
[md]: http://daringfireball.net/projects/markdown/
[tt]: http://textism.com/tools/textile/
[edit]: http://landocms.com/editing
[sh]: https://www.dropbox.com/help/19/en
[gh]: http://github.com/samrayner/Lando
[email]: mailto:&#115;&#97;&#109;&#64;&#115;&#97;&#109;&#114;&#97;&#121;&#110;&#101;&#114;&#46;&#99;&#111;&#109;
[docs]: http://landocms.com/docs
[sr]: http://samrayner.com
