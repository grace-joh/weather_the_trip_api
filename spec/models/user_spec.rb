require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user creation' do
    describe 'email validations' do
      it { should validate_presence_of :email }
      it { should validate_uniqueness_of :email }
    end

    before(:each) do
      @user = User.create!(email: 'example@email.com', password: 'password', password_confirmation: 'password')
    end

    describe 'secure password' do
      it { should have_secure_password }
      it 'does not save passwords to the database' do
        expect(@user.password_digest).not_to be_nil
        expect(@user.password_digest).not_to eq('password')
      end
    end

    describe 'api key' do
      it { should have_secure_token :api_key }
      it 'assigns a unique api key to each user' do
        expect(@user.api_key).to be_a(String)
        expect(@user.api_key.length).to eq(32)
      end
    end
  end
end
