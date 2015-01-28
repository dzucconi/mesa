require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let!(:page) { Fabricate(:page) }
  let!(:base) { Fabricate(:page, slug: 'index') }
  let(:valid_attributes) {
    {
      slug: 'new-dimensions-of-disparity',
      title: 'New Dimensions of Disparity',
      content: '*Here* we have no neat set of **frames of reference**.'
    }
  }

  describe 'GET index' do
    it 'redirects to the base page' do
      get :index
      expect(response).to redirect_to Page.base
    end
  end

  describe 'GET show' do
    it 'tries to find the requested Page' do
      get :show, id: page.slug
      expect(assigns(:page)).to eq(page)
    end

    it 'redirects if it cannot' do
      get :show, id: 'non-existent'
      expect(response).to redirect_to action: :new, id: 'non-existent'
    end
  end

  describe 'GET new' do
    it 'news up a Page, titlizing the ID' do
      get :new, id: 'nearly-there'
      expect(assigns(:page).title).to eql 'Nearly There'
    end
  end

  describe 'GET edit' do
    it 'tries to find the requested edit Page' do
      get :edit, id: page.slug
      expect(assigns(:page)).to eq(page)
    end

    it 'redirects if it cannot' do
      get :edit, id: 'non-existent'
      expect(response).to redirect_to action: :new, id: 'non-existent'
    end
  end

  describe 'POST create' do
    it 'creates a Page' do
      expect {
        post :create, page: valid_attributes
      }.to change(Page, :count).by 1
    end

    it 'assigns the newly created Page as @page' do
      post :create, page: valid_attributes
      expect(assigns(:page)).to be_a Page
      expect(assigns(:page)).to be_persisted
    end

    it 'redirects to the created Page' do
      post :create, page: valid_attributes
      expect(response).to redirect_to Page.last
    end
  end

  describe 'PUT update' do
    it 'updates the requested Page' do
      put :update, id: page.id, page: { title: 'Nameless shadow' }
      page.reload
      expect(page.title).to eql 'Nameless shadow'
      expect(response).to redirect_to page
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested Page' do
      expect {
        delete :destroy, id: page.id
      }.to change(Page, :count).by(-1)
    end
  end

  describe 'GET source' do
    it 'renders the Markdown source of the requested Page' do
      get :source, id: page.slug
      expect(response.body).to eql page.content
    end
  end
end
