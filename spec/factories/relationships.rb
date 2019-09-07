FactoryBot.define do
  factory :relationship do
    association :follower, factory: :admin_user
    association :followed, factory: :user
  end
end
