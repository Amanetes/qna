# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:questions) { create_list(:question, 2) }
  let(:question) { create(:question, title: 'Lorem', body: 'Ipsum') }
  let!(:user) { create(:user) }

  describe 'GET #index' do
    before { get(:index) }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template(:index)
    end

    it 'returns correct response status' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    before { get(:show, params: { id: question.id }) }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'renders show view' do
      expect(response).to render_template(:show)
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
  end

  describe 'GET #new' do
    before do
      sign_in(user)
      get(:new)
    end

    it 'assigns a new Question to @question' do
      # То значение, которое находится в переменной question
      # Это экземпляр класса Question
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      sign_in(user)
      get(:edit, params: { id: question.id })
    end

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'renders edit view' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    before { sign_in(user) }

    context 'with valid attributes' do
      let(:action) { post(:create, params: { question: attributes_for(:question) }) }

      it 'saves the new question in database' do
        expect { action }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        action
        expect(response).to redirect_to(question_path(assigns(:question)))
      end
    end

    context 'with invalid attributes' do
      let(:action) { post(:create, params: { question: attributes_for(:invalid_question) }) }

      it 'does not save the question' do
        expect { action }.not_to change(Question, :count)
      end

      it 're-renders new view' do
        action
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    before { sign_in(user) }

    context 'with valid attributes' do
      it 'assigns the requested question to @question' do
        post(:update, params: { id: question.id, question: attributes_for(:question) })
        expect(assigns(:question)).to eq(question)
      end

      it 'changes the question attributes' do
        post(:update, params: { id: question.id, question: { title: 'new title', body: 'new body' } })
        question.reload
        expect(question.title).to eq('new title')
        expect(question.body).to eq('new body')
      end

      it 'redirects to the updated question' do
        post(:update, params: { id: question.id, question: attributes_for(:question) })
        expect(response).to redirect_to(question)
      end
    end

    context 'with invalid attributes' do
      before { post(:update, params: { id: question.id, question: { title: 'new title', body: nil } }) }

      it 'does not change question attributes' do
        expect(question.title).to eq('Lorem')
        expect(question.body).to eq('Ipsum')
      end

      it 're-renders edit view' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, user: user) } # Создаем объект, чтобы он существовал в базе

    before { sign_in(user) }

    it 'deletes question' do
      expect { delete(:destroy, params: { id: question.id }) }.to change(user.questions, :count).by(-1)
    end

    it 'redirects to index view' do
      delete(:destroy, params: { id: question.id })
      expect(response).to redirect_to(questions_path)
    end
  end
end
