class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  mount_uploader :image, ImageUploader
end
