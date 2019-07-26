# frozen_string_literal: true

module Api
  module V1
    class RootController < BaseController
      def index
        render json: {
          _links: {
            self: { href: api_root_url },
            namespaces: {
              href: api_namespaces_url
            },
            namespace: {
              href: CGI.unescape(api_namespace_url('{id}')),
              templated: true
            }
          }
        }
      end
    end
  end
end
