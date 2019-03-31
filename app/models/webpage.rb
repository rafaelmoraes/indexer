# frozen_string_literal: true

class Webpage < ApplicationRecord
  validates :url, presence: true

  has_many :headers

  before_create :index_and_create_headers

  protected
    def index_and_create_headers
      parser = WebpageParser.new(url)
      if parser.page_found?
        parser.each_tag_indexable(*%w[h1 h2 h3]) do |indexable|
          headers.new indexable
        end
      else
        errors.add :url, "not found"
      end
    end
end
