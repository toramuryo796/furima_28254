class PurchasesController < ApplicationController
  before_action :purchase_item, only: [:create, :pay_item]
  before_action :find_item, only: [:index, :move_to_root]
  before_action :move_to_login, only: [:index, :create]
  before_action :move_to_root, only: [:index, :create]

  def index
    @purchase = CardPurchase.new
    @card = Card.find_by(user_id: current_user.id)
  end
  
  def create
    @card = Card.find_by(user_id: current_user.id)
    @purchase = CardPurchase.new(purchase_params)
    if @purchase.valid?
      @purchase.save
      return redirect_to root_path
    else
      return render :index
    end
  end
  private
  
  def purchase_params
    params.permit(:token, :postal_code, :origin_area_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
  
  def find_item
    @item = Item.find_by(id: params[:item_id])
  end

  def purchase_item
    @item = Item.find_by(id: purchase_params[:item_id])
  end

  def pay_item
    if current_user.card.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer_token = current_user.card.customer_token
      Payjp::Charge.create(
        amount: @item.price,
        customer: customer_token,
        currency: "jpy"
      )
    else
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
    end
  end

  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  def move_to_root
    redirect_to root_path if current_user == @item.user
  end
end
