Rails.application.routes.draw do
   get 'ingredients/edit'
    get 'ingredients/update'
    root to: 'page#home'
    devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }

    resources :ingredients
    resources :comments
    resources :recipes 

    resources :categories do 
        resources :recipes
    end

    resources :recipes do 
        resources :comments
    end
end
