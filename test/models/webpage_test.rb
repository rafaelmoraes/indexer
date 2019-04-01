# frozen_string_literal: true

require "test_helper"

class WebpageTest < ActiveSupport::TestCase
  test "should be invalid when url is empty" do
    page = Webpage.new url: ""
    assert_not page.valid?
    assert_equal "can't be blank", page.errors.messages[:url].first
  end

  test "should has many headers" do
    assert_respond_to Webpage.new, :headers
  end

  test "should has an error Url not found" do
    page = Webpage.create url: "https://asdf.coomm/"
    assert_not page.valid?
    assert_equal "can't be found", page.errors[:url].first
  end
end
