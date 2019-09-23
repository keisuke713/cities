FactoryBot.define do
  factory :post, class: Post do
    content 'a' * 140
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/tokyo.jpg'), 'image/jpg') }
    user
    initialize_with { Post.find_or_create_by(content: content) }
  end

  factory :child_post, class: Post do
    content :child_post
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/tokyo.jpg'), 'image/jpg') }
    user
    association :parent_post, factory: :post
    initialize_with { Post.find_or_create_by(content: content) }
  end
end
