# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_question, only: %i[show edit update destroy]
  def index
    @questions = Question.all
  end

  def show
    @answers = @question.answers
    @answer = @question.answers.build
  end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    redirect_to questions_path unless current_user
    if @question.destroy
      redirect_to questions_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
