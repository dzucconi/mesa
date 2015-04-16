# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  slug         :string
#  title        :text
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  namespace_id :integer
#

class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  validates_presence_of :namespace_id

  belongs_to :namespace

  def to_s
    title
  end

  def to_html
    Kramdown::Document.new(content || '').to_html
  end
end
