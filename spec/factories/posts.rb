FactoryBot.define do
  factory :post, class: Post do
    content 'a' * 140
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/tokyo.jpg'), 'image/jpg') }
    user
    draft_status 0
    initialize_with { Post.find_or_create_by(content: content, user: user)}
  end

  factory :child_post, class: Post do
    content :child_post
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/tokyo.jpg'), 'image/jpg') }
    user
    draft_status 0
    association :parent_post, factory: :post
  end

  factory :post_by_Cob, class: Post do
    content 'a' * 140
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/tokyo.jpg'), 'image/jpg') }
    association :user, factory: :user2
    draft_status 0
  end

  factory :child_post_by_Cob, class: Post do
    content :child_post
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/tokyo.jpg'), 'image/jpg') }
    association :user, factory: :user2
    association :parent_post, factory: :post
    draft_status 0
  end

  factory :draft, class: Post do
    content 'a' * 140
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/tokyo.jpg'), 'image/jpg') }
    user
    draft_status 1
  end
end
