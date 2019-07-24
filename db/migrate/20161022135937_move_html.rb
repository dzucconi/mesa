# frozen_string_literal: true
class MoveHtml < ActiveRecord::Migration
  def up
    ActiveRecord::Base.record_timestamps = false
    begin
      Page.find_each do |page|
        page.update_attributes!(html: page.to_html)
      end
    ensure
      ActiveRecord::Base.record_timestamps = true
    end
  end

  def down
    # ...
  end
end
