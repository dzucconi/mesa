module Api
  module V1
    class NamespaceSerializer < BaseSerializer
      attributes :id, :name, :slug, :created_at, :updated_at, :_links

      def _links
        {
          self: { href: api_namespace_url(self.slug) },
          pages: { href: api_namespace_pages_url(self.slug) }
        }
      end
    end
  end
end
