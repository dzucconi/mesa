module Api
  module V1
    class NamespaceSerializer < BaseSerializer
      attributes :id, :name, :slug, :created_at, :updated_at, :_links

      def _links
        {
          self: { href: api_namespace_url(self.slug) },
          pages: {
            href: CGI.unescape(api_namespace_pages_url(self.slug, page: '{page}', per: '{per}')),
            templated: true
          },
          page: {
            href: CGI.unescape(api_namespace_page_url(self.slug, '{id}')),
            templated: true
          }
        }
      end
    end
  end
end
