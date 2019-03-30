# frozen_string_literal: true

class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.string :url, null: false

      t.timestamps
    end
  end
end
