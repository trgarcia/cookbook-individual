class RecipeList < ApplicationRecord
  belongs_to :user
  has_many :recipe_recipe_lists
  has_many :recipes, through: :recipe_recipe_lists

  validates :name, :user_id, presence: true
  validates :name,  uniqueness: true


end
