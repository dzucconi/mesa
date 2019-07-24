# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V1::PagesController, type: :controller do
  let!(:namespace) do
    Fabricate(:namespace)
  end

  let!(:page) do
    Fabricate(:page, namespace: namespace)
  end

  describe 'GET index' do
    it 'returns the JSON representation of paginated pages belonging to the namespace' do
      get :index, namespace_id: namespace.slug
      expect(response.status).to be(200)
      parsed = JSON.parse(response.body)
      expect(parsed['total_count']).to be(1)
      expect(parsed['total_pages']).to be(1)
      expect(parsed['_embedded']['pages']).to be_a(Array)
      expect(parsed['_embedded']['pages'].first['id']).to eq(page.id)
      expect(parsed['_links'].keys).to eq(%w(self first next prev last))
    end
  end

  describe 'GET show' do
    it 'returns the JSON representation of a namespace' do
      get :show, namespace_id: namespace.slug, id: page.slug
      expect(response.status).to be(200)
      parsed = JSON.parse(response.body)
      expect(parsed['id']).to eq(page.id)
      expect(parsed['title']).to eq(page.title)
      expect(parsed['_links'].keys).to eq(%w(self namespace))
    end
  end
end
