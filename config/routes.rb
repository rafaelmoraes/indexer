# frozen_string_literal: true

Rails.application.routes.draw do
  jsonapi_resources :webpages, only: %i[index create] do
    jsonapi_resources :headers, only: :index
  end
end
