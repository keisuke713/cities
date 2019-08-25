FactoryBot.define do
  factory :comment, class: Comment do
    content 'a' * 140
    user
    post
    initialize_with { Comment.find_or_create_by(content: content) }
  end
end
