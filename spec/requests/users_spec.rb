require 'spec_helper'

describe "Users" do
  before(:each) do
    @attr = {:name => "JJ", :email => "jj@gmail.com", :password => "password", :password_confirmation => "password"}
  end
  describe "GET /users" do
    it "works! (now write some real specs)" do
      User.create!(@attr)
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get user_path 1
      response.status.should be(200)
    end
  end
  describe 'Sign Up' do
    describe 'failure' do
      it 'should not make a new user' do
        lambda do

          visit signup_path
          fill_in 'Name', :with => ''
          fill_in 'Email', :with => ''
          fill_in 'Password', :with => ''
          fill_in 'Password Confirmation', :with => ''
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end

    describe 'Success' do
      it 'should make a new user' do
        lambda do
          visit signup_path
          fill_in 'Name', :with => 'James Kirk'
          fill_in 'Email', :with => 'thecaptain@starfleet.com'
          fill_in 'Password', :with => 'captain'
          fill_in 'Password Confirmation', :with => 'captain'
          click_button
          response.should have_selector('div.flash.success', :content => 'Welcome')
          response.should render_template('users/show')
        end.should change(User, :count).by 1
      end
    end
  end

  describe 'signin/signout' do
    describe 'failure' do
      it 'should not sign a user in' do
        visit signin_path
        fill_in :email, :with => ''
        fill_in :password, :with => ''
        click_button
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end
    describe 'success' do
      it 'should sign user in and out' do
        user = create(:user)

        visit signin_path
        fill_in :email, :with => user.email
        fill_in :password, :with => user.password
        click_button
        controller.should be_signed_in
        click_link 'Sign out'
        controller.should_not be_signed_in
      end
    end
  end

end
