require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password }
    it { should validate_presence_of(:password_confirmation)}
  end

  describe 'user create' do
    it 'creates a user with password' do
      user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123',
                         password_confirmation: 'password123')
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
  end
end
