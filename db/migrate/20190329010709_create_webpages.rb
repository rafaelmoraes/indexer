# frozen_string_literal: true

class CreateWebpages < ActiveRecord::Migration[5.2]
  def change
    create_table :webpages do |t|
      t.string :url, null: false

      t.timestamps
    end
  end
end
