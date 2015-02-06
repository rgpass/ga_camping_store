class Itim
  attr_reader :id, :category, :name, :price
  attr_reader :rating, :description, :image_file

  def initialize(args)
    @id          = args[:id]
    @category    = args[:category]
    @name        = args[:name]
    @price       = args[:price]
    @rating      = args[:rating]
    @description = args[:description]
    @image_file  = args[:image_file]
  end

  def to_s
    "ID: #{@id}, Category: #{@category}, Name: #{@name}, " \
    "Price: #{@price}, Description: #{@description}, " \
    "Image File: #{@image_file}"
  end
end