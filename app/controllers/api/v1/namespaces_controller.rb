module Api
  module V1
    class NamespacesController < BaseController
      # GET /api/namespaces
      def index
        @namespaces = Namespace.page(params[:page]).per(params[:per])
        render_collection @namespaces, serializer: NamespaceSerializer
      end

      # GET /api/namespaces/:id
      def show
        @namespace = Namespace.find_by_slug!(params[:id])
        render_object @namespace, serializer: NamespaceSerializer
      end
    end
  end
end
