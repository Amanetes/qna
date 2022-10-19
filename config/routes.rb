# frozen_string_literal: true

Rails.application.routes.draw do
  root 'questions#index'

  devise_for :users

  resources :questions do
    resources :answers, only: %i[create destroy update]
  end
end
