FactoryBot.define do
  factory :post, class: Post do
    content 'a' * 140
    image nil
  end
end
