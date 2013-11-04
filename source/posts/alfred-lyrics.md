---
title: "Alfred Lyrics Search Workflow"
date: 2013-08-04 19:05
tags: download, alfred, mac, music
style: true
---

Ever had the lyrics of a song stuck in your head but can't for the life of you remember the artist or title? I get it all the time so wrote this Alfred workflow to search my iTunes library and start playing the first match it finds.

<iframe src="http://player.vimeo.com/video/71681950?portrait=0&byline=0&title=0" width="1280" height="720" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>

[Download Lyrics Search][dl]

<img class="right" src="/posts/alfred-lyrics/get-lyrical.png" alt="Get Lyrical" width="236" height="147" />

To get it working with your music collection you'll need to make sure all of your tracks have lyrics downloaded for them. Don't panic though, a great little Mac app called [Get Lyrical][gl] can automate the process, tagging songs you select or tagging in the background as you play them.

Once your library is tagged with lyrics, install the workflow and type **sing** followed by the lyrics.

Under The Hood
--------------
For those interested in the technical side, the Workflow is just an Applescript:

    on normalize(theString)
      --trim everything but letters and numbers
      return do shell script "echo " & quoted form of theString & " | tr '\r' ' ' | sed 's/[^[:space:][:alnum:]]//g'"
    end normalize

    tell application "iTunes"
      set theQuery to my normalize("{query}")
      --playlist 1 should be your whole music library
      set theTracks to tracks of library playlist 1
      set match to ""
      
      repeat with i from 1 to number of items in theTracks
        set theTrack to item i of theTracks
        set theLyrics to my normalize(lyrics of theTrack)
        if theQuery is in theLyrics then
          set match to (artist of theTrack & " - " & name of theTrack)
          exit repeat
        end if
      end repeat
      
      if match is not "" then
        play theTrack
        get match
      else
        get "No match found"
      end if
    end tell

You'll notice that it runs through your entire library in alphabetical order. Unfortunately, if the song you're looking for is by ZZ Top the search is going to be a hell of a lot slower than if it were by ABBA.

Also, lyrical clichés like "oh baby" or "tell me why" are likely to produce a match earlier than you expect so try to search for longer or less common phrases.[^1]

If anyone has suggestions for improvements please let me know. I like the simplicity of the script so don't plan to produce a playlist of search results or anything like that but feel free to use the Applescript as a starting point for your own script!

[^1]: It's actually pretty fun to guess at lyrics and see what songs they appear in. If a search for "hands in the air" or "in da club" return in less than 10 seconds your iTunes may be due a clear-out.

[gl]: http://shullian.com/get_lyrical.php
[dl]: https://dl.dropbox.com/s/k0jglbcxiwp6q59/Lyrics%20Search.alfredworkflow
