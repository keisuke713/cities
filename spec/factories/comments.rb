FactoryBot.define do
  factory :comment do
    content 'a' * 140
    user nil
    post nil
  end
end
