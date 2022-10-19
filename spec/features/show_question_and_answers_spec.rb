# frozen_string_literal: true

require_relative 'feature_helper'

feature 'Show question and answers', %q(
  In order to view question and its answers
  As an user
  I want to be able view question and its answers
) do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 3, question: question) }

  scenario 'Authenticated user can view question and answers' do
    sign_in(user)
    visit questions_path
    click_on question.title

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end

  scenario 'Non-authenticated user can view question and answers' do
    visit questions_path
    click_on question.title

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end
