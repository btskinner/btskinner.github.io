=begin
  Tag to include markdown text from linked file (e.g. Github README.md)
  Usage:
    {% linkmarkdown <filename> %}
=end

require 'open-uri'

module Jekyll
  class MarkdownTag < Liquid::Tag
    def initialize(tag_name, url, tokens)
      super
      @url = url.strip
    end
    def render(context)
      contents = open(@url, &:read)
      site = context.registers[:site]
      converter = Jekyll::Converters::Markdown::KramdownParser.new(site.config)
      contents = (Liquid::Template.parse contents).render site.site_payload
      html = converter.convert(contents)
    end
  end
end

Liquid::Template.register_tag('linkmarkdown', Jekyll::MarkdownTag)
