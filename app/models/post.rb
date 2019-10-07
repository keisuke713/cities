class Post < ApplicationRecord
  belongs_to :user
  has_many :child_post, class_name: :Post, foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent_post, class_name: :Post, foreign_key: :parent_id, optional: true
  has_many :comments, dependent: :destroy
  has_many :book_marks, dependent: :destroy
  has_many :book_marked_users, through: :book_marks, source: :user

  default_scope -> { order(created_at: :desc) }
  scope :match_by_user, ->(user_ids){ where(user_id: user_ids)}
  scope :match_by_content, ->(keyword){ where("content like ?", keyword)}
  scope :fetch_expect_draft, ->{ where(status: 0)}
  scope :fetch_only_draft, ->(user_id){ where(user_id: user_id, status: 1)}

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader

  def self.find_posts(following_ids)
    where(user_id: following_ids).includes(:user)
  end

  def text_slice
    content.length > 50 ? "#{content.slice(0..19)}..." : content
  end

  def parent?
    parent_id.nil?
  end
end
