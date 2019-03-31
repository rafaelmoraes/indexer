# frozen_string_literal: true

require "open-uri"

class WebpageParser
  def initialize(url)
    begin
      @page = Nokogiri::HTML(open(url))
      @page_found = true
    rescue
      @page_found = false
    end
  end

  def page_found?
    @page_found
  end

  def each_tag_indexable(*css_selectors)
    css_selectors.each do |css_selector|
      @page.css(css_selector).each do |nokogiri_node|
        index = extract_indexable nokogiri_node
        yield index if index
      end
    end
  end

  private
    def extract_indexable(nokogiri_node)
      anchor = nokogiri_node.css("a").first
      anchor = nokogiri_node.parent if anchor.nil?
      {
        tag: nokogiri_node.name,
        text: nokogiri_node.text&.strip,
        link: anchor["href"]
      } if anchor && anchor["href"]
    end
end
