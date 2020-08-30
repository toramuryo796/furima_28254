class CardPurchase
  
  include ActiveModel::Model
  attr_accessor :postal_code, :origin_area_id, :city, :house_number, :building_name, :phone_number, :item_id, :token, :user_id

  postal_code = /\A\d{3}[-]\d{4}+\Z/
  origin_area = { only_integer: true, greater_than: 0, less_than: 48 }
  full_characters = /\A[ぁ-んァ-ンー-龥]+\Z/
  number_full_characters = /\A[0-9ぁ-んァ-ンー-龥-]+\Z/
  phone = /\A0[0-9]{9,10}\Z/

  with_options presence: true do
    validates :postal_code,    format: { with: postal_code, message: "には'-'(ハイフン)を入れてください" }
    validates :origin_area_id
    validates :city,           format: { with: full_characters, message: 'は全角文字を入力してください' }
    validates :house_number,   format: { with: number_full_characters, message: 'は全角文字または半角数字を入力してください' }
    validates :phone_number,   format: { with: phone, message: 'は半角数字の10または11桁の数字を入れてください' }
  end
  def save
    unless @card.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.create(
        description: 'test',
        card: token
      )
      Card.create(
        card_token: token,
        customer_token: customer.id,
        user_id: user_id
      )
    end

    Purchase.create(postal_code: postal_code, origin_area_id: origin_area_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, user_id: user_id, item_id: item_id)

  end
end