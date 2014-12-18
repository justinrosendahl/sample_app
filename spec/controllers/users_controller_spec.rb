require 'spec_helper'

describe UsersController do
  render_views
  describe "GET 'new'" do
    describe 'New form field list' do
      it 'should have field "name"' do
        get :new
        response.should have_selector("input[name='user[name]'][type='text']")
      end
      it 'should have field "email"' do
        get :new
        response.should have_selector("input[name='user[email]'][type='text']")
      end
      it 'should have field "password"' do
        get :new
        response.should have_selector("input[name='user[password]'][type='password']")
      end
    end
    it 'returns http success' do
      get :new
      response.should be_success
    end
    it 'Should contain a title: Ruby on Rails Tutorial Sample App | Sign Up' do
      get :new
      response.should have_selector('title', :content => 'Sign Up')
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
        @attr = { :name => "", :email => "", :password => "", :password_confirmation => ""}
      end
      it 'should not create a user' do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it 'should have the right title' do
        post :create, :user => @attr
        response.should have_selector('title', :content => 'Sign Up')
      end

      it 'should render the "new" page' do
        post :create, :user => @attr
        response.should render_template(:new)
      end

    end
    describe 'success' do
      before(:each) do
        @attr = { :name => 'New User', :email => 'foo.bar@google.com',
                  :password => '1password', :password_confirmation => '1password'}
      end
      it 'should create a user' do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it 'should redirect to the user show page' do
         post :create, :user => @attr
        response.should redirect_to user_path(assigns(:user))
      end
      it 'should hanve a welcome message' do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end
    end

  end
end
