class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :items
  has_many :purchases
  has_one :card, dependent: :destroy
  has_one :personal
  has_many :sns_credentials

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.proider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    user
    { user: user, sns: sns }
  end

  with_options presence: true do
    validates :nickname, length: { maximum: 40 }, format: { with: /\A[a-zA-Zぁ-んァ-ンー-龥]+\Z/, message: " は数字・スペースを入れないでください" }
    validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "には'@'をつけてください" }
    validates :password, format: { with: /(?=.*\d+.*)(?=.*[a-zA-Z]+.*)+/, message: 'は半角英数字を混合させて入力してください' }
  end

end
