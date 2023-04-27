require 'rails_helper'

RSpec.feature 'Login page', type: :feature do
  before :each do
    User.create(name: 'Testing', email: 'user@example.com', password: 'password', confirmed_at: Time.now)
    visit user_session_path
  end

  it 'Should have login button' do
    expect(page).to have_content 'Log in'
  end

  it 'user can see inputs and button' do
    expect(page).to have_current_path(user_session_path)
  end

  it 'click the login error' do
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'Should login successfully' do
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'Login successfully should rediret to home page' do
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_current_path authenticated_root_path
  end
end