class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :fee
  belongs_to_active_hash :origin_area
  belongs_to_active_hash :take_day

  with_options presence: true do
    validates :title, length: {maximum: 40, message: "is invalid. Input within 40 characters."}
    validates :explain, length: {maximum: 1000, message: "is invalid. Input within 40 characters."}
    validates :price, numericality: {only_integer:true, greater_than:300, less_than:10000000, message: "is invalid. Input number from 300 to 9,999,999."}, format: {with: /\A[0-9]+\Z/, message: "is invalid. Input number."} 
    validates :category_id, numericality: {only_integer: true, greater_than:1, less_than:11}
    validates :status_id, numericality: {only_integer: true, greater_than:1, less_than:7}
    validates :fee_id, numericality: {only_integer: true, greater_than:1, less_than:3}
    validates :origin_area_id, numericality: {only_integer: true, greater_than:1, less_than:48}
    validates :take_days_id, numericality: {only_integer: true, greater_than:1, less_than:4}
  end

  validates :image, presence: true
    
end
