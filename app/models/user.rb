class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  validates :intro, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, format: { with: /[A-Z]\w+/,
    message: 'the first letter must be upcase' }

  mount_uploader :image, ImageUploader
  include SessionsHelper

  def text_slice
    intro.length > 25 ? "#{intro.slice(0..24)}..." : intro
  end
end
