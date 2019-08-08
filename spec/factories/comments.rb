FactoryBot.define do
  factory :comment, class: Comment do
    content 'a' * 140
    user
    post 
  end
end
