xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title data.site.title
  xml.subtitle data.me.bio
  xml.id URI.join(data.site.root_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(data.site.root_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(data.site.root_url, current_page.path), "rel" => "self"
  xml.updated blog.articles.first.date.to_time.iso8601
  xml.author { xml.name data.me.name }

  blog.articles[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => URI.join(data.site.root_url, article.url)
      xml.id URI.join(data.site.root_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name data.me.name }
      # xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end
