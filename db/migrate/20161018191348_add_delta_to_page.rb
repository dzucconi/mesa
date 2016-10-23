class AddDeltaToPage < ActiveRecord::Migration
  def change
    add_column :pages, :delta, :json
  end
end
