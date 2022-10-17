# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { Faker::Computer.platform }
    body { Faker::Lorem.question }
    association :user, factory: :user
  end

  factory :invalid_question, class: 'Question' do
    title { nil }
    body { nil }
  end
end
