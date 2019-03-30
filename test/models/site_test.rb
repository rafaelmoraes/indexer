# frozen_string_literal: true

require "test_helper"

class SiteTest < ActiveSupport::TestCase
  test "should be invalid when url is empty" do
    site = Site.new url: ""
    assert_not site.valid?
    assert_equal "can't be blank", site.errors.messages[:url].first
  end

  test "should has many headers" do
    assert_respond_to Site.new, :headers
  end
end
