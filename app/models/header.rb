# frozen_string_literal: true

class Header < ApplicationRecord
  NOT_FOUND = "Not found".freeze
  TAGS_REGEX = /\Ah(1|2|3)\z/.freeze

  belongs_to :site

  validates_presence_of :tag, :text, :link,
    message: "%{attribute} when does not exist must be: #{NOT_FOUND}"
  validates_format_of :tag,
                      with: TAGS_REGEX,
                      message: "must be h1 or h2 or h3"
end
