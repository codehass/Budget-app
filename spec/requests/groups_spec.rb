require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create(name: 'hassan', email: 'hassan@mail.com', password: 'password', confirmed_at: Time.now) }
  let(:category) do
    Group.create(id: 1, name: 'Food', icon: 'https://cdn-icons-png.flaticon.com/512/5141/5141534.png',
                 user_id: user.id)
  end

  describe 'Test Get categories#index' do
    before(:each) do
      sign_in user
      get '/'
    end
    it 'Test If the correct template was rendered' do
      expect(response).to render_template(:index)
    end
    it 'Test If response status was correct' do
      expect(response).to have_http_status(:ok)
    end
    it 'Test If the response body includes correct placeholder text' do
      expect(response.body).to include('Categories')
    end
  end

  describe 'Test Get categories#show' do
    before(:each) do
      sign_in user
      get "/users/#{user.id}/groups/#{category.id}"
    end
    it 'Test If the correct template was rendered' do
      expect(response).to render_template(:show)
    end
    it 'Test If response status was correct' do
      expect(response).to have_http_status(:ok)
    end
    it 'Test If the response body includes correct placeholder text' do
      expect(response.body).to include(category.name)
    end
  end
end