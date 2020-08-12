class Recipe < ApplicationRecord
	include Filterable

	has_one_attached :image
	belongs_to :user
	belongs_to :category
	has_many :comments
	has_many :recipe_ingredients, dependent: :destroy
	has_many :ingredients, through: :recipe_ingredients
	
	# validates :image, presence: true
	validates :name, presence: true, uniqueness: {:scope => [:user_id, :category_id]}
	validates :number_of_persons, presence: true
	validates :directions, presence: true 
	validate :ingredient_names
	before_validation :name_capitalizer

	
end
