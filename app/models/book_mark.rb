class BookMark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.find_id(user_id, post_id)
    select(:id).find_by("user_id = ? AND post_id = ?", user_id, post_id)
  end

  def self.find_post_id(user_id)
    select(:post_id).where("user_id = ?", user_id)
  end
end
