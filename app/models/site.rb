# frozen_string_literal: true

class Site < ApplicationRecord
  validates :url, presence: true

  has_many :headers
end
