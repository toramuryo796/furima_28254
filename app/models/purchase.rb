class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :origin_area

  with_options presence: true do
    validates :price
    validates :postal_code,    format:{with: /\A\d{3}[-]\d{4}+\Z/ , message: "is invalid. Input number with '-'."}
    validates :origin_area_id, numericality: {only_integer: true, greater_than:0, less_than:48}
    validates :city,           format: {with: /\A[ぁ-んァ-ンー-龥]+\Z/, message: "is invalid. Input full_width characters." }
    validates :house_number,   format: {with: /\A[0-9ぁ-んァ-ンー-龥]+\Z/, message: "is invalid. Input full_width characters or number."} 
    validates :phone_number,   numericality: {only_integer: true, message: "is invalid. Input number."}
  end
end
