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
    @active = 'items'
    @item = Item.new(item_params)
    # if @item is valid, it returns a truthy value
    if @item.save
      flash[:success] = "Item created."
      redirect_to items_path
    else
      render 'new'
    end
  end

  def edit
    @active = 'items'
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "Item updated."
      redirect_to item_path(@item.id)
    else
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:success] = "Item deleted."
    redirect_to items_path
  end

  private

    def item_params
      params.require(:item).permit(:name, :rating, :price,
                                   :description, :image_file)
    end
end