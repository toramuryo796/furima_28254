class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    
  full_width_regex = /\A[ぁ-んァ-ンー-龥]+\z/
  katakana_regex = /\A[ァ-ヶー-]+\z/

  validates :birth_date, presence: true
  with_options presence: true do
    validates :nickname, length: {maximum: 40}, format: {with: /\A[a-zA-Zぁ-んァ-ンー-龥]+\Z/}
    validates :email, uniqueness: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "is invalid, Include '@'."}
    validates :password, format: {with: /(?=.*\d+.*)(?=.*[a-zA-Z]+.*)+/, message: "is invalid.Input half_width characters and number."}
    validates :first_name, format: {with: full_width_regex, message: "is invalid. Input full_width characters."}
    validates :family_name, format: {with: full_width_regex, message: "is invalid. Input full_width characters."}
    validates :first_name_reading, format: {with: katakana_regex, message: "is invalid. Input half_width characters."}
    validates :family_name_reading, format: {with: katakana_regex, message: "is invalid. Input half_width characters."}
  end
end
