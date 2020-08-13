class Ingredient < ApplicationRecord
    has_many :recipe_ingredients, dependent: :destroy, dependent: :destroy
    has_many :recipes, through: :recipe_ingredients, dependent: :destroy

    validates :name, presence: true, uniqueness: true, on: :update
    
end
