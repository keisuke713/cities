FactoryBot.define do
  factory :admin_user, class: User do
    name 'Alice'
    email 'test@gmail.com'
    intro 'rubyなう'
    password 'Testtesttest'
    admin true
    initialize_with { User.find_or_create_by(email: email)}
  end

  factory :user, class: User do
    name 'Bob'
    email 'test1@gmail.com'
    intro 'rubyなう'
    password 'Testtesttest'
    initialize_with { User.find_or_create_by(email: email)}
  end

  factory :other_user, class: User do
    name 'Carol'
    email 'test2@gmail.com'
    intro 'rubyなう'
    password 'Testtesttest'
    initialize_with { User.find_or_create_by(email: email)}
  end
end
