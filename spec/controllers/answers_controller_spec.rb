# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  describe 'POST #create' do
    context 'with valid params' do
      let(:action) { post :create, params: { question_id: question.id, answer: attributes_for(:answer) } }

      it 'saves the new answer in database' do
        expect { action }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question show view' do
        action
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid params' do
      let(:action) { post :create, params: { question_id: question.id, answer: attributes_for(:invalid_answer) } }

      it 'does not save answer in database' do
        expect { action }.not_to change(question.answers, :count)
      end

      it 're-renders question show view' do
        action
        expect(response).to render_template(:show)
      end
    end
  end
end
