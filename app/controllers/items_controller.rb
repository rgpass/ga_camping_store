class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, except: [:index, :show]
  before_action :correct_user,   except: [:new, :create, :index, :show]

  def index
    @active = 'items'
    @items  = Item.all
  end

  def show
    @active = 'items'
  end

  def new
    @active = 'items'
    @item   = Item.new
  end

  def create
    @active = 'items'
    # @item = Item.new(item_params)
    @item = current_user.items.new(item_params) # automagically sets user_id: current_user.id
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
  end

  def update
    if @item.update_attributes(item_params)
      flash[:success] = "Item updated."
      redirect_to item_path(@item.id)
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    flash[:success] = "Item deleted."
    redirect_to items_path
  end

  private

    def item_params
      params.require(:item).permit(:name, :rating, :price,
                                   :description, :image_file)
    end

    def set_item
      @item = Item.find(params[:id])
    end

    def correct_user
      unless current_user?(@item.user) || current_user.admin?
        redirect_to user_path(current_user)
      end
    end
    
end