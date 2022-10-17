# frozen_string_literal: true

require 'rails_helper'

feature 'Create answer', %q(
  In order to be able to add an answer
  As an authenticated user
  I want to be able leave an answer
) do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user creates an answer for a question' do
    sign_in(user)
    visit questions_path
    click_on question.title
    fill_in 'Body', with: Faker::Lorem.sentence
    click_on 'Create'

    expect(page).to have_content 'Your answer successfully created.'
  end
end
