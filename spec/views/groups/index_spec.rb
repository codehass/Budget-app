require 'rails_helper'

RSpec.describe 'My Budget app', type: :feature do
  describe 'Home page' do
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
      @dress = Entity.create(id: 1, name: 'dress', amount: 50, user_id: @user.id)
      @purchase = Purchase.create(group_id: @clothing.id, entity_id: @dress.id)
      visit authenticated_root_path
    end

    it 'Should have the heading' do
      expect(page).to have_content 'Categories'
    end

    it 'Should have sign out button' do
      expect(page).to have_content 'Sign Out'
    end

    it 'Should have Add category button' do
      expect(page).to have_content 'Add a new category'
    end

    it 'Should list of categories names' do
      expect(page).to have_content(@food.name)
      expect(page).to have_content('Clothing')
    end

    it 'Should categories icons' do
      icons = page.has_selector?('img', count: 2)
      expect(icons).to be true
    end

    it 'Should categories amount of each category' do
      expect(page).to have_content(@dress.amount)
      expect(page).to have_content '$0'
    end

    it 'Should redirect to create category page' do
      click_link 'Add a new category'
      expect(page).to have_current_path(new_user_group_path(@user.id))
    end
  end
end