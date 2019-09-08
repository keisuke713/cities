class Relationship < ApplicationRecord
  belongs_to :follower, class_name: :User
  belongs_to :followed, class_name: :User
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  def self.check(user, other_user)
    Relationship.exists?(follower_id: user.id, followed_id: other_user.id)
  end
end
