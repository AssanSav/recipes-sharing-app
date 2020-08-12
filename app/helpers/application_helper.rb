module ApplicationHelper
   def created_date_of(recipe)
        recipe.created_at.strftime("%A, %b %e, at %l:%M %p")
    end

    def updated_date_of(recipe)
        recipe.updated_at.strftime("%A, %b %e, at %l:%M %p")
    end
    
end
