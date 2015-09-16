class User
  attr_reader :authenticated

  def initialize(options = {})
    options.reverse_merge!(authenticated: false)
    @authenticated = options[:authenticated]
  end

  def authenticated?
    @authenticated
  end
end
