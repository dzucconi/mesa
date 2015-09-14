# == Schema Information
#
# Table name: uploads
#
#  id           :integer          not null, primary key
#  file_name    :string
#  content_type :string
#  file_size    :integer
#  page_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Upload, type: :model do
  let!(:upload) { Fabricate(:upload) }

  it 'has a valid fabricator' do
    expect(upload).to be_valid
  end

  describe '#extension' do
    it 'returns the filename extension' do
      expect(upload.extension).to eq '.jpg'
    end
  end

  describe '#key' do
    it 'returns an S3 key' do
      expect(upload.key)
        .to eq "#{upload.page.id}/#{upload.id}/uploaded.jpg"
    end
  end

  describe '#qualified' do
    before(:each) do
      allow_any_instance_of(Upload).to receive(:bucket).and_return('mybucket')
    end

    it 'returns the S3 URL' do
      expect(upload.qualified)
        .to eq "https://mybucket.s3.amazonaws.com/#{upload.page.id}/#{upload.id}/uploaded.jpg"
    end
  end
end
