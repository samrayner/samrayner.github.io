---
title: "Using Ruby 1.9 with Alfred"
date: 2013-01-22 21:14
tags: development, mac, tip, alfred
---

I've been building a [Sprint.ly Workflow for Alfred 2][sfa] (currently [in beta][a2]) and wanted to use it as an opportunity to brush up on my [TDD][] and Ruby-foo.

Alfred 2 let's you run PHP, Python, Perl and Ruby scripts but they run from `usr/bin/lib` and Mountain Lion ships with (a pretty outdated) Ruby 1.8.7.

If you have a newer version of Ruby installed with [RVM][] or [rbenv][rbe], here's how to bootstrap Alfred to use it instead. In your Workflow, set up a Ruby script action as normal and fill it with:

    SCRIPT_FILE = "example"

    def ruby_exec_path(manager)
      begin
        ruby_path = `~/.#{manager}/bin/#{manager} which ruby`
        if $?.exitstatus == 127
          raise Errno::ENOENT
        end
      rescue Errno::ENOENT
        ruby_path = ""
      end
      return ruby_path.strip
    end

    ruby_path = ruby_exec_path("rvm")
    ruby_path = ruby_exec_path("rbenv") unless ruby_path.length
    ruby_path = "ruby" unless ruby_path.length

    parent_dir = File.expand_path(File.dirname(__FILE__))
    puts `#{ruby_path} "#{SCRIPT_FILE}.rb" "{query}"`

This fetches your active Ruby and runs the script `example.rb`, passing the Alfred query as an argument.

Create `example.rb` in your Workflow directory and you can grab the query string inside it:

    QUERY = ARGV[0]

Anything your file `puts` into `STDOUT` will be passed back to Alfred to use in your Workflow!

As well as letting you use The New Ruby Hotness, this has the added benefit of moving code out of Alfred and into files that are more easily tested and version controlled. The only down-side is that **your Workflow will require users to be running RVM or rbenv if you share it**.

---

**Update (Aug 4):** Good news! OS X Mavericks is [set to ship with Ruby 2.0][mav] by default so you shouldn't need to use this hack for much longer.

[sfa]: https://github.com/samrayner/Sprintly-for-Alfred
[a2]: http://blog.alfredapp.com/2013/01/12/first-alfred-v2-beta-now-available-for-mega-supporters/
[tdd]: http://en.wikipedia.org/wiki/Test-driven_development
[rvm]: https://rvm.io/
[rbe]: https://github.com/sstephenson/rbenv
[mav]: https://twitter.com/Narnach/status/344368814802227201
