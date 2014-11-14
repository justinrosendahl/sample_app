# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
        :name => 'Example User',
        :email => 'User@example.com',
        :password => 'foobar',
        :password_confirmation => 'foobar'
    }
  end

  it 'should create a new instance given valid attributes' do
    User.create!(@attr)
  end


  it 'should require name' do
    no_name_user = User.new(@attr.merge(:name => ''))
    no_name_user.valid?.should_not == true
  end

  it 'should require email' do
    no_email_user = User.new(@attr.merge(:name => 'Another User', :email => ''))
    no_email_user.should_not be_valid
  end

  it 'should reject names that are too long' do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it 'should accept valid email addresses' do
    addresses =  %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user  = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it 'should reject invalid email adrresses' do
    addresses =  %w[user@foo,com THE_USER_at_foo.bar.org first.last@foo.]
    addresses.each do |address|
      valid_email_user  = User.new(@attr.merge(:email => address))
      valid_email_user.should_not be_valid
    end
  end

  it 'should reject douplicate email addresses' do
    # Put a user with given email address into the database.do

    addresses =  %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it 'should reject douplicate email addresses' do
    upcased_email = @attr[:email].upcase

    # Put a user with given email address into the database.do
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  describe 'password validations' do
    it 'should require a password' do
      User.new(@attr.merge(:password => '', :password_conformation=>'')).should_not be_valid
    end
    it 'should require a matching password confirmation' do
      User.new(@attr.merge(:password_confirmation => 'invalid')).should_not be_valid
    end
    it 'should reject short password' do
      short = 'a' * 5
      hash = @attr.merge(:password=>short, :password_confirmation =>short)
      User.new(hash).should_not be_valid
    end
    it 'should reject long password' do
      long = 'a' * 41
      hash = @attr.merge(:password=>long, :password_confirmation=>long)
      User.new(hash).should_not be_valid
    end
  end
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    it 'should have an encrypted password attribute' do
      @user.should respond_to(:encrypted_password)
    end
    it 'should set the encrypted password' do
      @user.encrypted_password.should_not be_blank
    end
  end
end
