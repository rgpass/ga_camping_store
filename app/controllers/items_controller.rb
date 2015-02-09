# class ItemsController < ApplicationController
#   def index
#     @active = 'items'
#     @items = Inventory.all
#   end

#   def show
#     @active = 'items'
#     @item   = Inventory.find(params[:id].to_i)
#   end
# end

class ItemsController < ApplicationController
  def index
    @active = 'items'
    @items  = Item.all
  end

  def show
    @active = 'items'
    @item   = Item.find(params[:id])
  end

  def new
    @active = 'items'
    @item   = Item.new
  end

  def create
    @item = Item.new(item_params)
    # if @item is valid, it returns a truthy value
    if @item.save
      flash[:success] = "Item created."
      redirect_to items_path
    else
      render 'new'
    end
  end

  private

    def item_params
      params.require(:item).permit(:name, :rating, :price,
                                   :description, :image_file)
    end
end