class Item < ActiveRecord::Base

  belongs_to :user

  # Same thing as belongs_to :user
  # def user
  #   User.find(self.user_id)
  # end

  validates :name, presence: true, length: { minimum: 3, maximum: 254 }
  # Same thing, different way
  # validates :name, presence: true, length: { in: 3..254 }
  validates :price, presence: true
end
