# frozen_string_literal: true

require "rails_helper"

RSpec.describe Webpage, type: :model do
  subject { Webpage.new }

  describe "ActiveRecord" do
    describe "associations" do
      it { is_expected.to have_many :headers }
    end

    describe "callbacks" do
      it { is_expected.to callback(:index_and_create_headers).before(:create) }
    end
  end

  describe "validations" do
    before do
      stub_request(:get, "https://www.google.com/").to_return(status: 200)
      stub_request(:get, "www.site.does.not.exist").to_return(status: 404)
    end

    describe "#url" do
      it { is_expected.to validate_presence_of(:url) }
      context "when url is present" do
        it "and can be found should has no error" do
          subject.url = "https://www.google.com/"
          subject.valid?
          expect(subject.errors[:url]).to_not include("can't be found")
        end

        it "and can't be found should has error" do
          subject.url = "www.site.does.not.exist"
          subject.valid?
          expect(subject.errors[:url]).to include("can't be found")
        end
      end
    end
  end

  describe ".create" do
    before do
      body = File.new("spec/fixtures/services/webpage_parser/my_mock.html")
      stub_request(:get, "https://www.mymock.com")
        .to_return(body: body, status: 200)
    end

    let(:webpage) { Webpage.create url: "https://www.mymock.com" }

    it "#persisted? should be true" do
      expect(webpage.persisted?).to be true
    end

    it "should have 5 headers" do
      expect(webpage.headers.size).to eq(5)
    end
  end
end
