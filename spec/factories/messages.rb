FactoryBot.define do
  factory :message do
    content "a" * 140
    association :sender, factory: :admin_user
    association :receiver, factory: :user
  end
end
