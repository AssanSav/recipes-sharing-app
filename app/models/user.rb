class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
    has_many :recipes, dependent: :destroy
    has_many :comments, dependent: :destroy

    # validates :username, presence: true, uniqueness: true, length: {minimum: 5}, on: :create
    # validates :first_name, :last_name, presence: true, length: { maximum: 30 }

    def self.from_omniauth(auth) 
        user = where(provider: auth.provider, uid: auth.uid).first 
        unless user 
            user = where(email: auth.info.email).first_or_initialize 
            user.email = auth.info.email
            user.name = auth.info.name 
            user.image = auth.info.image 
            user.password = Devise.friendly_token[0,20]
            (user.save!(validate: false))
        end
        user
    end
end
