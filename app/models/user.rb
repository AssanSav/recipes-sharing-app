class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
    has_many :recipes
    has_many :comments

    validates :username, presence: true, uniqueness: true, length: {minimum: 5}, on: :create
    validates :first_name, :last_name, presence: true, length: { maximum: 30 }
end
