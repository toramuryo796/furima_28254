class ItemsController < ApplicationController
  before_action :ajax, only: [:commission, :profit]
  before_action :item_find , only: [:edit, :update, :destroy]

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
      @profit = price - @commission
    end
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
    @price = @item.price
    if @price 
      @commission = (@price * 0.1).to_i
      @profit = @price - @commission
    end
  end
  
  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def commission
  end

  def profit
  end
  
  private
  def item_params
    params.require(:item).permit(:title, :explain, :price, :image, :category_id, :status_id, :fee_id, :origin_area_id, :take_day_id).merge(user_id: current_user.id)
  end

  def ajax
    item = Item.new(item_params)
    render json:{ item: item }
  end

  def item_find 
    @item = Item.find(params[:id])
  end

end
