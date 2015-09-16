class AddStateToNamespaces < ActiveRecord::Migration
  def change
    add_column :namespaces, :state, :string
  end
end
