FactoryBot.define do
  factory :admin_user, class: User do
    name 'Keisuke'
    email 'nebakei.tkb713@gmail.com'
    intro 'rubyなう'
    password 'Baseball713'
    admin true
  end

  factory :user, class: User do
    name 'Keisuke'
    email 'nebakei.tkb0713@gmail.com'
    intro 'rubyなう'
    password 'Baseball713'
  end
end
