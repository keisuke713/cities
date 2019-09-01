class BookMark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.find_id(user_id, post_id)
    select(:id).find_by("user_id = ? AND post_id = ?", user_id, post_id)
  end
end
