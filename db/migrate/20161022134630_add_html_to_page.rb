# frozen_string_literal: true

class AddHtmlToPage < ActiveRecord::Migration
  def change
    add_column :pages, :html, :text
  end
end
