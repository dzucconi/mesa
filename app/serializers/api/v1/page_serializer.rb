module Api
  module V1
    class PageSerializer < BaseSerializer
      attributes :id, :slug, :title, :content, :html, :created_at, :updated_at, :_links

      def html
        object.to_html
      end

      def _links
        {
          self: { href: api_namespace_page_url(object.namespace, self.slug) },
          namespace: { href: api_namespace_url(object.namespace) }
        }
      end
    end
  end
end
