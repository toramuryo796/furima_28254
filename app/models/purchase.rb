class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :origin_area

  with_options presence: true do
    validates :price
    validates :postal_code
    validates :origin_area_id
    validates :city
    validates :house_number
    validates :building_name
    validates :phone_number
  end
end
