class PagesController < ApplicationController
  before_filter :find_namespace
  before_filter :authenticate!, except: [:index, :show, :source]

  # GET /
  def index
    @pages = @namespace.pages
  end

  # GET /:namespace_id/:id
  def show
    find_with_redirect
  end

  # GET /:namespace_id/new
  def new
    @page = @namespace.pages.find_by_slug!(params[:id])
    redirect_to edit_namespace_page_path(@namespace, @page), notice: 'Already exists'
  rescue ActiveRecord::RecordNotFound
    @page = @namespace.pages.new slug: params[:id], title: params[:id].try(:titleize)
  end

  # GET /:namespace_id/:id/edit
  def edit
    find_with_redirect
  end

  # POST /:namespace_id
  def create
    @page = @namespace.pages.new(page_params)

    if @page.save
      redirect_to edit_namespace_page_path(@namespace, @page), notice: 'Created'
    else
      render :new
    end
  end

  # PATCH/PUT /:namespace_id/:id
  def update
    @page = @namespace.pages.find(params[:id])
    if @page.update(page_params)
      if request.xhr?
        render json: @page
      else
        redirect_to namespace_page_path(@namespace, @page), notice: 'Updated'
      end
    else
      render :edit
    end
  end

  # DELETE /:namespace_id/:id
  def destroy
    @page = @namespace.pages.find(params[:id])
    @page.destroy
    redirect_to @namespace, notice: 'Deleted'
  end

  # GET /:namespace_id/:id/source
  def source
    find_with_redirect do
      render text: @page.content, content_type: Mime::TEXT
    end
  end

  private

  def page_params
    params.require(:page).permit(:slug, :title, :content)
  end

  def find_namespace
    @namespace = Namespace.find_by_slug!(params[:namespace_id])
    authenticate! if @namespace.locked?
  rescue
    redirect_to new_namespace_path name: params[:namespace_id]
  end

  def find_with_redirect
    @page = @namespace.pages.find_by_slug!(params[:id])
    yield if block_given?
  rescue ActiveRecord::RecordNotFound
    redirect_to new_namespace_page_path(@namespace, id: params[:id])
  end
end
