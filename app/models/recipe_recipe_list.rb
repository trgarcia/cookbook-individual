class RecipeRecipeList < ApplicationRecord
  belongs_to :recipe
  belongs_to :recipe_list

  validates :recipe, uniqueness: {scope: :recipe_list}
end
