class CategoriesController < ApplicationController
    before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
    
    
    def index
        @categories = Category.all
    end

    def new
        @category = Category.new
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = "Category successfully saved"
            redirect_to categories_path
        else
            flash[:danger] = "Category unable to be saved, contact your admin"
            render 'new'
        end
    end
    
    def edit
        @category = Category.find(params[:id])
    end
    
    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            flash[:success] = "Category successfully updated"
            redirect_to categories_path
        else
            render 'edit'
        end
    end
    
    def show
        @category = Category.find(params[:id])
    end
    
    def destroy
        
    end
    
    private
    def category_params
        params.require(:category).permit(:name)
    end
    
end