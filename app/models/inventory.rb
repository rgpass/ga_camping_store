class Inventory
  def self.all
    [
      Item.new(id: 1,
               category: 'Tents',
               name: '1-person Tent',
               price: 119.99,
               rating: 3.8,
               description: 'A very small tent.',
               image_file: '1_person_tent.jpg'
              ),
      Item.new(id: 2,
               category: 'Tents',
               name: '2-person Tent',
               price: 169.99,
               rating: 4.4,
               description: 'Just right for 2 people.',
               image_file: '2_person_tent.jpg'
              ),
      Item.new(id: 3,
               category: 'Tents',
               name: '3-person Tent',
               price: 249.99,
               rating: 3.5,
               description: '3 is a crowd!',
               image_file: '3_person_tent.jpg'
              ),
      Item.new(id: 4,
               category: 'Tents',
               name: '4-person Tent',
               price: 319.99,
               rating: 4.7,
               description: 'Fit for a family.',
               image_file: '4_person_tent.jpg'
              ),
      Item.new(id: 5,
               category: 'Flashlights',
               name: 'Small Flashlight',
               price:   6.99,
               rating: 4.0,
               description: 'A very small flashlight.',
               image_file: 'small_flashlight.jpg'
              ),
      Item.new(id: 6,
               category: 'Flashlights',
               name: 'Large Flashlight',
               price:  12.99,
               rating: 4.3,
               description: 'A big, powerful flashlight.',
               image_file: 'large_flashlight.jpg'
              ),
      Item.new(id: 7,
               category: 'Water Bottles',
               name: 'Small Water Bottle',
               price:   2.99,
               rating: 2.7,
               description: 'Holds 16 ounces.',
               image_file: 'small_water_bottle.jpg'
              ),
      Item.new(id: 8,
               category: 'Water Bottles',
               name: 'Large Water Bottle',
               price:   2.99,
               rating: 3.1,
               description: 'Holds 32 ounces.',
               image_file: 'large_water_bottle.jpg'
              ),
      Item.new(id: 9,
               category: 'Stoves',
               name: 'Small Stove',
               price:  29.99,
               rating: 3.5,
               description: 'Has 1 burner.',
               image_file: 'small_stove.jpg'
              ),
      Item.new(id: 10,
               category: 'Stoves',
               name: 'Large Stove',
               price:  39.99,
               rating: 4.7,
               description: 'Has 2 burners.',
               image_file: 'large_stove.jpg'
              ),
      Item.new(id: 11,
               category: 'Sleeping Bags',
               name: 'Simple Sleeping Bag',
               price:  49.99,
               rating: 4.4,
               description: 'A simple mummy bag.',
               image_file: 'simple_sleeping_bag.jpg'
              ),
      Item.new(id: 12,
               category: 'Sleeping Bags',
               name: 'Deluxe Sleeping Bag',
               price:  79.99,
               rating: 4.8,
               description: 'Will keep you warm in very cold weather!',
               image_file: 'deluxe_sleeping_bag.png'
              )
    ]
  end

  def self.find(id)
    all.find do |item|
      item.id == id
    end
  end

  def self.search(pattern)
    all.select do |item|
      item.category.downcase.include?(pattern.downcase) ||
      item.name.downcase.include?(pattern.downcase) ||
      item.description.downcase.include?(pattern.downcase)
    end
  end
end