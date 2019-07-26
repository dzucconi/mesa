# frozen_string_literal: true

class User
  attr_reader :authenticated

  def initialize(options = {})
    options.reverse_merge!(authenticated: false)
    @authenticated = options[:authenticated]
  end

  def authenticated?
    @authenticated
  end

  def to_json(_options = {})
    { authenticated: authenticated? }.to_json
  end
end
