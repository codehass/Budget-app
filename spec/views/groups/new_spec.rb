require 'rails_helper'

RSpec.describe 'My Budget app', type: :feature do
  describe 'Create a new category page' do
    before :each do
      @user =	User.create(id: 1, name: 'user', email: 'user@example.com', password: 'password', confirmed_at: Time.now)
      visit user_session_path
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      visit new_user_group_path(@user.id)
    end

    it 'Should have link to go back' do
      expect(page).to have_content 'Back'
    end

    it 'Should redirect to home when click link Back' do
      click_link 'Back'
      expect(page).to have_current_path authenticated_root_path
    end

    it 'Should have heading' do
      expect(page).to have_content 'Add a new category'
    end

    it 'Should have fields' do
      fields = page.has_selector?('input', count: 3)
      expect(fields).to be true
    end

    it 'Should redirect to home after filling field' do
      fill_in 'Category Name', with: 'hobbies'
      fill_in 'Icon URL', with: 'https://cdn-icons-png.flaticon.com/512/5141/5141534.png'
      click_button 'Save'
      expect(page).to have_content 'Category created successfully'
      expect(page).to have_current_path authenticated_root_path
    end
  end
end
