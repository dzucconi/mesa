class PagesController < ApplicationController
  before_filter :find_namespace

  # GET /
  def index
    @pages = @namespace.pages
    render template: 'namespaces/show'
  end

  # GET /1
  def show
    find_with_redirect
  end

  # GET /new
  def new
    @page = @namespace.pages.find_by_slug!(params[:id])
    redirect_to edit_namespace_page_path(@namespace, @page), notice: 'Already exists'
  rescue ActiveRecord::RecordNotFound
    @page = @namespace.pages.new slug: params[:id], title: params[:id].try(:titleize)
  end

  # GET /1/edit
  def edit
    find_with_redirect
  end

  # POST /
  def create
    @page = @namespace.pages.new(page_params)
    if @page.save
      redirect_to namespace_page_path(@namespace, @page), notice: 'Created'
    else
      render :new
    end
  end

  # PATCH/PUT /1
  def update
    @page = @namespace.pages.find(params[:id])
    if @page.update(page_params)
      redirect_to namespace_page_path(@namespace, @page), notice: 'Updated'
    else
      render :edit
    end
  end

  # DELETE /1
  def destroy
    @page = @namespace.pages.find(params[:id])
    @page.destroy
    redirect_to @namespace, notice: 'Deleted'
  end

  # GET /1/source
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
