class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  validates :age,   presence: true, numericality: {less_than: 150}
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, format: { with: /[A-Z]\w+/,
    message: 'the first letter must be upcase' }
end
