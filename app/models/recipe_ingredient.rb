class RecipeIngredient < ApplicationRecord
    belongs_to :recipe
    belongs_to :ingredient

    validates :amount, presence: true
    validates_uniqueness_of :ingredient_id, scope: :recipe_id
    
  
end
