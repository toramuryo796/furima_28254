class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchases

  full_width_regex = /\A[ぁ-んァ-ンー-龥]+\z/
  katakana_regex = /\A[ァ-ヶー-]+\z/

  validates :birth_date, presence: true
  with_options presence: true do
    validates :nickname, length: { maximum: 40 }, format: { with: /\A[a-zA-Zぁ-んァ-ンー-龥]+\Z/ }
    validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "には'@'をつけてください" }
    validates :password, format: { with: /(?=.*\d+.*)(?=.*[a-zA-Z]+.*)+/, message: 'は半角英数字を混合させて入力してください' }
    validates :first_name, format: { with: full_width_regex, message: 'は全角文字を入力してください' }
    validates :family_name, format: { with: full_width_regex, message: 'は全角文字を入力してください' }
    validates :first_name_reading, format: { with: katakana_regex, message: 'は半角文字を入力してください' }
    validates :family_name_reading, format: { with: katakana_regex, message: 'は半角文字を入力してください' }
  end
end
