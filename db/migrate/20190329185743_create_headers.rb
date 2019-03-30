# frozen_string_literal: true

class CreateHeaders < ActiveRecord::Migration[5.2]
  def change
    create_table :headers do |t|
      t.references :site, foreign_key: true
      t.string :tag, limit: 2, null: false
      t.string :text, null: false
      t.string :link, null: false

      t.timestamps
    end
  end
end
