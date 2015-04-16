class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :slug
      t.text :title
      t.text :content
      t.timestamps null: false
    end
  end
end
