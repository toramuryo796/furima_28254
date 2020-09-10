class ItemsController < ApplicationController
  before_action :item_find, only: %i[edit show update destroy confirm_user]
  before_action :move_to_index, only: %i[new create]
  before_action :confirm_user, only: %i[edit update]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def show
    @user = current_user
  end

  def new
    @item = Item.new
    @image_id = 1
    @btn_id = 1
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
    @image_id = 1
    @btn_id = 1
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

  private

  def item_params
    params.require(:item).permit(:title, :explain, :price, :category_id, :status_id, :fee_id, :origin_area_id, :take_day_id, images: []).merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless user_signed_in?
  end

  def confirm_user
    redirect_to item_path(@item) unless current_user == @item.user
  end
end
