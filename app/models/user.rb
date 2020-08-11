class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  validates :birth_date, presence: true
  with_options presence: true do
    validates :nickname, length: {maximum: 40}
    validates :email, uniqueness: true
    validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "is invalid, Include '@'."}
    validates :password, length: { minimum: 6 }
    validates :password, format: {with: /\A[a-zA-Z0-9]+\Z/, message: "is invalid.Input half_width characters"}
    validates :first_name, format: {with: /\A[ぁ-んァ-ンー-龥]+\z/, message: "is invalid. Input full_width characters."}
    validates :family_name, format: {with: /\A[ぁ-んァ-ンー-龥]+\z/, message: "is invalid. Input full_width characters."}
    validates :first_name_reading, format: {with: /\A[ァ-ヶー-]+\z/, message: "is invalid. Input half_width characters."}
    validates :family_name_reading, format: {with: /\A[ァ-ヶー-]+\z/, message: "is invalid. Input half_width characters."}
  end
end
