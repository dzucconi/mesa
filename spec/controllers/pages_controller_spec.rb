require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let!(:namespace) do
    Fabricate(:namespace)
  end

  let!(:page) do
    Fabricate(:page, namespace: namespace)
  end

  let(:valid_attributes) do
    {
      slug: 'new-dimensions-of-disparity',
      title: 'New Dimensions of Disparity',
      content: '*Here* we have no neat set of **frames of reference**.'
    }
  end

  describe 'GET index' do
    it 'gets all the pages' do
      get :index, namespace_id: namespace.slug
      expect(assigns(:pages)).to eq([page])
    end
  end

  describe 'GET show' do
    it 'tries to find the requested Page' do
      get :show, namespace_id: namespace.slug, id: page.slug
      expect(assigns(:page)).to eq(page)
    end

    it 'redirects if it cannot' do
      get :show, namespace_id: namespace.slug, id: 'non-existent'
      expect(response).to redirect_to action: :new, namespace_id: namespace.slug, id: 'non-existent'
    end
  end

  describe 'GET new' do
    before { auth }

    it 'news up a Page, titlizing the ID' do
      get :new, namespace_id: namespace.slug, id: 'nearly-there'
      expect(assigns(:page).title).to eql 'Nearly There'
    end

    it 'redirects to the show action if the Page already exists' do
      get :new, namespace_id: namespace.slug, id: page.slug
      expect(response).to redirect_to action: :show, namespace_id: namespace.slug, id: page.slug
    end
  end

  describe 'GET edit' do
    before { auth }

    it 'tries to find the requested edit Page' do
      get :edit, namespace_id: namespace.slug, id: page.slug
      expect(assigns(:page)).to eq(page)
    end

    it 'redirects if it cannot' do
      get :edit, namespace_id: namespace.slug, id: 'non-existent'
      expect(response).to redirect_to action: :new, namespace_id: namespace.slug, id: 'non-existent'
    end
  end

  describe 'POST create' do
    before { auth }

    it 'creates a Page' do
      expect do
        post :create, namespace_id: namespace.slug, page: valid_attributes
      end.to change(Page, :count).by 1
    end

    it 'assigns the newly created Page as @page' do
      post :create, namespace_id: namespace.slug, page: valid_attributes
      expect(assigns(:page)).to be_a Page
      expect(assigns(:page)).to be_persisted
    end

    it 'redirects to the show Page' do
      post :create, namespace_id: namespace.slug, page: valid_attributes
      expect(response).to redirect_to action: :show, namespace_id: namespace.slug, id: Page.last.slug
    end
  end

  describe 'PUT update' do
    before { auth }

    it 'updates the requested Page' do
      put :update, id: page.id, namespace_id: namespace.slug, page: { title: 'Nameless shadow' }
      page.reload
      expect(page.title).to eql 'Nameless shadow'
      expect(response).to redirect_to [namespace, page]
    end
  end

  describe 'DELETE destroy' do
    before { auth }

    it 'destroys the requested Page' do
      expect do
        delete :destroy, namespace_id: namespace.slug, id: page.id
      end.to change(Page, :count).by(-1)
    end
  end

  describe 'GET source' do
    it 'renders the Markdown source of the requested Page' do
      get :source, namespace_id: namespace.slug, id: page.slug
      expect(response.body).to eql page.content
    end
  end
end
