# frozen_string_literal: true

require "test_helper"

class WebpagesControllerTest < ActionDispatch::IntegrationTest
  test "should create card" do
    assert_difference("Webpage.count") do
      post webpages_url,
           as: :json,
           headers: {
             "Accept" => JSONAPI::MEDIA_TYPE,
             "Content-Type" => JSONAPI::MEDIA_TYPE
           },
           params: {
             data: {
               type: "webpages",
               attributes: { url: "https://google.com" }
             }
           }
    end

    assert_response :created
  end

  test "should get index" do
    get webpages_url
    assert_response :success
  end
end
