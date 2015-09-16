module Api
  module V1
    class NamespacesController < BaseController
      before_filter :find_namespace, only: [:show]

      # GET /api/namespaces
      def index
        @namespaces = Namespace.page(params[:page]).per(params[:per])
        render_collection @namespaces, serializer: NamespaceSerializer
      end

      # GET /api/namespaces/:id
      def show
        render_object @namespace, serializer: NamespaceSerializer
      end

      private

      def find_namespace
        @namespace = Namespace.find_by_slug!(params[:id])
        authenticate! if @namespace.locked?
      end
    end
  end
end
