class PagesController < ApplicationController
  # GET /
  def index
    @page = Page.base
    render template: 'pages/show'
  end

  # GET /1
  def show
    find_with_redirect
  end

  # GET /new
  def new
    @page = Page.new slug: params[:id], title: params[:id].titleize
  end

  # GET /1/edit
  def edit
    find_with_redirect
  end

  # POST /
  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to @page, notice: 'Created'
    else
      render :new
    end
  end

  # PATCH/PUT /1
  def update
    @page = Page.find(params[:id])
    if @page.update(page_params)
      redirect_to @page, notice: 'Updated'
    else
      render :edit
    end
  end

  # DELETE /1
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to Page.base, notice: 'Deleted'
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

  def find_with_redirect
    @page = Page.find_by_slug!(params[:id])
    yield if block_given?
  rescue ActiveRecord::RecordNotFound
    redirect_to new_page_path id: params[:id]
  end
end
