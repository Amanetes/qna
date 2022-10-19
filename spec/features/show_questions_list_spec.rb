# frozen_string_literal: true

require_relative 'feature_helper'

feature 'Show questions list', %q(
  In order to add an answer
  As an user
  I want to be able view questions list
) do

  given!(:user) { create(:user) }
  given!(:questions) { create_list(:question, 2) }

  scenario 'Authenticated user can view questions list' do
    sign_in(user)
    visit questions_path
    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end

  scenario 'Non-authenticated user can view questions list' do
    visit questions_path
    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end
end
