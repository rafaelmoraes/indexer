# frozen_string_literal: true

class Webpage < ApplicationRecord
  validates :url, presence: true

  validate :url_cannot_be_unreachable, if: Proc.new { |wp| wp.url.present? }

  has_many :headers

  before_create :index_and_create_headers

  def url_cannot_be_unreachable
    errors.add :url, "can't be found" unless WebpageParser.new(url).page_found?
  end

  protected
    def index_and_create_headers
      WebpageParser.new(url).each_tag_indexable(*Header::TAGS) do |indexable|
        headers.new indexable
      end
    end
end
