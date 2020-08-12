class CategoriesController < ApplicationController
    before_action :find_category, only: [:show, :edit, :update, :destroy]
    before_action :redirect_unless_admin, only: [:new, :create, :edit, :update, :destroy]

    def index
        @categories = Category.all
        @categories_recipes = Recipe.list_by_category 
    end

    def new 
        @category = Category.new 
    end 

    def create 
        @category = Category.new(category_params) 
        if @category.save 
            redirect_to category_path(@category), notice: "Category Successfully Created" 
        else
            render :new 
        end
    end 

    def update 
        if @category.update(category_params)
            redirect_to category_path(@category), notice: "Category Successfully Updated" 
        else 
            render :edit 
        end
    end 

    def destroy 
        @category.destroy 
        redirect_to categories_path, notice: "Category Successfully Deleted" 
    end

    private 

    def find_category 
        @category = Category.find_by(id: params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end 

    def redirect_unless_admin
        redirect_to categories_path unless current_user.admin 
    end
end
