FactoryBot.define do
  factory :post, class: Post do
    content 'a' * 140
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/tokyo.jpg'), 'image/jpg') }
    association :user, factory: :user
  end
end
