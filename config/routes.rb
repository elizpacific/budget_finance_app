Rails.application.routes.draw do
  get 'notifications/create'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "home#welcome_page", as: 'home'

  resources :cards
  resources :expenses
  resources :revenues
  resources :cards
  resources :users

  get 'expenses/search', to: 'expenses#search', as: 'expenses_search'
  get 'perks/charts', to: 'perks#charts', as: 'perks_charts'
  get 'home/about_us', to: 'home#about_us', as: 'about_us'

end
