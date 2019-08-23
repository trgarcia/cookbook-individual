class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :user

  validates :title, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method, presence: true
end
