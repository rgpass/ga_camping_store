class ItemsController < ApplicationController
  def index
    @active = 'items'
    @items = Inventory.all
  end

  def show
    @active = 'items'
    @item   = Inventory.find(params[:id].to_i)
  end
end