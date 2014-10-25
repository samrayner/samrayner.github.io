module ThemeHelpers
  def entity_obfuscate(string)
    string.gsub(/./){ |char| "&##{char[0].ord};" }
  end

  def percent_obfuscate(string)
    "%" + string.unpack("H2" * string.bytesize).join("%").upcase
  end

  def banner_style(page)
    properties = ["color", "image", "size", "repeat"]
    style = "background-size: auto;"

    if height = page.data.banner_height
      style += "height: #{height}px;"
    end

    properties.each do |prop|
      value = page.data.send("banner_#{prop}")

      if value
        value = "url(#{page.url}#{value})" if prop == "image"
        style += "background-#{prop}: #{value};"
      end
    end

    return style
  end

  def image_collection(dir, type)
    html = '<div class="'+type.to_s+'">'
    source_path = "/images/galleries"
    pattern = "#{Dir.pwd}/source#{source_path}/#{dir}/*.{jpg,jpeg,png,gif}"

    Dir.glob(pattern) do |path|
      filename = File.basename(path)
      file_path = "#{source_path}/#{dir}/#{filename}"

      html += '<a href="'+file_path+'" target="_blank">' if type == :gallery
      html += '<img src="'+file_path+'" alt="" />'
      html += '</a>' if type == :gallery
    end

    html += '</div>'
  end

  def gallery(slug)
    return image_collection(slug, :gallery)
  end

  def slideshow(slug)
    return image_collection(slug, :slideshow)
  end

  def window(gallery_slug, url, post_slug=nil)
    url ||= data.site.root_url
    permalink = post_slug ? "/posts/#{post_slug}/" : url

    id = url.gsub("http://", "").gsub(".", "_")
    html  = '<div class="chrome" id="'+id+'" data-permalink="'+permalink+'">'
    html += slideshow(gallery_slug)
    html += '</div>'

    return html
  end
end
