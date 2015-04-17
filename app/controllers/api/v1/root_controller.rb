module Api
  module V1
    class RootController < BaseController
      def index
        render json: {
          _links: {
            self: { href: api_root_url },
            namespaces: {
              href: api_namespaces_url
            }
          }
        }
      end
    end
  end
end
