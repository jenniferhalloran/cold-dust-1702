class ChefIngredientsController < ApplicationController

  def index
    @chef = Chef.find(params[:chef_id])
    @ingredients = @chef.unique_ingredients
  end
end
