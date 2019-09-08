class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :book_marks, dependent: :destroy
  has_many :book_marked_posts, through: :book_marks, source: :post
  has_many :active_relationships, class_name: :Relationship,
                   foreign_key: :follower_id,
                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: :Relationship,
                   foreign_key: :followed_id,
                   dependent: :destroy
  has_many :followers, through: :passive_relationships

  before_save { self.email = email.downcase }

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  validates :intro, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, format: { with: /[A-Z]\w+/,
    message: 'the first letter must be upcase' }

  mount_uploader :image, ImageUploader
  include SessionsHelper

  def text_slice
    intro.length > 25 ? "#{intro.slice(0..24)}..." : intro
  end

  def following_count
    "#{following.count}following"
  end

  def followers_count
    "#{followers.count}followers"
  end
end
