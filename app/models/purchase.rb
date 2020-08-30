class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :origin_area
  postal_code = /\A\d{3}[-]\d{4}+\Z/
  origin_area = { only_integer: true, greater_than: 0, less_than: 48 }
  full_characters = /\A[ぁ-んァ-ンー-龥]+\Z/
  number_full_characters = /\A[0-9ぁ-んァ-ンー-龥-]+\Z/
  phone = /\A0[0-9]{9,10}\Z/

  with_options presence: true do
    validates :price
    validates :postal_code,    format: { with: postal_code, message: "には'-'(ハイフン)を入れてください" }
    validates :origin_area_id
    validates :city,           format: { with: full_characters, message: 'は全角文字を入力してください' }
    validates :house_number,   format: { with: number_full_characters, message: 'は全角文字または半角数字を入力してください' }
    validates :phone_number,   format: { with: phone, message: 'は半角数字の10または11桁の数字を入れてください' }
  end
end
