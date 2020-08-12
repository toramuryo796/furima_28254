class ItemsController < ApplicationController
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
  end

  def create
  end

  private
  def item_params
    params.require(:item).permit(:title, :explain, :price, :category_id, :status_id, :fee_id, :origin_area_id, :take_days_id).merge(user_id: current_user.id)
  end
end
