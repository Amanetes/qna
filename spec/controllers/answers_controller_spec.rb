# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) { create(:question) }
  let(:answer) { create(:answer) }
  let!(:user) { create(:user) }

  before { sign_in(user) }

  describe 'POST #create' do
    context 'with valid params' do
      let(:action) { post :create, params: { question_id: question.id, answer: attributes_for(:answer) }, format: :js }

      it 'saves the new answer in database' do
        expect { action }.to change(question.answers, :count).by(1)
      end

      it 'render create template' do
        action
        expect(response).to render_template :create
      end
    end

    context 'with invalid params' do
      let(:action) { post :create, params: { question_id: question.id, answer: attributes_for(:invalid_answer) }, format: :js }

      it 'does not save answer in database' do
        expect { action }.not_to change(Answer, :count)
      end

      it 're-renders question show view' do
        action
        expect(response).to render_template(:create)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested answer to @answer' do
        patch(:update, params: { id: answer.id, question_id: question.id, answer: attributes_for(:answer) }, format: :js)
        expect(assigns(:answer)).to eq(answer)
      end

      it 'assigns the question' do
        patch(:update, params: { id: answer.id, question_id: question.id, answer: attributes_for(:answer) }, format: :js)
        expect(assigns(:question)).to eq(question)
      end

      it 'changes the answer attributes' do
        patch(:update, params: { id: answer.id, question_id: question.id, answer: { body: 'new body' } }, format: :js)
        answer.reload
        expect(answer.body).to eq('new body')
      end

      it 'renders update template' do
        patch(:update, params: { question_id: question.id, id: answer.id, answer: attributes_for(:answer) }, format: :js)

        expect(response).to render_template(:update)
      end

    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, user: user) }
    let!(:answer) { create(:answer, question: question, user: user) }

    before { sign_in(user) }

    it 'deletes answer' do
      expect { delete(:destroy, params: { question_id: question.id, id: answer.id }) }.to change(question.answers, :count).by(-1)
    end

    it 'redirects to show view' do
      delete(:destroy, params: { question_id: question.id, id: answer.id })
      expect(response).to redirect_to(question_path(question))
    end
  end
end
