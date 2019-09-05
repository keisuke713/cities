class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :book_marks, dependent: :destroy
  has_many :book_marked_users, through: :book_marks, source: :user
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader

  def text_slice
    content.length > 50 ? "#{content.slice(0..19)}..." : content
  end
end
