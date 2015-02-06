class Item < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3, maximum: 254 }
  # Same thing, different way
  # validates :name, presence: true, length: { in: 3..254 }
  validates :price, presence: true
end
