class PurchasesController < ApplicationController
  before_action :find_item, only: [:index, :create, :pay_item, :move_to_root]
  before_action :move_to_login, only: [:index, :create]
  before_action :move_to_root, only: [:index, :create]

  def index
    @purchase = Purchase.new
  end

  def create
    price = @item.price
    if @item.user_id != purchase_params[:user_id]
      @purchase = Purchase.new(price: price, postal_code: purchase_params[:postal_code], origin_area_id: purchase_params[:origin_area_id], city: purchase_params[:city], house_number: purchase_params[:house_number], building_name: purchase_params[:building_name], phone_number: purchase_params[:phone_number], user_id: purchase_params[:user_id], item_id: purchase_params[:item_id])
    else
      return false
    end

    if @purchase.valid?
    pay_item
    @purchase.save
    redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    if user_signed_in?
      params.permit(:token, :postal_code, :origin_area_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id,  item_id: params[:item_id])
    else
      params.permit(:token, :postal_code, :origin_area_id, :city, :house_number, :building_name, :phone_number).merge(item_id: params[:item_id])
    end
  end

  def find_item
    @item = Item.find_by(id: purchase_params[:item_id]) 
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency:'jpy'
    )
  end

  def move_to_login
    unless user_signed_in?   
      redirect_to new_user_session_path
    end
  end
 
  def move_to_root
    if current_user == @item.user
      redirect_to root_path
    end
  end
end
