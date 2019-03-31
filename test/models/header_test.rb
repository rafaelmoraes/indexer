# frozen_string_literal: true

require "test_helper"

class HeaderTest < ActiveSupport::TestCase
  test "should belongs to site" do
    header = Header.new
    assert_respond_to header, :site_id
    assert_respond_to header, :site
  end

  test "should validate presence of tag and link" do
    header = Header.new tag: "", link: ""
    %i[tag link].each do |attribute|
      assert_not header.valid?
      assert_equal "can't be blank",
                   header.errors[attribute].first,
                   "attribute: #{attribute}"
    end
  end

  test "should be invalid if tag is different of h1, h2, h3" do
    header = Header.new text: "A page title",
                        link: "https://google.com",
                        site: sites(:google)
    %w[h1 h2 h3].each do |tag_type|
      header.tag = tag_type
      header.valid?
      assert header.valid?, "tag equal: #{tag_type}"
    end
    %w[h4, h5, h6, div, potato, section].each do |tag_type|
      header.tag = tag_type
      assert_not header.valid?,  "tag equal: #{tag_type}"
      assert_equal "must be h1 or h2 or h3", header.errors[:tag].first
    end
  end
end
