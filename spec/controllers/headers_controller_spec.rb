# frozen_string_literal: true

require "rails_helper"

RSpec.describe HeadersController, type: :controller do
  before do
    # post does not accept headers as parameter
    request.headers.merge!(
      "Accept" => JSONAPI::MEDIA_TYPE,
      "Content-Type" => JSONAPI::MEDIA_TYPE
    )
    body = File.new("spec/fixtures/services/webpage_parser/my_mock.html")
    stub_request(:get, "https://www.mymock.com")
      .to_return(body: body, status: 200)
  end

  describe "GET index" do
    it "given a webpage id returns all headers" do
      webpage = Webpage.create url: "https://www.mymock.com"
      get :index,
          params: { webpage_id: webpage.id }
      headers_found = JSON.parse(response.body)["data"]
      expect(headers_found.size).to eq webpage.headers.count
    end
  end
end
