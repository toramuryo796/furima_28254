class CardsController < ApplicationController
  before_action :move_to_root, only: %i[new]
  def new
    @card = Card.new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(
      description: "test",
      card: params[:token],
    )
    card = Card.new(
      card_token: params[:token],
      customer_token: customer.id,
      user_id: current_user.id,
    )
    if card.valid?
      if card.card_token?
        card.save
        redirect_to root_path
      end
    else
      render :new
    end
  end

  def destroy
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
    # customer = Payjp::Customer.retrieve(card.customer_token)
    # @card = customer.cards.first
    if card.present?
      # customer.delete
      # @card.delete
      if card.destroy
        redirect_to new_card_path
      end
    end
  end

  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
  end

  private
  def move_to_root
    card = Card.find_by(user_id: current_user)
    if card.present?
      redirect_to root_path
    end
  end

end
