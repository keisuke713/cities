class Relationship < ApplicationRecord
  belongs_to :follower, class_name: :User
  belongs_to :followed, class_name: :User
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  def self.find_by_id(current_user, user)
    find_by(follower_id: current_user.id, followed_id: user.id)&.id
  end
end
