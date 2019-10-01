class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :book_marks, dependent: :destroy
  has_many :book_marked_posts, through: :book_marks, source: :post
  has_many :active_relationships, class_name: :Relationship,
                   foreign_key: :follower_id,
                   dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: :Relationship,
                   foreign_key: :followed_id,
                   dependent: :destroy
  has_many :followers, through: :passive_relationships
  has_many :send_messages, class_name: :Message,
                foreign_key: :sender_id,
                dependent: :destroy
  has_many :received_message_users, through: :send_messages, source: :receiver
  has_many :receive_messages, class_name: :Message,
                foreign_key: :receiver_id,
                dependent: :destroy
  has_many :sent_message_users, through: :receive_messages, source: :sender

  before_save { self.email = email.downcase }

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  validates :intro, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, format: { with: /[A-Z]\w+/,
    message: 'the first letter must be upcase' }

  scope :in_ids, -> (_ids){ where(id: _ids) }
  scope :match_by_name, ->(name){ where("name like ?", name)}
  scope :exclude_name, ->(name){ where.not("name like ?", name)}

  mount_uploader :image, ImageUploader
  include SessionsHelper

  def text_slice
    intro.length > 25 ? "#{intro.slice(0..24)}..." : intro
  end

  def following_count
    "#{followings.count}following"
  end

  def followers_count
    "#{followers.count}followers"
  end

  def communicated_users
    self.class.in_ids(communicated_user_ids)
  end

  private

  def communicated_user_ids
    (received_message_user_ids + sent_message_user_ids).uniq
  end

  def received_message_user_ids
    received_message_users.pluck(:id)
  end

  def sent_message_user_ids
    sent_message_users.pluck(:id)
  end
end
