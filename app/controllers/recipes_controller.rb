class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @recipes = Recipe.all.order("created_at desc")
  end

  def show
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "Recipe was successfully saved!"
    else
      render 'new', alert: "Recipe was not saved!"
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe was updated!"
    else
      render 'edit', alert: "Recipe was not updated"
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, notice: "Recipe was deleted!"
  end



  private
    def recipe_params
      params.require(:recipe).permit(:title, :description, :user_id, :image, ingredients_attributes: [:id, :name, :_destroy],
        directions_attributes: [:id, :step, :_destroy])
    end

    def find_recipe
      @recipe = Recipe.find(params[:id])
    end
end
