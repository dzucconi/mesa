# frozen_string_literal: true

module Api
  module V1
    class PagesController < BaseController
      before_filter :find_namespace

      # GET /api/:namespace_id/pages
      def index
        @pages = @namespace.pages.page(params[:page]).per(params[:per])
        render_collection @pages, serializer: PageSerializer
      end

      # GET /api/:namespace_id/pages/:id
      def show
        @page = @namespace.pages.find_by_slug!(params[:id])
        render_object @page, serializer: PageSerializer
      end

      private

      def find_namespace
        @namespace = Namespace.find_by_slug!(params[:namespace_id])
        authenticate! if @namespace.locked?
      end
    end
  end
end
