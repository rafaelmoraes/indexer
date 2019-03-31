# frozen_string_literal: true

class HeaderResource < JSONAPI::Resource
  attributes :tag, :text, :link
  has_one :webpage
end
