require 'rails_helper'

RSpec.feature 'Signup', type: :feature do
  it 'Should not sign up with empty fields' do
    visit new_user_registration_path
    click_button 'Sign up'
    expect(page).to have_content "Email can't be blank"
  end

  it 'Should not sign up with empty name field' do
    User.create(name: 'Hello', email: 'hello@example.com', password: 'password', confirmed_at: Time.now)
    visit new_user_registration_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content "Name can't be blank"
  end

  it 'click the login error' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Hello'
    fill_in 'Email', with: 'ali@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end