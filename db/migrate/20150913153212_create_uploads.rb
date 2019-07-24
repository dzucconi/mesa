# frozen_string_literal: true
class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :file_name
      t.string :content_type
      t.integer :file_size
      t.references :page, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
