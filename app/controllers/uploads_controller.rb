class UploadsController < ApplicationController
  before_filter :find_namespaced_page

  # GET /:namespace_id/:page_id/uploads
  def index
    @uploads = @page.uploads
  end

  # POST /:namespace_id/:page_id/uploads
  def create
    @upload = @page.uploads.create!(upload_params)

    render json: {
      put: @upload.signed,
      get: @upload.qualified
    }
  end

  private

  def upload_params
    params.require(:upload).permit(:file_name, :file_size, :content_type)
  end

  def find_namespaced_page
    @namespace = Namespace.find_by_slug!(params[:namespace_id])
    @page = @namespace.pages.includes(:uploads).find_by_slug!(params[:page_id])
  rescue
    redirect_to new_namespace_page_path(params[:namespace_id], id: params[:page_id])
  end
end
