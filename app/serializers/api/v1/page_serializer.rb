# frozen_string_literal: true
module Api
  module V1
    class PageSerializer < BaseSerializer
      attributes :id,
        :slug,
        :mode,
        :title,
        :delta,
        :content,
        :html,
        :markdown,
        :urls,
        :created_at,
        :updated_at,
        :_links

      def html
        case object.mode
        when 'plain'
          object.content
        else
          object.html
        end
      end

      def markdown
        object.to_markdown
      end

      def urls
        object.to_urls
      end

      def _links
        {
          self: {
            href: api_namespace_page_url(object.namespace, self.slug)
          },
          namespace: {
            href: api_namespace_url(object.namespace)
          }
        }
      end
    end
  end
end
