class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :replies, class_name: 'Comment', foreign_key: 'comment_id', dependent: :destroy
  belongs_to :original_comment, class_name: 'Comment', foreign_key: 'comment_id', optional: true
  validates :content, presence: true, length: { maximum: 140 }
end
