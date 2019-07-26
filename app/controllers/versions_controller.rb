# frozen_string_literal: true

class VersionsController < ApplicationController
  before_filter :find_namespaced_page

  # GET /:namespace_id/:page_id/versions
  def index
    @versions = @page.versions.unscope(:order).order(created_at: :desc)
  end

  # POST /:namespace_id/:page_id/versions/:id
  def restore
    @page = @page.versions.find(params[:id]).reify
    if @page.save
      redirect_to namespace_page_path(@namespace, @page), notice: 'Restored'
    else
      redirect :back
    end
  end

  private

  def find_namespaced_page
    @namespace = Namespace.find_by_slug!(params[:namespace_id])
    authenticate! if @namespace.locked?
    @page = @namespace.pages.includes(:uploads).find_by_slug!(params[:page_id])
  rescue StandardError
    redirect_to new_namespace_page_path(params[:namespace_id], id: params[:page_id])
  end
end
