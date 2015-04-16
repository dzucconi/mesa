# == Schema Information
#
# Table name: namespaces
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Namespace < ActiveRecord::Base
  has_many :pages, -> { order created_at: :desc }, dependent: :destroy

  extend FriendlyId
  friendly_id :name

  def to_s
    "/#{slug}"
  end
end
