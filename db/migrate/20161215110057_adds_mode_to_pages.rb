# frozen_string_literal: true

class AddsModeToPages < ActiveRecord::Migration
  def change
    add_column :pages, :mode, :integer, default: 0
  end
end
