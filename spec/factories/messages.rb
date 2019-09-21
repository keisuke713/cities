FactoryBot.define do
  factory :message do
    content "a" * 140
    association :sender, factory: :admin_user
    association :receiver, factory: :user
  end

  factory :receive_message, class: Message do
    content "a" * 140
    association :sender, factory: :user
    association :receiver, factory: :admin_user
  end
end
