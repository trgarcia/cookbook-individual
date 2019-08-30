# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create(email:'admin@email.com', password:'123456', admin:true)
recipe_type = RecipeType.create(name:'sobremesa')
Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                       cuisine: 'Brasileira', difficulty: 'Medio',
                       cook_time: 60,
                       user: admin,
                       ingredients: 'Farinha, açucar, cenoura',
                       cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
