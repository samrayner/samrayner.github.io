---
title: "Wanted - User Agent Spoof Safari Extension"
date: 2012-09-05 22:52
tags: mac, wishlist, development
---

Since uninstalling Flash on my Mac I've found it frustrating following links to video and audio websites that require it. [YouTube][yt], [SoundCloud][sc], [TED][] and [CollegeHumor][ch] (to name a few) all offer HTML5 players to mobile devices but force a Flash player on desktop visitors.

To get around it, I either use my [Open in Chrome Applescript][oic] or this Applescript to spoof the user agent string. To use it, you'll first need to enable the Develop menu in _Safari preferences > Advanced_ and enable access for assistive devices in _System Preferences > Accessibility_.

    tell application "Safari" to activate
    tell application "System Events"
      click menu item "Safari iOS 5.1 — iPad" of ((process "Safari")'s (menu bar 1)'s (menu bar item "Develop")'s (menu "Develop")'s (menu item "User Agent")'s (menu "User Agent"))
    end tell

The script works well, reloading the current tab complete with working player, but it feels like something that could be automated.

What I would love is a Safari extension that takes a list of domains and automatically spoofs the user agent string or at least redirects to the mobile version on visiting them. Unfortunately, being JavaScript-based, I'm not sure the former is possible with a Safari extension but the (slightly more limited) latter solution might be.

If anyone has any ideas on getting this done, please give me a shout on Twitter [@samrayner][tw]! Hopefully, eventually, such a script won't be necessary and sites like YouTube will do a better job falling back to HTML5.

---

**Update (Sep 12):** Looks like I'm [not][1] [the][2] [only][3] [one][4] who wants this.

Unfortunately, it turns out most of the offending websites rely solely on the user agent to serve HTML5 media. `m.X.com` doesn't always exist and, when it does, often behaves differently when viewed with a desktop user agent. Fellow developers -- _please_ [use object detection not UA detection][det].

It looks like a Safari extension is out of reach, but [a Chrome extension already exists][ce] thanks to [a recent update to the Chrome Extensions API][wr]. Hopefully Apple will follow suit.

[yt]: http://youtube.com/
[sc]: http://soundcloud.com/
[ted]: http://www.ted.com/
[ch]: http://www.collegehumor.com/
[oic]: {{site_root}}/posts/scripts/#open-in-chrome
[tw]: http://twitter.com/samrayner
[ce]: http://spoofer-extension.appspot.com/about
[wr]: http://developer.chrome.com/trunk/extensions/webRequest.html
[det]: http://www.quirksmode.org/js/support.html

[1]: http://stackoverflow.com/questions/4118823/safari-extension-that-spoofs-user-agent
[2]: http://stackoverflow.com/questions/9697855/is-there-extension-for-safari-to-switch-user-agent-automatically-for-specified-s
[3]: http://www.quora.com/Safari-web-browser/Is-there-a-Safari-plugin-or-extension-that-automatically-modifies-the-browsers-user-agent-for-specific-websites
[4]: http://twitter.com/zadr/status/97216550347603969
