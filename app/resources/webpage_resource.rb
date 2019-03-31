# frozen_string_literal: true

class WebpageResource < JSONAPI::Resource
  attributes :url

  has_many :headers
end
