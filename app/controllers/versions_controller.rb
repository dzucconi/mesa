class VersionsController < ApplicationController
  before_filter :find_namespaced_page

  # GET /:namespace_id/:page_id/versions
  def index
    @versions = @page.versions.unscope(:order).order(created_at: :desc)
  end

  private

  def find_namespaced_page
    @namespace = Namespace.find_by_slug!(params[:namespace_id])
    authenticate! if @namespace.locked?
    @page = @namespace.pages.includes(:uploads).find_by_slug!(params[:page_id])
  rescue
    redirect_to new_namespace_page_path(params[:namespace_id], id: params[:page_id])
  end
end
