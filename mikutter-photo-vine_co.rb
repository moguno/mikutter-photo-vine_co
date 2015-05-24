require "open-uri"
require "nokogiri"

Plugin.create(:"mikutter-photo-vine_co") {
  def open_vine_thumb(url)
    if !url.is_a?(String)
      return nil
    end

    html = open(url, "rb") { |fp|
      fp.read
    }

    doc = Nokogiri::HTML::parse(html, nil)
    attr = doc.xpath("//meta[@property='og:image']/@content").first

    open(attr.value, "rb")
  end

  defimageopener("vine.co", /^https?\:\/\/vine.co\/v\//) { |display_url|
    url = if display_url =~ /^https\:(.+)$/
      display_url
    else
      "https:#{$1}"
    end

    open_vine_thumb(url)
  }
}
