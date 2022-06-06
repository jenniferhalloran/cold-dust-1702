require 'rails_helper'

describe 'chefs show page' do
  before do
    @chef1 = Chef.create!(name: "Rob")
    chef2 = Chef.create!(name: "Emmanuel")

    dish1 = @chef1.dishes.create!(name: "Pancakes", description: "Stack of 3 fluffy pancakes")
    dish2 = @chef1.dishes.create!(name: "Omelette", description: "Served with home fries")
    dish3 = chef2.dishes.create!(name: "Skillet", description: "Eggs, veg, and homies")
    dish4 = @chef1.dishes.create!(name: "Crepes", description: "Berry and Brie")

    milk = Ingredient.create!(name: "milk", calories: 90)
    flour = Ingredient.create!(name: "flour", calories: 60)
    eggs = Ingredient.create!(name: "eggs", calories: 80)
    potatoes = Ingredient.create!(name: "potatoes", calories: 100)
    mushies = Ingredient.create!(name: "mushrooms", calories: 50)

    DishIngredient.create!(dish: dish1, ingredient: milk)
    DishIngredient.create!(dish: dish2, ingredient: milk)
    DishIngredient.create!(dish: dish1, ingredient: flour)
    DishIngredient.create!(dish: dish2, ingredient: flour)
    DishIngredient.create!(dish: dish1, ingredient: eggs)
    DishIngredient.create!(dish: dish2, ingredient: eggs)
    DishIngredient.create!(dish: dish4, ingredient: eggs)
    DishIngredient.create!(dish: dish2, ingredient: potatoes)
    DishIngredient.create!(dish: dish3, ingredient: mushies)
    visit chef_path(@chef1)

  end

  it "displays the chef's name and a link to all the ingredients they use in their dishes" do
    expect(page).to have_content("Rob")
    expect(page).to_not have_content("Emmanuel")

    click_link("Click Here to See Rob's Ingredients")

    expect(current_path).to eq(chef_ingredients_path(@chef1))
    expect(page).to have_content("Rob's Ingredients:")

    within '.all-ingredients' do
      expect(page).to have_content("milk", count: 1)
      expect(page).to have_content("flour", count: 1)
      expect(page).to have_content("eggs", count: 1)
      expect(page).to have_content("potatoes")
      expect(page).to_not have_content("mushrooms")
    end
  end

  it "displays the 3 most popular ingredients a chef uses in his dishes" do

    within '.popular-ingredients' do
      expect(page).to have_content("eggs")
      expect(page).to have_content("flour")
      expect(page).to have_content("milk")
      expect(page).to_not have_content("potatoes")
    end

  end

end
