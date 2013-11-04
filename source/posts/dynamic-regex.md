---
title: "Dynamic Regular Expressions"
date: 2013-05-03 18:47
tags: development
---

I faced an interesting challenge while developing [Sprint.ly for Alfred][sfa] recently; how to provide a preview of a story title as the user typed it. A [story][] is a concept from [Agile software development][agile] that encapsulates the _who_, _what_ and _why_ of a feature.

> As a **site owner**, I want **a contact form** so that **visitors can get in touch**.

First off, I created a `Story` class to hold the components of a story and a `title` method to get them out as a formatted string:

    class Story
      attr_accessor :who, :what, :why

      def title
        #declare our separators
        prefixes = {
          who: "As a",
          what: "I want",
          why: "so that"
        }

        #go all grammar nazi
        prefixes[:who] << "n" if @who && ["a","e","i","o"].include?(@who[0,1])

        #format the story into a string
        "#{prefixes[:who]} #{@who}, #{prefixes[:what]} #{@what} #{prefixes[:why]} #{@why}"
      end
    end

The tricky bit would be taking a string as input and parsing it into those attributes. I needed the title broken up to submit the parts separately to the [Sprint.ly API][api] as well as generate the preview on the fly.

I wanted the preview to start out as _"As a \_\_, I want \_\_ so that \_\_"_, with the blanks being filled in as the user typed. I also wanted to give the option of a _aa iw st_ shorthand to speed up entry, and to allow the blanks to be filled in any order.

Unable to write a standard regex that would cut it, I ended up with this system of appending to a regex as matches were found:

    def parse_title(title)
      #default values
      @who = "__"
      @what = "__"
      @why = "__"

      #define our capture triggers
      captures = {
        "who" => "as an?|aa",
        "what" => " i want| iw",
        "why" => " so that| st"
      }

      #get things started
      regex_str = '^\s*'

      #if the prefix is present, append a named capture group to the regex
      captures.each do |key,val|
        prefix = '(?:'+val+')\s+'
        if title.match(Regexp.new(prefix, true))
          regex_str << prefix+'(?<'+key+'>.+)'
        end
      end

      #apply the final regex built from the string
      matches = title.match(Regexp.new(regex_str, true))

      if matches
        matches.names.each do |name| 
          value = matches[name].strip
          #strip out any trailing comma from the who
          value.sub!(/,$/, "") if name == "who"
          #store each component in the instance variables
          self.send(name+"=", value)
        end
      end
    end

The solution greedily matches everything after a trigger phrase until another trigger is encountered and then breaks the string down.

With that done, the last thing was to trigger parsing by calling a setter method on every keystroke:

    def title=(value)
      self.parse_title(value)
    end

And it works pretty well!

<iframe src="http://player.vimeo.com/video/65418688?portrait=0&byline=0&title=0" width="762" height="534" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>

Download [Sprint.ly for Alfred][sfa] to give it a spin. If you know a smarter way of doing this, I'd be really interested to hear it [on Twitter][tw] or [via email][email].

[story]: http://en.wikipedia.org/wiki/User_story
[sfa]: {{site_root}}/posts/alfred-sprintly
[agile]: http://en.wikipedia.org/wiki/Agile_software_development
[api]: https://github.com/sprintly/sprint.ly-docs
[email]: &#109;&#97;&#105;&#x6c;&#x74;&#x6f;&#58;&#x73;&#97;&#109;&#64;&#115;&#x61;&#x6d;&#114;&#97;&#x79;&#110;&#101;&#x72;&#46;&#99;&#111;&#109;
[tw]: http://twitter.com/samrayner
