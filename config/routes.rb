Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/vinyls/:id/get_music_url', to: 'vinyls#get_music_url', as: 'vinyl_get_music_url'

  resources :vinyls do
    collection do
      get 'search'
    end
  end
end
