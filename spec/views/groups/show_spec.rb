require 'rails_helper'

RSpec.describe 'My Budget app', type: :feature do
  describe 'Show page (list of transactions)' do
    before :each do
      @user =	User.create(id: 1, name: 'user', email: 'user@example.com', password: 'password', confirmed_at: Time.now)
      visit user_session_path
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      @clothing = Group.create(id: 2, name: 'Clothing', icon: 'https://cdn-icons-png.flaticon.com/512/5141/5141534.png',
                               user_id: @user.id)
      @dress = Entity.create(id: 1, name: 'dress', amount: 50, user_id: @user.id)
      @hat = Entity.create(id: 2, name: 'hat', amount: 7, user_id: @user.id)
      @purchase1 = Purchase.create(group_id: @clothing.id, entity_id: @dress.id)
      @purchase2 = Purchase.create(group_id: @clothing.id, entity_id: @hat.id)
      visit user_group_path(@user.id, @clothing.id)
    end

    it 'Should have link to go back' do
      expect(page).to have_content 'Back'
    end

    it 'Should redirect to home when click link Back' do
      click_link 'Back'
      expect(page).to have_current_path authenticated_root_path
    end

    it 'Should have the transactions name' do
      expect(page).to have_content @dress.name.capitalize
      expect(page).to have_content 'Hat'
    end

    it 'Should have the transactions list' do
      list_items = page.all('ul li')
      expect(list_items.length).to eq 2
    end

    it 'Should have the transactions amount' do
      list_items = page.all('ul li')
      expect(list_items[0]).to have_content @hat.amount
    end

    it 'Should have the transactions total amount' do
      expect(page).to have_content '$57'
    end

    it 'Should have the category name' do
      expect(page).to have_content @clothing.name.capitalize
    end
  end
end