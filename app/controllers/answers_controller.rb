# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_question, only: %i[create]

  def create
    @answer = @question.answers.build(answer_params)

    if @answer.save
      redirect_to @question
    else
      render 'questions/show', status: :unprocessable_entity
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end