require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:each) do
      @user = User.new
    end

    it "should create a user when there are no input errors" do
      @user.first_name = "Bill"
      @user.last_name = "Nye"
      @user.email = "thescience@guy.com"
      @user.password = "sciencerox"
      @user.password_confirmation = "sciencerox"
      @user.save!
    end

    it "should not create a user when the password does not meet the minimum" do
      @user.first_name = "Bill"
      @user.last_name = "Nye"
      @user.email = "thescience@guy.com"
      @user.password = "abc"
      @user.password_confirmation = "abc"
      
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "should not create a user when the password fields are blank" do
      @user.first_name = "Bill"
      @user.last_name = "Nye"
      @user.email = "thescience@guy.com"
      @user.password = nil
      @user.password_confirmation = nil
      
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    
    it "should not create a user when the password fields do not match" do
      @user.first_name = "Bill"
      @user.last_name = "Nye"
      @user.email = "thescience@guy.com"
      @user.password = "sciencerox"
      @user.password_confirmation = "scienceroxx"
      
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    
    it "should not create a user when the email is already registered" do
      @user1 = User.new
      @user1.first_name = "Bill"
      @user1.last_name = "Nye"
      @user1.email = "thescience@guy.com"
      @user1.password = "sciencerox"
      @user1.password_confirmation = "sciencerox"
      
      @user1.save

      @user.first_name = "Science"
      @user.last_name = "Guy"
      @user.email = "thescience@guy.com"
      @user.password = "sciencerox"
      @user.password_confirmation = "sciencerox"
      @user.save
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new
    end

    it "should pass if data is valid" do
      @user.first_name = "Bill"
      @user.last_name = "Nye"
      @user.email = "thescience@guy.com"
      @user.password = "sciencerox"
      @user.password_confirmation = "sciencerox"
      @user.save!
      @user = User.authenticate_with_credentials("thescience@guy.com", "sciencerox")
      expect(@user).not_to be(nil)
    end
    
    it "should fail if data is not valid" do
      @user.first_name = "Bill"
      @user.last_name = "Nye"
      @user.email = "thescience@guy.com"
      @user.password = "sciencerox"
      @user.password_confirmation = "sciencerox"
      @user.save!
      @user = User.authenticate_with_credentials("thescience@guy.com", "sciencesux")
      expect(@user).to be(nil)
    end
    
    it "should pass if email has extra spaces" do
      @user.first_name = "Bill"
      @user.last_name = "Nye"
      @user.email = "thescience@guy.com"
      @user.password = "sciencerox"
      @user.password_confirmation = "sciencerox"
      @user.save!
      @user = User.authenticate_with_credentials("  thescience@guy.com  ", "sciencerox")
      expect(@user).not_to be(nil)
    end
    
    it "should pass if email has different cases" do
      @user.first_name = "Bill"
      @user.last_name = "Nye"
      @user.email = "thescience@guy.com"
      @user.password = "sciencerox"
      @user.password_confirmation = "sciencerox"
      @user.save!
      @user = User.authenticate_with_credentials("tHEsCiEnCe@guy.com", "sciencerox")
      expect(@user).not_to be(nil)
    end
    
  end

end
