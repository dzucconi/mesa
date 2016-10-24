class SearchController < ApplicationController
  before_filter :authenticate!

  def index
    @query = params[:q]
    @pages = Page.basic_search(@query).page(params[:page]).per(params[:per]) if @query.present?
  end
end
