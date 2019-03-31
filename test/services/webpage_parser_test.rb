# frozen_string_literal: true

require "test_helper"

class WebpageParserTest < ActiveSupport::TestCase
  test "should page_found be false" do
    parser = WebpageParser.new("https://www.asdf.coomm")
    assert_not parser.page_found?
  end

  test "should found 5 indexables" do
    count = 0
    mock_parser.each_tag_indexable(*%w[h1 h2 h3]) do |indexable|
      count += 1
    end
    assert_equal 5, count
  end

  test "should return a Hash with attributes tag, text, link" do
    mock_parser.each_tag_indexable("h2") do |indexable|
      assert_instance_of Hash, indexable
      keys = indexable.keys
      assert_includes keys, :tag
      assert_includes keys, :text
      assert_includes keys, :link
    end
  end

  private
    def mock_parser
      parser = WebpageParser.new("")
      mock_page = File.open("test/fixtures/files/webpage.html")
      parser.instance_variable_set :@page, Nokogiri::HTML(mock_page)
      parser
    end
end
