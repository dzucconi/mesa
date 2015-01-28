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

require 'rails_helper'

RSpec.describe Page, type: :model do
  let!(:page) { Fabricate(:page) }
  let!(:base) { Fabricate(:page, slug: 'index') }

  it 'has a valid fabricator' do
    expect(page).to be_valid
  end

  describe '#to_s' do
    it 'returns the title' do
      expect("#{page}").to eql 'Impression, Sunrise'
    end
  end

  describe '#to_html' do
    it 'returns the content as HTML' do
      html = page.to_html
      expect(html).to include '<p><em>Although</em> it seems'
      expect(html).to include '<a href="http://en.wikipedia.org/wiki/Impression,_Sunrise">'
      expect(html).to include '<strong>Impression: Sunrise</strong>'
      expect(html).to include '</p>'
    end
  end

  describe '#base' do
    it 'finds the base object' do
      expect(Page.base).to eq base
    end
  end
end
