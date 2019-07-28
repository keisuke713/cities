class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader

  def text_slice
    content.length > 50 ? "#{content.slice(0..19)}..." : content
  end
end
