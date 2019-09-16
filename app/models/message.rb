class Message < ApplicationRecord
  belongs_to :sender, class_name: :User
  belongs_to :receiver, class_name: :User
  validates :content, presence: true, length: { maximum: 140 }
  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  def self.sender_and_receiver(user)
    (user.sender + user.receiver).tap { |users| users.uniq! }
  end

  def self.all_messages(current_user_id, other_user_id)
    where(sender_id: current_user_id, receiver_id: other_user_id).or(Message.where(sender_id: other_user_id, receiver_id: current_user_id)).order(:created_at).includes(:sender)
  end
end
