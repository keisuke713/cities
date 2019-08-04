FactoryBot.define do
  factory :post, class: Post do
    content 'a' * 140
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/tokyo.jpg'))
  end
end
