# frozen_string_literal: true
Fabricator(:namespace) do
  name 'Default'
  slug { |attrs| attrs[:name].parameterize }
end
