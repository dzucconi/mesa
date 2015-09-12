require 'rails_helper'

RSpec.describe Api::V1::NamespacesController, type: :controller do
  let!(:namespace) do
    Fabricate(:namespace)
  end

  describe 'GET index' do
    it 'returns the JSON representation of paginated namespaces' do
      get :index
      expect(response.status).to be(200)
      parsed = JSON.parse(response.body)
      expect(parsed['total_count']).to be(1)
      expect(parsed['total_pages']).to be(1)
      expect(parsed['_embedded']['namespaces']).to be_a(Array)
      expect(parsed['_embedded']['namespaces'].first['id']).to eq(namespace.id)
      expect(parsed['_links'].keys).to eq(%w(self first next prev last))
    end
  end

  describe 'GET show' do
    it 'returns the JSON representation of a namespace' do
      get :show, id: namespace.slug
      expect(response.status).to be(200)
      parsed = JSON.parse(response.body)
      expect(parsed['id']).to eq(namespace.id)
      expect(parsed['name']).to eq(namespace.name)
      expect(parsed['_links'].keys).to eq(%w(self pages page))
    end
  end
end
