# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { 'MyText' }
    association question, factory: :question
  end
end
