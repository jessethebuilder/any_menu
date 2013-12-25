require 'spec_helper'

describe User do
  let(:user){ create :user }
  let(:owner){ create :owner }

  describe 'validations' do
    it{ should validate_presence_of :email }
    it{ should validate_uniqueness_of :email }
    it{ should validate_presence_of :password }
    it{ should validate_presence_of :user_type }
    it{ should ensure_inclusion_of(:user_type).in_array(USER_TYPES) }
  end

  describe 'Associations' do
    it{ should have_many :orders }
  end
end
