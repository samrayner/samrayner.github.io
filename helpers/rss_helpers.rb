module RssHelpers
  def rss_format_time(time)
    time.strftime("%a, %d %b %Y %H:%M:%S %z")
  end

  def rss_published(article)
    rss_format_time(article.date.to_time)
  end

  def rss_modified(article)
    rss_format_time(File.mtime(article.source_file))
  end
end
