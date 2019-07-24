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
#  status       :string
#

class Page < ActiveRecord::Base
  include AASM

  extend FriendlyId
  friendly_id :slug

  enum mode: [:wysiwyg, :html, :plain]

  has_paper_trail only: [:content, :delta]

  validates :namespace_id, presence: true
  validates :slug, presence: true

  belongs_to :namespace, touch: true
  has_many :uploads, dependent: :destroy

  before_validation :ensure_slug

  aasm column: 'status' do
    state :active, initial: true
    state :archived

    event :archive do
      transitions from: [:active], to: :archived
    end
  end

  scope :active, -> { where(status: :active) }
  scope :archived, -> { where(status: :archived) }

  def ensure_slug
    self.slug = (title.try(:parameterize) || SecureRandom.hex(11)) if slug.blank?
  end

  def preview
    output = to_plain && to_plain
      .tr("\n", ' ')
      .truncate(200)

    output.blank? ? nil : output
  end

  def to_s
    (title.blank? ? nil : title) || preview.try(:truncate, 25) || slug
  end

  def to_html
    Kramdown::Document.new(content || '').to_html
  end

  def to_markdown
    case mode
    when 'plain'
      content
    when 'wysiwyg'
      delta && Delta.to_markdown(delta['ops'])
    when 'html'
      nil
    end
  end

  def to_urls
    URI.extract(to_markdown || html)
  end

  def to_plain
    delta && delta['ops']
      .map { |op| op['insert'].strip if op['insert'].is_a? String }
      .compact
      .join(' ')
      .strip
  end
end
