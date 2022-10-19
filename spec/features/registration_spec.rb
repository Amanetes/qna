# frozen_string_literal: true

require_relative 'feature_helper'

feature 'User registration', %q(
  In order to be able ask questions
  As an user
  I want to be able to register
) do

  given!(:existing_user) { create(:user) }

  scenario 'Non-registered user tries to register' do
    visit new_user_registration_path
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: 'foobar'
    fill_in 'Password confirmation', with: 'foobar'
    click_on 'Sign up'

    expect(page).to have_content 'You have signed up successfully.'
    expect(page).to have_current_path root_path, ignore_query: true
  end

  scenario 'Registered user tries to register' do
    visit new_user_registration_path
    fill_in 'Email', with: existing_user.email
    fill_in 'Password', with: existing_user.password
    fill_in 'Password confirmation', with: existing_user.password
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
    expect(page).to have_current_path user_registration_path, ignore_query: true
  end
end
