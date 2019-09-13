class Relationship < ApplicationRecord
  belongs_to :follower, class_name: :User
  belongs_to :followed, class_name: :User
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  def self.find_by_id(current_user_id, user_id)
    find_by(follower_id: current_user_id, followed_id: user_id)&.id
  end
end
