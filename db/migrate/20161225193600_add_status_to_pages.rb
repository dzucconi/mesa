class AddStatusToPages < ActiveRecord::Migration
  def change
    add_column :pages, :status, :string, default: 'active'
    add_index :pages, :status
  end
end
