class BookMark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.exist?(user,post)
    where("user_id = ? AND post_id = ?", user.id, post.id).size > 0
  end
end
