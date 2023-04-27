require 'rails_helper'

RSpec.describe 'My Budget app', type: :feature do
  describe 'Create a new transaction page' do
    before :each do
      @user =	User.create(id: 1, name: 'user', email: 'user@example.com', password: 'password', confirmed_at: Time.now)
      visit user_session_path
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      @food = Group.create(id: 1, name: 'Food', icon: 'https://cdn-icons-png.flaticon.com/512/5141/5141534.png',
                           user_id: @user.id)
      @clothing = Group.create(id: 2, name: 'Clothing', icon: 'https://cdn-icons-png.flaticon.com/512/5141/5141534.png',
                               user_id: @user.id)
      visit new_entity_path
    end

    it 'Should have link to go back' do
      expect(page).to have_content 'Back'
    end

    it 'Should redirect to home when click link Back' do
      click_link 'Back'
      expect(page).to have_current_path authenticated_root_path
    end

    it 'Should have heading' do
      expect(page).to have_content 'Add a new transaction'
    end

    it 'Should have fields' do
      fields = page.has_selector?('input', count: 3)
      expect(fields).to be true
    end

    it 'Should have select box' do
      fields = page.has_selector?('select', count: 1)
      expect(fields).to be true
    end

    it 'Select box should have options' do
      fields = page.has_selector?('option', count: 2)
      expect(fields).to be true
    end

    it 'Should redirect to selected category after filling field' do
      fill_in 'Transaction Name', with: 'shirt'
      fill_in 'Amount', with: '12'
      select('Clothing')
      click_button 'Save'
      expect(page).to have_content 'Transaction created successfully'
      expect(page).to have_current_path user_group_path(@user.id, @clothing.id)
    end
  end
end