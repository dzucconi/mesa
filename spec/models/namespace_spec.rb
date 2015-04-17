# == Schema Information
#
# Table name: namespaces
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Namespace, type: :model do
  let!(:namespace) { Fabricate(:namespace) }

  it 'has a valid fabricator' do
    expect(namespace).to be_valid
  end

  describe '#to_s' do
    it 'returns the name' do
      expect("#{namespace}").to eql 'default'
    end
  end
end
