FactoryBot.define do
  factory :comment, class: Comment do
    content 'a' * 140
    user nil
    post nil
  end
end
