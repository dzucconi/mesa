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
#  delta        :json
#  html         :text
#  mode         :integer          default(0)
#

class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  enum mode: [:wysiwyg, :html, :plain]

  has_paper_trail only: [:content, :delta]

  validates :namespace_id, presence: true
  validates :slug, presence: true

  belongs_to :namespace, touch: true
  has_many :uploads, dependent: :destroy

  before_validation :ensure_slug

  def ensure_slug
    self.slug = (title.try(:parameterize) || SecureRandom.hex(11)) if slug.blank?
  end

  def to_s
    (title.blank? ? nil : title) || preview.try(:truncate, 25) || slug
  end

  def to_html
    Kramdown::Document.new(content || '').to_html
  end

  def plain
    delta && delta['ops']
      .map { |op| op['insert'].strip if op['insert'].is_a? String }
      .compact
      .join(' ')
      .strip
  end

  def preview
    output = plain && plain
      .tr("\n", ' ')
      .truncate(200)

    output.blank? ? nil : output
  end
end
