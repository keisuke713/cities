FactoryBot.define do
  factory :admin_user, class: User do
    name 'Alice'
    email 'test@gmail.com'
    intro 'rubyなう'
    password 'Testtesttest'
    admin true
  end

  factory :user, class: User do
    name 'Bob'
    email 'test1@gmail.com'
    intro 'rubyなう'
    password 'Testtesttest'
  end
end
