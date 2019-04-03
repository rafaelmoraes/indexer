# frozen_string_literal: true

class Header < ApplicationRecord
  TAGS = %w[h1 h2 h3].freeze

  belongs_to :webpage

  validates_presence_of :tag, :link
  validates_inclusion_of :tag,
                      in: TAGS,
                      message: "must be #{TAGS.join(' or ')}"
end
