class CategoriesController < ApplicationController
    
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
        
    end
    
    def update
        
    end
    
    def show
        
    end
    
    def destroy
        
    end
    
    private
    def category_params
        params.require(:category).permit(:name)
    end
    
end