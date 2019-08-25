Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :recipes, only: %i[show new create edit update]

  resources :recipes, only: %i[show new create edit update] do
      post 'add_to_list', on: :member
    end

  resources :recipe_types, only: %i[show new create]
  resources :recipe_lists, only: %i[new create show]

  get '/my_lists', to: 'recipe_lists#my_lists'
  get '/search', to: 'recipes#search'
  get '/user_recipes', to: 'recipes#user_recipes'
end
