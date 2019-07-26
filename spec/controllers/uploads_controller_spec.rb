# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UploadsController, type: :controller do
  let!(:upload) { Fabricate(:upload) }

  let(:page) { upload.page }
  let(:namespace) { page.namespace }

  let(:valid_attributes) do
    {
      file_name: 'upload.gif',
      file_size: 888,
      content_type: 'image/gif'
    }
  end

  describe 'GET index' do
    it 'gets all the uploads attached to the page' do
      get :index, namespace_id: namespace.slug, page_id: page.slug
      expect(assigns(:uploads)).to eq [upload]
    end
  end

  describe 'POST index' do
    before { auth }

    before(:each) do
      allow_any_instance_of(Upload).to receive(:signed).and_return('s3url')
    end

    it 'creates a Upload' do
      expect do
        post :create, namespace_id: namespace.slug, page_id: page.slug, upload: valid_attributes
      end.to change(Upload, :count).by 1
    end

    it 'assigns the newly created Upload as @upload' do
      post :create, namespace_id: namespace.slug, page_id: page.slug, upload: valid_attributes
      expect(assigns(:upload)).to be_a Upload
      expect(assigns(:upload)).to be_persisted
    end

    it 'renders the JSON of the PUT and GET urls for the attached file' do
      post :create, namespace_id: namespace.slug, page_id: page.slug, upload: valid_attributes
      body = JSON.parse(response.body)
      expect(body.keys).to eq %w[put get]
    end
  end
end
