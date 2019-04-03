# frozen_string_literal: true

require "rails_helper"

RSpec.describe WebpagesController, type: :controller do
  before do
    # post does not accept headers as parameter
    request.headers.merge!(
      "Accept" => JSONAPI::MEDIA_TYPE,
      "Content-Type" => JSONAPI::MEDIA_TYPE
    )
    stub_request(:get, "https://www.google.com/").to_return(status: 200)
    stub_request(:get, "www.site.does.not.exist").to_return(status: 404)
  end

  describe "POST create" do
    context "when the data is valid" do
      it "has a 201(created) status code" do
        expect do
          post :create,
               format: :json,
               params: {
                 data: {
                   type: "webpages",
                   attributes: { url: "https://www.google.com" }
                 }
               }
        end.to change { Webpage.count }.by(1)
        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)["data"]["id"]).to_not be nil
      end
    end

    context "when the data is invalid" do
      it "has a 422(unprocessable entity) status code" do
        expect do
          post :create,
               format: :json,
               params: {
                 data: {
                   type: "webpages",
                   attributes: { url: "" }
                 }
               }
        end.to change { Webpage.count }.by(0)
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)["errors"]).to_not be nil
      end

      it "has a 422(unprocessable entity) status code" do
        expect do
          post :create,
               format: :json,
               params: {
                 data: {
                   type: "webpages",
                   attributes: { url: "www.site.does.not.exist" }
                 }
               }
        end.to change { Webpage.count }.by(0)
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)["errors"]).to_not be nil
      end
    end
  end

  describe "GET index" do
    it "return all webpages" do
      get :index
      webpages = JSON.parse(response.body)["data"]
      expect(webpages).to be_a Array
      expect(webpages.size).to eq Webpage.count
    end
  end
end
