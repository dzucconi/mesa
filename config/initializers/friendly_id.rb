# frozen_string_literal: true

FriendlyId.defaults do |config|
  config.use :reserved
  config.reserved_words = %w[new edit session login logout users admin stylesheets assets javascripts images random source]
  config.use :finders
  config.use :slugged
end
