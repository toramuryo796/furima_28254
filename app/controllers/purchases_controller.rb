class PurchasesController < ApplicationController
  def index
    @item = Item.find_by(params[:id])
    @purchase = Purchase.new
  end

  def create
    @item = Item.find_by(params[:id])
    price = @item.price
    # binding.pry
    @purchase = Purchase.new(price: price, postal_code: purchase_params[:postal_code], origin_area_id: purchase_params[:origin_area_id], city: purchase_params[:city], house_number: purchase_params[:house_number], building_name: purchase_params[:building_name], phone_number: purchase_params[:phone_number], user_id: purchase_params[:user_id], item_id: purchase_params[:item_id])
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
    # params.permit(:token).merge(user_id: current_user.id, item_id: params[:item_id])
    params.permit(:token, :postal_code, :origin_area_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id,  item_id: params[:item_id])
  end

  def pay_item
    @item = Item.find_by(params[:id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency:'jpy'
    )
  end
end
