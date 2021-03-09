require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    User.create({
      first_name: "Bob",
      last_name: "Lang",
      email: "lan@TEST.com",
      password: "bbasdfadsf",
      password_confirmation: "bbasdfadsf"
    })
  end
  
  describe "Validations: " do
    # go back to the prev exercise and see how password validation worked 
    it "saves when all five fields are valid" do
      @user = User.create({
        first_name: "Alice",
        last_name: "Gregory",
        email: "alice@test.com",
        password: "hellothere",
        password_confirmation: "hellothere"
      })
      expect(@user.id).to be_present
    end

    it "doesn't save when first name is missing" do
      @user = User.create({
        last_name: "Bon",
        email: "bon@bon.com",
        password: "bonafide",
        password_confirmation: "bonafide"
      })
      expect(@user.id).to be_nil
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "doesn't save when last name is missing" do
      @user = User.create({
        first_name: "Bryce",
        email: "bryce@gmail.com",
        password: "bonafide",
        password_confirmation: "bonafide"
      })
      expect(@user.id).to be_nil
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "doesn't save when password confirmation is missing" do
      @user = User.create({
        first_name: "Bryce",
        last_name: "Collin",
        email: "bryce@gmail.com",
        password: "hellothere"
      })
      expect(@user.id).to be_nil
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "doesn't save when password confirmation is incorrect" do
      @user = User.create({
        first_name: "Bryce",
        last_name: "Collin",
        email: "bryce@gmail.com",
        password: "hellothere",
        password_confirmation: "boldEggs"
      })
      expect(@user.id).to be_nil
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "doesn't save when the same email already exists (case insensitive)" do
      @user = User.create({
        first_name: "Pop",
        last_name: "Bop",
        email: "LAN@test.com",
        password: "bastony!",
        password_confirmation: "bastony!"
      })
      expect(@user.id).to be_nil
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end

    it "doesn't save when the password is fewer than 8 characters" do
      @user = User.create({
        first_name: "Michael",
        last_name: "Wang",
        email: "hell@asd.com",
        password: "bee",
        password_confirmation: "bee"
      })
      expect(@user.id).to be_nil
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it "returns an instance of the user if the user exists" do
      @user = User.authenticate_with_credentials("lan@TEST.com", "bbasdfadsf")
      expect(@user.id).to be_present
    end

    it "returns nil if the user does not exist" do
      @user = User.authenticate_with_credentials("lan@Test.com", "astennis")
      expect(@user).to be_nil
    end

    it "returns an instance of the user if the email has spaces" do
      @user = User.authenticate_with_credentials("  lan@TEST.com", "bbasdfadsf")
      expect(@user.id).to be_present
    end

    it "returns an instance of the user if the email has the wrong cases" do
      @user = User.authenticate_with_credentials("LAN@test.com", "bbasdfadsf")
      expect(@user.id).to be_present
    end
  end
end