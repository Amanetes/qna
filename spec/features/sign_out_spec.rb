# frozen_string_literal: true

require_relative 'feature_helper'

feature 'User sign out', %q(
  In order to be able to sign out
  As an authenticated user
  I want to be able to sign out
) do

  given(:user) { create(:user) }

  scenario 'Authenticated user tries to sign out' do
    sign_in(user)
    visit destroy_user_session_path

    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_current_path root_path, ignore_query: true
  end
end
