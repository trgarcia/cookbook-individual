Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :recipes, only: %i[show new create edit update]

  resources :recipes, only: %i[show new create edit update] do
      member do
        post 'add_to_list'

      end
      #delete 'delete_to_list', on: :member
    end

  resources :recipe_types, only: %i[show new create]
  resources :recipe_lists, only: %i[new create show]

  get '/my_lists', to: 'recipe_lists#my_lists'
  get '/search', to: 'recipes#search'
  get '/user_recipes', to: 'recipes#user_recipes'
  get '/pendings', to: 'recipes#pendings'
  post '/modified_status', to: 'recipes#modified_status'

  namespace :api do
    namespace :v1 do
      resources :recipes, only: %i[show]
    end
  end

end
