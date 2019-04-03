# frozen_string_literal: true

require "rails_helper"

RSpec.describe WebpageParser do
  before do
    stub_request(:get, "www.site-does-not.exist").to_return(status: 404)

    my_mock = File.new("spec/fixtures/services/webpage_parser/my_mock.html")
    stub_request(:get, "https://www.my-mock.com")
      .to_return(body: my_mock, status: 200)
  end

  context "when url not found" do
    subject { WebpageParser.new("www.site-does-not.exist") }
    it "#page_found? should be false" do
      expect(subject.page_found?).to be false
    end

    it "#each_tag_indexable should return an empty Array" do
      indexables = subject.each_tag_indexable
      expect(indexables).to be_a Array
      expect(indexables.empty?).to be true
    end
  end

  context "when url found" do
    subject { WebpageParser.new("https://www.my-mock.com") }
    it "#page_found? should be true" do
      expect(subject.page_found?).to be true
    end

    context "and webpage has h1, h2 or h3 with links" do
      describe "#each_tag_indexable" do
        let(:indexeds) do
          indexeds = []
          subject.each_tag_indexable(*%w[h1 h2 h3]) do |index|
            indexeds << index
          end
          indexeds
        end

        it "should return an not empty Array" do
          expect(indexeds).to be_a Array
          expect(indexeds.present?).to be true
        end

        it "should return an Array with Hashes" do
          indexeds.each do |i|
            expect(i).to be_a Hash
          end
        end

        it "all hashes should has the key :tag, :link and :text" do
          indexeds.each do |i|
            expect(i.keys).to include :tag
            expect(i.keys).to include :text
            expect(i.keys).to include :link
          end
        end

        context "when a header is child of an anchor" do
          it "should get the values correctly" do
            index = indexeds.select do |i|
              i if i[:link] == "https://url_from_a_with_child.com"
            end.first
            expect(index[:tag]).to eq("h1")
            expect(index[:link]).to eq("https://url_from_a_with_child.com")
            expect(index[:text]).to eq("Header 1 with parent anchor")
          end
        end

        context "when a header is parent of an anchor" do
          it "should get the values correctly" do
            index = indexeds.select do |i|
              i if i[:link] == "https://url_from_h1.com"
            end.first
            expect(index[:tag]).to eq("h1")
            expect(index[:link]).to eq("https://url_from_h1.com")
            expect(index[:text]).to eq("Header 1")
          end
        end

        context "when there are more than one header of the same kind" do
          it "should get all of them" do
            repeted_headers = indexeds.select { |i| i if i[:tag] == "h3" }
            expect(repeted_headers.size).to eq(2)
          end
        end
      end
    end
  end
end
