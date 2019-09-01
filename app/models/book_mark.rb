class BookMark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :post_id, -> (user_id){ select(:post_id).where("user_id = ?", user_id) }

  def self.exist?(user, post)
    where("user_id = ? AND post_id = ?", user.id, post.id).size > 0
  end
end
