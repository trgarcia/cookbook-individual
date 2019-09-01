Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :recipes, only: %i[show new create edit update]

  resources :recipes, only: %i[show new create edit update] do
      member do
        post 'add_to_list'
        post 'approve'
        post 'reject'
      end
      #delete 'delete_to_list', on: :member
    end

  resources :recipe_types, only: %i[show new create]
  resources :recipe_lists, only: %i[new create show]
  resources :cuisines, only: %i[new create]
  get '/my_lists', to: 'recipe_lists#my_lists'
  get '/search', to: 'recipes#search'
  get '/user_recipes', to: 'recipes#user_recipes'
  get '/pendings', to: 'recipes#pendings'


  namespace :api do
    namespace :v1 do
      resources :recipes, only: %i[show create destroy] do
        member do
          post 'accepted'
          post 'rejected'
        end
      end
      resources :recipe_types, only: %i[create show]
      get '/recipes', to: 'recipes#recipes'
    end
  end

end
