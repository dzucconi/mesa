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

class Upload < ActiveRecord::Base
  belongs_to :page

  validates :file_name, presence: true
  validates :file_size, presence: true
  validates :content_type, presence: true
  validates :page_id, presence: true

  def bucket
    ENV['AWS_S3_BUCKET']
  end

  def signed
    Aws::S3::Resource
      .new
      .bucket(bucket)
      .object(key)
      .presigned_url(:put, acl: 'public-read')
  end

  def extension
    File.extname(file_name)
  end

  def key
    "#{page.id}/#{id}/#{File.basename(file_name, extension).parameterize}#{extension}"
  end

  def qualified
    "https://#{bucket}.s3.amazonaws.com/#{key}"
  end
end
