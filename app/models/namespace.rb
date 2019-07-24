# frozen_string_literal: true
# == Schema Information
#
# Table name: namespaces
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state      :string
#

class Namespace < ActiveRecord::Base
  include AASM

  extend FriendlyId
  friendly_id :name

  has_many :pages, -> { order updated_at: :desc }, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true

  aasm column: 'state' do
    state :published, initial: true
    state :locked

    event :publish do
      transitions from: [:locked, :published], to: :published
    end

    event :retract do
      transitions from: [:locked, :published], to: :locked
    end
  end

  before_save :match_slug

  def match_slug
    self.slug = name.parameterize
  end

  def to_s
    name
  end
end
