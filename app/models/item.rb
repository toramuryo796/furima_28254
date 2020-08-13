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

  validates :title, :explain, :price, :category_id, :status_id, :fee_id, :origin_area_id, :take_days_id, presence: true

end
