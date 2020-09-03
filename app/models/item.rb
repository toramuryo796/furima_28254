class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_many_attached :images
  has_many :likes
  has_many :liked_users, through: :Likes, source: :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :fee
  belongs_to_active_hash :origin_area
  belongs_to_active_hash :take_day

  with_options presence: true do
    validates :title, length: { maximum: 40, message: 'は40文字以内で記入してください' }
    validates :explain, length: { maximum: 1000, message: 'は100文字以内で記入してください' }
    validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10000000, message: 'は300~10,000,000の数字を入力してください' }, format: { with: /\A[0-9]+\Z/, message: 'は半角数字を入力してください' }
    validates :category_id
    validates :status_id
    validates :fee_id
    validates :origin_area_id
    validates :take_day_id
  end

  validates :images, presence: true
end
