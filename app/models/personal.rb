class Personal < ApplicationRecord
  belongs_to :user,    optional:true
  
  full_width_regex = /\A[ぁ-んァ-ンー-龥]+\z/
  katakana_regex = /\A[ァ-ヶー-]+\z/

  validates :birth_date, presence: true

  with_options presence: true do
    validates :first_name, format:{ with: full_width_regex, message: 'は全角文字を入力してください' }
    validates :family_name, format:{ with: full_width_regex, message: 'は全角文字を入力してください' }
    validates :first_name_reading, format: { with: katakana_regex, message: 'は半角文字を入力してください' }
    validates :family_name_reading, format: { with: katakana_regex, message: 'は半角文字を入力してください' }
  end
end
