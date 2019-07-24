# frozen_string_literal: true
class CreateNamespaces < ActiveRecord::Migration
  def change
    create_table :namespaces do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.timestamps null: false
    end

    add_index :namespaces, :name, unique: true
    add_index :namespaces, :slug, unique: true

    add_column :pages, :namespace_id, :integer
    add_index :pages, :namespace_id
    add_index :pages, [:slug, :namespace_id], unique: true
  end
end
