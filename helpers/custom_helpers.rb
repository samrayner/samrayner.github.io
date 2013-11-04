module CustomHelpers
  def html_obfuscate(string)
    encoded_chars = []
    string.each_char do |char|
      encoded_chars << "&##{char[0].ord};"
    end
    encoded_chars.join
  end
end
