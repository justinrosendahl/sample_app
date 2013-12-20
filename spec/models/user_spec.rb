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
    @attr = { :name => "Example User", :email => "User@example.com" }
  end

  it "should create a new instance given valid attributes" do
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
end
