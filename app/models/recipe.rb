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

	scope :find_recipes_by_name, -> (name) { where("name like ?", "#{name.capitalize}%")}
	scope :find_recipes_by_serving, -> (number_of_persons) { where number_of_persons: number_of_persons }
	

	def recipe_ingredients_attributes=(recipe_ingredients_hash)
		recipe_ingredients_hash.values.each do |recipe_ingredient|
			recipe = Recipe.find_by(id: recipe_ingredient[:recipe_id])
			rec_ingredient = RecipeIngredient.find_by(id: recipe_ingredient[:id])
			ingredient = Ingredient.find_by(id: recipe_ingredient[:ingredient_attributes][:id])
			if recipe && rec_ingredient && ingredient
				rec_ingredient.update(amount: recipe_ingredient[:amount])
				ingredient.update(name: recipe_ingredient[:ingredient_attributes][:name])
			else
				self.recipe_ingredients.build(recipe_ingredient)
			end
		end
	end
	
	def ingredient_names 
		self.recipe_ingredients.map(&:ingredient_id)
		if ingredient_ids != ingredient_ids.uniq
			self.errors.add(:recipe_ingredients, "Ingredient Name Should Appear Once!")
		end
	end

	
end
