# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  slug       :string
#  title      :text
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  BASE = 'index'

  def self.base
    find_by_slug BASE
  end

  def index?
    slug == BASE
  end

  def to_s
    title
  end

  def to_html
    Kramdown::Document.new(content).to_html
  end
end
