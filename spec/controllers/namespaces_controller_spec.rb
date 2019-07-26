# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NamespacesController, type: :controller do
  let!(:namespace) do
    Fabricate(:namespace)
  end

  let(:valid_attributes) do
    { name: 'non-specific' }
  end

  describe 'GET index' do
    it 'gets all the namespaces' do
      get :index
      expect(assigns(:namespaces)).to eq([namespace])
    end
  end

  describe 'GET new' do
    before { auth }

    it 'news up a Namespace' do
      get :new, id: 'nearly-there'
      expect(assigns(:namespace).name).to eql 'nearly-there'
    end

    it 'redirects to the edit action if the Namespace already exists' do
      get :new, id: namespace.slug
      expect(response).to redirect_to action: :show, id: namespace.slug
    end
  end

  describe 'POST create' do
    before { auth }

    it 'creates a Namespace' do
      expect do
        post :create, namespace: valid_attributes
      end.to change(Namespace, :count).by 1
    end

    it 'assigns the newly created Namespace as @namespace' do
      post :create, namespace: valid_attributes
      expect(assigns(:namespace)).to be_a Namespace
      expect(assigns(:namespace)).to be_persisted
    end

    it 'redirects to the created Namespace' do
      post :create, namespace: valid_attributes
      expect(response).to redirect_to Namespace.last
    end
  end
end
