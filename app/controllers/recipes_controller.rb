class RecipesController < ApplicationController
    before_action :find_recipe, only: [:show, :edit, :update, :destroy]

    def index
        @recipes = Recipe.filter(params.slice(:find_recipes_by_name, :find_recipes_by_serving)).desc_listing
        unless @recipes.present?
            redirect_to recipes_path, notice: "Record Not Found"
        end
    end 

    def new 
        @recipe = Recipe.new 
        4.times do 
            @recipe.recipe_ingredients.build.build_ingredient
        end
    end 

    def create 
        @recipe = current_user.recipes.build(recipe_params)
        if @recipe.save
            redirect_to recipe_path(@recipe.id), notice: "Recipe Successfully Created" 
        else 
            render :new
        end 
    end 

    def show
        redirect_to recipes_path, notice: "Record not found!" if @recipe.nil?
    end 

    def edit 
        redirect_to recipes_path, notice: "Record not found!" if @recipe.nil?
    end 

    def update 
        if @recipe.update(recipe_params) 
            redirect_to recipe_path(@recipe), notice: "Recipe Successfully Updated" 
        else 
            render :edit 
        end 
    end 

    def destroy  
        if @recipe.destroy
            redirect_to recipes_path, notice: "Successfully deleted recipe"
        end
    end 

    private 

    def find_recipe 
        @recipe = Recipe.find_by(id: params[:id])
    end 

    def recipe_params
        params.require(:recipe).permit(:name, :directions, :image, :number_of_persons, :category_id, :recipe_ingredients_attributes => [:id, :recipe_id, :amount, :ingredient_attributes => [:id, :name]])
    end 

end
