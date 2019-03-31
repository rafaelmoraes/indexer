# frozen_string_literal: true

class Header < ApplicationRecord
  TAGS_REGEX = /\Ah(1|2|3)\z/.freeze

  belongs_to :webpage

  validates_presence_of :tag, :link
  validates_format_of :tag,
                      with: TAGS_REGEX,
                      message: "must be h1 or h2 or h3"
end
