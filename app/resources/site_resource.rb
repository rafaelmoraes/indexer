# frozen_string_literal: true

class SiteResource < JSONAPI::Resource
  attributes :url

  has_many :headers
end
