require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'password encryption' do
    it 'encrypts the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: 'User', password: 'password')
    end

    it 'does not save the password to the database' do
      User.create!(username: 'User', password: 'password')
      user = User.find_by(username: 'User')
      expect(user.password).not_to be('password')
    end

    describe 'session_token' do
      it 'assigns a session token if it doesn\'t already exist' do
        user = User.create(username: 'User', password: 'password')
        expect(user.session_token).not_to be_nil
      end 
    end


  end


  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest)}
  # it { should validate_presence_of(:session_token)}
  it { should validate_length_of(:password).is_at_least(6)}
  it "allows nil value for password" do
    should allow_value(nil).for(:password)
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
