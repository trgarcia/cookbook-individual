class CreateRecipeRecipeLists < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_recipe_lists do |t|
      t.references :recipe, foreign_key: true
      t.references :recipe_list, foreign_key: true

      t.timestamps
    end
  end
end
