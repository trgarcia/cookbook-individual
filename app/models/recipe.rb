class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :user
  has_many :recipe_recipe_lists
  has_many :recipe_lists, through: :recipe_recipe_lists

  validates :title, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method, presence: true
end
