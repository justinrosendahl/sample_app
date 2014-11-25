require 'spec_helper'

describe UsersController do
  render_views
  describe "GET 'new'" do
    it 'returns http success' do
      get :new
      response.should be_success
    end
    it 'Should contain a title: Ruby on Rails Tutorial Sample App | Sign Up' do
      get :new
      response.should have_selector('title', :content => 'Ruby on Rails Tutorial Sample App | Sign Up')
    end
  end
  describe "get 'show'" do
    before(:each) do
      @user = create(:user)
    end
    it 'should be successful' do
      get :show, :id => @user
      response.should be_success
    end
    it 'should find the right user' do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    it 'should have the right title' do
      get :show, :id => @user
      response.should have_selector('title', :content => @user.name)
    end
    it "it should include the user's name" do
      get :show, :id => @user
      response.should have_selector('h1', :content => @user.name)
    end
    it 'should have a profile image' do
      get :show, :id => @user
      response.should have_selector('h1>img', :class => 'gravatar')
    end
  end
  describe "post 'create'" do
    describe 'failure' do
      before(:each) do
        @attr = { :name => "", :email => "", :password => "", :password_confermation => ""}
      end
      it 'should not create a user' do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it 'should have the right title' do
        post :create, :user => @attr
        response.should have_selector('title', content => 'Sign up')
      end

      it 'should render the "new" page' do
        post :create, :user => @attr
        response.should render_template(:new)
      end

    end
  end
end
