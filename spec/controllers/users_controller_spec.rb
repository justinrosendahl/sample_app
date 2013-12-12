require 'spec_helper'

describe UsersController do
  render_views
  describe "GET 'new'" do
    it 'returns http success' do
      get 'new'
      response.should be_success
    end
    it 'Should contain a title: Ruby on Rails Tutorial Sample App | Sign Up' do
      get 'new'
      response.should have_selector('title', :content => 'Ruby on Rails Tutorial Sample App | Sign Up')
    end
  end

end
