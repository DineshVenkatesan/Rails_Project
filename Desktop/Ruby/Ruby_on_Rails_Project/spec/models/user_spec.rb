require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'New user registration' do
    before do
      @user = FactoryBot.build(:user)
    end

    context 'with valid inputs' do
      it 'with valid email, password and password_confirmation shold able to register' do
        expect(@user).to be_valid
      end

      it 'cannot register with existing email' do
        @user.save
        new_user = FactoryBot.build(:user, email: @user.email)
        expect(new_user).not_to be_valid
      end

      it 'can register if password and password_confirmation are same and both are 6 characters or more' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        expect(@user).to be_valid
      end
    end

    context 'with invalid inputs' do
      it 'should not able to register without email' do
        @user.email = nil
        expect(@user).not_to be_valid 
      end

      it 'should not able to register without password' do
        @user.password = nil
        expect(@user).not_to be_valid 
      end

      it 'should not able to register without password_confirmation' do
        @user.password_confirmation = ''
        expect(@user).not_to be_valid
      end

      it 'cannot register if password is less then 5 charectors' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        expect(@user).not_to be_valid
      end

      it 'cannot register with miss match password' do
        @user.password = '123456'
        @user.password_confirmation = '123457'
        expect(@user).not_to be_valid
      end
    end
  end
end
