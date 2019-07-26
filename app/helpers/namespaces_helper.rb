# frozen_string_literal: true

module NamespacesHelper
  def toggled_status(status)
    !status.present? || status == 'active' ? 'archived' : 'active'
  end
end
