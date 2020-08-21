class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :origin_area
  postal_code = {with: /\A\d{3}[-]\d{4}+\Z/ , message: "is invalid. Input number with '-'."}
  origin_area = {only_integer: true, greater_than:0, less_than:48}
  full_characters = {with: /\A[ぁ-んァ-ンー-龥]+\Z/, message: "is invalid. Input full_width characters."}
  number_full_characters = {with: /\A[0-9ぁ-んァ-ンー-龥-]+\Z/, message: "is invalid. Input full_width characters or number."} 
  phone = {with: /\A0[0-9]{9,10}\Z/, message: "is invalid. Input 10 or 11 numbers"}

  with_options presence: true do
    validates :price
    validates :postal_code,    format: postal_code
    validates :origin_area_id, numericality: origin_area
    validates :city,           format: full_characters
    validates :house_number,   format: number_full_characters
    validates :phone_number,   format: phone
  end
end
