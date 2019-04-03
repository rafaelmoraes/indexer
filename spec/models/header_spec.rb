# frozen_string_literal: true

require "rails_helper"

RSpec.describe Header, type: :model do
  subject { Header.new }

  describe "ActiveRecord association" do
    it { is_expected.to belong_to(:webpage) }
  end

  describe "validations" do
    describe "#tag" do
      it { is_expected.to validate_presence_of(:tag) }
      it do
        is_expected.to validate_inclusion_of(:tag)
          .in_array(Header::TAGS)
          .with_message("must be #{Header::TAGS.join(' or ')}")
      end
    end

    describe "#link" do
      it { is_expected.to validate_presence_of(:link) }
    end
  end

  describe "does have to create" do
    before do
      stub_request(:get, "https://www.google.com/").to_return(status: 200)
      stub_request(:get, "https://www.bing.com/").to_return(status: 200)
    end
    context "when webpage, tag and link are present and text is blank" do
      it "#persisted? should be true" do
        header = Header.create(
          webpage: Webpage.create(url: "https://www.google.com"),
          tag: "h1",
          link: "https://www.google.com"
        )
        expect(header.persisted?).to be true
      end
    end
    context "when webpage, tag, link and text are present" do
      it "#persisted? should be true" do
        header = Header.create(
          webpage: Webpage.create(url: "https://www.bing.com"),
          tag: "h2",
          link: "https://www.bing.com",
          text: "Bing is a web search engine that anybody uses"
        )
        expect(header.persisted?).to be true
      end
    end
  end
end
