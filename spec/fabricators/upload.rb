# frozen_string_literal: true

Fabricator(:upload) do
  file_name 'uploaded.jpg'
  file_size 666
  content_type 'image/jpeg'
  page { Fabricate(:page) }
end
