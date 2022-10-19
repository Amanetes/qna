# frozen_string_literal: true

require_relative 'feature_helper'

feature 'Answer editing', %q(
  In order to fix mistake
  As an author of answer
  I want to be able to edit my answer
) do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'Non-authenticated user tries to edit question' do
    visit question_path(question)

    expect(page).not_to have_link 'Edit'
  end

  describe 'Authenticated user' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'sees link to Edit' do
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    # scenario 'Tries to edit his answer', js: true do
    #   click_on 'Edit'
    #   within '.answers' do
    #     fill_in 'Answer', with: 'Edited answer'
    #     click_on 'Save'
    #
    #     expect(page).not_to have_content answer.body
    #     expect(page).to have_content 'Edited answer'
    #     expect(page).not_to have_selector 'textarea'
    #   end
    # end
  end
end
