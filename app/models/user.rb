class User < ActiveRecord::Base
  before_save { email.downcase! }

  has_many :items

  # Similar to has_many :items
  # def items
  #   Item.where(user_id: self.id)
  # end

  validates :name, presence: true, length: { minimum: 3, maximum: 254 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 254 },
            format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
end
