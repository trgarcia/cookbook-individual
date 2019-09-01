class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :user
  belongs_to :cuisine
  has_many :recipe_recipe_lists
  has_many :recipe_lists, through: :recipe_recipe_lists
  has_one_attached :imagem


  enum status: { pending:0, accepted:1, rejected:2}

  validates :title, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method, presence: true
end
