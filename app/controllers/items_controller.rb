class ItemsController < ApplicationController
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    price = @item.price
    if price 
      @commission = (price * 0.1).to_i
    end
    if price
      @profit = price - @commission
    end
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def commission
    item = Item.new(item_params)
    render json:{ item: item }
  end

  private

  def item_params
    params.require(:item).permit(:title, :explain, :price, :image, :category_id, :status_id, :fee_id, :origin_area_id, :take_days_id).merge(user_id: current_user.id)
  end
end
