FactoryBot.define do
  factory :reply do
    content 'a' * 140
    user
    comment
  end
end
