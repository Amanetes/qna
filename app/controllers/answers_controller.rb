# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  before_action :set_question, only: %i[create destroy]
  before_action :set_answer, only: %i[destroy]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
    else
      flash[:alert] = 'Cannot create an answer'
    end
  end

  def destroy
    redirect_to question_url(@question) unless current_user
    if @answer.destroy
      redirect_to question_url(@question), notice: 'Your answer successfully deleted'
    else
      render 'questions/show', status: :unprocessable_entity
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
