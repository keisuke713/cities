class Message < ApplicationRecord
  belongs_to :sender, class_name: :User
  belongs_to :receiver, class_name: :User
  validates :content, presence: true, length: { maximum: 140 }
  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  scope :in_ids, -> (_ids){ where(id: _ids) }
  scope :in_sender, -> (_sender_id) { where(sender_id: _sender_id) }
  scope :in_receiver, -> (_receiver_id) { where(receiver_id: _receiver_id) }
  scope :between_people, -> (_sender_id, _receiver_id) { where(sender_id: _sender_id, receiver_id: _receiver_id) }

  def self.messages_with(current_user_id, other_user_id)
    my_sent_ids = between_people(current_user_id, other_user_id).pluck(:id)
    my_received_ids = between_people(other_user_id, current_user_id).pluck(:id)
    in_ids(my_sent_ids + my_received_ids).order(:created_at).includes(:sender)
  end

  def my_message?(user)
    sender == user
  end
end
