# frozen_string_literal: true

require 'rails_helper'

feature 'User answer', %q(
  In order to exchange my knowledge
  As an authenticated user
  I want to be able create answers
) do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }

  # scenario 'Authenticated user creates an answer for a question', js: true do
  #   sign_in(user)
  #   visit questions_path
  #
  #   click_on question.title
  #   fill_in 'Your answer', with: Faker::Lorem.sentence
  #   click_on 'Create'
  #
  #   expect(page).to have_current_path(question_path(question), ignore_query: true)
  #   expect(page).to have_content 'Your answer successfully created.'
  # end

  scenario 'Authenticated user creates an answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'

    expect(page).to have_current_path(question_path(question), ignore_query: true)
    within '.answers' do
      expect(page).to have_content 'My answer'
    end
  end
end
