# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { Faker::Lorem.sentence }
    association :question, factory: :question
    association :user, factory: :user
  end

  factory :invalid_answer, class: 'Answer' do
    body { nil }
  end
end
